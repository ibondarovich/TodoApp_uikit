//
//  UIColorExtension.swift
//  TodoApp_uikit
//
//  Created by user on 08/01/2026.
//

import Foundation
import UIKit

extension UIColor {
    static var workColor: UIColor {
        UIColor(named: "work") ?? .systemBlue
    }

    static var exercise: UIColor {
        UIColor(named: "exercise") ?? .systemGreen
    }

    static var studyColor: UIColor {
        UIColor(named: "study") ?? .systemOrange
    }
}
