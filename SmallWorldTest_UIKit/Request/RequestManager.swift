//
//  RequestManager.swift
//  SmallWorldTest_UIKit
//
//  Created by Sabih Haris on 10/12/2023.
//

import Foundation

struct RequestManager {
    
    func getData<T:Decodable>(requestUrl: URL, resultType: T.Type, completion:@escaping(_ result: T?)-> Void) {
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            if(error == nil && responseData != nil && responseData?.count != 0) {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                    _ = completion(result)
                }
                catch let error{
                    debugPrint("error happened = \(error)")
                }
            }

        }.resume()
    }

}
