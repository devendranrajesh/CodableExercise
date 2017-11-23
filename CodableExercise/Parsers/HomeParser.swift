//
//  HomeParser.swift
//  CodableExercise
//
//  Created by Jayesh Kawli on 11/23/17.
//

import Foundation

class HomeParser {
    func parseHome() {
        let home = Home(people: [Person(name: "aaa", address: "bbb"), Person(name: "aaa1", address: "bbb1")], room: Room(direction: 2, name: "Living Room", wall: Wall(color: 10, width: 20)), car: true, buildDate: Date(), time: Time(hour: Hour(minute: 100)), style: .apartment, url: URL(string: "http://www.google.com")!)

        if let encodedHomeObject = try? JSONEncoder().encode(home) {
            print(String(data: encodedHomeObject,encoding: .utf8)!)

            if let decodedHomeObject = try? JSONDecoder().decode(Home.self, from: encodedHomeObject) {
                print(decodedHomeObject)
            }
        }

        let homeJSON = """
        {"family": [{"name": "aaa", "address": "bbb"}, {"name": "aaa1", "address": "bbb1"}], "room": {"room_direction": 2, "name": "Living Room", "wall": {"color": 10, "width": 20}}, "build_date": "10/29/2017", "time": {"hour": {"minute": 900 }}, "home_style": "apartment", "home_url": "http://www.google.com"}
        """

        if let decodedHomeObject = try? JSONDecoder().decode(Home.self, from: homeJSON.data(using: .utf8)!) {
            print(decodedHomeObject)
            if let encodedHomeObject = try? JSONEncoder().encode(decodedHomeObject) {
                print(String(data: encodedHomeObject,encoding: .utf8)!)
            }
        }

        do {
            let decodedHomeObject = try JSONDecoder().decode(Home.self, from: homeJSON.data(using: .utf8)!)
            print(decodedHomeObject)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

struct Home: Codable {
    let people: [Person]
    let room: Room
    let car: Bool?
    let buildDate: Date
    let time: Time
    let style: Style
    let url: URL

    enum CodingKeys: String, CodingKey {
        case people = "family"
        case room
        case car
        case buildDate = "build_date"
        case time
        case style = "home_style"
        case url = "home_url"
    }
}

enum Style: String, Codable {
    case rowHouse
    case apartment = "apartment"
    case house
}

struct Time: Codable {
    let hour: Hour
}

struct Hour: Codable {
    let minute: Int
}

struct Room: Codable {
    let direction: Int
    let name: String
    let wall: Wall

    enum CodingKeys: String, CodingKey {
        case direction = "room_direction"
        case name
        case wall
    }
}

struct Wall: Codable {
    let color: Int
    let width: Int
}
