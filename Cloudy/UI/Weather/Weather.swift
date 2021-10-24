//
//  Weather.swift
//  Cloudy
//
//  Created by Alex Mokretsov on 10/24/21.
//

import SwiftUI

struct Weather<ViewModel>: View where ViewModel: WeatherViewModel {
    
    let viewModel: ViewModel
    
    var body: some View {
        ZStack {
            background
            content
        }
    }
    
    var content: some View {
        VStack {
            header
            
            shortForecast
            
            Spacer()
        }
    }
    
    var header: some View {
        VStack(spacing: 0) {
            Text(viewModel.headerModel.cityName)
                .font(.system(size: 32))
                .padding(.top, 105)
            
            Text(viewModel.headerModel.status)
            
            Text(viewModel.headerModel.temperature)
                .font(.system(size: 100))
                .fontWeight(.thin)
                .overlay(temperatureIcon, alignment: .topTrailing)
        }
        .foregroundColor(.lightBlue)
    }
    
    var shortForecast: some View {
        // TODO: Refactor to use actual data
        ShortTermForecast(models: .constant([
            ShortForecastModel(time: "7", amPm: "am", temperature: "59°", isNow: true),
            ShortForecastModel(time: "7", amPm: "am", temperature: "59°", isNow: false)
        ]))
    }
    
    var temperatureIcon: some View {
        Text("°")
            .font(.system(size: 72))
            .fontWeight(.thin)
            .offset(x: 20)
    }
    
    var background: some View {
        Image("golden_gate")
            .resizable()
            .ignoresSafeArea()
    }
}

struct Weather_Previews: PreviewProvider {
    static var previews: some View {
        Weather(viewModel: PreviewWeatherViewModel())
    }
}
