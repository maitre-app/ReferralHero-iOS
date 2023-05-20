//
//  SDK Initialisation.swift
//  ReferralHero
//
//  Created by YESHA PATEL on 17/05/2023.
//

import Foundation

var decoder: JSONDecoder = { return JSONDecoder() }()
var user: SubscriberModel? = nil

public class RHApiKey {
    public static var apiKey: String = ""
    public static var uuID: String = ""
    
    public static func configure(withAPIKey apiKey: String, withuuID uuID: String) {
        RHApiKey.apiKey = apiKey
        RHApiKey.uuID = uuID
        RH.retrieveUserData()
    }
}
