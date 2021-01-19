//  NetworkService.swift
//  FoodShow
//
//  Created by AzaDev on 12/26/20.
//  Copyright © 2020 TeamOfFour. All rights reserved.
//

import Foundation

class NetworkService {
    
    class func request<T: Codable>(for: T.Type = T.self, router: Router, id:Int?,params: [URLQueryItem]?, completion: @escaping (T) -> ()) {
        
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.getPath(id: id)
        components.queryItems = router.parameters(params: params ?? [])
        
        let session = URLSession(configuration: .default)
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
            guard response != nil else {
                print("no response")
                return
            }
            guard let data = data else {
                print("no data")
                return
            }
            
                let responseObject = try!  JSONDecoder().decode(T.self, from: data)
                 DispatchQueue.main.async {
                     completion(responseObject)
                 }
            
        }
        dataTask.resume()
    }
}
