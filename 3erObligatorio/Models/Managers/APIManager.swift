//
//  APIManager.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 6/21/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class APIManager {
    static let shared = APIManager()
    let baseUrl = "https://opentdb.com/api.php"
    
    func getQuestion(category:QuestionCategory ,difficulty:QuestionDifficulty, onCompletionHandler: @escaping(_ result: APIResult?, _ error: Error?) -> Void){
        let parameters: [String:Any] = ["amount": 1,"category": category.rawValue,"difficulty":difficulty.rawValue,"type":"multiple","encode":"base64"]
        Alamofire.request(baseUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject{ (response: DataResponse<APIResult>) in
            switch response.result{
            case .success:
                    onCompletionHandler(response.value,nil)
            case .failure(let error):
                onCompletionHandler(nil,error)
            }
        }
    }
}
