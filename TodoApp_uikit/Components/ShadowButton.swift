//
//  ShadowButton.swift
//  TodoApp_uikit
//
//  Created by user on 10/01/2026.
//

import UIKit


class ShadowButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        backgroundColor = .link
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 5
        layer.masksToBounds = false
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0
        
    }

}
