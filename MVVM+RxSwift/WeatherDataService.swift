//
//  WeatherDataService.swift
//  MVVM+RxSwift
//
//  Created by Luka Gabric on 14/02/2017.
//  Copyright © 2017 lukagabric.com. All rights reserved.
//

import Foundation
import RxSwift

open class WeatherDataService {
    
    open func fetchWeatherData() -> Observable<WeatherData> {
        let observable = Observable<WeatherData>.create { [weak self] observer in
            if let sself = self {
                let time = 0.5 + TimeInterval(arc4random_uniform(10)) / 10.0
                
                DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                    observer.onNext(sself.createRandomWeatherData())
                    observer.onCompleted()
                }
            }
            
            return Disposables.create()
        }
        
        return observable.shareReplay(1)

    }
    
    private func createRandomWeatherData() -> WeatherData {
        let subtractTime = -1 * TimeInterval(arc4random_uniform(3600))
        let date = Date().addingTimeInterval(subtractTime)
        
        let temperature = -20 + Float(arc4random_uniform(400)) / 10.0
        
        let tempDiff = -8 + Float(arc4random_uniform(160)) / 10.0
        let realFeel = temperature + tempDiff
        
        let precipitationPercentage = Float(arc4random_uniform(101))
        
        let weatherData = WeatherData(locationName: "Osijek", temperature: temperature, realFeel: realFeel, precipitationPercentage: precipitationPercentage, updatedAt: date)

        return weatherData
    }
    
}
