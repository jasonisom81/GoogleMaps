import SwiftUI
import GoogleMaps
import GooglePlaces

struct MapView: UIViewRepresentable {
    @Binding var searchResults: [IdentifiablePlace]
    @Binding var selectedPlace: IdentifiablePlace?

    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        uiView.clear()

        for result in searchResults {
            let marker = GMSMarker(position: result.place.coordinate)
            marker.title = result.place.name
            marker.snippet = result.place.formattedAddress
            marker.userData = result
            marker.map = uiView
        }

        if let firstResult = searchResults.first?.place {
            let camera = GMSCameraPosition.camera(withLatitude: firstResult.coordinate.latitude,
                                                  longitude: firstResult.coordinate.longitude,
                                                  zoom: 14.0)
            uiView.animate(to: camera)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(selectedPlace: $selectedPlace)
    }

    class Coordinator: NSObject, GMSMapViewDelegate {
        @Binding var selectedPlace: IdentifiablePlace?

        init(selectedPlace: Binding<IdentifiablePlace?>) {
            _selectedPlace = selectedPlace
        }

        func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
            if let place = marker.userData as? IdentifiablePlace {
                selectedPlace = place
            }
            return true
        }
    }
}
