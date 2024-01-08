//
//  DailyWeatherView.swift
//  CWK2Template
//
//  Created by girish lukka on 02/11/2023.
//

import SwiftUI

struct DailyWeatherView: View {
    var day: Daily
    var body: some View {

        let formattedDate = DateFormatterUtils.formattedDateWithWeekdayAndDay(from: TimeInterval(day.dt))
        Text(formattedDate)
            .font(.body) // Customize the font if needed
            .padding()

    }
}

struct DailyWeatherView_Previews: PreviewProvider {
    static var day = WeatherMapViewModel().weatherDataModel!.daily
    static var previews: some View {
        DailyWeatherView(day: day[0])
    }
}
