//
//  LocationHandler.swift
//  MusicByLocation
//
//  Created by Matteo Mountain on 02/03/2023.
//

import Foundation
import CoreLocation

class LocationHandler: NSObject, CLLocationManagerDelegate, ObservableObject {
    let manager = CLLocationManager()
    let geocoder = CLGeocoder()
    @Published var lastKnownCountry: String = ""
    @Published var lastKnownLocation: String = ""
    @Published var lastKnownPostcode: String = ""
    @Published var lastKnownCountryCode: String = ""
    @Published var lastKnownAdministrativeArea: String = ""
    
    override init() {
        super.init()
        manager.delegate = self
    }

    func requestAuthorisation() {
        manager.requestWhenInUseAuthorization()
    }

    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let firstLocation = locations.first {
            geocoder.reverseGeocodeLocation(firstLocation, completionHandler: { (placemarks, error) in
                if error != nil {
                    self.lastKnownLocation = "Could not perform lookup of location from coordinate information"
                } else {
                    if let firstPlacemark = placemarks?[0] {
                        self.lastKnownCountry = firstPlacemark.country ?? "Couldn't find country"
                        self.lastKnownLocation = firstPlacemark.locality ?? "Couldn't find locality"
                        self.lastKnownPostcode = firstPlacemark.postalCode ?? "Couldn't find postcode"
                        self.lastKnownCountryCode = firstPlacemark.isoCountryCode ?? "Couldn't find country code"
                        self.lastKnownAdministrativeArea = firstPlacemark.administrativeArea ?? "Couldn't find administrative area"
                    }
                }
            })
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.lastKnownCountry = "Error finding country"
        self.lastKnownLocation = "Error finding location"
        self.lastKnownPostcode = "Error finding postcode"
        self.lastKnownCountryCode = "Error finding country code"
        self.lastKnownAdministrativeArea = "Error finding administrative area"
        

    }
}

