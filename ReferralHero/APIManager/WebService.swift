//
//  WebService.swift
//  ReferralHero
//
//  Created by YESHA PATEL on 16/05/2023.
//

import Foundation

let WEB_SER = WEB_HELPER.shared

class WEB_HELPER
{
    private init() { }
    static let shared = WEB_HELPER()
    
    private func getBaseUrl() -> String
    {
        return "https://dev.referralhero.com/api/sdk/v1/lists/" + RHApiKey.uuID
      //  return "https://app.referralhero.com/api/v2/lists/" + RHApiKey.uuID
    }
    
    private func getDefaultParam(param: [String : Any]) -> [String : Any]
    {
        var newParam = param
        newParam["timestamp"] = "\(Int(TimeInterval(Date().timeIntervalSince1970)))"

        return newParam
    }
    
    //MARK:- GET SERVICE
    func api_GET(endPoint: String, completion: @escaping (Result<[String: Any], Error>, Data?) -> Void)
    {
        guard let url = URL(string: self.getBaseUrl() + endPoint) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)), nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
               request.addValue("application/vnd.referralhero.v1", forHTTPHeaderField: "Accept")
               request.addValue(RHApiKey.apiKey, forHTTPHeaderField: "Authorization")
               request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error), nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid HTTP response", code: 0, userInfo: nil)), nil)
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let dataDictionary = json as? [String: Any] {
                        completion(.success(dataDictionary), data)
                    } else {
                        completion(.failure(NSError(domain: "Invalid JSON response", code: 0, userInfo: nil)), nil)
                    }
                } catch {
                    completion(.failure(error), nil)
                }
            }
        }
        task.resume()
    }
    
    //MARK:- POST SERVICE
    func api_POST(endPoint: String, param: [String : Any], completion: @escaping (Result<[String: Any], Error>, Data?) -> Void) {
        let passParam = self.getDefaultParam(param: param)
        
        guard let url = URL(string: self.getBaseUrl() + endPoint) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)), nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
           if let jsonData = try? JSONSerialization.data(withJSONObject: passParam) {
               request.httpBody = jsonData
               request.addValue("application/vnd.referralhero.v1", forHTTPHeaderField: "Accept")
               request.addValue(RHApiKey.apiKey, forHTTPHeaderField: "Authorization")
               request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error), nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid HTTP response", code: 0, userInfo: nil)), nil)
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let dataDictionary = json as? [String: Any] {
                        completion(.success(dataDictionary), data)
                    } else {
                        completion(.failure(NSError(domain: "Invalid JSON response", code: 0, userInfo: nil)), nil)
                    }
                } catch {
                    completion(.failure(error), nil)
                }
            }
        }
        
        task.resume()
    }
    
    //MARK:- PATCH SERVICE
    func api_PATCH(endPoint: String, param: [String : Any], completion: @escaping (Result<[String: Any], Error>, Data?) -> Void) {
        let passParam = self.getDefaultParam(param: param)
        
        guard let url = URL(string: self.getBaseUrl() + endPoint) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)), nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
           if let jsonData = try? JSONSerialization.data(withJSONObject: passParam) {
               request.httpBody = jsonData
               request.addValue("application/vnd.referralhero.v1", forHTTPHeaderField: "Accept")
               request.addValue(RHApiKey.apiKey, forHTTPHeaderField: "Authorization")
               request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error), nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid HTTP response", code: 0, userInfo: nil)), nil)
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let dataDictionary = json as? [String: Any] {
                        completion(.success(dataDictionary), data)
                    } else {
                        completion(.failure(NSError(domain: "Invalid JSON response", code: 0, userInfo: nil)), nil)
                    }
                } catch {
                    completion(.failure(error), nil)
                }
            }
        }
        
        task.resume()
    }
    
    //MARK:- DELETE SERVICE
    func api_DELETE(endPoint: String, param: [String : Any], completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let passParam = self.getDefaultParam(param: param)
        
        guard let url = URL(string: self.getBaseUrl() + endPoint) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
           if let jsonData = try? JSONSerialization.data(withJSONObject: passParam) {
               request.httpBody = jsonData
               request.addValue("application/vnd.referralhero.v1", forHTTPHeaderField: "Accept")
               request.addValue(RHApiKey.apiKey, forHTTPHeaderField: "Authorization")
               request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid HTTP response", code: 0, userInfo: nil)))
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let dataDictionary = json as? [String: Any] {
                        completion(.success(dataDictionary))
                    } else {
                        completion(.failure(NSError(domain: "Invalid JSON response", code: 0, userInfo: nil)))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    //MARK:- PUT SERVICE
    func api_PUT(endPoint: String, param: [String : Any], completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let passParam = self.getDefaultParam(param: param)
        
        guard let url = URL(string: self.getBaseUrl() + endPoint) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
           if let jsonData = try? JSONSerialization.data(withJSONObject: passParam) {
               request.httpBody = jsonData
               request.addValue("application/vnd.referralhero.v1", forHTTPHeaderField: "Accept")
               request.addValue(RHApiKey.apiKey, forHTTPHeaderField: "Authorization")
               request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid HTTP response", code: 0, userInfo: nil)))
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let dataDictionary = json as? [String: Any] {
                        completion(.success(dataDictionary))
                    } else {
                        completion(.failure(NSError(domain: "Invalid JSON response", code: 0, userInfo: nil)))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}

extension Array {
    
    func getData() -> Data {
        return try! JSONSerialization.data(withJSONObject: self, options: [])
    }
}

extension Dictionary {
    
    func getData() -> Data {
        return try! JSONSerialization.data(withJSONObject: self, options: [])
    }
}

extension NSDictionary {
    
    func getData() -> Data {
        return try! JSONSerialization.data(withJSONObject: self, options: [])
    }
}
