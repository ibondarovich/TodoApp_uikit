//
//  TaskTableViewCellDelegate.swift
//  TodoApp_uikit
//
//  Created by user on 08/01/2026.
//

import Foundation

protocol TaskTableViewCellDelegate: AnyObject {
    func markTask(id:String, isComplete: Bool)
}
