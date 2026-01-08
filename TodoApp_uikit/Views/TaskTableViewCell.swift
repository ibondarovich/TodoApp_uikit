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
    @IBOutlet weak var isCompleteButton: UIButton!
    private var task: Task?
    private weak var taskTableViewCellDelegate: TaskTableViewCellDelegate?
    
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
    
    func configure(withTask task: Task, taskTableViewCellDelegate: TaskTableViewCellDelegate?) {
        categoryLabel.text = task.category.rawValue
        captionLabel.text = task.description
        isCompleteButton.setImage(task.isCompleted ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "circle"), for: .normal)
        dateLabel.text = dateFormatter.string(from: task.createdDate)
        selectionStyle = .none
        
        self.task = task
        self.taskTableViewCellDelegate = taskTableViewCellDelegate
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func completedToggleTapped(_ sender: Any) {
        guard let task = task else {
            return
        }
        
        taskTableViewCellDelegate?.markTask(id: task.id, isComplete: !task.isCompleted)
    }
}
