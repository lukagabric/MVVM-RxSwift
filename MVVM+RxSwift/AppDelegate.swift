//
//  AppDelegate.swift
//  MVVM+RxSwift
//
//  Created by Luka Gabric on 14/02/2017.
//  Copyright © 2017 lukagabric.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let weatherDataService = OccasionalErrorWeatherDataService()
//        let weatherDataService = WeatherDataService()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = WeatherViewController(weatherDataService: weatherDataService)
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
}
