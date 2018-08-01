//
//  ViewController.swift
//  weatherapp
//
//  Created by Chris Cook on 8/1/18.
//  Copyright © 2018 destinycreates. All rights reserved.
//

import UIKit

class weatherViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var iconLabel: UILabel!
    
    @IBOutlet weak var currentTempLabel: UILabel!
    
    @IBOutlet weak var highTempLabel: UILabel!
    
    @IBOutlet weak var lowTempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUIWithoutData()
        
        let apiManager = APIManager()
        apiManager.geocode(address: "louisville", onSuccess: { (GeocodingData) in
            print(GeocodingData.formattedAddress)
            print(GeocodingData.latitude)
            print(GeocodingData.longitude)
        }) { (error) in
        }
        
    }
    
    func setupUIWithoutData() {
        locationLabel.text = ""
        iconLabel.text = "☂️"
        currentTempLabel.text = "Enter a location!"
        highTempLabel.text = "-"
        lowTempLabel.text = "-"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

