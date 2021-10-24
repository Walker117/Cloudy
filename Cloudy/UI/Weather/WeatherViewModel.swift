//
//  WeatherViewModel.swift
//  Cloudy
//
//  Created by Alex Mokretsov on 10/24/21.
//

import Foundation

protocol WeatherViewModel: ObservableObject {
    var headerModel: WeatherHeaderModel { get }
}

class RealWeatherViewModel: WeatherViewModel {
    var headerModel: WeatherHeaderModel = WeatherHeaderModel(cityName: "San Jose", status: "Mostly Cloudy", temperature: "63")
}

class PreviewWeatherViewModel: WeatherViewModel {
    var headerModel: WeatherHeaderModel = WeatherHeaderModel(cityName: "San Jose", status: "Mostly Cloudy", temperature: "63")
}
