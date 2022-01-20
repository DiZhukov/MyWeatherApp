//
//  GetCitiesWeather.swift
//  WeatherApp
//
//  Created by Dima Zhukov on 20.01.22.
//

import Foundation
import CoreLocation

let networkWeatherManager = NetworkWeatherManager()

func getCityWeather(citiesArray: [String], completionHandler: @escaping (Int, Weather) -> Void ) {
    for (index, item) in citiesArray.enumerated() {
        getCoordinateFrom(city: item) { (coordinare, error) in
            guard let coordinare = coordinare, error == nil else { return }
            
            networkWeatherManager.fetchWeather(latitude: coordinare.latitude, longitude: coordinare.longitude) { (weather) in completionHandler(index, weather)
        }
    }
}
}


func getCoordinateFrom(city: String, completion: @escaping(_ coordinare: CLLocationCoordinate2D?, _ error: Error?) -> ()) {
    CLGeocoder().geocodeAddressString(city) { (placemark, error ) in
        completion(placemark?.first?.location?.coordinate, error)
    }
}
