//
//  CertificateService.swift
//  QuickRestart
//
//  Created by Imagine Kawabe on 2019/06/30.
//  Copyright © 2019 Imagine Kawabe. All rights reserved.
//

import Foundation
import Alamofire

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

    func fetchCertificatesFromDb(completion: @escaping ([Certificate]) -> Void) {
        let apiToContact = "https://78an9p6nn8.execute-api.ap-northeast-1.amazonaws.com/default/getCertificateByAddress"
        let parameters = ["address" : UserDefaults.standard.string(forKey: "eth_address")]
        
        Alamofire.request(apiToContact, method: .post, parameters: parameters as Parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let err = response.error {
                    print(err.localizedDescription)
                    completion([])
                } else {
                    guard let data = response.data else { completion([]); return }
                    let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                    guard let jsonDict = json["certificates"] as? [[String:Any]] else { completion([]); return }
                    let certificates = jsonDict.compactMap{ Certificate(json: $0) }
                    completion(certificates)
                }
        }
    }

}
