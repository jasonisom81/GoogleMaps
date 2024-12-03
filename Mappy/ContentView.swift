import SwiftUI
import GooglePlaces

struct ContentView: View {
    @State private var isSearchSheetPresented = false
    @State private var searchResults: [GMSPlace] = []

    var body: some View {
        ZStack {
            MapView(searchResults: $searchResults)
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
    }
}

struct SearchSheetView: UIViewControllerRepresentable {
    @Binding var searchResults: [GMSPlace]
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
        @Binding var searchResults: [GMSPlace]
        @Binding var isPresented: Bool

        init(searchResults: Binding<[GMSPlace]>, isPresented: Binding<Bool>) {
            _searchResults = searchResults
            _isPresented = isPresented
        }

        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            searchResults = [place]
            isPresented = false
        }

        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            print("Error: \(error.localizedDescription)")
        }

        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            isPresented = false
        }
    }
}
