//
//  Country.swift
//

import Foundation

struct Country: Codable{
    
    var name:String
    var countryCode:String
    var capital:String
    var population:Int
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case countryCode = "alpha3Code"
        case capital = "capital"
        case population = "population"
    }
    
    // implementation of Codable protocol
    func encode(to encoder:Encoder) throws{
    }
    
    init(from decoder:Decoder) throws{
        
        let response = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try response.decodeIfPresent(String.self, forKey: CodingKeys.name) ?? "N/A"
        self.countryCode = try response.decodeIfPresent(String.self, forKey: CodingKeys.countryCode) ?? "N/A"
        self.capital = try response.decodeIfPresent(String.self, forKey: CodingKeys.capital) ?? "N/A"
        self.population = try response.decodeIfPresent(Int.self, forKey: CodingKeys.population) ?? 0

    }
    
}
