import SwiftUI
import GoogleMaps

struct MapView: UIViewRepresentable {
    @State private var cameraPosition: GMSCameraPosition = .camera(withLatitude: 36.1699, longitude: -115.1398, zoom: 10.0) // Default location: Las Vegas

    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView()
        mapView.camera = cameraPosition

        // Create a marker (optional)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 36.1699, longitude: -115.1398)
        marker.title = "Las Vegas"
        marker.snippet = "Nevada"
        marker.map = mapView

        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        uiView.camera = cameraPosition
    }
}
