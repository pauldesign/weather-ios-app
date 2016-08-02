//
//  FirstViewController.swift
//  WeatherApplication-Main
//
//  Created by Paul Maxeiner on 8/2/16.
//  Copyright © 2016 Paul Maxeiner. All rights reserved.
//

import UIKit
import CoreLocation

extension CurrentWeather {
    var temperatureString: String {
        return "\(Int(temperature))º"
    }
    
    var humidityString: String {
        let percentageValue = Int(humidity * 100)
        return "\(percentageValue)%"
    }
    
    var precipitationprobabilityString: String {
        let percentageValue = Int(precipitationProbability * 100)
        return "\(percentageValue)%"
    }
}

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    lazy var forecastAPIClient = ForecastAPIClient(APIKey: "d00d10843e7a2ed8746b03549f78448e")
    
    let coordinate = Coordinate(latitude: 40.103882, longitude: -82.784575)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchCurrentWeather()
        findMyLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchCurrentWeather() {
        
        forecastAPIClient.fetchCurrentWeather(coordinate) { result in
            
            self.toggleRefreshAnimation(false)
            
            switch result {
                
            case .Success(let currentWeather):
                self.display(currentWeather)
                
            case .Failure(let error as NSError):
                self.showAlert("Unable to retrieve forecast", message: error.localizedDescription)
                
            case .Empty(let error as NSError):
                self.showAlert("Unable to retrieve forecast", message: error.localizedDescription)
                
            default: break
                
            }
        }
    }
    
    func display(weather: CurrentWeather) {
//        currentTemperatureLabel.text = weather.temperatureString
//        currentPrecipitationLabel.text = weather.precipitationprobabilityString
//        currentHumidityLabel.text = weather.humidityString
//        currentSummaryLabel.text = weather.summary
//        currentWeatherIcon.image = weather.icon
    }
    
    func showAlert(title: String, message: String?, style: UIAlertControllerStyle = .Alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let dismissAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(dismissAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func findMyLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        
        // Here we start locating
        locationManager.startUpdatingLocation()
    }
    
}

// We adopt the CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        for location in locations {
            print("THIS IS THE LOCATION \(location.coordinate.latitude)")
        }
        
        // This will stop updating the location.
        locationManager.stopUpdatingLocation()
    }
}



