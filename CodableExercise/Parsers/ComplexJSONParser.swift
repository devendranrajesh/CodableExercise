//
//  ComplexJSONParser.swift
//  CodableExercise
//
//  Created by Jayesh Kawli on 11/23/17.
//

import Foundation

class ComplexJSONParser {
    func parseComplexJSON() {
        let quickbrowseCategories = JSONFileReader.readAndParseObjectsFromJSONFile(with: "quickbrowse")
        print(quickbrowseCategories)
    }
}
