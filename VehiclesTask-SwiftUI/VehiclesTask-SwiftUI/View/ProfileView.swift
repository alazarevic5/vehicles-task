//
//  ProfileView.swift
//  VehiclesTask-SwiftUI
//
//  Created by Aleksandra Lazarevic on 25.4.23..
//

import SwiftUI

struct ProfileView: View {
    
    @State var goHome = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.white, .gray], startPoint: .top, endPoint: .bottomTrailing)
            VStack(alignment: .leading, spacing: 10) {
                Text("Name").foregroundColor(Color("redColor"))
                Text(User.name)
                Divider()
                Text("Email").foregroundColor(Color("redColor"))
                Text(User.email)
                Divider()
                Text("Last time online").foregroundColor(Color("redColor"))
                Text(SetupData.formatDate(str: User.lastTimeOnline))
                Divider()
                Spacer()
            }.padding()
        }
        .fullScreenCover(isPresented: $goHome, content: {
            LoginView()
        })
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    self.goHome = true
                } label: {
                    Image(systemName: "door.right.hand.open").foregroundColor(Color("redColor"))
                }

            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
