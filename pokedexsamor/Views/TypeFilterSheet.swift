import SwiftUI

struct TypeFilterSheet: View {
    @Binding var selectedTypes: Set<String>
    @Environment(\.dismiss) var dismiss
    
    let allTypes: [String] = [
        "Insecte", "Ténèbres", "Dragon", "Électrik", "Fée",
        "Combat", "Feu", "Vol", "Spectre", "Plante",
        "Glace", "Normal", "Poison", "Psy", "Roche",
        "Acier", "Eau", "Sol"
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
                                Text(type)
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(selectedTypes.contains(type) ? Color.red : Color.gray.opacity(0.2))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Filtrer par type")
                .navigationBarItems(
                    leading: Button("Réinitialiser") {
                        resetFilter()
                    },
                    trailing: Button("Sauvegarder") {
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

#Preview {
    TypeFilterSheet(selectedTypes: .constant(Set<String>()))
}
