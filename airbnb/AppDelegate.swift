//
//  AppDelegate.swift
//  airbnb
//
//  Created by JB on 2021/05/22.
//
 
import UIKit
import GoogleSignIn
import FBSDKCoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    public static var user: GIDGoogleUser!
    // 구글 로그인
    // 구글 로그인 성공시
        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
            if let error = error {
                if(error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                    print("not signed in before or signed out")
                } else {
                    print(error.localizedDescription)
                }
            }
            
            // singleton 객체 - user가 로그인을 하면, AppDelegate.user로 다른곳에서 사용 가능
            AppDelegate.user = user
            
            // 사용자 정보 가져오기
//            if let userId = user.userID,                  // For client-side use only!
//                let idToken = user.authentication.idToken, // Safe to send to the server
//                let fullName = user.profile.name,
//                let givenName = user.profile.givenName,
//                let familyName = user.profile.familyName,
//                let email = user.profile.email {
//
//                print("Token : \(idToken)")
//                print("User ID : \(userId)")
//                print("User Email : \(email)")
//                print("User Name : \((fullName))")
//
//            } else {
//                print("Error : User Data Not Found")
//            }
            
            return
        }
    // 구글 로그아웃시
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Disconnect")
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // 구글
        GIDSignIn.sharedInstance()?.handle(url)
        
        //페이스북
        ApplicationDelegate.shared.application(
                    app,
                    open: url,
                    sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                    annotation: options[UIApplication.OpenURLOptionsKey.annotation]
                )
        
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 구글
        GIDSignIn.sharedInstance().clientID = "186497991722-ts2ubj7gaf851vfv8b3vcnqjq0g5p5mf.apps.googleusercontent.com"
        GIDSignIn.sharedInstance()?.delegate = self
        
        // 페이스북
        ApplicationDelegate.shared.application(
                    application,
                    didFinishLaunchingWithOptions: launchOptions
                )
        return true
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        AppEvents.activateApp()
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

