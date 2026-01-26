//
//  CategoryModel.swift
//  TodoApp_uikit
//
//  Created by user on 18/12/2025.
//

import Foundation
import UIKit
import RealmSwift

enum Category: String, CaseIterable, PersistableEnum {
    case work = "Work", study = "Study", excercise = "Excercise"

    var color: UIColor {
        switch self {
        case .work:
            return UIColor.workColor
        case .excercise:
            return UIColor.excercise
        case .study:
            return UIColor.studyColor
        }
    }
}
