//
//  SDK Initialisation.swift
//  ReferralHero
//
//  Created by YESHA PATEL on 17/05/2023.
//

import Foundation
import Network
import UIKit
import Network
import BranchSDK

var decoder: JSONDecoder = { return JSONDecoder() }()
var user: SubscriberModel? = nil

public class RHApiKey {
    
    public static var apiKey: String = ""
    public static var uuID: String = ""
    public static var Device: String = ""
    public static var OS: String = ""
    public static var referrerCode: String? = nil
    public static var visitorId: String? = nil
    
    public static func configure(withAPIKey apiKey: String, withuuID uuID: String, launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil, branchKey: String) {
        RHApiKey.apiKey = apiKey
        RHApiKey.uuID = uuID
        RH.retrieveUserData()
        
        // Initialize Branch SDK to get referral code
        Branch.getInstance(branchKey).initSession(launchOptions: launchOptions) { (params, error) in
            if let refCode = params?["referral_code"] as? String {
                RHApiKey.referrerCode = refCode
                print("referral code received: \(refCode)")
            }
            if let visitorId = params?["visitor_id"] as? String {
                RHApiKey.visitorId = visitorId
                print("visitorId received: \(visitorId)")
            }
        }
        self.setDefaultParameters()
    }
  
    public static func setDefaultParameters() {
        let networkManager = NetworkManager()
        RHApiKey.Device = networkManager.getDeviceInfo().modelName
        RHApiKey.OS = networkManager.getDeviceInfo().osVersion
    }
}

class NetworkManager {
    func getDeviceInfo() -> (modelName: String, osVersion: String) {
        let device = UIDevice.current
        let modelName = device.model
        let systemVersion = device.systemVersion
        return (modelName,systemVersion)
    }
}

public class BranchHelper {
    public static func handle(userActivity: NSUserActivity) -> Bool {
        return Branch.getInstance().continue(userActivity)
    }
    public static func handle(url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return Branch.getInstance().application(UIApplication.shared, open: url, options: options)
    }
}
