import SwiftUI

struct StatsTabView: View {
    let pokemon: PokemonDetail

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Stats de base")
                .font(.headline)

            ForEach(pokemon.stats) { stat in
                HStack {
                    Text(stat.name.capitalized)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ProgressBarView(value: CGFloat(stat.value) / 100.0)
                        .frame(width: 150, height: 10)
                    Text("\(stat.value)")
                        .font(.subheadline)
                        .frame(width: 30, alignment: .trailing)
                }
            }

            Divider()

            if !pokemon.defenses.isEmpty {
                Text("Défense des types")
                    .font(.headline)

                HStack {
                    ForEach(pokemon.defenses) { defense in
                        VStack {
                            Text(defense.type.capitalized)
                                .font(.caption)
                            Text(String(format: "%.1fx", defense.multiplier))
                                .font(.caption)
                                .foregroundColor(defense.multiplier > 1 ? .red : .green)
                        }
                        .padding(6)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    }
                }
            }
        }
        .padding()
    }
}
