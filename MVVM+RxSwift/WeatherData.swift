//
//  WeatherData.swift
//  MVVM+RxSwift
//
//  Created by Luka Gabric on 14/02/2017.
//  Copyright © 2017 lukagabric.com. All rights reserved.
//

import Foundation

public struct WeatherData {
    
    public var locationName: String
    public var temperature: Float
    public var realFeel: Float
    public var precipitation: Float
    public var updatedAt: Date
    
}

extension WeatherData: Equatable {}
public func ==(lhs: WeatherData, rhs: WeatherData) -> Bool {
    return lhs.locationName == rhs.locationName &&
        lhs.temperature == rhs.temperature &&
        lhs.realFeel == rhs.realFeel &&
        lhs.precipitation == rhs.precipitation &&
        lhs.updatedAt == rhs.updatedAt
}
