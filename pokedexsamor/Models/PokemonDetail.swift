import Foundation

struct PokemonDetail: Decodable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let speciesName: String
    let isFavorite: Bool
    let weight: Int
    let height: Int
    let baseExperience: Int
    let stats: [Stat]
    let types: [String]
    let abilities: [Ability]
    let weaknesses: [String]
    let defenses: [Defense]
    let evolutionChain: String?
    let evolutions: [String]
    let moves: [String]

    var imageURL: String {
        "https://mapi.cegeplabs.qc.ca/pokedex/v2/images/\(name.lowercased()).png"
    }

    enum CodingKeys: String, CodingKey {
        case id, name, description, weight, height
        case baseExperience = "base_experience"
        case speciesName = "species_name"
        case isFavorite = "is_favorite"
        case stats, types, abilities, weaknesses, defenses, evolutionChain, evolutions, moves
    }
}

struct Stat: Decodable, Identifiable {
    let id = UUID()
    let name: String
    let value: Int

    enum CodingKeys: String, CodingKey {
        case name
        case value
    }
}

struct Ability: Decodable, Identifiable {
    let id = UUID()
    let name: String
}

struct Defense: Decodable, Identifiable {
    let id = UUID()
    let type: String
    let multiplier: Double
}
