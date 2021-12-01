////
////  Placeholder.swift
////  Service-Desk-Ios-App
////
////  Created by Dmitrii Voronin on 01.12.2021.
////
//
//import SwiftUI
//
//extension View {
//    func placeholder( _ text: String, when shouldShow: Bool, alignment: Alignment = .leading) -> some View {
//        placeholder(when: shouldShow, alignment: alignment) { Text(text).foregroundColor(.gray) }
//    }
//    
//    private func placeholder<Content: View>(when shouldShow: Bool, alignment: Alignment = .leading, @ViewBuilder placeholder: () -> Content) -> some View {
//        ZStack(alignment: alignment) {
//            placeholder().opacity(shouldShow ? 1 : 0)
//            self
//        }
//    }
//    
//}
