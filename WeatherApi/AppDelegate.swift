//
//  AppDelegate.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/10/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_
        application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)

        let realm = try? Realm()
        let dataBaseService = DataBaseService(dataRealm: CountryDataRealm(realm: realm))
        
        let countriesViewController = CountriesViewController(
            countriesNetworkService: CountriesNetworkService(),
            requestService: RequestService(session: URLSession(configuration: .default)),
            model: CountriesModel(),
            dataBaseService: dataBaseService
        )
        
        window.rootViewController = UINavigationController(rootViewController: countriesViewController)
        window.makeKeyAndVisible()

        self.window = window
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}
