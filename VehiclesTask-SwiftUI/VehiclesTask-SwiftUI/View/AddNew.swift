//
//  AddNew.swift
//  VehiclesTask-SwiftUI
//
//  Created by Aleksandra Lazarevic on 25.4.23..
//

import SwiftUI

struct AddNew: View {
    
    @State var vin: String = ""
    @State var make: String = ""
    @State var model: String = ""
    
    @State var alert: Bool = false
    @State var message: String = ""
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.white, .gray], startPoint: .top, endPoint: .bottomTrailing)
            VStack(alignment: .leading, spacing: 10) {
                Text("Vin").fontWeight(.light).foregroundColor(Color("redColor"))
                TextField("Enter vin value...", text: $vin).textInputAutocapitalization(.never)
                    .padding().cornerRadius(10)
                    .background(Color(hex: "fafcff"))
                    .foregroundColor(.black).cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color("redColor"), style: StrokeStyle(lineWidth: 1.0)))
                Divider()
                Text("Make").fontWeight(.light).foregroundColor(Color("redColor"))
                TextField("Enter make...", text: $make).textInputAutocapitalization(.never)
                    .padding().cornerRadius(10)
                    .background(Color(hex: "fafcff"))
                    .foregroundColor(.black).cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color("redColor"), style: StrokeStyle(lineWidth: 1.0)))
                Divider()
                Text("Model").fontWeight(.light).foregroundColor(Color("redColor"))
                TextField("Enter model...", text: $model).textInputAutocapitalization(.never)
                    .padding().cornerRadius(10)
                    .background(Color(hex: "fafcff"))
                    .foregroundColor(.black).cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color("redColor"), style: StrokeStyle(lineWidth: 1.0)))
                Divider()
                Spacer()
            }.padding()
        }
        .navigationTitle("Add new vehicle")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if vin.trimmingCharacters(in: .whitespaces) != "" && make.trimmingCharacters(in: .whitespaces) != "" && model.trimmingCharacters(in: .whitespaces) != "" {
                        Requests.sendVehicle(vin: vin, make: make, model: model) { res, details in

                            if details["id"] as? String != nil {
                                
                                message = "Success!\nVehicle\n \(details["vin"] as? String ?? "") has been created!"
                                alert = true
                                
                                vin = ""
                                make = ""
                                model = ""
                                
                            } else {
                                message = "Error!\nVehicle\n \(details["description"] as? String ?? "") has been created!"
                                alert = true
                                vin = ""
                                make = ""
                                model = ""
                            }
                        }
                    }
                } label: {
                    Image(systemName: "checkmark").foregroundColor(Color("redColor"))
                }

            }
        }
        .alert(message, isPresented: $alert) {
            Button("OK", role: .cancel) { }
        }

    }
}

struct AddNew_Previews: PreviewProvider {
    static var previews: some View {
        AddNew()
    }
}
