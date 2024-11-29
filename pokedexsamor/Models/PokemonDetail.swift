import Foundation

struct PokemonDetail: Codable {
    let id: Int
    let name: String
    let description: String
    let species: String
    let height: Double
    let weight: Double
    let types: [String]
    let weaknesses: [String]
    let stats: [Stat]
    let evolutions: [Evolution]
    let primaryTypeColor: String
    let image: String
}

struct Stat: Codable {
    let name: String
    let value: Int
}

struct Evolution: Codable {
    let id: Int
    let name: String
    let image: String
}
