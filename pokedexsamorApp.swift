import SwiftUI

@main
struct pokedexsamorApp: App {
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            PokemonListView()
                .preferredColorScheme(.light)
        }
    }
}
