//
//  ViewController.swift
//  TodoApp_uikit
//
//  Created by user on 17/12/2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var tasks: [Task] = []
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        button.tintColor = .white
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.imageView?.layer.transform = CATransform3DMakeScale(1.4, 1.4, 1.4)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        titleView.clipsToBounds = true
        titleView.layer.cornerRadius = 20
        titleView.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.separatorStyle = .none
        
       
        view.addSubview(addButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let safeAreaBottom = view.safeAreaInsets.bottom
        let width: CGFloat = 60
        let height: CGFloat = 60
        let xPos = view.frame.width / 2 - width / 2
        let yPos = view.frame.height - height - safeAreaBottom
        
        addButton.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
        
        addButton.layer.cornerRadius = width / 2
    }
    
    @objc func addButtonTapped() {
        let newTaskViewController = NewTaskViewController()
        newTaskViewController.configure { [weak self] task in
            self?.tasks.append(task)
            self?.tableView.reloadData()
        }
        
        present(newTaskViewController, animated: true)
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = tasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.id, for: indexPath) as! TaskTableViewCell
        
        cell.configure(withTask: task)
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        let newTaskViewController = NewTaskViewController(task: task)
        newTaskViewController.configure { [weak self] task in
            self?.tasks[indexPath.row] = task
            self?.tableView.reloadData()
        }
        
        
        present(newTaskViewController, animated: true)
    }
}
