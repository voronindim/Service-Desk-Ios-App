//
//  ViewErrorType.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 13.11.2021.
//

import Foundation

enum ViewErrorType {
    case unknownError
}

extension ViewErrorType {
    init(useCaseError: UseCasesError) {
        switch useCaseError {
        case .unknownError:
            self = .unknownError
        }
    }
}
