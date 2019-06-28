//
//  Question.swift
//  3erObligatorio
//
//  Created by Nicolás Handalian on 6/17/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class APIResult: Mappable {
    var response_code: Int?
    var results:[Question]?
    
    required init?(map: Map) {
        if map.JSON["response_code"] == nil { return nil }
        if map.JSON["results"] == nil { return nil }
    }
    
    func mapping(map: Map) {
        response_code <- map["response_code"]
        results <- map["results"]
    }
}
