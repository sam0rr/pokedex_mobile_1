import SwiftUI

struct PokemonRowNavigationView: View {
    let pokemon: Pokemon

    var body: some View {
        NavigationLink(destination: PokemonDetailView(idOrName: "\(pokemon.id)")) {
            PokemonRow(pokemon: pokemon)
                .padding(.vertical, 4) // Add padding for better spacing
        }
        .buttonStyle(PlainButtonStyle()) // Removes default NavigationLink styling
    }
}

