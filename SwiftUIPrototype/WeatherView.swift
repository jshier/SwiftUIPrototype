//
//  WeatherView.swift
//  SwiftUIPrototype
//
//  Created by Jon Shier on 9/16/19.
//  Copyright © 2019 Jon Shier. All rights reserved.
//

import Alamofire
import SwiftUI

struct WeatherView: View {
    @ObservedObject var currentWeather = Resource<Weather, AFError>()
    @State var secret: String?
    
    var body: some View {
        VStack {
            currentWeather.value.map { (weather: Weather) in
                VStack {
                    RightNowView(weather: weather)
                    TodayView(weather: weather)
                    WeekView(weather: weather)
                }
            }
            currentWeather.error.map { (error: AFError) in
                VStack {
                    Text("Oops! Failed to get weather due to error: \(error.localizedDescription)")
                }
            }
            Button(action: {
                self.currentWeather.perform(WeatherRequest(secret: ""))
            }, label: { Text("Refresh") })
        }
    }
}

struct RightNowView: View {
    let weather: Weather
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Right now")
                    .font(.largeTitle)
                Text(weather.minutely.summary)
                    .lineLimit(2)
                    .font(.footnote)
            }
            HStack {
                Image(systemName: "cloud.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75, height: 75)
                    .padding(.horizontal, 5)
                    .foregroundColor(.gray)
                VStack {
                    Text(weather.currently.temperature.temperatureFormatted)
                    Text("Feels like \(weather.currently.apparentTemperature.temperatureFormatted)")
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 8)
    }
}

struct TodayView: View {
    let weather: Weather
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Today")
                .font(.largeTitle)
            Text(weather.hourly.summary)
                .lineLimit(2)
                .font(.footnote)
            TemperatureGraph(data: Array(weather.hourly.data.prefix(8)))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 8)
    }
}

struct TemperatureGraph: View {
    let data: [Weather.Hourly.Datapoint]
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(data.indices) { index in
                GraphBar(index: index, value: "\(self.data[index].temperature.temperatureFormatted)", height: 100)
            }
        }
    }
}

struct GraphBar: View {
    var index: Int
    var value: String
    var height: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.purple)
                .frame(height: height, alignment: .bottom)
                .cornerRadius(2)
                .overlay(Text(value)
                            .foregroundColor(.white)
                            .frame(alignment: .top)
                            .padding(.horizontal, 2)
                            .padding(.top, 2),
                         alignment: .top)
            
        }
        
    }
}

struct WeekView: View {
    let weather: Weather
    
    var body: some View {
        VStack {
            Text("This Week")
        }
    }
}

struct WeatherViewPreviews: PreviewProvider {
    static let datapoints: [Weather.Hourly.Datapoint] = [
    .init(time: 1509991200, temperature: 77, apparentTemperature: 75),
    .init(time: 1509991200, temperature: 77, apparentTemperature: 75),
    .init(time: 1509991200, temperature: 77, apparentTemperature: 75),
    .init(time: 1509991200, temperature: 77, apparentTemperature: 75)
    ]
    static let sampleWeather = Weather(currently: .init(temperature: 77, apparentTemperature: 75),
                                       minutely: .init(summary: "Light rain stopping in 13 min., starting again 30 min. later. Light rain stopping in 13 min., starting again 30 min. later."),
                                       hourly: .init(summary: "Rain starting later this afternoon, continuing until this evening.",
                                                     data: datapoints))
    
    static var previews: some View {
        Group {
            WeatherView()
            RightNowView(weather: sampleWeather)
            TodayView(weather: sampleWeather)
            WeekView(weather: sampleWeather)
            GraphBar(index: 0, value: "100°", height: 100)
            
        }
    }
}

struct Weather: Decodable {
    struct Current: Decodable {
        let temperature: Double
        let apparentTemperature: Double
    }
    
    struct Minutely: Decodable {
        let summary: String
    }
    
    struct Hourly: Decodable {
        let summary: String
        let data: [Datapoint]
        struct Datapoint: Decodable {
            let time: Int
            let temperature: Double
            let apparentTemperature: Double
        }
    }
    
    let currently: Current
    let minutely: Minutely
    let hourly: Hourly
}

extension Double {
    var temperatureFormatted: String {
        return Formatters.temperature.string(from: Measurement<UnitTemperature>(value: self, unit: .fahrenheit))
    }
}

enum Formatters {
    static let temperature: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        formatter.numberFormatter = numberFormatter
        
        return formatter
    }()
}

//42.657391, -83.194097

struct WeatherRequest {
    let secret: String
    var coordinates = "42.657391,-83.194097"
}

extension WeatherRequest: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = try "https://api.darksky.net/forecast/".asURL()
                        .appendingPathComponent(secret)
                        .appendingPathComponent(coordinates)
        
        return URLRequest(url: url)
    }
}
