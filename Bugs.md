# Big Bug 耗时一整天

简单总结记录一下吧

没有深入了解的情况下，贸然的跟着教程改变了 `pubspec.yaml` 中的 `cloud_firebase` 依赖版本还混淆了 pod 的 install 和 update指令，错误操作下引起了后续 ios flutter调试失败。即使不断切换网络，更改 `hosts`，在 `pod install` 上面花费了大量时间，都并没有起到作用。

期间我尝试了找到 gitee 的 Pod 源，这个确实可以起到一定的作用，但是在引用第三方源的时候，他的 submodule 的 url 貌似依然比较难更改

pod install 的时候可能在临时盘如 /private/var/folders/fc/.../T/... 当我再想打开时

>  (base) MacBook-Pro:d20230217-51146-srml69 gsq$ open .
>
> 2023-02-17 04:30:44.537 open[3798:380621] CFURLCopyResourcePropertyForKey failed because it was passed a URL which has no scheme
>
> 2023-02-17 04:30:44.538 open[3798:380621] CFURLCopyResourcePropertyForKey failed because it was passed a URL which has no scheme
>
> No application knows how to open URL ./ (Error Domain=NSOSStatusErrorDomain Code=-10814 "kLSApplicationNotFoundErr: E.g. no application claims the file" UserInfo={_LSLine=1489, _LSFunction=runEvaluator}).

