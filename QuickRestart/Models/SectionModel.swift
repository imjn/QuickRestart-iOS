//
//  SectionModel.swift
//  QuickRestart
//
//  Created by Imagine Kawabe on 2019/06/30.
//  Copyright © 2019 Imagine Kawabe. All rights reserved.
//

import Foundation
import RxDataSources

typealias ItemSection = AnimatableSectionModel<SectionID, Disaster>

protocol Identifiable: IdentifiableType, Equatable {
    associatedtype Identifier: Equatable
    var identity: Identifier { get }
}

enum SectionID: String, IdentifiableType {
    case DisasterListSection
    var identity: String {
        return self.rawValue
    }
}
