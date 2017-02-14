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
        
    //MARK: - Init
    
    init(weatherDataService: WeatherDataService, refreshDriver: Driver<Void>) {
        self.weatherDataService = weatherDataService
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        let refreshDataDriver = refreshDriver.startWith(())
        let fetchWeatherDataObservable = refreshDataDriver.asObservable().flatMapLatest { weatherDataService.fetchWeatherData() }
        let fetchWeatherDataDriver = fetchWeatherDataObservable.asDriver(onErrorDriveWith: Driver.empty())
        
        self.locationName = fetchWeatherDataDriver.map { $0.locationName }
        self.temperature = fetchWeatherDataDriver.map { String(format: "%.1f", $0.temperature) }
        self.realFeel = fetchWeatherDataDriver.map { String(format: "%.1f", $0.realFeel) }
        self.precipitationPercentage = fetchWeatherDataDriver.map { String(format: "%.0f%%", $0.precipitationPercentage) }
        self.updatedAt = fetchWeatherDataDriver.map { dateFormatter.string(from: $0.updatedAt) }
        
        self.isLoading = Driver.of(refreshDataDriver.map { _ in true }, fetchWeatherDataDriver.map { _ in false }).merge()
        self.hasFailed = Driver.of(refreshDataDriver.map { _ in true }, fetchWeatherDataObservable.map { _ in false }.asDriver(onErrorJustReturn: true)).merge()
    }
    
    //MARK: -
}
