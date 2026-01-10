//
//  RoundedButton.swift
//  TodoApp_uikit
//
//  Created by user on 08/01/2026.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    override func prepareForInterfaceBuilder() {
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        backgroundColor = .link
    }

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//        titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
//        backgroundColor = .link
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 10
    }
}
