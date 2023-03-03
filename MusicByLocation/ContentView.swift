//
//  ContentView.swift
//  MusicByLocation
//
//  Created by Matteo Mountain on 02/03/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var locationHandler = LocationHandler()
    var body: some View {
        VStack {
            List {
                
                Text("Country: \(locationHandler.lastKnownCountry)")
                    .padding()
                
                Text("City: \(locationHandler.lastKnownLocation)")
                    .padding()

                Text("Postcode: \(locationHandler.lastKnownPostcode)")
                    .padding()
                
                Text("Country Code: \(locationHandler.lastKnownCountryCode)")
                    .padding()
                
                Text("Administrative Area: \(locationHandler.lastKnownAdministrativeArea)")
                    .padding()

            }
            Spacer()
            Button("Find Music", action: {
                locationHandler.requestLocation()
            })
        }.onAppear( perform: {
            locationHandler.requestAuthorisation()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
