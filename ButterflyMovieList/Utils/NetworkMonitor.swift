//
//  NetworkMonitorProtocol.swift
//  ButterflyMovieList
//
//  Created by Gishantha Darshana on 2025-10-17.
//

import Network

protocol NetworkMonitorProtocol {
    var isConnected: Bool { get }
}

final class DefaultNetworkMonitor: NetworkMonitorProtocol {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    private(set) var isConnected: Bool = true
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
}
