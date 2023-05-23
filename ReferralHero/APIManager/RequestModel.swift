//
//  RequestParameterModel.swift
//  ReferralHero
//
//  Created by YESHA PATEL on 17/05/2023.
//

//MARK: - Track Referral -

public struct RHTrackReferral{
    public var email: String? = user?.data?.email
    public var phone_number: String? = user?.data?.phone_number
    public var crypto_wallet_address: String? = user?.data?.crypto_wallet_address
    public var referrer: String
    public init(email: String?, phone_number: String, crypto_wallet_address: String, referrer: String) {
        self.email = email
        self.phone_number = phone_number
        self.crypto_wallet_address = crypto_wallet_address
        self.referrer = referrer
    }
    
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["email"] = email
        dictionary["phone_number"] = phone_number
        dictionary["crypto_wallet_address"] = crypto_wallet_address
        dictionary["referrer"] = referrer
        return dictionary
    }
}

//MARK: - Create subscriber -

public struct RHSubscriber{
    public var email: String
    public var domain: String
    public var name: String
    public var ip_address: String?
    public var os_type: String?
    public var screen_size: String?
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
    // Usage
    
    public init(email: String, domain: String, name: String, ip_address: String? = nil, os_type: String? = nil, screen_size: String? = nil, extra_field: String? = nil, extra_field2: String? = nil, status: String? = nil, referrer: String? = nil, points: String? = nil, double_optin: String? = nil, source: String? = nil, device: String? = nil, conversion_value: String? = nil, conversion_category: String? = nil, transaction_id: String? = nil) {
        self.email = email
        self.domain = domain
        self.name = name
        self.ip_address = ip_address
        self.os_type = os_type
        self.screen_size = screen_size
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
    }
    
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["email"] = email
        dictionary["domain"] = domain
        dictionary["name"] = name
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
        dictionary["ip_address"] = RHApiKey.IP
        dictionary["device"] = RHApiKey.Device
        dictionary["os_type"] = RHApiKey.OS
        dictionary["screen_size"] = RHApiKey.SCREEN_SIZE
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
