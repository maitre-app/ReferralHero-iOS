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
    
    //MARK: - EndPoints -
    let subscribers = "/subscribers"
    let leaderboard = "/leaderboard"
    
    internal func storeUserData(response: Data?) {
        if let data = response
        {
            UserDefaults.standard.set(data, forKey: "User")
            UserDefaults.standard.synchronize()
            print("Dictionary stored in UserDefaults.")
        }
    }
    
    internal func retrieveUserData(){
        if let data = UserDefaults.standard.data(forKey: "User") {
                user = try? decoder.decode(SubscriberModel.self, from: data)
        } else {
                debugPrint("User not found in UserDefaults.")
            }
    }
    
    //MARK: - CreateNewSubscriber API -
    public func formSubmit(param: RHSubscriber){
        WEB_SER.api_POST(endPoint: subscribers, param: param.toDictionary())
        { [self] (result,data) in
            switch result{
                case .success(let response):
                    self.storeUserData(response: data)
                    self.retrieveUserData()
                    delegate?.didReceiveAPIResponse(response, "Create new subscriber")
                    print(response)
                case .failure(let err):
                    delegate?.didFailWithError(err, "Create new subscriber")
                    print(err)
            }
        }
    }
    //MARK: - Subscriber Detail API -
    public func getSubscriberDetail(){
        WEB_SER.api_GET(endPoint: subscribers + "/\(user?.data?.id ?? "")")
        { [self] (result, data) in
            switch result{
                case .success(let response):
                    self.storeUserData(response: data)
                    self.retrieveUserData()
                    delegate?.didReceiveAPIResponse(response, "SubscriberDetail")
                    print(response)
                case .failure(let err):
                    delegate?.didFailWithError(err, "SubscriberDetail")
                    print(err)
            }
        }
    }
    //MARK: - Delete Subscriber API -
    public func DeleteSubscriber(){
        WEB_SER.api_DELETE(endPoint: subscribers + "/\(user?.data?.id ?? "")", param: [:])
        { [self] (result) in
            switch result{
                case .success(let response):
                    delegate?.didReceiveAPIResponse(response, "DeleteReferral")
                    print(response)
                case .failure(let err):
                    delegate?.didFailWithError(err, "DeleteReferral")
                    print(err)
            }
        }
    }
    //MARK: - Update Subscriber API -
    public func UpdateSubscriber(param: RHSubscriber){
        WEB_SER.api_PATCH(endPoint: subscribers + "/\(user?.data?.id ?? "")", param: param.toDictionary())
        { [self] (result, data) in
            switch result{
                case .success(let response):
                    self.storeUserData(response: data)
                    self.retrieveUserData()
                    delegate?.didReceiveAPIResponse(response, "UpdateSubscriber")
                    print(response)
                case .failure(let err):
                    delegate?.didFailWithError(err, "UpdateSubscriber")
                    print(err)
            }
        }
    }
    //MARK: - Click Capture API -
    public func clickCapture(social: String){
        WEB_SER.api_POST(endPoint: subscribers + "/\(user?.data?.id ?? "")" + "/click_capture", param: ["social" : social])
        { [self] (result, data) in
            switch result{
                case .success(let response):
                    delegate?.didReceiveAPIResponse(response, "clickCapture")
                    print(response)
                case .failure(let err):
                    delegate?.didFailWithError(err, "clickCapture")
                    print(err)
            }
        }
    }
    //MARK: - GetMyReferrals API -
    public func getMyReferrals(){
        WEB_SER.api_GET(endPoint: subscribers + "/\(user?.data?.id ?? "")" + "/referrals_data")
        { [self] (result, data) in
            switch result{
                case .success(let response):
                    delegate?.didReceiveAPIResponse(response, "getMyReferrals")
                    print(response)
                case .failure(let err):
                    delegate?.didFailWithError(err, "getMyReferrals")
                    print(err)
            }
        }
    }
    //MARK: - GetLeaderboard API -
    public func getLeaderboard(){
        WEB_SER.api_GET(endPoint: leaderboard)
        { [self] (result, data) in
            switch result{
                case .success(let response):
                    delegate?.didReceiveAPIResponse(response, "getLeaderboard")
                    print(response)
                case .failure(let err):
                    delegate?.didFailWithError(err, "getLeaderboard")
                    print(err)
            }
        }
    }
    //MARK: - Track Referral API -
    public func trackReferral(param: RHTrackReferral){
        WEB_SER.api_POST(endPoint: subscribers + "/track_referral_conversion_event", param: param.toDictionary())
        { [self] (result, data) in
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
    //MARK: - Confirm Referral API -
    public func ConfirmReferral(){
        WEB_SER.api_POST(endPoint: subscribers + "/\(user?.data?.id ?? "")" + "/confirm", param: [:])
        { [self] (result, data) in
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
    
    //MARK: - Organic Track Referral API -
    public func OrganicTrackReferral(param: RHOrganicReferral){
        WEB_SER.api_POST(endPoint: subscribers + "/organic_track_referral", param: param.toDictionary())
        { [self] (result, data) in
            switch result{
                case .success(let response):
                    delegate?.didReceiveAPIResponse(response, "Organic Track Referral")
                    print(response)
                case .failure(let err):
                    delegate?.didFailWithError(err, "Organic Track Referral")
                    print(err)
            }
        }
    }
    
    //MARK: - Create Pending Referral API -
    public func CreatePendingReferral(param: RHReferral){
        WEB_SER.api_POST(endPoint: subscribers + "/pending_referral", param: param.toDictionary())
        { [self] (result, data) in
            switch result{
                case .success(let response):
                    delegate?.didReceiveAPIResponse(response, "Create Pending Referral")
                    print(response)
                case .failure(let err):
                    delegate?.didFailWithError(err, "Create Pending Referral")
                    print(err)
            }
        }
    }

    //MARK: - Referral List API -
    public func RewardsList(){
        WEB_SER.api_GET(endPoint: subscribers + "/\(user?.data?.id ?? "")" + "/rewards")
        { [self] (result, data) in
            switch result{
                case .success(let response):
                    delegate?.didReceiveAPIResponse(response, "Rewards List")
                    print(response)
                case .failure(let err):
                    delegate?.didFailWithError(err, "Rewards List")
                    print(err)
            }
        }
    }

    //MARK: - Referrer List API -
    public func ReferrerList(){
        WEB_SER.api_GET(endPoint: subscribers + "/referrer?os_type=ios&device=mobile&ip_address=\(RHApiKey.IP)&screen_size=\(RHApiKey.SCREEN_SIZE)")
        { [self] (result, data) in
            switch result{
                case .success(let response):
                    delegate?.didReceiveAPIResponse(response, "Referrer List")
                    print(response)
                case .failure(let err):
                    delegate?.didFailWithError(err, "Referrer List")
                    print(err)
            }
        }
    }
    
    //MARK: - Get Referrer API -
    public func GetReferrer(){
    // this is how it needs to look:
    // https://dev.referralhero.com/api/sdk/v1/lists/:uuid/subscribers/referrer
        WEB_SER.api_GET(endPoint: subscribers + "/referrer")
        { [self] (result, data) in
            switch result{
                case .success(let response):
                    delegate?.didReceiveAPIResponse(response, "Get Referrer")
                    print(response)
                case .failure(let err):
                    delegate?.didFailWithError(err, "Get Referrer")
                    print(err)
            }
        }
    }
    
    //MARK: - Logout API -
    public func Logout(){
        UserDefaults.standard.removeObject(forKey: "User")
        UserDefaults.standard.synchronize()
        user = nil
    }
}

//    //MARK: - Create Visitor Referral API -
//    public func CreateVisitorReferral(){
//        WEB_SER.api_POST_V2(endPoint: subscribers + "/visitor_referral", param: [:])
//        { [self] (result, data) in
//            switch result{
//                case .success(let response):
//                    delegate?.didReceiveAPIResponse(response, "Create Visitor Referral")
//                    print(response)
//                case .failure(let err):
//                    delegate?.didFailWithError(err, "Create Visitor Referral")
//                    print(err)
//            }
//        }
//    }

////MARK: - Promote Referral API -
//
//func Promote(){
//    WEB_SER.api_POST(endPoint: subscribers + "/\(user?.data?.id ?? "")" + "/promote", param: [:])
//    { [self] (result, data) in
//        switch result{
//            case .success(let response):
//                delegate?.didReceiveAPIResponse(response, "Promote")
//                print(response)
//            case .failure(let err):
//                delegate?.didFailWithError(err, "Promote")
//
//                print(err)
//        }
//    }
//}
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
