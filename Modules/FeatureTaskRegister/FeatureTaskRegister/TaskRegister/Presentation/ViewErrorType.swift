//
//  ViewErrorType.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 13.11.2021.
//

import Foundation

enum ViewErrorType {
    case unknownError
    case chnageStatusError
}

extension ViewErrorType {
    init(useCaseError: UseCasesError) {
        switch useCaseError {
        case .unknownError:
            self = .unknownError
        case .chnageStatusError:
            self = .chnageStatusError
        }
    }
}
