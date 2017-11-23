//
//  DictionaryParser.swift
//  CodableExercise
//
//  Created by Jayesh Kawli on 11/23/17.
//

import Foundation

class DictionaryParser {
    func parseDictionary() {
        let jsonDictionary = """
            {"tom": {"first": "Tom", "last": "Smith", "user_age": 31},
            "bob": {"first": "Bob", "last": "Marley", "user_age": 18},
            "peter": {"first": "Peter", "last": "Pan", "user_age": 8}}
        """
        let decodedDictionary = try! JSONDecoder().decode([String: Human].self, from: jsonDictionary.data(using: .utf8)!)
        print(decodedDictionary)
    }
}

struct Human: Codable {
    let firstName: String
    let lastName: String
    let age: Int

    enum CodingKeys: String, CodingKey {
        case firstName = "first"
        case lastName = "last"
        case age = "user_age"
    }
}
