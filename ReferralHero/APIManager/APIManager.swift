//
//  APIManager.swift
//  ReferralHero
//
//  Created by YESHA PATEL on 16/05/2023.
//

import Foundation

public let RH = API_HELPER.shared

public class API_HELPER
{
    private init() { }
    static let shared = API_HELPER()
    
    public weak var delegate: RHDelegate?
    
    //MARK: - EndPoints - GET -
    
    //MARK: - EndPoints - POST -
    let subscribers = "/subscribers"
    internal func storeUserData(response: [String: Any]) {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: response, requiringSecureCoding: false)
            UserDefaults.standard.set(data, forKey: "User")
            UserDefaults.standard.synchronize()
            print("Dictionary stored in UserDefaults.")
        } catch {
            print("Error storing dictionary: \(error)")
        }
    }
    
    internal func retrieveUserData(){
        if let data = UserDefaults.standard.data(forKey: "User") {
            do {
                if let dictionary = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSDictionary.self, from: data) as? [String: Any] {
                    user = try decoder.decode(SubscriberModel.self, from: data)
                    debugPrint(user?.data?.id as Any)
                    print("Retrieved subscriber data: \(dictionary)")
                }
            } catch {
                print("Error retrieving subscriber data: \(error)")
            }
        } else {
            debugPrint("User  not found in UserDefaults.")
        }
    }
    
    //MARK: - CreateNewSubscriber API -
    
    public func Submit(param: RHSubscriber){
        WEB_SER.api_POST(endPoint: subscribers, param: param.toDictionary())
        { [self] (result) in
            switch result{
                case .success(let response):
                    self.storeUserData(response: response)
                    self.retrieveUserData()
                    ConfirmReferral()
                    delegate?.didReceiveAPIResponse(response, "Create new subscriber")
                    print(response)
                case .failure(let err):
                    delegate?.didFailWithError(err, "Create new subscriber")
                    print(err)
            }
        }
    }
    
    //MARK: - Confirm Referral API -
    
    func ConfirmReferral(){
        WEB_SER.api_POST(endPoint: subscribers + "/\(user?.data?.id ?? "")" + "/confirm", param: [:])
        { [self] (result) in
            switch result{
                case .success(let response):
                    delegate?.didReceiveAPIResponse(response, "Confirm referral")
                    print(response)
                case .failure(let err):
                    delegate?.didFailWithError(err, "Confirm referral")
                    print(err)
            }
        }
    }
    
    //MARK: - Track Referral API -
    
    func TrackReferral(param: RHTrackReferral){
        WEB_SER.api_POST(endPoint: subscribers + "/track_referral_conversion_event", param: param.toDictionary())
        { [self] (result) in
            switch result{
                case .success(let response):
                    delegate?.didReceiveAPIResponse(response, "TrackReferral")
                    print(response)
                case .failure(let err):
                    delegate?.didFailWithError(err, "TrackReferral")
                    print(err)
            }
        }
    }
    
    //MARK: - Promote Referral API -
    
    func Promote(){
        WEB_SER.api_POST(endPoint: subscribers + "/\(user?.data?.id ?? "")" + "/promote", param: [:])
        { [self] (result) in
            switch result{
                case .success(let response):
                    delegate?.didReceiveAPIResponse(response, "Promote")
                    print(response)
                case .failure(let err):
                    delegate?.didFailWithError(err, "Promote")
                    print(err)
            }
        }
    }
}












////MARK:- CreateNewSubscriber API
//public func CreateNewSubscriber(param: paraCreateNewSubscriber,completion: @escaping ([String: Any]?, Bool, String) -> ()){
//    WEB_SER.api_POST(task: create_new_subscribers, param: param.toDictionary())
//    { [self] (result) in
//        switch result{
//            case .success(let response):
//                completion(response, true, "Object parsed")
//                delegate?.didReceiveAPIResponse(response)
//                print(response)
//            case .failure(let err):
//                completion(nil, false, "Something went wrong")
//                delegate?.didFailWithError(err)
//                print(err)
//        }
//    }
//}
