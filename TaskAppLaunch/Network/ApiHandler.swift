//
//  ApiHandler.swift
//  TaskAppLaunch
//
//  Created by Kishore on 21/01/23.
//

import Foundation
import Alamofire

enum Methods {
    case get,post
}

class ApiHandler {
    
    static func getData(url: String,parameters: Parameters?, method: Methods, headers: HTTPHeaders?, view: UIViewController, completion:@escaping (_ data: Data?,_ error: Error?)->Void){
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            
            switch method{
            case .get:
                // methoType = Methods.get
                print("Get")
                
                AF.request(url, method: .get).responseJSON{ response in
                    
                    if let data = response.data,let value = response.value{
                        print(value as Any)
                        completion(data,nil)
                    }else{
                        print("Error")
                        completion(nil,response.error)
                    }
                }
                
                
            case .post:
                print("Post")
                
                AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response{ response in
                    //                    guard let error = response.error else {return}
                    
                    if let data = response.data,let value = response.value{
                        print(value as Any)
                        completion(data,nil)
                    }else{
                        print("Error")
                        completion(nil,response.error)
                    }
                }
            }
        }else{
            toastMessage(" Please check InternetConnectivity ")
        }
    }
}

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

