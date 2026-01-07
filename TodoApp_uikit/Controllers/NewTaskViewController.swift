//
//  NewTaskViewController.swift
//  TodoApp_uikit
//
//  Created by user on 18/12/2025.
//

import UIKit

class NewTaskViewController: UIViewController {
    private var onTaskCreated: ((Task) -> Void)?
    private var task : Task?
        
    lazy var modalView: NewTaskModalView = {
        let modalWidth = view.frame.width - 30
        let modalHeight = 430
        let frame = CGRect(x: 15, y: Int(view.center.y) - (modalHeight / 2), width: Int(modalWidth), height: modalHeight)
        let modalView = NewTaskModalView(frame: frame, task: task)
        
        modalView.newTaskDelegate = self
        modalView.onSubmit = {[weak self] task in
            self?.onTaskCreated?(task)
        }
                
        return modalView
    }()
    
    init(task: Task? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        
        self.task = task
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black.withAlphaComponent(0.9)
        view.addSubview(modalView)
    }
    
    func configure(onTaskCreated: @escaping ((Task) -> Void)) {
        self.onTaskCreated = onTaskCreated
    }

}

extension NewTaskViewController: NewTaskDelegate {
    func closeView() {
        dismiss(animated: true)
    }
}
