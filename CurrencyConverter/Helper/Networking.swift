//
//  Networking.swift
//  CurrencyConverter
//
//  Created by Nana on 31/10/24.
//

import Foundation
import Network

// A class to monitor the network connection status, notifying if the connection is active or not.
class NetworkingMonitor: ObservableObject {
    // NWPathMonitor instance to observe network path changes
    private let monitor = NWPathMonitor()
    // A custom dispatch queue for handling network monitoring tasks.
    private let queue = DispatchQueue(label: "Monitor")
    // Published property to notify SwiftUI views about the network status.
    //When `isActive` is true, there is an active internet connection.
    @Published var isActive = false
    
    // Initializes the NetworkingMonitor, sets up the network path update handler, and starts monitoring.
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isActive = path.status == .satisfied
            }
        }
        
        monitor.start(queue: queue)
    }
}
