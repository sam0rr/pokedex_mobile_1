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
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))], spacing: 15) {
                        ForEach(allTypes, id: \.self) { type in
                            Button(action: {
                                toggleTypeSelection(type)
                            }) {
                                PokemonTypeChip(
                                    typeName: type,
                                    width: 160,
                                    height: 40,
                                    isSelected: selectedTypes.contains(type)
                                )
                            }
                        }
                    }
                    .padding()
                }
                
                    Button(action: { dismiss() }) {
                        HStack {
                            Image(systemName: "checkmark")
                                .font(.system(size: 20, weight: .bold))
                            Text("Sauvegarder")
                                .font(.headline)
                                .bold()
                        }
                        .frame(width: 150, height: 20)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(8)
                    }
                }
            
            .navigationTitle("Filtrer par type")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: { dismiss() }) {
                    Image(systemName: "arrow.backward")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.black)
                },
                trailing: Button(action: resetFilter) {
                    Image(systemName: "arrow.uturn.backward")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.black)
                }
            )
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
