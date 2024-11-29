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
        let formattedName = name.lowercased().replacingOccurrences(of: " ", with: "-")
        return "https://mapi.cegeplabs.qc.ca/pokedex/v2/images/\(formattedName).png"
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case isFavorite = "is_favorite"
        case types
    }
}