期间参考了一些回答和文章
[1] [ 解决gRPC源码克隆速度慢的问题 ](https://www.jianshu.com/p/969ad8be9f8d)
[2] [[Cloud Firestore\] fatal error: module 'cloud_firestore' not found · Issue #1979 · firebase / flutterfire ](https://github.com/firebase/flutterfire/issues/1979)
[3] [Module 'cloud_firestore' not found in GeneratedPluginRegistrant.h · Discussion #8409 · firebase/firebase-ios-sdk ](https://github.com/firebase/firebase-ios-sdk/discussions/8409) - 未解决
[4] [CocoaPods Guides - Getting Started](https://guides.cocoapods.org/using/getting-started.html#installation)
[5] [Xcode build failure · Issue #109774 · flutter / flutter ](https://github.com/flutter/flutter/issues/109774) 另: warning: Stale file
[6] 作者: 开始 pod install 前 `rm -rf ~/.cocoapods/repos/trunk` 这个可以解决版本冲突 ( 问题表现有如 [JSON::ParserError](https://github.com/CocoaPods/CocoaPods/issues/9578) - X )，但是换源之后就没有关系了
[7] [[Cloud Firestore\] doesn't work with IOS (get stuck on pod install gRPC-Core) · Issue #2533 · firebase / flutterfire ](https://github.com/firebase/flutterfire/issues/2533) 类似问题

问题千千万 ( \*\_\_\* ; )

最后还是在普通网络环境下，`pod install --verbose --no-repo-update`

等来了配置结果

```bash
(base) MacBook-Pro:ios gsq$ pod install --verbose --no-repo-update
  Preparing

Analyzing dependencies

Inspecting targets to integrate
  Using `ARCHS` setting to build architectures of target `Pods-Runner`: (``)

Finding Podfile changes
  A Flutter
  A cloud_firestore
  A firebase_auth
  A firebase_core
  A path_provider_foundation

Fetching external sources
-> Fetching podspec for `Flutter` from `Flutter`
-> Fetching podspec for `cloud_firestore` from `.symlinks/plugins/cloud_firestore/ios`
cloud_firestore: Using Firebase SDK version '10.3.0' defined in 'firebase_core'
-> Fetching podspec for `firebase_auth` from `.symlinks/plugins/firebase_auth/ios`
firebase_auth: Using Firebase SDK version '10.3.0' defined in 'firebase_core'
-> Fetching podspec for `firebase_core` from `.symlinks/plugins/firebase_core/ios`
firebase_core: Using Firebase SDK version '10.3.0' defined in 'firebase_core'
-> Fetching podspec for `path_provider_foundation` from `.symlinks/plugins/path_provider_foundation/ios`

Resolving dependencies of `Podfile`

Comparing resolved specification to the sandbox manifest
  A BoringSSL-GRPC
  A Firebase
  A FirebaseAuth
  A FirebaseCore
  A FirebaseCoreInternal
  A FirebaseFirestore
  A Flutter
  A GTMSessionFetcher
  A GoogleUtilities
  A Libuv-gRPC
  A PromisesObjC
  A abseil
  A cloud_firestore
  A firebase_auth
  A firebase_core
  A gRPC-C++
  A gRPC-Core
  A leveldb-library
  A nanopb
  A path_provider_foundation

Downloading dependencies

-> Installing BoringSSL-GRPC (0.0.24)
  > Copying BoringSSL-GRPC from
  `/Users/gsq/Library/Caches/CocoaPods/Pods/Release/BoringSSL-GRPC/0.0.24-3175b` to
  `Pods/BoringSSL-GRPC`

-> Installing Firebase (10.3.0)
  > Copying Firebase from `/Users/gsq/Library/Caches/CocoaPods/Pods/Release/Firebase/10.3.0-f92fc`
  to `Pods/Firebase`

-> Installing FirebaseAuth (10.3.0)
 > Git download
 > Git download
     $ /usr/bin/git clone https://github.com/firebase/firebase-ios-sdk.git
     /var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-1vy9rr --template=
     --single-branch --depth 1 --branch CocoaPods-10.3.0
     Cloning into '/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-1vy9rr'...
     Note: switching to 'dce2e1abc6c0d5e830ff1cffe3f8633fda64001e'.
     
     You are in 'detached HEAD' state. You can look around, make experimental
     changes and commit them, and you can discard any commits you make in this
     state without impacting any branches by switching back to a branch.
     
     If you want to create a new branch to retain commits you create, you may
     do so (now or later) by using -c with the switch command. Example:
     
       git switch -c <new-branch-name>
     
     Or undo this operation with:
     
       git switch -
     
     Turn off this advice by setting config variable advice.detachedHead to false
     
  > Copying FirebaseAuth from
  `/Users/gsq/Library/Caches/CocoaPods/Pods/Release/FirebaseAuth/10.3.0-0e415` to
  `Pods/FirebaseAuth`

-> Installing FirebaseCore (10.3.0)
 > Git download
 > Git download
     $ /usr/bin/git clone https://github.com/firebase/firebase-ios-sdk.git
     /var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-lo525 --template=
     --single-branch --depth 1 --branch CocoaPods-10.3.0
     Cloning into '/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-lo525'...
     Note: switching to 'dce2e1abc6c0d5e830ff1cffe3f8633fda64001e'.
     
     You are in 'detached HEAD' state. You can look around, make experimental
     changes and commit them, and you can discard any commits you make in this
     state without impacting any branches by switching back to a branch.
     
     If you want to create a new branch to retain commits you create, you may
     do so (now or later) by using -c with the switch command. Example:
     
       git switch -c <new-branch-name>
     
     Or undo this operation with:
     
       git switch -
     
     Turn off this advice by setting config variable advice.detachedHead to false
     
  > Copying FirebaseCore from
  `/Users/gsq/Library/Caches/CocoaPods/Pods/Release/FirebaseCore/10.3.0-98875` to
  `Pods/FirebaseCore`

-> Installing FirebaseCoreInternal (10.5.0)
 > Git download
 > Git download
     $ /usr/bin/git clone https://github.com/firebase/firebase-ios-sdk.git
     /var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-fn0a53 --template=
     --single-branch --depth 1 --branch CocoaPods-10.5.0
     Cloning into '/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-fn0a53'...
     Note: switching to 'f567ed9a2b30e29159df258049a9c662c517688e'.
     
     You are in 'detached HEAD' state. You can look around, make experimental
     changes and commit them, and you can discard any commits you make in this
     state without impacting any branches by switching back to a branch.
     
     If you want to create a new branch to retain commits you create, you may
     do so (now or later) by using -c with the switch command. Example:
     
       git switch -c <new-branch-name>
     
     Or undo this operation with:
     
       git switch -
     
     Turn off this advice by setting config variable advice.detachedHead to false
     
  > Copying FirebaseCoreInternal from
  `/Users/gsq/Library/Caches/CocoaPods/Pods/Release/FirebaseCoreInternal/10.5.0-e463f` to
  `Pods/FirebaseCoreInternal`

-> Installing FirebaseFirestore (10.3.0)
 > Git download
 > Git download
     $ /usr/bin/git clone https://github.com/firebase/firebase-ios-sdk.git
     /var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-5ifzvw --template=
     --single-branch --depth 1 --branch CocoaPods-10.3.0
     Cloning into '/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-5ifzvw'...
     Note: switching to 'dce2e1abc6c0d5e830ff1cffe3f8633fda64001e'.
     
     You are in 'detached HEAD' state. You can look around, make experimental
     changes and commit them, and you can discard any commits you make in this
     state without impacting any branches by switching back to a branch.
     
     If you want to create a new branch to retain commits you create, you may
     do so (now or later) by using -c with the switch command. Example:
     
       git switch -c <new-branch-name>
     
     Or undo this operation with:
     
       git switch -
     
     Turn off this advice by setting config variable advice.detachedHead to false
     
  > Copying FirebaseFirestore from
  `/Users/gsq/Library/Caches/CocoaPods/Pods/Release/FirebaseFirestore/10.3.0-244f7` to
  `Pods/FirebaseFirestore`

-> Installing Flutter (1.0.0)

-> Installing GTMSessionFetcher (3.1.0)
 > Git download
 > Git download
     $ /usr/bin/git clone https://github.com/google/gtm-session-fetcher.git
     /var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-e86wgp --template=
     --single-branch --depth 1 --branch v3.1.0
     Cloning into '/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-e86wgp'...
     Note: switching to '96d7cc73a71ce950723aa3c50ce4fb275ae180b8'.
     
     You are in 'detached HEAD' state. You can look around, make experimental
     changes and commit them, and you can discard any commits you make in this
     state without impacting any branches by switching back to a branch.
     
     If you want to create a new branch to retain commits you create, you may
     do so (now or later) by using -c with the switch command. Example:
     
       git switch -c <new-branch-name>
     
     Or undo this operation with:
     
       git switch -
     
     Turn off this advice by setting config variable advice.detachedHead to false
     
  > Copying GTMSessionFetcher from
  `/Users/gsq/Library/Caches/CocoaPods/Pods/Release/GTMSessionFetcher/3.1.0-c9e71` to
  `Pods/GTMSessionFetcher`

-> Installing GoogleUtilities (7.11.0)
 > Git download
 > Git download
     $ /usr/bin/git clone https://github.com/google/GoogleUtilities.git
     /var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-6b2nnk --template=
     --single-branch --depth 1 --branch CocoaPods-7.11.0
     Cloning into '/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-6b2nnk'...
     Note: switching to '0543562f85620b5b7c510c6bcbef75b562a5127b'.
     
     You are in 'detached HEAD' state. You can look around, make experimental
     changes and commit them, and you can discard any commits you make in this
     state without impacting any branches by switching back to a branch.
     
     If you want to create a new branch to retain commits you create, you may
     do so (now or later) by using -c with the switch command. Example:
     
       git switch -c <new-branch-name>
     
     Or undo this operation with:
     
       git switch -
     
     Turn off this advice by setting config variable advice.detachedHead to false
     
  > Copying GoogleUtilities from
  `/Users/gsq/Library/Caches/CocoaPods/Pods/Release/GoogleUtilities/7.11.0-c2bdc` to
  `Pods/GoogleUtilities`

-> Installing Libuv-gRPC (0.0.10)
 > Git download
 > Git download
     $ /usr/bin/git clone https://github.com/libuv/libuv.git
     /var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-fmn3ne --template=
     --single-branch --depth 1 --branch v1.37.0
     Cloning into '/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-fmn3ne'...
     Note: switching to '02a9e1be252b623ee032a3137c0b0c94afbe6809'.
     
     You are in 'detached HEAD' state. You can look around, make experimental
     changes and commit them, and you can discard any commits you make in this
     state without impacting any branches by switching back to a branch.
     
     If you want to create a new branch to retain commits you create, you may
     do so (now or later) by using -c with the switch command. Example:
     
       git switch -c <new-branch-name>
     
     Or undo this operation with:
     
       git switch -
     
     Turn off this advice by setting config variable advice.detachedHead to false
     
  > Copying Libuv-gRPC from
  `/Users/gsq/Library/Caches/CocoaPods/Pods/Release/Libuv-gRPC/0.0.10-55e51` to `Pods/Libuv-gRPC`

-> Installing PromisesObjC (2.1.1)
 > Git download
 > Git download
     $ /usr/bin/git clone https://github.com/google/promises.git
     /var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-qziuk5 --template=
     --single-branch --depth 1 --branch 2.1.1
     Cloning into '/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-qziuk5'...
     Note: switching to '3e4e743631e86c8c70dbc6efdc7beaa6e90fd3bb'.
     
     You are in 'detached HEAD' state. You can look around, make experimental
     changes and commit them, and you can discard any commits you make in this
     state without impacting any branches by switching back to a branch.
     
     If you want to create a new branch to retain commits you create, you may
     do so (now or later) by using -c with the switch command. Example:
     
       git switch -c <new-branch-name>
     
     Or undo this operation with:
     
       git switch -
     
     Turn off this advice by setting config variable advice.detachedHead to false
     
  > Copying PromisesObjC from
  `/Users/gsq/Library/Caches/CocoaPods/Pods/Release/PromisesObjC/2.1.1-ab77f` to `Pods/PromisesObjC`

-> Installing abseil (1.20211102.0)
 > Git download
 > Git download
     $ /usr/bin/git clone https://github.com/abseil/abseil-cpp.git
     /var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-rmez84 --template=
     --single-branch --depth 1 --branch 20211102.0
     Cloning into '/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-rmez84'...
     Note: switching to '215105818dfde3174fe799600bb0f3cae233d0bf'.
     
     You are in 'detached HEAD' state. You can look around, make experimental
     changes and commit them, and you can discard any commits you make in this
     state without impacting any branches by switching back to a branch.
     
     If you want to create a new branch to retain commits you create, you may
     do so (now or later) by using -c with the switch command. Example:
     
       git switch -c <new-branch-name>
     
     Or undo this operation with:
     
       git switch -
     
     Turn off this advice by setting config variable advice.detachedHead to false
     
  > Copying abseil from `/Users/gsq/Library/Caches/CocoaPods/Pods/Release/abseil/1.20211102.0-ebe5b`
  to `Pods/abseil`

-> Installing cloud_firestore (4.4.1)

-> Installing firebase_auth (4.2.7)

-> Installing firebase_core (2.6.0)

-> Installing gRPC-C++ (1.44.0)
 > Git download
 > Git download
     $ /usr/bin/git clone https://github.com/grpc/grpc.git
     /var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-q63mg1 --template=
     --single-branch --depth 1 --branch v1.44.0
     Cloning into '/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-q63mg1'...
     Note: switching to '591d56e1300b6d11948e1b821efac785a295989c'.
     
     You are in 'detached HEAD' state. You can look around, make experimental
     changes and commit them, and you can discard any commits you make in this
     state without impacting any branches by switching back to a branch.
     
     If you want to create a new branch to retain commits you create, you may
     do so (now or later) by using -c with the switch command. Example:
     
       git switch -c <new-branch-name>
     
     Or undo this operation with:
     
       git switch -
     
     Turn off this advice by setting config variable advice.detachedHead to false
     
     Updating files: 100% (9462/9462), done.
 > Running prepare command
   $ /bin/bash -c  set -e set -e     find src/core -type f \( -path '*.h' -or -path '*.cc' \)
   -print0 | xargs -0 -L1 sed -E -i'.grpc_back' 's;#include <openssl/(.*)>;#if COCOAPODS==1\  
   #include <openssl_grpc/\1>\ #else\   #include <openssl/\1>\ #endif;g'     find third_party/xxhash
   -type f -name xxhash.h -print0 | xargs -0 -L1 sed -E -i'.grpc_back' 's;@param([^,]*),;@param\1
   ,;g'     find src/core/ third_party/xxhash/ -type f -name '*.grpc_back' -print0 | xargs -0 rm
  > Copying gRPC-C++ from `/Users/gsq/Library/Caches/CocoaPods/Pods/Release/gRPC-C++/1.44.0-9675f`
  to `Pods/gRPC-C++`

-> Installing gRPC-Core (1.44.0)
 > Git download
 > Git download
     $ /usr/bin/git clone https://github.com/grpc/grpc.git
     /var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69 --template=
     --single-branch --depth 1 --branch v1.44.0
     Cloning into '/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69'...
     Note: switching to '591d56e1300b6d11948e1b821efac785a295989c'.
     
     You are in 'detached HEAD' state. You can look around, make experimental
     changes and commit them, and you can discard any commits you make in this
     state without impacting any branches by switching back to a branch.
     
     If you want to create a new branch to retain commits you create, you may
     do so (now or later) by using -c with the switch command. Example:
     
       git switch -c <new-branch-name>
     
     Or undo this operation with:
     
       git switch -
     
     Turn off this advice by setting config variable advice.detachedHead to false
     
     Updating files: 100% (9462/9462), done.
     $ /usr/bin/git -C /var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69
     submodule update --init --recursive
     Submodule 'third_party/abseil-cpp' (https://github.com/abseil/abseil-cpp.git) registered for path 'third_party/abseil-cpp'
     Submodule 'third_party/benchmark' (https://github.com/google/benchmark) registered for path 'third_party/benchmark'
     Submodule 'third_party/bloaty' (https://github.com/google/bloaty.git) registered for path 'third_party/bloaty'
     Submodule 'third_party/boringssl-with-bazel' (https://github.com/google/boringssl.git) registered for path 'third_party/boringssl-with-bazel'
     Submodule 'third_party/cares/cares' (https://github.com/c-ares/c-ares.git) registered for path 'third_party/cares/cares'
     Submodule 'third_party/envoy-api' (https://github.com/envoyproxy/data-plane-api.git) registered for path 'third_party/envoy-api'
     Submodule 'third_party/googleapis' (https://github.com/googleapis/googleapis.git) registered for path 'third_party/googleapis'
     Submodule 'third_party/googletest' (https://github.com/google/googletest.git) registered for path 'third_party/googletest'
     Submodule 'third_party/libuv' (https://github.com/libuv/libuv.git) registered for path 'third_party/libuv'
     Submodule 'third_party/opencensus-proto' (https://github.com/census-instrumentation/opencensus-proto.git) registered for path 'third_party/opencensus-proto'
     Submodule 'third_party/opentelemetry' (https://github.com/open-telemetry/opentelemetry-proto.git) registered for path 'third_party/opentelemetry'
     Submodule 'third_party/protobuf' (https://github.com/protocolbuffers/protobuf.git) registered for path 'third_party/protobuf'
     Submodule 'third_party/protoc-gen-validate' (https://github.com/envoyproxy/protoc-gen-validate.git) registered for path 'third_party/protoc-gen-validate'
     Submodule 'third_party/re2' (https://github.com/google/re2.git) registered for path 'third_party/re2'
     Submodule 'third_party/xds' (https://github.com/cncf/xds.git) registered for path 'third_party/xds'
     Submodule 'third_party/zlib' (https://github.com/madler/zlib) registered for path 'third_party/zlib'
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/abseil-cpp'...
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/benchmark'...
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/bloaty'...
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/boringssl-with-bazel'...
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/cares/cares'...
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/envoy-api'...
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/googleapis'...
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/googletest'...
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/libuv'...
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/opencensus-proto'...
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/opentelemetry'...
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/protobuf'...
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/protoc-gen-validate'...
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/re2'...
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/xds'...
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/zlib'...
     Submodule path 'third_party/abseil-cpp': checked out '215105818dfde3174fe799600bb0f3cae233d0bf'
     Submodule path 'third_party/benchmark': checked out '0baacde3618ca617da95375e0af13ce1baadea47'
     Submodule path 'third_party/bloaty': checked out '60209eb1ccc34d5deefb002d1b7f37545204f7f2'
     Submodule 'third_party/abseil-cpp' (https://github.com/abseil/abseil-cpp.git) registered for path 'third_party/bloaty/third_party/abseil-cpp'
     Submodule 'third_party/capstone' (https://github.com/aquynh/capstone.git) registered for path 'third_party/bloaty/third_party/capstone'
     Submodule 'third_party/demumble' (https://github.com/nico/demumble.git) registered for path 'third_party/bloaty/third_party/demumble'
     Submodule 'third_party/googletest' (https://github.com/google/googletest.git) registered for path 'third_party/bloaty/third_party/googletest'
     Submodule 'third_party/protobuf' (https://github.com/protocolbuffers/protobuf.git) registered for path 'third_party/bloaty/third_party/protobuf'
     Submodule 'third_party/re2' (https://github.com/google/re2) registered for path 'third_party/bloaty/third_party/re2'
     Submodule 'third_party/zlib' (https://github.com/madler/zlib) registered for path 'third_party/bloaty/third_party/zlib'
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/bloaty/third_party/abseil-cpp'...
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/bloaty/third_party/capstone'...
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/bloaty/third_party/demumble'...
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/bloaty/third_party/googletest'...
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/bloaty/third_party/protobuf'...
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/bloaty/third_party/re2'...
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/bloaty/third_party/zlib'...
     Submodule path 'third_party/bloaty/third_party/abseil-cpp': checked out '5dd240724366295970c613ed23d0092bcf392f18'
     Submodule path 'third_party/bloaty/third_party/capstone': checked out '852f46a467cb37559a1f3a18bd45d5ca8c6fc5e7'
     Submodule path 'third_party/bloaty/third_party/demumble': checked out '01098eab821b33bd31b9778aea38565cd796aa85'
     Submodule path 'third_party/bloaty/third_party/googletest': checked out '565f1b848215b77c3732bca345fe76a0431d8b34'
     Submodule path 'third_party/bloaty/third_party/protobuf': checked out 'bc1773c42c9c3c522145a3119e989e0dff2a8d54'
     Submodule 'third_party/benchmark' (https://github.com/google/benchmark.git) registered for path 'third_party/bloaty/third_party/protobuf/third_party/benchmark'
     Submodule 'third_party/googletest' (https://github.com/google/googletest.git) registered for path 'third_party/bloaty/third_party/protobuf/third_party/googletest'
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/bloaty/third_party/protobuf/third_party/benchmark'...
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/bloaty/third_party/protobuf/third_party/googletest'...
     Submodule path 'third_party/bloaty/third_party/protobuf/third_party/benchmark': checked out '5b7683f49e1e9223cf9927b24f6fd3d6bd82e3f8'
     Submodule path 'third_party/bloaty/third_party/protobuf/third_party/googletest': checked out '5ec7f0c4a113e2f18ac2c6cc7df51ad6afc24081'
     Submodule path 'third_party/bloaty/third_party/re2': checked out '5bd613749fd530b576b890283bfb6bc6ea6246cb'
     Submodule path 'third_party/bloaty/third_party/zlib': checked out 'cacf7f1d4e3d44d871b605da3b647f07d718623f'
     Submodule path 'third_party/boringssl-with-bazel': checked out 'b9232f9e27e5668bc0414879dcdedb2a59ea75f2'
     Submodule path 'third_party/cares/cares': checked out 'e982924acee7f7313b4baa4ee5ec000c5e373c30'
     Submodule path 'third_party/envoy-api': checked out '20b1b5fcee88a20a08b71051a961181839ec7268'
     Submodule path 'third_party/googleapis': checked out '2f9af297c84c55c8b871ba4495e01ade42476c92'
     Submodule path 'third_party/googletest': checked out 'c9ccac7cb7345901884aabf5d1a786cfa6e2f397'
     Submodule path 'third_party/libuv': checked out '02a9e1be252b623ee032a3137c0b0c94afbe6809'
     Submodule path 'third_party/opencensus-proto': checked out '4aa53e15cbf1a47bc9087e6cfdca214c1eea4e89'
     Submodule path 'third_party/opentelemetry': checked out '60fa8754d890b5c55949a8c68dcfd7ab5c2395df'
     Submodule path 'third_party/protobuf': checked out 'cb46755e6405e083b45481f5ea4754b180705529'
     Submodule 'third_party/benchmark' (https://github.com/google/benchmark.git) registered for path 'third_party/protobuf/third_party/benchmark'
     Submodule 'third_party/googletest' (https://github.com/google/googletest.git) registered for path 'third_party/protobuf/third_party/googletest'
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/protobuf/third_party/benchmark'...
     Cloning into '/private/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-srml69/third_party/protobuf/third_party/googletest'...
     Submodule path 'third_party/protobuf/third_party/benchmark': checked out '5b7683f49e1e9223cf9927b24f6fd3d6bd82e3f8'
     Submodule path 'third_party/protobuf/third_party/googletest': checked out '5ec7f0c4a113e2f18ac2c6cc7df51ad6afc24081'
     Submodule path 'third_party/protoc-gen-validate': checked out '59da36e59fef2267fc2b1849a05159e3ecdf24f3'
     Submodule path 'third_party/re2': checked out '8e08f47b11b413302749c0d8b17a1c94777495d5'
     Submodule path 'third_party/xds': checked out 'cb28da3451f158a947dfc45090fe92b07b243bc1'
     Submodule path 'third_party/zlib': checked out 'cacf7f1d4e3d44d871b605da3b647f07d718623f'
 > Running prepare command
   $ /bin/bash -c  set -e set -e     find src/core -type f \( -path '*.h' -or -path '*.cc' \)
   -print0 | xargs -0 -L1 sed -E -i'.grpc_back' 's;#include <openssl/(.*)>;#if COCOAPODS==1\  
   #include <openssl_grpc/\1>\ #else\   #include <openssl/\1>\ #endif;g'     find third_party/xxhash
   -type f -name xxhash.h -print0 | xargs -0 -L1 sed -E -i'.grpc_back' 's;@param([^,]*),;@param\1
   ,;g'     find src/core/ third_party/xxhash/ -type f -name '*.grpc_back' -print0 | xargs -0 rm
  > Copying gRPC-Core from `/Users/gsq/Library/Caches/CocoaPods/Pods/Release/gRPC-Core/1.44.0-943e4`
  to `Pods/gRPC-Core`

-> Installing leveldb-library (1.22.1)
 > Git download
 > Git download
     $ /usr/bin/git clone https://github.com/google/leveldb.git
     /var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-g1swk8 --template=
     --single-branch --depth 1 --branch 1.22
     Cloning into '/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-g1swk8'...
     Note: switching to '78b39d68c15ba020c0d60a3906fb66dbf1697595'.
     
     You are in 'detached HEAD' state. You can look around, make experimental
     changes and commit them, and you can discard any commits you make in this
     state without impacting any branches by switching back to a branch.
     
     If you want to create a new branch to retain commits you create, you may
     do so (now or later) by using -c with the switch command. Example:
     
       git switch -c <new-branch-name>
     
     Or undo this operation with:
     
       git switch -
     
     Turn off this advice by setting config variable advice.detachedHead to false
     
  > Copying leveldb-library from
  `/Users/gsq/Library/Caches/CocoaPods/Pods/Release/leveldb-library/1.22.1-50c7b` to
  `Pods/leveldb-library`

-> Installing nanopb (2.30909.0)
 > Git download
 > Git download
     $ /usr/bin/git clone https://github.com/nanopb/nanopb.git
     /var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-9i6ave --template=
     --single-branch --depth 1 --branch 0.3.9.9
     Cloning into '/var/folders/fc/n5827zt91vb65jnqcsgpv5cr0000gn/T/d20230217-51146-9i6ave'...
     Note: switching to '819d0a2173aff699fb8c364b6fb906f7cdb1a692'.
     
     You are in 'detached HEAD' state. You can look around, make experimental
     changes and commit them, and you can discard any commits you make in this
     state without impacting any branches by switching back to a branch.
     
     If you want to create a new branch to retain commits you create, you may
     do so (now or later) by using -c with the switch command. Example:
     
       git switch -c <new-branch-name>
     
     Or undo this operation with:
     
       git switch -
     
     Turn off this advice by setting config variable advice.detachedHead to false
     
  > Copying nanopb from `/Users/gsq/Library/Caches/CocoaPods/Pods/Release/nanopb/2.30909.0-b552c` to
  `Pods/nanopb`

-> Installing path_provider_foundation (0.0.1)
  - Running pre install hooks
  - Running pre integrate hooks

Generating Pods project
  - Creating Pods project
  - Installing files into Pods project
    - Adding source files
    - Adding frameworks
    - Adding libraries
    - Adding resources
    - Adding development pod helper files
    - Linking headers
  - Installing Pod Targets
    - Installing target `BoringSSL-GRPC` iOS 9.0
      - Copying module map file to `Pods/Target Support
      Files/BoringSSL-GRPC/BoringSSL-GRPC.modulemap`
      - Generating Info.plist file at `Pods/Target Support
      Files/BoringSSL-GRPC/BoringSSL-GRPC-Info.plist`
      - Generating dummy source at `Pods/Target Support Files/BoringSSL-GRPC/BoringSSL-GRPC-dummy.m`
    - Installing target `Firebase` iOS 11.0
    - Installing target `FirebaseAuth` iOS 11.0
      - Generating module map file at `Pods/Target Support
      Files/FirebaseAuth/FirebaseAuth.modulemap`
      - Generating umbrella header at `Pods/Target Support
      Files/FirebaseAuth/FirebaseAuth-umbrella.h`
      - Generating Info.plist file at `Pods/Target Support
      Files/FirebaseAuth/FirebaseAuth-Info.plist`
      - Generating dummy source at `Pods/Target Support Files/FirebaseAuth/FirebaseAuth-dummy.m`
    - Installing target `FirebaseCore` iOS 10.0
      - Generating module map file at `Pods/Target Support
      Files/FirebaseCore/FirebaseCore.modulemap`
      - Generating umbrella header at `Pods/Target Support
      Files/FirebaseCore/FirebaseCore-umbrella.h`
      - Generating Info.plist file at `Pods/Target Support
      Files/FirebaseCore/FirebaseCore-Info.plist`
      - Generating dummy source at `Pods/Target Support Files/FirebaseCore/FirebaseCore-dummy.m`
    - Installing target `FirebaseCoreInternal` iOS 10.0
      - Generating module map file at `Pods/Target Support
      Files/FirebaseCoreInternal/FirebaseCoreInternal.modulemap`
      - Generating umbrella header at `Pods/Target Support
      Files/FirebaseCoreInternal/FirebaseCoreInternal-umbrella.h`
      - Generating Info.plist file at `Pods/Target Support
      Files/FirebaseCoreInternal/FirebaseCoreInternal-Info.plist`
      - Generating dummy source at `Pods/Target Support
      Files/FirebaseCoreInternal/FirebaseCoreInternal-dummy.m`
    - Installing target `FirebaseFirestore` iOS 11.0
      - Generating module map file at `Pods/Target Support
      Files/FirebaseFirestore/FirebaseFirestore.modulemap`
      - Generating umbrella header at `Pods/Target Support
      Files/FirebaseFirestore/FirebaseFirestore-umbrella.h`
      - Generating Info.plist file at `Pods/Target Support
      Files/FirebaseFirestore/FirebaseFirestore-Info.plist`
      - Generating dummy source at `Pods/Target Support
      Files/FirebaseFirestore/FirebaseFirestore-dummy.m`
    - Installing target `Flutter` iOS 11.0
    - Installing target `GTMSessionFetcher` iOS 10.0
      - Generating module map file at `Pods/Target Support
      Files/GTMSessionFetcher/GTMSessionFetcher.modulemap`
      - Generating umbrella header at `Pods/Target Support
      Files/GTMSessionFetcher/GTMSessionFetcher-umbrella.h`
      - Generating Info.plist file at `Pods/Target Support
      Files/GTMSessionFetcher/GTMSessionFetcher-Info.plist`
      - Generating dummy source at `Pods/Target Support
      Files/GTMSessionFetcher/GTMSessionFetcher-dummy.m`
    - Installing target `GoogleUtilities` iOS 9.0
      - Generating module map file at `Pods/Target Support
      Files/GoogleUtilities/GoogleUtilities.modulemap`
      - Generating umbrella header at `Pods/Target Support
      Files/GoogleUtilities/GoogleUtilities-umbrella.h`
      - Generating Info.plist file at `Pods/Target Support
      Files/GoogleUtilities/GoogleUtilities-Info.plist`
      - Generating dummy source at `Pods/Target Support
      Files/GoogleUtilities/GoogleUtilities-dummy.m`
    - Installing target `Libuv-gRPC` iOS 9.0
      - Generating module map file at `Pods/Target Support Files/Libuv-gRPC/Libuv-gRPC.modulemap`
      - Generating umbrella header at `Pods/Target Support Files/Libuv-gRPC/Libuv-gRPC-umbrella.h`
      - Generating Info.plist file at `Pods/Target Support Files/Libuv-gRPC/Libuv-gRPC-Info.plist`
      - Generating dummy source at `Pods/Target Support Files/Libuv-gRPC/Libuv-gRPC-dummy.m`
    - Installing target `PromisesObjC` iOS 9.0
      - Generating module map file at `Pods/Target Support
      Files/PromisesObjC/PromisesObjC.modulemap`
      - Generating umbrella header at `Pods/Target Support
      Files/PromisesObjC/PromisesObjC-umbrella.h`
      - Generating Info.plist file at `Pods/Target Support
      Files/PromisesObjC/PromisesObjC-Info.plist`
      - Generating dummy source at `Pods/Target Support Files/PromisesObjC/PromisesObjC-dummy.m`
    - Installing target `abseil` iOS 9.0
      - Generating module map file at `Pods/Target Support Files/abseil/abseil.modulemap`
      - Generating umbrella header at `Pods/Target Support Files/abseil/abseil-umbrella.h`
      - Generating Info.plist file at `Pods/Target Support Files/abseil/abseil-Info.plist`
      - Generating dummy source at `Pods/Target Support Files/abseil/abseil-dummy.m`
    - Installing target `cloud_firestore` iOS 11.0
      - Generating module map file at `Pods/Target Support
      Files/cloud_firestore/cloud_firestore.modulemap`
      - Generating umbrella header at `Pods/Target Support
      Files/cloud_firestore/cloud_firestore-umbrella.h`
      - Generating Info.plist file at `Pods/Target Support
      Files/cloud_firestore/cloud_firestore-Info.plist`
      - Generating dummy source at `Pods/Target Support
      Files/cloud_firestore/cloud_firestore-dummy.m`
    - Installing target `firebase_auth` iOS 11.0
      - Generating module map file at `Pods/Target Support
      Files/firebase_auth/firebase_auth.modulemap`
      - Generating umbrella header at `Pods/Target Support
      Files/firebase_auth/firebase_auth-umbrella.h`
      - Generating Info.plist file at `Pods/Target Support
      Files/firebase_auth/firebase_auth-Info.plist`
      - Generating dummy source at `Pods/Target Support Files/firebase_auth/firebase_auth-dummy.m`
    - Installing target `firebase_core` iOS 11.0
      - Generating module map file at `Pods/Target Support
      Files/firebase_core/firebase_core.modulemap`
      - Generating umbrella header at `Pods/Target Support
      Files/firebase_core/firebase_core-umbrella.h`
      - Generating Info.plist file at `Pods/Target Support
      Files/firebase_core/firebase_core-Info.plist`
      - Generating dummy source at `Pods/Target Support Files/firebase_core/firebase_core-dummy.m`
    - Installing target `gRPC-C++` iOS 9.0
      - Generating Info.plist file at `Pods/Target Support
      Files/gRPC-C++/ResourceBundle-gRPCCertificates-Cpp-gRPC-C++-Info.plist`
      - Generating module map file at `Pods/Target Support Files/gRPC-C++/gRPC-C++.modulemap`
      - Generating umbrella header at `Pods/Target Support Files/gRPC-C++/gRPC-C++-umbrella.h`
      - Generating Info.plist file at `Pods/Target Support Files/gRPC-C++/gRPC-C++-Info.plist`
      - Generating dummy source at `Pods/Target Support Files/gRPC-C++/gRPC-C++-dummy.m`
    - Installing target `gRPC-Core` iOS 9.0
      - Copying module map file to `Pods/Target Support Files/gRPC-Core/gRPC-Core.modulemap`
      - Generating Info.plist file at `Pods/Target Support Files/gRPC-Core/gRPC-Core-Info.plist`
      - Generating dummy source at `Pods/Target Support Files/gRPC-Core/gRPC-Core-dummy.m`
    - Installing target `leveldb-library` iOS 8.0
      - Generating module map file at `Pods/Target Support
      Files/leveldb-library/leveldb-library.modulemap`
      - Generating umbrella header at `Pods/Target Support
      Files/leveldb-library/leveldb-library-umbrella.h`
      - Generating Info.plist file at `Pods/Target Support
      Files/leveldb-library/leveldb-library-Info.plist`
      - Generating dummy source at `Pods/Target Support
      Files/leveldb-library/leveldb-library-dummy.m`
    - Installing target `nanopb` iOS 9.0
      - Generating module map file at `Pods/Target Support Files/nanopb/nanopb.modulemap`
      - Generating umbrella header at `Pods/Target Support Files/nanopb/nanopb-umbrella.h`
      - Generating Info.plist file at `Pods/Target Support Files/nanopb/nanopb-Info.plist`
      - Generating dummy source at `Pods/Target Support Files/nanopb/nanopb-dummy.m`
    - Installing target `path_provider_foundation` iOS 9.0
      - Generating module map file at `Pods/Target Support
      Files/path_provider_foundation/path_provider_foundation.modulemap`
      - Generating umbrella header at `Pods/Target Support
      Files/path_provider_foundation/path_provider_foundation-umbrella.h`
      - Generating Info.plist file at `Pods/Target Support
      Files/path_provider_foundation/path_provider_foundation-Info.plist`
      - Generating dummy source at `Pods/Target Support
      Files/path_provider_foundation/path_provider_foundation-dummy.m`
  - Installing Aggregate Targets
    - Installing target `Pods-Runner` iOS 11.0
      - Generating Info.plist file at `Pods/Target Support Files/Pods-Runner/Pods-Runner-Info.plist`
      - Generating module map file at `Pods/Target Support Files/Pods-Runner/Pods-Runner.modulemap`
      - Generating umbrella header at `Pods/Target Support Files/Pods-Runner/Pods-Runner-umbrella.h`
      - Generating dummy source at `Pods/Target Support Files/Pods-Runner/Pods-Runner-dummy.m`
  - Generating deterministic UUIDs
  - Stabilizing target UUIDs
  - Running post install hooks
    - Podfile
  - Writing Xcode project file to `Pods/Pods.xcodeproj`
  Cleaning up sandbox directory

Integrating client project

Integrating target `Pods-Runner` (`Runner.xcodeproj` project)
  Adding Build Phase '[CP] Embed Pods Frameworks' to project.
  - Running post integrate hooks
  - Writing Lockfile in `Podfile.lock`
  - Writing Manifest in `Pods/Manifest.lock`

-> Pod installation complete! There are 5 dependencies from the Podfile and 20 total pods installed.

[!] CocoaPods did not set the base configuration of your project because your project already has a custom config set. In order for CocoaPods integration to work at all, please either set the base configurations of the target `Runner` to `Target Support Files/Pods-Runner/Pods-Runner.profile.xcconfig` or include the `Target Support Files/Pods-Runner/Pods-Runner.profile.xcconfig` in your build configuration (`Flutter/Release.xcconfig`).
```

