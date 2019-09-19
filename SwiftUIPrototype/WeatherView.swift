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
                RightNowView(weather: weather)
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
                    .lineLimit(nil)
                    .font(.subheadline)
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

struct WeatherViewPreviews: PreviewProvider {
    static let sampleWeather = Weather(currently: .init(temperature: 77, apparentTemperature: 75),
                                       minutely: .init(summary: "Light rain stopping in 13 min., starting again 30 min. later."))
    
    static var previews: some View {
        Group {
            WeatherView()
            RightNowView(weather: sampleWeather)
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
    
    let currently: Current
    let minutely: Minutely
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
