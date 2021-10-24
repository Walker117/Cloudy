//
//  ShortTermForecast.swift
//  Cloudy
//
//  Created by Alex Mokretsov on 10/24/21.
//

import SwiftUI

struct ShortTermForecast: View {
    let backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.1529411765, blue: 0.1960784314, alpha: 0.799652908)
    let frameColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
    var body: some View {
        ZStack {
            Color(backgroundColor)
            
            content
        }
        .frame(height: 121)
    }
    
    var content: some View {
        VStack(spacing: 0) {
            borderLine
            
            Spacer()
            
            forecastScrollableView
                
            
            Spacer()
            
            borderLine
        }
    }
    
    var forecastScrollableView: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 25) {
                ShortTermForecastCell()
                ShortTermForecastCell(isNow: false)
                ShortTermForecastCell(isNow: false)
                ShortTermForecastCell(isNow: false)
                ShortTermForecastCell(isNow: false)
                ShortTermForecastCell(isNow: false)
                ShortTermForecastCell(isNow: false)
            }.padding([.leading, .trailing], 20)
        }
    }
    
    var borderLine: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(Color(frameColor))
            .opacity(0.2)
    }
}

struct ShortTermForecast_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Image("golden_gate")
                .resizable()
                .ignoresSafeArea()
            
            ShortTermForecast()
                
        }
        .ignoresSafeArea()
    }
}
