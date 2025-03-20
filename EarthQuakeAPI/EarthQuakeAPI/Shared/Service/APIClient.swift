//
//  APIClient.swift
//  EarthQuakeAPI
//
//  Created by cuongdd on 20/3/25.
//  Copyright © 2025 duycuong. All rights reserved.
//

import Foundation
import SwiftyJSON

class APIClient: NSObject {
    static let shared: APIClient = APIClient()
    
    private lazy var urlSession: URLSession = {
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue.main)
        return session
    }()
    
    func getData(with target: APIType, completionHandler: @escaping(JSON) -> Void) {
        let request = createRequest(target: target)
        print(request.cURL())
        
        urlSession.dataTask(with: request) { (data, response, error) in
            var json = JSON()
            if let error = error as? URLError {
                json = [
                    "descriptionError": error.localizedDescription,
                    "code": error.code
                ]
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                json = [
                    "statusCode": httpResponse.statusCode
                ]
                if httpResponse.statusCode == 401 {
                    self.cancelAllRequest()
                }
            }
            
            if let data = data {
                do {
                    json = try JSON(data: data)
                    print(json)
                    completionHandler(json)
                } catch let error {
                    print("parse json", error.localizedDescription)
                }
            }
        }.resume()
    }
    
    private func createURL(target: APIType) -> URL {
        var urlComponent = URLComponents()
        urlComponent.scheme = target.scheme
        urlComponent.host = target.host
        urlComponent.path = target.path
        
        if let port = target.port {
            urlComponent.port = port
        }
        
        if let queryItems = target.queryItems {
            urlComponent.queryItems = queryItems
        }
        
        guard let url = urlComponent.url else {
            fatalError("Can not get url")
        }
        
        return url
    }
    
    private func createRequest(target: APIType) -> URLRequest {
        let url = createURL(target: target)
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        var headerFields = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        if let headers = target.headers {
            for header in headers {
                headerFields[header.key] = header.value
            }
        }
        
        if let bodyDictionary = target.bodyDictionary {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: bodyDictionary, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        if let bodyData = target.bodyData {
            do {
                let httpBody = try JSONEncoder().encode(bodyData)
                request.httpBody = httpBody
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        request.httpMethod = target.method
        request.allHTTPHeaderFields = headerFields
        
        return request
    }
    
    private func cancelAllRequest() {
        self.urlSession.getAllTasks { tasks in
            tasks.forEach{ (task) in
                task.cancel()
            }
        }
    }
}

extension APIClient: URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, didCreateTask task: URLSessionTask) {
        //        print("====task was create", task.state)
    }
}

extension APIClient: URLSessionDelegate {
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: (any Error)?) {
        //        print("====error", error?.localizedDescription as Any)
    }
}
