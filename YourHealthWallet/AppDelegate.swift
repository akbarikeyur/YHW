//
//  AppDelegate.swift
//  YourHealthWallet
//
//  Created by Shridhar on 1/30/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import Firebase
import FBSDKLoginKit
import Fabric
import Crashlytics
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var locationManager: CLLocationManager!
    var dicHRA :NSMutableDictionary = [:]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        GMSServices.provideAPIKey("AIzaSyBJh7rENCQR6UcKnUQ6IL3vnAxzrG4yH9Q")
        
        Fabric.with([Crashlytics.self])

        IQKeyboardManager.sharedManager().enable = true
        
        let navigationBarAppearace = UINavigationBar.appearance()
        
        navigationBarAppearace.tintColor = UIColor.red
        navigationBarAppearace.barTintColor = UIColor.blue
        
        //application.statusBarStyle = .default
        
        //Autolayout logs disable
        UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")

        //Firebase configration
        FirebaseApp.configure()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)

        //If user is LoggedIn then redirect to dashbaord otherwise iniatial
        AppUserDefaults.isUserLoggedIn() ? AppDelegate.setDashboard() :AppDelegate.setInitial()

        window?.makeKeyAndVisible()
        
        //Facebook
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        //setLocationManager()
        askForHealthKitAccess()
        
        return true
    }
    
    private func askForHealthKitAccess() {
        
        HealthManagerKit.Shared.authorizeHealthKit { (authorized, error) -> Void in
            if !authorized, let error = error {
                //self.showAlert(title: "HealthKit Authentication Failed", message: error.localizedDescription)
            }
        }
    }
    
//    private func showAlert(title: String, message: String) {
//        
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
//        alertController.addAction(okAction)
//        self.present(alertController, animated: true, completion: nil)
//    }
//    //MARK:- Location
//    func setLocationManager()
//    {
//        locationManager = CLLocationManager()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        //locationManager.distanceFilter = CLLocationDistance(USERVALUE.DISTANCE_DIFFERENCE)
//        locationManager.pausesLocationUpdatesAutomatically = false
//        locationManager.requestAlwaysAuthorization()
//
//        if CLLocationManager.locationServicesEnabled() {
//            //locationManager.startUpdatingHeading()
//            locationManager.startUpdatingLocation()
//            locationManager.startMonitoringSignificantLocationChanges()
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location = locations.last!
//        GlobalVars.latitude = Float(location.coordinate.latitude)
//        GlobalVars.longitude = Float(location.coordinate.longitude)
//        NotificationCenter.default.post(name:NSNotification.Name(rawValue: NOTIFICATION.ON_UPDATE_USER_LOCATION), object: nil)
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(error.localizedDescription)
//    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "YourHealthWallet")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension AppDelegate {

    class func mainWindow() -> UIWindow {
        return ((UIApplication.shared.delegate?.window)!)!
    }
    class func shared() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    //Initial Controller setup
    class func setInitial() {
        let startUpNavigation = NavigationController()
        let initialVC = InitialViewController()
        startUpNavigation.viewControllers = [initialVC]
        startUpNavigation.setNavigationBarHidden(true, animated: false)
        self.mainWindow().rootViewController  = startUpNavigation
    }
    
    //Login setup
    class func setLoginVC()
    {
        let startUpNavigation = NavigationController()
        let initialVC = LoginViewController()
        initialVC.isFromRegister = true
        startUpNavigation.viewControllers = [initialVC]
        startUpNavigation.setNavigationBarHidden(true, animated: false)
        self.mainWindow().rootViewController  = startUpNavigation
    }
    
    //Login setup
    class func setHRAVC()
    {
        let startUpNavigation = NavigationController()
        let hRABaseVC = HRABaseVC()
        startUpNavigation.viewControllers = [hRABaseVC]
        startUpNavigation.setNavigationBarHidden(true, animated: false)
        self.mainWindow().rootViewController  = startUpNavigation
    }
    
    //Dashboard setup
    class func setDashboard() {
        
        if (AppUserDefaults.isHRACompleted())
        {
            let startUpNavigation = NavigationController()
            let dashBoardVC = HomeDraverController()
            startUpNavigation.viewControllers = [dashBoardVC]
            startUpNavigation.setNavigationBarHidden(true, animated: false)
            self.mainWindow().rootViewController  = startUpNavigation
        }
        else
        {
           self.setHRAVC()
        }
    }
    
}

