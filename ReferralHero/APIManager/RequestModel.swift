//
//  RequestParameterModel.swift
//  ReferralHero
//
//  Created by YESHA PATEL on 17/05/2023.
//

//MARK: - Track Referral -

public struct RHTrackReferral{
    public var email: String
    public var name: String
    public init(email: String, name: String) {
        self.email = email
        self.name = name
    }
    
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["email"] = email
        dictionary["name"] = name
        return dictionary
    }
}
public struct RHOrganicReferral{
    public var email: String
    public var name: String
    public var referrer: String?
    public var hosting_url: String?
    public var visitorId: String?
    
    public init(email: String, name: String, referrer: String? = nil, hosting_url: String? = nil, visitorId: String? = nil) {
        self.email = email
        self.name = name
        self.referrer = referrer
        self.hosting_url = hosting_url
        self.visitorId = visitorId
    }
    
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["email"] = email
        dictionary["name"] = name
        dictionary["referrer"] = referrer
        dictionary["hosting_url"] = hosting_url
        dictionary["visitor_id"] = hosting_url
        return dictionary
    }
}
public struct RHReferral{
    public var email: String
    public var name: String
    public var referrer: String?
    public var hosting_url: String?
    public var visitorId: String?
    
    public init(email: String, name: String, referrer: String? = nil, hosting_url: String? = nil, visitorId: String? = nil) {
        self.email = email
        self.name = name
        self.referrer = referrer
        self.hosting_url = hosting_url
        self.visitorId = visitorId
    }
    
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["email"] = email
        dictionary["name"] = name
        dictionary["referrer"] = referrer
        dictionary["hosting_url"] = hosting_url
        dictionary["os_type"] = "IOS"
        dictionary["device"] = RHApiKey.Device
        dictionary["visitor_id"] = hosting_url
        return dictionary
    }
}
//MARK: - Create subscriber -

public struct RHSubscriber{
    public var email: String
    public var domain: String
    public var name: String
    public var phone_number: String?
    public var os_type: String?
    public var extra_field: String?
    public var extra_field2: String?
    public var status: String?
    public var referrer: String?
    public var points: String?
    public var double_optin: String?
    public var source: String?
    public var device: String?
    public var conversion_value: String?
    public var conversion_category: String?
    public var transaction_id: String?
    public var crypto_wallet_address: String?
    public var visitorId: String?
    
    // Usage
    
    public init(email: String, domain: String, name: String, phone_number: String? = nil, os_type: String? = nil, extra_field: String? = nil, extra_field2: String? = nil, status: String? = nil, referrer: String? = nil, points: String? = nil, double_optin: String? = nil, source: String? = nil, device: String? = nil, conversion_value: String? = nil, conversion_category: String? = nil, transaction_id: String? = nil, crypto_wallet_address: String? = nil, visitorId: String? = nil) {
        self.email = email
        self.domain = domain
        self.name = name
        self.phone_number = phone_number
        self.os_type = os_type
        self.extra_field = extra_field
        self.extra_field2 = extra_field2
        self.status = status
        self.referrer = referrer
        self.points = points
        self.double_optin = double_optin
        self.source = source
        self.device = device
        self.conversion_value = conversion_value
        self.conversion_category = conversion_category
        self.transaction_id = transaction_id
        self.crypto_wallet_address = crypto_wallet_address
        self.visitorId = visitorId
    }
    
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["email"] = email
        dictionary["domain"] = domain
        dictionary["name"] = name
        dictionary["phone_number"] = phone_number
        dictionary["extra_field"] = extra_field
        dictionary["extra_field2"] = extra_field2
        dictionary["status"] = status
        dictionary["referrer"] = referrer
        dictionary["points"] = points
        dictionary["double_optin"] = double_optin
        dictionary["source"] = source
        dictionary["device"] = device
        dictionary["conversion_value"] = conversion_value
        dictionary["conversion_category"] = conversion_category
        dictionary["device"] = RHApiKey.Device
        dictionary["os_type"] = "IOS"
        dictionary["crypto_wallet_address"] = crypto_wallet_address
        dictionary["visitor_id"] = visitorId
        
        print("-----------------------------")
        print(dictionary)
        print("-----------------------------")
        return dictionary
    }
}
//MARK: - Subscriber Model -

struct SubscriberModel : Codable {
    let status : String?
    let data : SubscriberData?
    let calls_left : String?
    let timestamp : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case data = "data"
        case calls_left = "calls_left"
        case timestamp = "timestamp"
    }
}
struct SubscriberData : Codable {
    let id : String?
    let name : String?
    let email : String?
    let phone_number : String?
    let crypto_wallet_address : String?
    let crypto_wallet_provider : String?
    let extra_field : String?
    let extra_field_2 : String?
    let option_field : String?
    let conversion_amount : Double?
    let code : String?
    let position : Int?
    let referred : Bool?
    let referred_by : Referred_by?
    let people_referred : Int?
    let promoted : Bool?
    let promoted_at : String?
    let verified : Bool?
    let verified_at : Int?
    let points : Int?
    let risk_level : Int?
    let host : String?
    let source : String?
    let device : String?
    let referral_link : String?
    let created_at : Int?
    let last_updated_at : Int?
    let response : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case email = "email"
        case phone_number = "phone_number"
        case crypto_wallet_address = "crypto_wallet_address"
        case crypto_wallet_provider = "crypto_wallet_provider"
        case extra_field = "extra_field"
        case extra_field_2 = "extra_field_2"
        case option_field = "option_field"
        case conversion_amount = "conversion_amount"
        case code = "code"
        case position = "position"
        case referred = "referred"
        case referred_by = "referred_by"
        case people_referred = "people_referred"
        case promoted = "promoted"
        case promoted_at = "promoted_at"
        case verified = "verified"
        case verified_at = "verified_at"
        case points = "points"
        case risk_level = "risk_level"
        case host = "host"
        case source = "source"
        case device = "device"
        case referral_link = "referral_link"
        case created_at = "created_at"
        case last_updated_at = "last_updated_at"
        case response = "response"
    }
}
struct Referred_by : Codable {
}
