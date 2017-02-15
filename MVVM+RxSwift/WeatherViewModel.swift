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
    let precipitation: Driver<String>
    let updatedAt: Driver<String>
    
    let isLoading: Driver<Bool>
    let hasFailed: Driver<Bool>
    
    private let locationNameVar = Variable<String>("")
    private let temperatureVar = Variable<String>("")
    private let realFeelVar = Variable<String>("")
    private let precipitationVar = Variable<String>("")
    private let updatedAtVar = Variable<String>("")
    
    private let isLoadingVar = Variable<Bool>(false)
    private let hasFailedVar = Variable<Bool>(false)
    
    private let dateFormatter: DateFormatter
    
    private let disposeBag = DisposeBag()
    
    private let weatherDataService: WeatherDataService
    
    //MARK: - Init
    
    init(weatherDataService: WeatherDataService, refreshDriver: Driver<Void>) {
        self.weatherDataService = weatherDataService
        
        self.locationName = self.locationNameVar.asDriver()
        self.temperature = self.temperatureVar.asDriver()
        self.realFeel = self.realFeelVar.asDriver()
        self.precipitation = self.precipitationVar.asDriver()
        self.updatedAt = self.updatedAtVar.asDriver()
        
        self.isLoading = self.isLoadingVar.asDriver()
        self.hasFailed = self.hasFailedVar.asDriver()
        
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateStyle = .medium
        self.dateFormatter.timeStyle = .short
        
        refreshDriver.startWith(()).drive(onNext: { [weak self] in self?.refreshData() }).disposed(by: self.disposeBag)
    }
    
    //MARK: - Private
    
    private func refreshData() {
        self.hasFailedVar.value = false
        self.isLoadingVar.value = true
        
        self.weatherDataService.fetchWeatherData().subscribe(
            onNext: { [weak self] weatherData in
                guard let sself = self else { return }
                
                sself.locationNameVar.value = weatherData.locationName
                sself.temperatureVar.value = String(format: "%.1f\u{00B0}C", weatherData.temperature)
                sself.realFeelVar.value = String(format: "%.1f\u{00B0}C", weatherData.realFeel)
                sself.precipitationVar.value = String(format: "%.0f%%", weatherData.precipitation)
                sself.updatedAtVar.value = sself.dateFormatter.string(from: weatherData.updatedAt)
            },
            onError: { [weak self] _ in
                guard let sself = self else { return }
                
                sself.isLoadingVar.value = false
                sself.hasFailedVar.value = true
            },
            onCompleted: { [weak self] in
                guard let sself = self else { return }
                
                sself.isLoadingVar.value = false
                sself.hasFailedVar.value = false
        }).disposed(by: self.disposeBag)
    }
    
    //MARK: -
}
