//
//  DailyWeatherView.swift
//  CWK2Template
//
//  Created by girish lukka on 02/11/2023.
//

import SwiftUI

import SwiftUI

import SwiftUI

struct DailyWeatherView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    var day: Daily

    var body: some View {
        VStack(alignment: .leading) {
            if let _ = weatherMapViewModel.weatherDataModel {
                ForEach(day.weather, id: \.id) { weatherEntry in
                    HStack {
                        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weatherEntry.icon).png"))
                            .frame(width: 50, height: 50)
                        Spacer()
                        VStack(alignment: .leading, spacing: 5) {
                            Text(weatherEntry.weatherDescription.rawValue.capitalized)
                                .font(.system(size: 16))
                            Text(DateFormatterUtils.formattedDateWithWeekdayAndDay(from: TimeInterval(day.dt)))
                                .font(.system(size: 14))
                        }
                        .padding(.leading, 10)

                        Spacer()

                        Text("\(day.temp.max, specifier: "%.0f")° / \(day.temp.min, specifier: "%.0f")°")
                            .font(.system(size: 16, weight: .bold)) // enhancement add bold font to accentuate temperatures
                            .padding(.trailing, 10)
                    }
                    .padding(.vertical, 8)
                }
            }
        }
    }
}



struct DailyWeatherView_Previews: PreviewProvider {
    static var day = WeatherMapViewModel().weatherDataModel!.daily
    static var previews: some View {
        DailyWeatherView(day: day[0])
    }
}



