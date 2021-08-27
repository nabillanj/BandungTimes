//
//  Bundle+Extensions.swift
//  BandungTimes
//
//  Created by nabilla on 26/08/21.
//

import Foundation

extension Bundle {

    /// Get App Versioning from Bundle
    /// - Returns: return string or app version
    func getAppVersion() -> String {
        guard let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            return ""
        }
        return version
    }

    /// Get Build Versioning from Bundle
    /// - Returns: return string or build version
    func getBuildVersion() -> String {
        guard let buildVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String else {
            return ""
        }
        return buildVersion
    }
}
