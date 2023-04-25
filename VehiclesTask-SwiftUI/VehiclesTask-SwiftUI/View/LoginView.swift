//
//  LoginView.swift
//  VehiclesTask-SwiftUI
//
//  Created by Aleksandra Lazarevic on 25.4.23..
//

import SwiftUI

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    
    @State private var showText: Bool = true
    
    @State private var alert = false
    
    @State private var message = ""
    @State var goToHome = false
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("home").resizable().clipped().aspectRatio(contentMode: .fill).overlay(Color.black.opacity(0.5)).ignoresSafeArea()
                
                VStack (alignment: .center, spacing: 20) {
                    Spacer()
                    VStack {
                        Image("car_login").resizable().clipped().aspectRatio(contentMode: .fit).frame(width: 200).padding(EdgeInsets(top: 25, leading: 20, bottom: 20, trailing: 20))
                        
                        Text("Login").multilineTextAlignment(.center).foregroundColor(Color("redColor")).font(.system(size: 30)).bold().fixedSize(horizontal: false, vertical: true)
                        
                        VStack (alignment: .leading) {
                            Text("Email").fontWeight(.light).foregroundColor(Color("redColor"))
                            TextField("Enter your email...", text: $email).textInputAutocapitalization(.never)
                                .padding().cornerRadius(10)
                                .background(Color(hex: "fafcff"))
                                .foregroundColor(.black).cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color("redColor"), style: StrokeStyle(lineWidth: 1.0)))
                            Text("Šifra").fontWeight(.light).foregroundColor(Color("redColor")).padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                            HStack (alignment: .center) {
                                if showText {
                                    SecureField("Enter your password...", text: $password)
                                        .padding().cornerRadius(10)
                                        .background(Color(hex: "fafcff"))
                                        .foregroundColor(.black).cornerRadius(10)
                                        .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color("redColor"), style: StrokeStyle(lineWidth: 1.0)))
                                    
                                } else {
                                    TextField("Enter your password...", text: $password)
                                        .padding().cornerRadius(10)
                                        .background(Color(hex: "fafcff"))
                                        .foregroundColor(.black).cornerRadius(10)
                                        .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color("redColor"), style: StrokeStyle(lineWidth: 1.0)))
                                }
                                
                                Button(action: {
                                    showText.toggle()
                                }, label: {
                                    Image(systemName: showText ? "eye.slash.fill" : "eye.fill").frame(width: 30, height: 30)
                                }).accentColor(.secondary)
                            }.padding(.bottom, 20)
                            
                            NavigationLink(destination: HomeView(), isActive: $goToHome) {
                                Button {
                                    if email == "" || password == "" {
                                        withAnimation(.easeInOut) {
                                            message = "Please enter your email and password."
                                            alert = true
                                        }
                                        return
                                    } else {
                                        withAnimation(.easeInOut) {
                                            alert = false
                                        }
                                        Requests.loginUser(email: email, password: password) { success, data in
                                            
                                            if success {
                                                print("Dobrodosao! \(data["token"] as? String ?? "")")
                                                User.token = data["token"] as? String ?? ""
                                                if let user = data["user"] as? [String: Any] {
                                                    User.email = user["email"] as? String ?? ""
                                                    User.name = user["name"] as? String ?? ""
                                                    User.userId = user["id"] as? String ?? ""
                                                    User.lastTimeOnline = user["lastTimeOnline"] as? String ?? ""
                                                    print("ID USERA \(User.userId)")
                                                    email = ""
                                                    password = ""
                                                    goToHome = true
                                                }
                                            } else {
                                                withAnimation(.easeInOut) {
                                                    message = data["description"] as? String ?? ""
                                                    alert = true
                                                }
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                } label: {
                                    Text("Login").foregroundColor(.white).bold().padding().background(Color("redColor")).cornerRadius(10).frame(minWidth: 0, maxWidth: .infinity)
                                }
                            }
                            
                        }.padding().padding()
                    }.frame(width: UIScreen.screenWidth - 50).background(LinearGradient(colors: [.white, .gray], startPoint: .topLeading, endPoint: .bottomTrailing).blur(radius: 20)).cornerRadius(10)
                    Spacer()
                    
                    
                    
                }
                
            }.alert(message, isPresented: $alert) {
                Button("OK", role: .cancel) { }
            }
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
