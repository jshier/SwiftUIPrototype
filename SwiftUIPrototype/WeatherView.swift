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
    @State var secret: Binding<String>?
    
    var body: some View {
        VStack {
            if currentWeather.value != nil {
                Text(currentWeather.value!.currently.temperature.temperatureFormatted)
            } else if currentWeather.error != nil {
                Text("Oops! Failed to get weather due to error: \(currentWeather.error!.localizedDescription)")
                        .lineLimit(10)
            } else {
                Text("Getting weather!")
            }
            Button(action: {
                self.currentWeather.perform(WeatherRequest(secret: ""))
            }, label: { Text("Refresh") })
        }
    }
}

struct WeatherViewPreviews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

struct Weather: Decodable {
    struct Current: Decodable {
        let temperature: Double
    }
    
    let currently: Current
}

extension Double {
    var temperatureFormatted: String {
        return Formatters.temperature.string(from: Measurement<UnitTemperature>(value: self, unit: .fahrenheit))
    }
}

enum Formatters {
    static let temperature = MeasurementFormatter()
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
