import SwiftUI
import GooglePlaces

struct PlaceDetailView: View {
    var place: GMSPlace

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(place.name ?? "Unknown Name")
                    .font(.title)
                    .bold()
                Text(place.formattedAddress ?? "Unknown Address")
                if let phoneNumber = place.phoneNumber {
                    Text("Phone: \(phoneNumber)")
                }
                Text("Rating: \(place.rating)")
                if let website = place.website {
                    Link("Website", destination: website)
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Place Details")
    }
}
