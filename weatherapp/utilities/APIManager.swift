//
//  apikey.swift
//  weatherapp
//
//  Created by Chris Cook on 8/1/18.
//  Copyright © 2018 destinycreates. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager {
    let apiKeys = APIKeys()
    
    let googleBaseURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
    
    let darkSkyBaseURL = "https://api.darksky.net/forecast/"
    
    enum APIError: Error {
        case noData
        case noResponse
        case invalidData
    }
    func geocode(address: String, onSuccess: @escaping (GeocodingData) -> Void, onError: @escaping (Error) -> Void ) {
        
        let url = "\(googleBaseURL)\(address)\(apiKeys.googleKey)"
        
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                guard let geocodingData = GeocodingData(json: json) else {
                    onError(APIError.invalidData)
                    return
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    func getWeather(lattitude: Double, longitude: Double, onSuccess: @escaping (WeatherData) -> Void, onError: @escaping (Error) -> Void) {
        let url = "\(darkSkyBaseURL)\(apiKeys.darkSkyKey)\(lattitude),\(longitude)"
        
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                guard let weatherData = WeatherData(json: json) else {
                    onError(APIError.invalidData)
                    return
                }
                onSuccess(weatherData)
            case .failure(let error):
                onError(error)
            }
        }
    }
}










