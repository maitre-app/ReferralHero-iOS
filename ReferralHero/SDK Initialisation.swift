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
    public static var IP: String = ""
    public static var Device: String = ""
    public static var OS: String = ""
    public static var SCREEN_SIZE = ""
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
  
    public static func setDefaultParameters()
    {
        let networkManager = NetworkManager()
//        if let ipAddress = networkManager.getInternalIPAddress() {
//            RHApiKey.IP = ipAddress
//        }
        
        networkManager.getPublicIPAddress { IP in
            if let ipAddress = IP {
                RHApiKey.IP = ipAddress
                print("getPublicIPAddress.\(ipAddress)")
                } else {
                    print("Unable to fetch the public IP address.")
                }
        }
        RHApiKey.Device = networkManager.getDeviceInfo().modelName
        RHApiKey.OS = networkManager.getDeviceInfo().osVersion
        RHApiKey.SCREEN_SIZE = networkManager.getScreenSize()
    }
}

class NetworkManager {

    func getScreenSize() -> String {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        let screenSize = "\(screenWidth) x \(screenHeight)"
        return screenSize
    }
    
    func getDeviceInfo() -> (modelName: String, osVersion: String) {
        let device = UIDevice.current
        let modelName = device.model
        let systemVersion = device.systemVersion
        
        return (modelName,systemVersion)
    }

    func getInternalIPAddress() -> String? {
        var ipAddress: String?

        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                let interface = ptr?.pointee
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                
                if addrFamily == UInt8(AF_INET) { // IPv4
                    let interfaceName = String(cString: (interface?.ifa_name)!)
                    if interfaceName == "en0" { // Wi-Fi interface
                        var ipAddressBuffer = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        if getnameinfo(interface?.ifa_addr, socklen_t((interface?.ifa_addr.pointee.sa_len)!), &ipAddressBuffer, socklen_t(ipAddressBuffer.count), nil, 0, NI_NUMERICHOST) == 0 {
                            ipAddress = String(cString: ipAddressBuffer)
                        }
                    }
                }
            }
            freeifaddrs(ifaddr)
        }

        return ipAddress
    }
    
    func getPublicIPAddress(completion: @escaping (String?) -> Void) {
        let url = URL(string: "https://api.ipify.org/")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let data = data, let ipAddress = String(data: data, encoding: .utf8) {
                completion(ipAddress)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }

    func getIPAddress() -> String? {
        var address : String?

        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }

        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee

            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

                // Check interface name:
                // wifi = ["en0"]
                // wired = ["en2", "en3", "en4"]
                // cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]
                
                let name = String(cString: interface.ifa_name)
                if  name == "en0" || name == "en2" || name == "en3" || name == "en4" || name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {

                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)

        return address
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
