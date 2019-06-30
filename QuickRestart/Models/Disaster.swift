//
//  Disaster.swift
//  QuickRestart
//
//  Created by Imagine Kawabe on 2019/06/29.
//  Copyright © 2019 Imagine Kawabe. All rights reserved.
//

import Foundation

class DisasterQueryResult {
    var disasters: [Disaster]
    var nextQuery: URL?

    init(json: [String:Any]) {
        guard let results = json["results"] else {
            disasters = []
            nextQuery = nil
            return
        }
        guard let dict = results as? [[String:Any]] else {
            disasters = []
            nextQuery = nil
            return
        }
        self.disasters = dict.compactMap { disaster in
            Disaster(dict: disaster)
        }
        if let queryStr = json["next"] as? String {
            self.nextQuery = URL(string: queryStr)
        }
    }
}

class Disaster: Identifiable {
    static func == (lhs: Disaster, rhs: Disaster) -> Bool {
        return lhs.identity == rhs.identity
    }
    typealias Identity = String
    var identity: Identity = UUID().uuidString

    var id: String
    var rank: Int?
    var labels: [String]?
    var location: [Double]?
    var title: String
    var country: String?
    var content: String?
    var date: Date

    init?(dict: [String:Any]) {
        guard
            let id = dict["id"] as? String,
            let title = dict["title"] as? String,
            let start = dict["start"] as? String,
            let date = start.toDate()
        else { return nil }
        self.id = id
        self.title = title
        self.rank = dict["rank"] as? Int
        self.labels = dict["labels"] as? [String]
        self.location = dict["location"] as? [Double]
        self.country = dict["country"] as? String
        self.content = dict["description"] as? String
        self.date = date
    }
}
