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
        let formattedID = String(format: "%03d", id)
        return "https://assets.pokemon.com/assets/cms2/img/pokedex/detail/\(formattedID).png"
    }

    enum CodingKeys: String, CodingKey {
        case id, name, description, weight, height
        case baseExperience = "base_experience"
        case speciesName = "species_name"
        case isFavorite = "is_favorite"
        case stats, types, abilities, weaknesses, defenses, evolutionChain, evolutions, moves
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        speciesName = try container.decode(String.self, forKey: .speciesName)
        isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
        weight = try container.decode(Int.self, forKey: .weight)
        height = try container.decode(Int.self, forKey: .height)
        baseExperience = try container.decode(Int.self, forKey: .baseExperience)
        types = try container.decode([String].self, forKey: .types)
        abilities = try container.decode([Ability].self, forKey: .abilities)
        weaknesses = try container.decode([String].self, forKey: .weaknesses)
        defenses = try container.decode([Defense].self, forKey: .defenses)
        evolutionChain = try container.decodeIfPresent(String.self, forKey: .evolutionChain)
        evolutions = try container.decode([String].self, forKey: .evolutions)
        moves = try container.decode([String].self, forKey: .moves)

        let statsDictionary = try container.decode([String: Int].self, forKey: .stats)
        stats = statsDictionary.map { Stat(name: $0.key, value: $0.value) }
    }
}

struct Stat: Decodable, Identifiable {
    let id = UUID()
    let name: String
    let value: Int
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
