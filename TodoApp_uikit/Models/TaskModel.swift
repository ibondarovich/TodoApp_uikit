//
//  TaskModel.swift
//  TodoApp_uikit
//
//  Created by user on 07/01/2026.
//

import Foundation

struct Task {
    let id: String 
    let category: Category
    let description: String
    let createdDate: Date
    let isCompleted: Bool
}
