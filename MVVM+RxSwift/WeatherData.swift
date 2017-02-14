//
//  WeatherData.swift
//  MVVM+RxSwift
//
//  Created by Luka Gabric on 14/02/2017.
//  Copyright © 2017 lukagabric.com. All rights reserved.
//

import Foundation

public struct WeatherData {
    
    var locationName: String
    var temperature: Float
    var realFeel: Float
    var precipitationPercentage: Float
    var updatedAt: Date
    
}

extension WeatherData: Equatable {}
public func ==(lhs: WeatherData, rhs: WeatherData) -> Bool {
    return lhs.locationName == rhs.locationName &&
        lhs.temperature == rhs.temperature &&
        lhs.realFeel == rhs.realFeel &&
        lhs.precipitationPercentage == rhs.precipitationPercentage &&
        lhs.updatedAt == rhs.updatedAt
}
