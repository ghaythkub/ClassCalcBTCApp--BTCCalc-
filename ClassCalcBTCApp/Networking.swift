//
//  Networking.swift
//  ClassCalcBTCApp
//
//  Created by Ghayth Kubaisi on 2/15/19.
//  Copyright © 2019 Ghayth Kubaisi. All rights reserved.
//

import Foundation
import Alamofire

class networkingClient

{
    typealias webResponse = (NSDictionary?,Error?) -> Void // to make the request parameter cleaner
    
    func executeRequest(Url: URL , completion: @escaping webResponse) // passing block as parameter to handle the data later when the function is called
    {
        //request the desired url through Alamofire
        Alamofire.request(Url).validate().responseJSON{ response in
            
            if let error = response.error {
                
                completion(nil,error) // manage error
            } else if let jsonArray = response.result.value as? NSDictionary
            {
                completion(jsonArray,nil) // manage data
                
            }
    
        }
   
    }
 
}
