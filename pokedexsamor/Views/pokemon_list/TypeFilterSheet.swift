import SwiftUI

struct TypeFilterSheet: View {
    @Binding var selectedTypes: Set<String>
    @Environment(\.dismiss) var dismiss

    let allTypes: [String] = [
        "Bug", "Dark", "Dragon", "Electric", "Fairy",
        "Fighting", "Fire", "Flying", "Ghost", "Grass",
        "Ice", "Normal", "Poison", "Psychic", "Rock",
        "Steel", "Water", "Ground"
    ]

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 16) {
                        ForEach(allTypes, id: \.self) { type in
                            Button(action: {
                                toggleTypeSelection(type)
                            }) {
                                PokemonTypeChip(typeName: type)
                                    .overlay(
                                        Rectangle()
                                            .stroke(selectedTypes.contains(type) ? Color(type.lowercased()) : Color.clear, lineWidth: 2)
                                    )
                                    .shadow(
                                        color: selectedTypes.contains(type) ? Color(type.lowercased()).opacity(0.5) : Color.clear,
                                        radius: selectedTypes.contains(type) ? 2 : 0, x: 0, y: 1
                                    )
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Filter by Type")
                .navigationBarItems(
                    leading: Button("Reset") {
                        resetFilter()
                    },
                    trailing: Button("Save") {
                        dismiss()
                    }
                )
            }
        }
    }
    
    private func toggleTypeSelection(_ type: String) {
        if selectedTypes.contains(type) {
            selectedTypes.remove(type)
        } else {
            selectedTypes.insert(type)
        }
    }
    
    private func resetFilter() {
        selectedTypes.removeAll()
    }
}

struct TypeFilterSheet_Previews: PreviewProvider {
    static var previews: some View {
        TypeFilterSheet(selectedTypes: .constant(Set<String>()))
    }
}
