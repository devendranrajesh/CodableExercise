//
//  CompanyParser.swift
//  CodableExercise
//
//  Created by Jayesh Kawli on 11/23/17.
//

import Foundation

class CompanyParser {
    func parseCompany() {
        let company = Company(people: [Person(name: "aaa", address: "bbb"), Person(name: "aaa1", address: "bbb1")])
        let data2 = try! JSONEncoder().encode(company)
        let companyPeopleJSON = try! JSONSerialization.jsonObject(with: data2, options: [])
        print(companyPeopleJSON)
        let decodedCompany = try! JSONDecoder().decode(Company.self, from: data2)
        print(decodedCompany)
    }
}

struct Person: Codable {
    let name: String
    let address: String
}

struct Company: Codable {
    let people: [Person]
}
