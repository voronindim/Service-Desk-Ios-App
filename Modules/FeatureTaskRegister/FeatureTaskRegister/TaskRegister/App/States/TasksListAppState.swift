//
//  AppModelState.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 13.11.2021.
//

import Foundation

enum TasksListAppState {
    case loading
    case loaded([Task])
    case error(UseCasesError)
}
