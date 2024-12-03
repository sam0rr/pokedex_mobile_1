import Foundation

struct PokemonResponse: Decodable {
    let results: [Pokemon]
}

struct Pokemon: Decodable, Identifiable {
    let id: Int
    let name: String
    let isFavorite: Bool
    let types: [String]

    var imageURL: String {
        // Format the ID as a three-digit string (e.g., 001, 002)
        let formattedID = String(format: "%03d", id)
        return "https://assets.pokemon.com/assets/cms2/img/pokedex/detail/\(formattedID).png"
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case isFavorite = "is_favorite"
        case types
    }
}
