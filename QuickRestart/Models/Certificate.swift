//
//  Certificate.swift
//  QuickRestart
//
//  Created by Imagine Kawabe on 2019/06/30.
//  Copyright © 2019 Imagine Kawabe. All rights reserved.
//

import Foundation

enum Seriousness: String {
    case a, b, c, d, e
}

enum Category: String {
    case earthquake,
    tsunami,
    flood
}

class Certificate {

    var id: String
    var title: String
    var seriousness: Seriousness
    var imageRef: URL
    var category: Category
    var date: Date
    var estimatedMoney: String
    var postedImageRefs: [URL]

    init(id: String, title: String, seriousness: Seriousness, imageRef: URL, category: Category, date: Date, estimatedMoney: String, postedImageRefs: [URL]) {
        self.id = id
        self.title = title
        self.seriousness = seriousness
        self.imageRef = imageRef
        self.category = category
        self.date = date
        self.estimatedMoney = estimatedMoney
        self.postedImageRefs = postedImageRefs
    }

    init?(json: [String: Any]) {
        let dict = json["certificate"] as! [String:Any]
        guard
            let id = dict["id"] as? String,
            let title = dict["title"] as? String,
            let seriousnessStr = dict["seriousness"] as? String,
            let seriousness = Seriousness(rawValue: seriousnessStr),
            let imageRefStr = dict["imageRef"] as? String,
            let imageRef = URL(string: imageRefStr),
            let categoryStr = dict["category"] as? String,
            let category = Category(rawValue: categoryStr),
            let dateStr = dict["date"] as? String,
            let date = dateStr.toDate(),
            let estimatedMoney = dict["estimatedMoney"] as? String,
            let postedImageRefsStr = dict["postedImageRefs"] as? [String]
            else { return  nil }

        self.id = id
        self.title = title
        self.seriousness = seriousness
        self.imageRef = imageRef
        self.category = category
        self.date = date
        self.estimatedMoney = estimatedMoney
        self.postedImageRefs = postedImageRefsStr.compactMap({ URL(string: $0) })
    }

}

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        return dateFormatter.date(from: self)
    }
}
