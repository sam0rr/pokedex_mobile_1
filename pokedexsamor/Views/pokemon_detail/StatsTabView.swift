import SwiftUI

struct StatsTabView: View {
    let pokemon: PokemonDetail
    let typeColor: Color

    private let statDisplayMapping: [String: String] = [
        "hp": "HP",
        "attack": "Attack",
        "defense": "Defense",
        "special-attack": "Sp. Atk",
        "special-defense": "Sp. Def",
        "speed": "Speed"
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Stats de base")
                    .font(.headline)
                    .foregroundColor(typeColor)

                ForEach(orderedStats, id: \.name) { stat in
                    HStack {
                        Text(statDisplayMapping[stat.name.lowercased()] ?? stat.name)
                            .font(.subheadline)
                            .frame(width: 80, alignment: .leading)

                        Text("\(stat.value)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .frame(width: 30, alignment: .leading)

                        ProgressBarView(value: CGFloat(stat.value) / 100.0, typeColor: typeColor, width: 180)
                            .frame(height: 6)
                    }
                }

                if let defenses = pokemon.defenses, !defenses.isEmpty {
                    Text("Défenses de type")
                        .padding(.top, 10)
                        .font(.headline)
                        .foregroundColor(typeColor)

                    Text("L'efficacité de chaque type sur \(pokemon.name.capitalized).")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))], spacing: 12) {
                        ForEach(defenses, id: \.type) { defense in
                            VStack(spacing: 4) {
                                Image(defense.type.lowercased())
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32, height: 32)

                                Text(formatMultiplier(defense.multiplier))
                                    .font(.caption)
                                    .foregroundColor(defense.multiplier > 1 ? .red : .green)
                            }
                        }
                    }
                }
            }
            .padding(.leading, 40)
            .padding(.top, 50)
            .padding(.bottom, 40)
            .padding(.trailing, 40)
        }
    }

    private func formatMultiplier(_ multiplier: Double) -> String {
        if multiplier == 0.5 {
            return "1/2"
        } else if multiplier == 0.25 {
            return "1/4"
        } else if multiplier == 0.125 {
            return "1/8"
        } else if multiplier.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", multiplier)
        } else {
            return String(format: "%.1f", multiplier)
        }
    }

    private var orderedStats: [Stat] {
        guard let stats = pokemon.stats else { return [] }

        let statOrder = ["hp", "attack", "defense", "special-attack", "special-defense", "speed"]
        return statOrder.compactMap { name in
            stats.first(where: { $0.name.lowercased() == name })
        }
    }
}
