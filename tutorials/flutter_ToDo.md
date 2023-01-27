# Implement a ToDo APP

Reference: [Author. Madan]([1. Flutter Todo App using Firebase Database | Complete Line by Line Explanation - YouTube](https://www.youtube.com/watch?v=qFrJ30VFCFc&list=PL9n0l8rSshSnT19B70XO9dYUucjD3aYWa&index=36)), [Author. Dev Stack]([(107) Flutter - Connect Firebase to your Flutter (App & Web) || Project Configuration || Signup a user #01 - YouTube](https://www.youtube.com/watch?v=p1NPtRdvQBU&list=PLtIU0BH0pkKrQZUFWENF_VXINhfv9WiIA))

> Follow the tutorials to see how it works.

## 1. 在创建Flutter 新项目后连接上[Firebase]([Firebase console (google.com)](https://console.firebase.google.com/u/0/?hl=zh-cn&pli=1))

- Bundle Identifier in `./macos/Runner/Configs/AppInfo.xcconfig`

- More details in [Configure 1]([Flutter: Configure Firebase for iOS and Android (2023) - Kindacode](https://www.kindacode.com/article/flutter-configure-firebase-for-ios-and-android/)),  [Configure 2]([VSCode Flutter开发集成iOS版FireBase - 简书 (jianshu.com)](https://www.jianshu.com/p/cff76974d983)),  [Configure 3]([How To Add Firebase to Your iOS App Quickly ← [Updated 2020\] (softauthor.com)](https://softauthor.com/add-firebase-sdk-to-your-ios-app-using-cocoapods/#:~:text=Add Initialization Code Open up FirebaseiOSDemo folder from,lines of code. One is at the top%3A)), [Official Document]([将 Firebase 添加到您的 Apple 项目  | 适用于 Apple 平台的 Firebase (google.com)](https://firebase.google.com/docs/ios/setup?authuser=0&hl=zh-cn))

  暂时不考虑Facebook，Google登陆



> In the Console,  `r`  to hot reload

## 2. 在`./lib `下main文件中构建主体框架

- 在`./lib/displays ` 设计主页
  - Container ➡️ Scaffold
  - Problem: [Prefer const with constant], [Solutions](https://stackoverflow.com/questions/68554055/flutter-const-with-const-constructors)

> `stf` to use Stateful Widget

- Firebase Authorization