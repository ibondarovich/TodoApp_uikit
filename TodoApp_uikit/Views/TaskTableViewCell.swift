//
//  TaskTableViewCell.swift
//  TodoApp_uikit
//
//  Created by user on 17/12/2025.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    static let id = "TaskTableViewCell"
    
    @IBOutlet weak var categoryContainerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var isComplete: UIImageView!
    
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return dateFormatter
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        categoryContainerView.layer.cornerRadius = categoryContainerView.frame.height / 2
        
        containerView.layer.cornerRadius = 16
        containerView.clipsToBounds = true
    }
    
    func configure(withTask task: Task) {
        categoryLabel.text = task.category.rawValue
        captionLabel.text = task.description
        isComplete.image = task.isCompleted ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "circle")
        dateLabel.text = dateFormatter.string(from: task.createdDate)
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
