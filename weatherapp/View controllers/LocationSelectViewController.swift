//
//  LocationSelectViewController.swift
//  weatherapp
//
//  Created by Chris Cook on 8/2/18.
//  Copyright © 2018 destinycreates. All rights reserved.
//

import UIKit

class LocationSelectViewController: UIViewController, UISearchBarDelegate {
    
    let apiManager = APIManager()
    
    var geocodingData: GeocodingData?
    var weatherData: WeatherData?
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchAddress = searchBar.text?.replacingOccurrences(of: " ", with: " +") else {
            return
        }
        apiManager.geocode(address: searchAddress, onSuccess: onRetrieving(geocodingData:), onError: errorRetrieved(error:))
        
    }
    func errorRetrieved(error: Error) {
        geocodingData = nil
        weatherData = nil
    }
    
    
    
    func onRetrieving(geocodingData: GeocodingData) {
        self.geocodingData = geocodingData
        
        apiManager.getWeather(lattitude: geocodingData.latitude, longitude: geocodingData.longitude, onSuccess: onRetrievingWeatherData(weatherData:), onError: errorRetrieved(error:))
    }
    
    func onRetrievingWeatherData(weatherData: WeatherData) {
        self.weatherData = weatherData
        self.performSegue(withIdentifier: "unwindToMainScreen", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        guard let destinationVC = segue.destination as? weatherViewController, let retrievedGeocodingData = geocodingData, let retrievedWeatherData = weatherData else {
            return
        }
        destinationVC.geocodingData = retrievedGeocodingData
        destinationVC.weatherData = retrievedWeatherData
     }

}
