import Foundation

// Card model - similar to defining types/interfaces in React
struct Card: Codable {
    let id: String
    let name: String
    let overallRating: Int
    let classType: String
    let classStats: [String]
    let prompt: String
    let level: Int
    let patk: Int
    let pdef: Int
    let matk: Int
    let mdef: Int
    let speed: Int
    let critHit: Int
    let critDmg: Int
    let vitality: Int
    let eva: Int
    let likes: Int
    let wins: Int
    let losses: Int
    let image: String
    
    // CodingKeys to map JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Name"
        case overallRating = "Overall Rating"
        case classType = "Class"
        case classStats = "ClassStats"
        case prompt = "Prompt"
        case level = "Level"
        case patk = "PATK"
        case pdef = "PDEF"
        case matk = "MATK"
        case mdef = "MDEF"
        case speed = "SPD"
        case critHit = "CRIT"
        case critDmg = "CDMG"
        case vitality = "VIT"
        case eva = "EVA"
        case likes = "Likes"
        case wins = "Wins"
        case losses = "Losses"
        case image = "IMAGE"
    }
}

struct CardData: Codable {
    let cards: [Card]
} 