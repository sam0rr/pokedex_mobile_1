import SwiftUI

struct PokemonListView: View {
    @StateObject private var viewModel = PokemonListViewModel()

    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                CustomProgressView(message: "Chargement des Pokémon...")
                    .padding(.top, 50)
            } else {
                VStack(spacing: 0) {
                    titleSection
                    searchBarSection
                    contentSection
                }
                .background(Color(.systemBackground))
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true) // Keep the back button hidden
                .toolbar { filterToolbar }
                .sheet(isPresented: $viewModel.isFilterSheetPresented) {
                    TypeFilterSheet(selectedTypes: $viewModel.selectedTypes)
                }
                .onAppear(perform: onAppear)
                .sheet(isPresented: $viewModel.isScannerActive) {
                    QRCodeScannerView(
                        completion: { scannedCodes in
                            viewModel.addScannedPokemons(scannedCodes)
                        },
                        isScannerActive: $viewModel.isScannerActive
                    )
                }
                .gesture(
                    DragGesture().onChanged { _ in } // Disable the swipe back gesture
                )
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Ensure consistent navigation style
    }


    private var titleSection: some View {
        Text("Pokédex")
            .font(.system(size: 42, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 16)
            .background(Color(.systemBackground))
    }

    private var searchBarSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Rechercher un Pokémon par nom")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.gray)
                .padding(.leading, 16)
                .padding(.bottom, 4)

            HStack {
                searchField
                qrScannerButton
            }
            .padding(.horizontal, 16)

            if !viewModel.scannedPokemons.isEmpty {
                resetScannedButton
            }
        }
        .padding(.bottom, 12)
        .background(Color(.systemBackground))
        .zIndex(1)
    }

    private var searchField: some View {
        TextField("Quel Pokémon cherchez-vous?", text: $viewModel.searchQuery)
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
            .onChange(of: viewModel.searchQuery) { _ in
                viewModel.resetScannedPokemons()
            }
    }

    private var qrScannerButton: some View {
        Button(action: viewModel.toggleScanner) {
            Image(systemName: "qrcode.viewfinder")
                .font(.system(size: 24))
                .foregroundColor(.gray)
        }
    }

    private var resetScannedButton: some View {
        HStack {
            Spacer()
            Button(action: viewModel.resetScannedPokemons) {
                HStack {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                    Text("Réinitialiser les Pokémon scannés")
                        .foregroundColor(.red)
                }
                .padding()
            }
            Spacer()
        }
        .padding(.horizontal, 16)
    }


    private var contentSection: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Chargement des Pokémon...")
                    .padding()
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.displayedPokemon, id: \.id) { pokemon in
                            PokemonRowNavigationView(pokemon: pokemon)
                        }

                        if viewModel.displayedPokemon.isEmpty {
                            emptyState
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
    }

    private var emptyState: some View {
        VStack {
            Spacer()
            Text("Aucun Pokémon trouvé.")
                .foregroundColor(.secondary)
                .padding()
            Spacer()
        }
    }

    private var filterToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
                viewModel.isFilterSheetPresented.toggle()
                viewModel.resetScannedPokemons()
            }) {
                Image(systemName: "line.horizontal.3.decrease.circle")
                    .font(.title2)
                    .foregroundColor(.black)
            }
        }
    }

    private func onAppear() {
        if viewModel.pokemonList.isEmpty {
            viewModel.fetchPokemon()
        }
    }
}
