//
//  Webservice.swift
//  Test_Bank_iOS
//
//  Created by Abhishek D on 16/10/19.
//  Copyright © 2019 Abhishek D. All rights reserved.
//

import Foundation

/**
 This class handles the common POST and GET request from the workers.
 */
class Network {
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, ErrorResponse?) -> Void) {
        
        var errorRes = ErrorResponse(code: 11, message: NSLocalizedString("Something went wrong. Please try again later.", comment: ""))
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                if let error = error {
                    errorRes = ErrorResponse(code: error._code, message: error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    completion(nil, errorRes)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    errorRes = ErrorResponse(code: error._code, message: error.localizedDescription)
                    DispatchQueue.main.async {
                        completion(nil, errorRes)
                    }
                }
            }
        }
        task.resume()
    }
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, ErrorResponse?) -> Void) -> URLSessionDataTask {
        var errorRes = ErrorResponse(code: 11, message: NSLocalizedString("Something went wrong. Please try again later.", comment: ""))

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                
                if let error = error {
                    errorRes = ErrorResponse(code: error._code, message: error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    completion(nil, errorRes)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    errorRes = ErrorResponse(code: error._code, message: error.localizedDescription)
                    DispatchQueue.main.async {
                        completion(nil, errorRes)
                    }
                }
            }
        }
        task.resume()
        
        return task
    }
}
