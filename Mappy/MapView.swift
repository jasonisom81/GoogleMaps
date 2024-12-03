import SwiftUI
import GoogleMaps
import GooglePlaces

struct MapView: UIViewRepresentable {
    @Binding var searchResults: [GMSPlace]
    @State private var cameraPosition: GMSCameraPosition = .camera(withLatitude: 36.1699, longitude: -115.1398, zoom: 10.0)

    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView()
        mapView.camera = cameraPosition
        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        if let firstResult = searchResults.first {
            let camera = GMSCameraPosition.camera(withLatitude: firstResult.coordinate.latitude,
                                                  longitude: firstResult.coordinate.longitude,
                                                  zoom: 14.0)
            uiView.camera = camera

            // Clear existing markers
            uiView.clear()

            // Add markers for search results
            for place in searchResults {
                let marker = GMSMarker()
                marker.position = place.coordinate
                marker.title = place.name
                marker.snippet = place.formattedAddress
                marker.map = uiView
            }
        }
    }
}
