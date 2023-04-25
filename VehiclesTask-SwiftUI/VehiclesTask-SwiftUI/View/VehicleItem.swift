//
//  VehicleItem.swift
//  VehiclesTask-SwiftUI
//
//  Created by Aleksandra Lazarevic on 25.4.23..
//

import SwiftUI

struct VehicleItem: View {
    
    @State var vin: String
    @State var make: String
    @State var model: String
    
    var body: some View {

            VStack (alignment: .leading) {
                HStack {
                    Text("Vin:").foregroundColor(Color("redColor"))
                    Text(vin)
                    Spacer()
                }.isHidden(vin == "", remove: true)
                HStack {
                    Text("Make:").foregroundColor(Color("redColor"))
                    Text(make)
                    Spacer()
                }.isHidden(make == "", remove: true)
                HStack {
                    Text("Model:").foregroundColor(Color("redColor"))
                    Text(model)
                    Spacer()
                }.isHidden(model == "", remove: true)
            }.padding().background(Color(hex: "#e6f4ff").opacity(0.5)).overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color("redColor"), style: StrokeStyle(lineWidth: 1.0))).cornerRadius(10).frame(minWidth: 0, maxWidth: .infinity).frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
            )
        }
    
}

struct VehicleItem_Previews: PreviewProvider {
    static var previews: some View {
        VehicleItem(vin: "", make: "", model: "")
    }
}
