//
//  ViewState.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 13.11.2021.
//

import Foundation

enum ViewState {
    case loading
    case loaded
    case error(ViewErrorType)
}
