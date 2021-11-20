//
//  InfoToast.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 20.11.2021.
//

import Foundation
import ToastViewSwift
import UIKit

final class InfoToast {
    static func show(_ text: String, image: UIImage?) {
        guard let image = image else {
            let toast = Toast.text(text)
            toast.show()
            return
        }
        let toast = Toast.default(image: image, title: text)
        toast.show()
    }
}
