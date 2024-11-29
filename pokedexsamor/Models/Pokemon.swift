import Foundation

struct Pokemon: Identifiable, Codable {
    let id: Int
    let name: String
    let types: [String]
    let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case types
        case imageUrl = "image"
    }
}
