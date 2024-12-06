import SwiftUI

struct PokemonRowNavigationView: View {
    let pokemon: Pokemon

    var body: some View {
        NavigationLink(destination: PokemonDetailView(idOrName: "\(pokemon.id)")) {
            PokemonRow(pokemon: pokemon)
                .padding(.vertical, 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

