//
//  AppDelegate.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import UIKit
#if DEBUG
import netfox
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if DEBUG
        NFX.sharedInstance().start()
        #endif
        
        setRootViewController()
        return true
    }
    
    func setRootViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.navigationController = UINavigationController()
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.window?.rootViewController = self.navigationController
        self.window?.makeKeyAndVisible()
        
        if let retrievedToken = UserDefault.getUserToken() {
            self.navigationController?.pushViewController(HomepageViewController(), animated: false)
        } else {
            self.navigationController?.pushViewController(FormViewController(viewModel: LoginViewModel()), animated: false)
        }

        
    }
}
