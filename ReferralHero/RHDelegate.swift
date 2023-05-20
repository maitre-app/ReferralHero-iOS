//
//  RHDelegate.swift
//  ReferralHero
//
//  Created by YESHA PATEL on 18/05/2023.
//

import Foundation

//MARK: - Create subscriber -

public protocol RHDelegate: AnyObject {
    func didReceiveAPIResponse(_ response: [String: Any], _ endPoint: String)
    func didFailWithError(_ error: Error, _ endPoint: String)
}
