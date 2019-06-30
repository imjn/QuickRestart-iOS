//
//  IndexPath+CacheKey.swift
//  QuickRestart
//
//  Created by Imagine Kawabe on 2019/06/30.
//  Copyright © 2019 Imagine Kawabe. All rights reserved.
//

import Foundation

extension IndexPath {
    var cacheKey: String {
        return String(describing: self)
    }
}
