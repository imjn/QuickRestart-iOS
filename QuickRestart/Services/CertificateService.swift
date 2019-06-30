//
//  CertificateService.swift
//  QuickRestart
//
//  Created by Imagine Kawabe on 2019/06/30.
//  Copyright © 2019 Imagine Kawabe. All rights reserved.
//

import Foundation

class CertificateService {
    func fetchCertificates(completion: @escaping ([Certificate]) -> Void) {
        if let path = Bundle.main.url(forResource: "Certificate", withExtension: "json")
        {
            let data = try! Data(contentsOf: path)
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            guard let jsonDict = json["certificates"] as? [[String:Any]] else { completion([]); return }
            let certificates = jsonDict.compactMap{ Certificate(json: $0) }
            completion(certificates)
        }
    }
}
