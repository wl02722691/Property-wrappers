//
//  ViewController.swift
//  Property wrappers
//
//  Created by 張書涵 on 2019/11/1.
//  Copyright © 2019 張書涵. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // bad solution
//        UserDefaults.standard.hasSeenAppIntroduction = true
//        guard !UserDefaults.standard.hasSeenAppIntroduction else { return }
        
        UserDefaultsConfig.hasSeenAppIntroduction = true
        guard UserDefaultsConfig.hasSeenAppIntroduction else { return }
        
        
        
        UserDefaultsConfig.username = "Alice"
        guard UserDefaultsConfig.username != "Alice" else { return }
        
        showAppIntroduction()
    }
    
    func showAppIntroduction() {
        print("showAppIntroduction")
    }


}

// bad solution
extension UserDefaults {

    public enum Keys {
        static let hasSeenAppIntroduction = "has_seen_app_introduction"
    }

    /// Indicates whether or not the user has seen the onboarding.
    var hasSeenAppIntroduction: Bool {
        set {
            set(newValue, forKey: Keys.hasSeenAppIntroduction)
        }
        get {
            return bool(forKey: Keys.hasSeenAppIntroduction)
        }
    }
}

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct UserDefaultsConfig {
    
    @UserDefault("has_seen_app_introduction", defaultValue: false)
    static var hasSeenAppIntroduction: Bool
    
    @UserDefault("username", defaultValue: "Antoine van der Lee")
    static var username: String
    
    
}
