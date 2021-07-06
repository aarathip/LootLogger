//
//  AppDelegate.swift
//  LootLogger
//
//  Created by Aarathi Prasad on 7/3/21.
//

import UIKit
//to use Firebase
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var ref: DatabaseReference!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        //Make sure to enable anonymous authentication on the Firebase console also
//        Auth.auth().signInAnonymously { authResult, error in
//            // if no error
//            if let error = error {
//                print ("Error logging in \(error)")
//            }
//            else {
//                guard let user = authResult?.user else { return }
//                Database.database().isPersistenceEnabled = true
//                self.ref = Database.database().reference()
//                print("User id: " + user.uid)
//            }
//            //let isAnonymous = user.isAnonymous  // true
//            self.ref.child("users/\(user.uid)/").getData { (error, snapshot) in
//                if let error = error {
//                    print("Error getting data \(error)")
//                }
//                else if snapshot.exists() {
//                    print("Got data \(snapshot.value!)")
//                }
//                else {
//                    print("No data available")
//                }
//            }
     //   }
        return true
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

