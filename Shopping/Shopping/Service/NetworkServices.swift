//
//  File.swift
//  TemplateIOS
//
//  Created by Shapee Hoa on 10/24/19.
//  Copyright © 2019 Shapee Clound. All rights reserved.
//

import Foundation
import Reachability
import Alamofire

class NetworkServices {
    static let shared = NetworkServices()
    private var reachability: Reachability!
    
    static func isNetworkAvailable() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    func configure() {
        self.reachability = try! Reachability()
        NotificationCenter.default.addObserver(self, selector:#selector(self.reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
        do {
            try self.reachability.startNotifier()
        } catch (let error) {
            print("Error occured while starting reachability notifications : \(error.localizedDescription)")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .cellular:
            print("Network available via Cellular Data.")
            break
        case .wifi:
            print("Network available via WiFi.")
            break
        case .none:
            print("Network is not available.")
            break
        case .unavailable:
            print("Network is unavailable.")
            break
        }
    }
}
