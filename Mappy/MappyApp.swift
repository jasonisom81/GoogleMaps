//
//  MappyApp.swift
//  Mappy
//
//  Created by Jason Isom on 12/2/24.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

@main
struct YourProjectNameApp: App {
    init() {
        GMSServices.provideAPIKey("AIzaSyAdygUzb6AMu91rAOnv_ep9NadsN18dP7E")
        GMSPlacesClient.provideAPIKey("AIzaSyAdygUzb6AMu91rAOnv_ep9NadsN18dP7E")
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
    
