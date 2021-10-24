//
//  Weather.swift
//  Cloudy
//
//  Created by Alex Mokretsov on 10/24/21.
//

import SwiftUI

struct Weather: View {
    
    @State var cityName = "San Jose"
    @State var status = "Mostly Cloudy"
    @State var temperature = "63"
    
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
            Text(cityName)
                .font(.system(size: 32))
                .padding(.top, 105)
            
            Text(status)
            
            Text(temperature)
                .font(.system(size: 100))
                .fontWeight(.thin)
                .overlay(temperatureIcon, alignment: .topTrailing)
        }
        .foregroundColor(.lightBlue)
    }
    
    var shortForecast: some View {
        ShortTermForecast()
            
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
        Weather()
    }
}
