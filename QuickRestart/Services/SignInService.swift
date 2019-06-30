//
//  SignInService.swift
//  QuickRestart
//
//  Created by Imagine Kawabe on 2019/06/30.
//  Copyright © 2019 Imagine Kawabe. All rights reserved.
//

import Foundation
import Alamofire

class SignInService {
    func signIn(username: String, completion: @escaping (Bool) -> Void) {
        let apiToContact = "https://fvw084zh70.execute-api.ap-northeast-1.amazonaws.com/default/registerUser"
        let address = "0xa43e00a4d376d14117e7c97bfb57b54409f9b2b4"
        let parameters: [String: Any] = [
            "username" : username,
            "eth_address" : address,
            "ada_address" : "Ae2tdPwUPEZ25qr3SQLbKc8obr5cpzkKG6427TPGGjknT4J3YJrnn8RwwtD"
        ]

        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(address, forKey: "eth_address")

        Alamofire.request(apiToContact, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let err = response.error {
                    print(err.localizedDescription)
                    completion(false)
                } else {
                    guard let data = response.data else { completion(false); return }
                    let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                    if let message = json["result"] as? String, message == "success" {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
        }

    }
}
