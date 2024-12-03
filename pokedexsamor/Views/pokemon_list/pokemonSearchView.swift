import SwiftUI

struct PokemonSearchView: View {
    @Binding var searchText: String // Bindable to the parent view

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
                }) {
                    Image(systemName: "qrcode.viewfinder")
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)

        }
    }
}

struct PokemonSearchView_Previews: PreviewProvider {
    @State static var searchText = ""

    static var previews: some View {
        PokemonSearchView(searchText: $searchText)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
