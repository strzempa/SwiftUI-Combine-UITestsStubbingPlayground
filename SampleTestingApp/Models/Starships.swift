import Foundation

struct Starships: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Result]?
    
    struct Result: Codable {
        let name, model, manufacturer, costInCredits: String?
        let length, maxAtmospheringSpeed, crew, passengers: String?
        let cargoCapacity, consumables, hyperdriveRating, mglt: String?
        let starshipClass: String?
        let pilots, films: [String]?
        let created, edited: String?
        let url: String?
    }
}
