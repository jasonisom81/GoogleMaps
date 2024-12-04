import SwiftUI
import GooglePlaces

struct IdentifiablePlace: Identifiable {
    let id = UUID()
    let place: GMSPlace
}

struct ContentView: View {
    @State private var isSearchSheetPresented = false
    @State private var searchResults: [IdentifiablePlace] = []
    @State private var selectedPlace: IdentifiablePlace?

    var body: some View {
        ZStack {
            MapView(searchResults: $searchResults, selectedPlace: $selectedPlace)
                .ignoresSafeArea()

            VStack {
                Spacer()
                Button(action: {
                    isSearchSheetPresented = true
                }) {
                    Text("Search")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
            }
        }
        .sheet(isPresented: $isSearchSheetPresented) {
            SearchSheetView(searchResults: $searchResults, isPresented: $isSearchSheetPresented)
        }
        .sheet(item: $selectedPlace) { placeWrapper in
            PlaceDetailView(place: placeWrapper.place)
        }
    }
}

struct SearchSheetView: UIViewControllerRepresentable {
    @Binding var searchResults: [IdentifiablePlace]
    @Binding var isPresented: Bool

    func makeUIViewController(context: Context) -> GMSAutocompleteViewController {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = context.coordinator
        return autocompleteController
    }

    func updateUIViewController(_ uiViewController: GMSAutocompleteViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(searchResults: $searchResults, isPresented: $isPresented)
    }

    class Coordinator: NSObject, GMSAutocompleteViewControllerDelegate {
        @Binding var searchResults: [IdentifiablePlace]
        @Binding var isPresented: Bool

        init(searchResults: Binding<[IdentifiablePlace]>, isPresented: Binding<Bool>) {
            _searchResults = searchResults
            _isPresented = isPresented
        }

        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            searchResults = [IdentifiablePlace(place: place)]
            isPresented = false
        }

        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            print("Autocomplete error: \(error.localizedDescription)")
            isPresented = false
        }

        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            isPresented = false
        }
    }
}
