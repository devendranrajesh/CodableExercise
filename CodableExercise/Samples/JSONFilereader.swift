//
//  JSONFilereader.swift
//  CodableExercise
//
//  Created by Jayesh Kawli on 11/23/17.
//

import Foundation

class JSONFileReader: NSObject {
    static func readAndParseObjectsFromJSONFile(with name: String) -> Decodable? {
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else { return nil }
        do {
            let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe) as Data
            do {
                let decodedObject = try JSONDecoder().decode(QuickBrowse.self, from: jsonData)
                return decodedObject
            } catch let error {
                print("Error occurred while trying to convert JSON data into Swift types \(error.localizedDescription)")
            }
        } catch let error {
            print("Error occurred while trying to read contents of file \(name) with error \(error.localizedDescription)")
        }
        /// Simply return a nil value when unpleasant situation is encountered.
        return nil
    }
}

