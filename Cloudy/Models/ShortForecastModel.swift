//
//  ShortForecastModel.swift
//  Cloudy
//
//  Created by Alex Mokretsov on 10/24/21.
//

import Foundation

struct ShortForecastModel: Hashable {
    let time: String
    let amPm: String
    let temperature: String
    let isNow: Bool
}
