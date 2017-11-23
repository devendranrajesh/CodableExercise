//
//  ArrayParser.swift
//  CodableExercise
//
//  Created by Jayesh Kawli on 11/23/17.
//

import Foundation

class ArrayParser {
    func parseArray() {
        let jsonData = """
        [
            {"first": "Tom", "last": "Smith", "user_age": 31},
            {"first": "Bob", "last": "Smith", "user_age": 28}
        ]
        """.data(using: .utf8)!

        let decodedData = try! JSONDecoder().decode([Human].self, from: jsonData)
        print(decodedData)
    }
}
