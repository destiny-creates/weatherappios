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
    
    enum APIError: Error {
        case noData
        case noResponse
        case invalidData
    }
    func geocode(address: String, onSuccess: @escaping (GeocodingData) -> Void, onError: @escaping (Error) -> Void ) {
        //https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=[address] [API Key]
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
}










