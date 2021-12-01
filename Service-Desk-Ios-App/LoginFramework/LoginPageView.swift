////
////  LoginPageView.swift
////  Service-Desk-Ios-App
////
////  Created by Dmitrii Voronin on 01.12.2021.
////
//
//import SwiftUI
//
//struct LoginPageView: View {
//    // MARK: - Handlers
//    
//    var loginButtonDidTapped: ((_ userName: String, _ password: String) -> Void)
//    var forgotButtonDidTapped: (() -> Void)
//    var signupButtonDidTapped: (() -> Void)
//    
//    // MARK: - Body
//    
//    var body: some View {
//        NavigationView {
//            Home(loginButtonDidTapped: loginButtonDidTapped, forgotButtonDidTapped: forgotButtonDidTapped, signupButtonDidTapped: signupButtonDidTapped)
//                .preferredColorScheme(.dark)
//                .navigationBarHidden(true)
//        }
//    }
//    
//}
//
//struct Home: View {
//    
//    // MARK: - @States
//    
//    @State private var userName = ""
//    @State private var password = ""
//    
//    // MARK: - Handlers
//    
//    var loginButtonDidTapped: ((_ userName: String, _ password: String) -> Void)
//    var forgotButtonDidTapped: (() -> Void)
//    var signupButtonDidTapped: (() -> Void)
//    
//    // MARK: - Body
//    
//    var body: some View {
//        VStack {
//            Image("login-image")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .padding(.horizontal, 35)
//                .padding(.vertical)
//            
//            HStack {
//                VStack(alignment: .leading, spacing: 12, content: {
//                    Text("Login")
//                        .font(.title)
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//                    Text("Please sign in to continue")
//                        .foregroundColor(.white.opacity(0.5))
//                })
//                Spacer(minLength: 0)
//            }
//            .padding(.leading, 35 )
//            
//            HStack {
//                Image(systemName: "envelope")
//                    .font(.title2)
//                
//                TextField("", text: $userName)
//                    .placeholder("LOGIN", when: userName.isEmpty)
//            }
//            .foregroundColor(.white)
//            .padding()
//            .background(Color.white.opacity(userName == "" ? 0 : 0.12))
//            .cornerRadius(15)
//            .padding(.horizontal)
//            
//            HStack {
//                Image(systemName: "lock")
//                    .font(.title2)
//                
//                SecureField("", text: $password)
//                    .placeholder("PASSWORD", when: password.isEmpty)
//            }
//            .foregroundColor(.white)
//            .padding()
//            .background(Color.white.opacity(password == "" ? 0 : 0.12))
//            .cornerRadius(15)
//            .padding(.horizontal)
//            .padding(.top)
//            
//            Button(action: { loginButtonDidTapped(userName, password) }, label: {
//                Text("LOGIN")
//                    .fontWeight(.heavy)
//                    .foregroundColor(.white)
//                    .padding(.vertical)
//                    .frame(width: UIScreen.main.bounds.width - 150)
//                    .background(Color.blue)
//                    .clipShape(Capsule())
//                
//            })
//            .padding(.top)
//            .opacity(userName != "" && password != "" ? 1 : 0.5)
//            .disabled(userName != "" && password != "" ? false : true)
//            
//            Button(action: { forgotButtonDidTapped() }, label: {
//                Text("Forget password?")
//                    .foregroundColor(Color.blue)
//            })
//                .padding(.top, 8)
//            
//            Spacer(minLength: 0)
//            
//            HStack(spacing: 6) {
//                Text("Don't have an account? ")
//                    .foregroundColor(.white.opacity(0.6))
//                
//                Button(action: { signupButtonDidTapped() }, label: {
//                    Text("Signup")
//                        .fontWeight(.heavy)
//                        .foregroundColor(Color.blue)
//                })
//            }
//            .padding(.vertical)
//        }
//        .background(Color.black.ignoresSafeArea(.all, edges: .all))
//    }
//}
//
//struct LoginPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginPageView(loginButtonDidTapped: {_,_  in}, forgotButtonDidTapped: {}, signupButtonDidTapped: {})
//    }
//}
//
