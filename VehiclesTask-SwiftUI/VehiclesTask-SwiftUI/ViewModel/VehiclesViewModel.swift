//
//  VehiclesViewModel.swift
//  VehiclesTask-SwiftUI
//
//  Created by Aleksandra Lazarevic on 25.4.23..
//

import Foundation

class VehiclesViewModel: ObservableObject {
        
    @Published var vehicles = [Vehicle]()
    
    func fetchVehicles() {
        Requests.getVehicles { res, vehicles in
            self.vehicles = vehicles
        }
    }
 
}
