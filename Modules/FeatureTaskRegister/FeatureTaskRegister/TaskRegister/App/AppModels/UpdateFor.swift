//
//  UpdateFor.swift
//  FeatureTaskRegister
//
//  Created by Дмитрий Воронин on 09.01.2022.
//

import Foundation

enum UpdateFor {
    case me
    case department(UUID)
    case employee(UUID)
}
