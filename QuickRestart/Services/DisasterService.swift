//
//  DisasterService.swift
//  QuickRestart
//
//  Created by Imagine Kawabe on 2019/06/29.
//  Copyright © 2019 Imagine Kawabe. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class DisasterService {
//    static func fetchDisasters() {
//        let apiToContact = "https://api.predicthq.com/v1/events/?category=disasters,severe-weather"
//        let header = ["Authorization":"Bearer guTUm3B8z9T1jnXa7iYdS6hiKRnfDH"]
//        Alamofire.request(apiToContact, headers: header)
//            .responseJSON { response in
//                guard let data = response.data else { return }
//                let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
//                let queryResult = DisasterQueryResult(json: json)
//        }
//    }

    func fetchDisasters(query: URL?) -> Observable<DisasterQueryResult?> {
        return Observable.create({ observer in
            var queryResult: DisasterQueryResult?
            var apiToContact = "https://api.predicthq.com/v1/events/?category=disasters,severe-weather"
            if let query = query {
                let nextQueryStr = query.absoluteString
                apiToContact = nextQueryStr
            }
            let header = ["Authorization":"Bearer guTUm3B8z9T1jnXa7iYdS6hiKRnfDH"]
            Alamofire.request(apiToContact, method: .get, headers: header).responseJSON() { response in
                switch response.result {
                case .success:
                    guard let data = response.data else { return }
                    let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                    queryResult = DisasterQueryResult(json: json)
                case .failure(let error):
                    observer.onError(error)
                }
                observer.onNext(queryResult)
                observer.onCompleted()
            }
            return Disposables.create()
        })
    }


}
