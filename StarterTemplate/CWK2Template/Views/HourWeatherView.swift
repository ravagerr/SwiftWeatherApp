//
//  HourWeatherView.swift
//  CWK2Template
//
//  Created by girish lukka on 02/11/2023.
//

import SwiftUI

struct HourWeatherView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    var current: Current

    var body: some View {
        let formattedDate = DateFormatterUtils.formattedDateWithDay(from: TimeInterval(current.dt))
        VStack(alignment: .center, spacing: 5) {
            Text(formattedDate)
                .font(.body)

                .padding(.horizontal)
                .background(Color.white)
                .foregroundColor(.black)
            
            if let _ = weatherMapViewModel.weatherDataModel {
                HStack(alignment: .center) {
                    Spacer()
                    ForEach(current.weather, id: \.id) { weatherEntry in
                        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weatherEntry.icon).png"))
                            .frame(width: 50, height: 50)
                        Spacer()
                    }
                }
                VStack(alignment: .center) {
                    Text("\((Double)(current.temp), specifier: "%.0f") ºC")
                    Text(current.weather[0].weatherDescription.rawValue.capitalized)
                }
            }
        }
        
    }
}




