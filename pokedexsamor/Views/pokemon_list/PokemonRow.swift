import SwiftUI

struct PokemonRow: View {
    let pokemon: Pokemon

    var body: some View {
        ZStack {
            (Color(pokemon.types.first?.lowercased() ?? "normal")
                .lighter(by: 0.15))
                .cornerRadius(15)
                .shadow(
                    color: Color(pokemon.types.first?.lowercased() ?? "normal")
                        .opacity(0.6),
                    radius: 10,
                    x: 0, y: 2
                )

            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("#\(String(format: "%03d", pokemon.id))")
                            .font(.system(size: 12))
                            .bold()
                            .foregroundColor(.black)

                        if pokemon.isFavorite {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.bottom, 1)

                    Text(pokemon.name)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.bottom, 1)

                    HStack {
                        ForEach(pokemon.types, id: \.self) { type in
                            PokemonTypeChip(typeName: type)
                        }
                    }
                }
                Spacer()

                AsyncImage(url: URL(string: pokemon.imageURL)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 120, height: 120)
                            .offset(x: 0, y: -25)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .offset(x: 0, y: -25)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .offset(x: 0, y: -25)
                    @unknown default:
                        EmptyView()
                            .frame(width: 120, height: 120)
                            .offset(x: 0, y: -25)
                    }
                }
            }
            .padding(.horizontal, 12)
        }
        .padding(6)
    }
}
