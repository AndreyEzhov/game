//
//  RCValues.swift
//  Arcanoid
//
//  Created by aezhov on 27/11/2018.
//  Copyright © 2018 Андрей Ежов. All rights reserved.
//

import Firebase

enum ValueKey: String {
    case appPrimaryColor
}

class RCValues {
    
    // MARK: - Properties
    
    var loadingDoneCallback: (() -> Void)?
    
    var fetchComplete = false
    
    // MARK: - Construction
    
    init() {
        loadDefaultValues()
        fetchCloudValues()
    }
    
    // MARK: - Private Functions
    
    func loadDefaultValues() {
        let appDefaults: [String: Any?] = [
            ValueKey.appPrimaryColor.rawValue : "#FBB03B"
        ]
        RemoteConfig.remoteConfig().setDefaults(appDefaults as? [String: NSObject])
    }
    
    func fetchCloudValues() {
        #if DEBUG_CONFIG
        let fetchDuration: TimeInterval = 0
        activateDebugMode()
        #else
        let fetchDuration: TimeInterval = 43200
        #endif
        
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: fetchDuration) { [weak self] status, error in
            
            if let error = error {
                print("Uh-oh. Got an error fetching remote values \(error)")
                return
            }
            
            RemoteConfig.remoteConfig().activateFetched()
            let appPrimaryColorString = RemoteConfig.remoteConfig()
                .configValue(forKey: ValueKey.appPrimaryColor.rawValue)
                .stringValue ?? "undefined"
            print("Our app's primary color is \(appPrimaryColorString)")
            
            self?.fetchComplete = true
            self?.loadingDoneCallback?()
        }
    }
    
    func activateDebugMode() {
        let debugSettings = RemoteConfigSettings(developerModeEnabled: true)
        RemoteConfig.remoteConfig().configSettings = debugSettings
    }
}
