//
//  WeatherViewModel.swift
//  MVVM+RxSwift
//
//  Created by Luka Gabric on 14/02/2017.
//  Copyright © 2017 lukagabric.com. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class WeatherViewModel {
    
    //MARK: - Vars
    
    let locationName: Driver<String>
    let temperature: Driver<String>
    let realFeel: Driver<String>
    let precipitationPercentage: Driver<String>
    let updatedAt: Driver<String>
    
    let isLoading: Driver<Bool>
    let hasFailed: Driver<Bool>
    
    private let weatherDataService: WeatherDataService
    
    private enum WeatherDataEvent {
        case weatherData(WeatherData)
        case error
        case loading
    }
        
    //MARK: - Init
    
    init(weatherDataService: WeatherDataService, refreshDriver: Driver<Void>) {
        self.weatherDataService = weatherDataService
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        let weatherDataEventDriver = refreshDriver
            .startWith(())
            .flatMapLatest { _ -> Driver<WeatherDataEvent> in
                return weatherDataService.fetchWeatherData()
                    .map { .weatherData($0) }
                    .asDriver(onErrorJustReturn: .error)
                    .startWith(.loading)
        }
        let weatherDataDriver = weatherDataEventDriver
            .flatMapLatest { event -> Driver<WeatherData> in
                switch event {
                case .weatherData(let data): return Driver.just(data)
                default: return Driver.empty()
                }
        }
        self.isLoading = weatherDataEventDriver
            .map { event in
                switch event {
                case .loading: return true
                default: return false
                }
        }
        self.hasFailed = weatherDataEventDriver
            .map { event in
                switch event {
                case .error: return true
                default: return false
                }
        }
        
        self.locationName = weatherDataDriver.map { $0.locationName }
        self.temperature = weatherDataDriver.map { String(format: "%.1f\u{00B0}C", $0.temperature) }
        self.realFeel = weatherDataDriver.map { String(format: "%.1f\u{00B0}C", $0.realFeel) }
        self.precipitationPercentage = weatherDataDriver.map { String(format: "%.0f%%", $0.precipitationPercentage) }
        self.updatedAt = weatherDataDriver.map { dateFormatter.string(from: $0.updatedAt) }
    }
    
    //MARK: -
}
