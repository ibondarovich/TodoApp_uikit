//
//  TaskModel.swift
//  TodoApp_uikit
//
//  Created by user on 07/01/2026.
//

import Foundation
import RealmSwift

struct Task {
    let id: String 
    let category: Category
    let caption: String
    let createdDate: Date
    let isCompleted: Bool
}

class LocalTask: Object {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var category = Category.study
    @Persisted var caption = ""
    @Persisted var createdDate = Date()
    @Persisted var isCompleted = false
}
