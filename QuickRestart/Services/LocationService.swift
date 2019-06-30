//
//  LocationService.swift
//  QuickRestart
//
//  Created by Imagine Kawabe on 2019/06/30.
//  Copyright © 2019 Imagine Kawabe. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire

class LocationService {
    static func sendLocation(location: CLLocation, completion: @escaping (Bool) -> Void) {
        let parameters: [String: Any] = [
            "username" : "imagine", // TODO
            "latitude" : location.coordinate.latitude,
            "longitude" : location.coordinate.longitude
        ]
        Alamofire.request("https://hssoiltszg.execute-api.ap-northeast-1.amazonaws.com/default/registerLocation", method: .post, parameters: parameters, encoding: JSONEncoding.default)
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
