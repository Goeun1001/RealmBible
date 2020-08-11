//
//  SceneDelegate.swift
//  Bible
//
//  Created by jge on 2020/08/05.
//  Copyright © 2020 jge. All rights reserved.
//

import UIKit
import SwiftUI

class LoadingSettings: ObservableObject {
    @Published var isLoaded: Bool = false
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        let contentView = StartView()
        let onload = LoadingSettings()
//        let contentView = ContentView()

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
//            window.rootViewController = UIHostingController(rootView: contentView)
            window.rootViewController = UIHostingController(rootView: contentView.environmentObject(onload))
            self.window = window
            window.makeKeyAndVisible()
        }
        
        let fileManager = FileManager.default

        guard let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let finalDatabaseURL = documentsUrl.appendingPathComponent("holybible.db")

        do {
            if !fileManager.fileExists(atPath: finalDatabaseURL.path) {
                print("DB does not exist in documents folder")
                if let dbFilePath = Bundle.main.path(forResource: "holybible", ofType: "db") {
                    try fileManager.copyItem(atPath: dbFilePath, toPath: finalDatabaseURL.path)
                    
                    
                } else {
                    print("Uh oh - foo.db is not in the app bundle")
                }
            } else {
                print("Database file found at path: \(finalDatabaseURL.path)")
            }
        } catch {
            print("Unable to copy foo.db: \(error)")
        }
        
//        DataReader().setUpRealm()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

struct StartView: View {
    @EnvironmentObject var settings: LoadingSettings

    var body: some View {
        if UserDefaults.standard.bool(forKey: "isLoaded") {
            return AnyView(VerseView())
        } else {
            return AnyView(LoadingBaseView())
        }
    }
}
