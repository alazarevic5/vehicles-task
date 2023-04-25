//
//  Requests.swift
//  VehiclesTask
//
//  Created by Aleksandra Lazarevic on 24.4.23..
//

import Foundation
import Alamofire
import UIKit

class Requests {
    
    static func loginUser(email: String, password: String, completion: @escaping ((Bool, [String: Any]) -> Void)){
        let params = ["email": email, "password":password]
        AF.request(Routes.baseURL.rawValue + Routes.login.rawValue, method: .post, parameters: params).response { data in
            print(data)
            if let data = data.data {
                do {
                    if let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let errorCode = jsonData["errorCode"] as? Int {
                            completion(false, jsonData)
                        } else {
                            completion(true, jsonData)
                        }
                    }
                } catch let ex {
                    print(ex.localizedDescription)
                }
            }
        }
    }
    
    static func getVehicles(completion: @escaping (Bool, [Vehicle])->Void) {
        let urlString = Routes.baseURL.rawValue + Routes.getAndPostVehicles.rawValue + User.userId + Routes.vehicles.rawValue
        let headers: HTTPHeaders = [.authorization(bearerToken: User.token)]
        AF.request(urlString, method: .get, headers: headers).response { data in
            if let data = data.data {
                do {
                    if let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]] {
                        var results = [Vehicle]()
                        for element in jsonData {
                            if let vehicleInfo = element["vehicleInfo"] as? [String: Any] {
                                print(vehicleInfo)
                                let vehicle = Vehicle(vin: vehicleInfo["vin"] as? String ?? "")
                                results.append(vehicle)
                            }
                        }
                        completion(true, results)
                    }
                } catch let ex {
                    print(ex.localizedDescription)
                }
            }
        }
    }
    
    static func sendVehicle(vin: String, completion: @escaping ((Bool, [String: Any]) -> Void)){
        let params = ["vin": vin]
        let headers: HTTPHeaders = [.authorization(bearerToken: User.token)]
        
        let strUrl = Routes.baseURL.rawValue + Routes.getAndPostVehicles.rawValue + User.userId + Routes.vehicles.rawValue

        AF.request(strUrl, method: .post, parameters: params, headers: headers).response { data in
            print(data)
            if let data = data.data {
                do {
                    if let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let errorCode = jsonData["errorCode"] as? Int {
                            completion(false, jsonData)
                        } else {
                            completion(true, jsonData)
                        }
                    }
                } catch let ex {
                    print(ex.localizedDescription)
                }
            }
        }
    }
    
    
    
}
//{
//    "email" : "tasktest@catch.com",
//    "password" : "qwer1234"
//}
