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

        let dataBaseService = DataBaseService(provider: CountryDataRLM())
        let requestService = RequestService(session: URLSession(configuration: .default))
        
        let countriesNetworkService = CountriesNetworkService(requestService: requestService, dataBaseService: dataBaseService)
        
        let countriesViewController = CountriesViewController(countriesNetworkService: countriesNetworkService, model: CountriesModel())
            
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
