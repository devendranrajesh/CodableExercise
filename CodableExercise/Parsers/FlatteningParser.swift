//
//  FlatteningParser.swift
//  CodableExercise
//
//  Created by Jayesh Kawli on 11/23/17.
//

import Foundation

class FlatteningParser {
    func flatteningParser() {
        let nestedData = """
                     {"name": "lawnmower", "info": { "style": "kolsch", "abv": "4.9" }}
                   """
        do {
            let decodedUserObject = try JSONDecoder().decode(User.self, from: nestedData.data(using: .utf8)!)
            print(decodedUserObject)
            if let encodedUserObject = try? JSONEncoder().encode(decodedUserObject) {
                print(String(data: encodedUserObject,encoding: .utf8)!)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

struct User: Codable {

    var name: String
    var style: String
    var abv: String

    enum CodingKeys: String, CodingKey {
        case name
        case info
    }

    enum InfoKey: String, CodingKey {
        case style
        case abv
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        let extraInfo = try values.nestedContainer(keyedBy: InfoKey.self, forKey: .info)
        style = try extraInfo.decode(String.self, forKey: .style)
        abv = try extraInfo.decode(String.self, forKey: .abv)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        var infoValue = container.nestedContainer(keyedBy: InfoKey.self, forKey: .info)
        try infoValue.encode(style, forKey: .style)
        try infoValue.encode(abv, forKey: .abv)
    }
}
