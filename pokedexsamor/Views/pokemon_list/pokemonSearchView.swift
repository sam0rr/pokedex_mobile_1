import SwiftUI

struct PokemonSearchView: View {
    @Binding var searchText: String
    @State private var isShowingScanner = false

    var body: some View {
        VStack {
            HStack {
                TextField("Quel Pokémon cherchez-vous?", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding(.trailing, 10)
                        }
                    )

                Button(action: {
                    isShowingScanner.toggle()
                }) {
                    Image(systemName: "qrcode.viewfinder")
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        .sheet(isPresented: $isShowingScanner) {
            QRCodeScannerView(
                completion: { result in
                    isShowingScanner = false
                    switch result {
                    case .success(let code):
                        searchText = code
                    case .failure(let error):
                        print("Scanning failed: \(error.localizedDescription)")
                    }
                },
                isScannerActive: $isShowingScanner
            )
        }
    }
}
