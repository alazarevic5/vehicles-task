//
//  HomeView.swift
//  VehiclesTask-SwiftUI
//
//  Created by Aleksandra Lazarevic on 25.4.23..
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var vehiclesViewModel = VehiclesViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.white, .gray], startPoint: .top, endPoint: .bottomTrailing)
            ScrollView {
                VStack (alignment: .leading) {
                    ForEach(vehiclesViewModel.vehicles, id: \.self) { vehicle in
                        VehicleItem(vin: vehicle.vin, make: vehicle.make, model: vehicle.model)
                    }
                }.padding()
            }.padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
        }
        .navigationTitle("Vehicles")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationLink(destination: ProfileView()) {
                    Image(systemName: "person.circle").foregroundColor(Color("redColor"))
                }
                               }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: AddNew()) {
                    Image(systemName: "plus").foregroundColor(Color("redColor"))
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            vehiclesViewModel.fetchVehicles()
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
