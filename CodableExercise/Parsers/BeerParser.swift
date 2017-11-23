//
//  BeerParser.swift
//  CodableExercise
//
//  Created by Jayesh Kawli on 11/23/17.
//

import Foundation

class BeerParser {
    func parseBeers() {
        let breweriesJSON = """
                                {"meta": {"page": 1, "page_count": 100}, "breweries": [{"name": "ddd", "location": "Seattle"}, {"name": "ddwewe", "location": "Washington"}]}
                              """

        do {
            let decodedBeerObject = try JSONDecoder().decode(Beer.self, from: breweriesJSON.data(using: .utf8)!)
            print(decodedBeerObject)
            if let encodedBeerObject = try? JSONEncoder().encode(decodedBeerObject) {
                print(String(data: encodedBeerObject,encoding: .utf8)!)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

struct Beer: Codable {
    let meta: Meta
    let breweries: [Breweries]
}

struct Meta: Codable {
    let page: Int
    let pageCount: Int

    enum CodingKeys: String, CodingKey {
        case page
        case pageCount = "page_count"
    }
}

struct Breweries: Codable {
    let name: String
    let location: String
}

extension Meta {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let page = try container.decode(Int.self, forKey: .page)
        let pageCount = try container.decode(Int.self, forKey: .pageCount)
        self.init(page: page + 50, pageCount: pageCount + 400)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(page * 768, forKey: .page)
        try container.encode(pageCount / 13, forKey: .pageCount)
    }
}
