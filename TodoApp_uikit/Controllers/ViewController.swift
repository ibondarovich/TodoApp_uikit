//
//  ViewController.swift
//  TodoApp_uikit
//
//  Created by user on 17/12/2025.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var tableView: UITableView!
    let realm = try! Realm()
    
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
        
        let localTasks = realm.objects(LocalTask.self)
        for localTask in localTasks {
            let task = Task(id: localTask._id, category: localTask.category, caption: localTask.caption, createdDate: localTask.createdDate, isCompleted: localTask.isCompleted)
            
            tasks.append(task)
        }
        
        tableView.reloadData()
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
            
            let localTask = LocalTask()
            localTask._id = task.id
            localTask.caption = task.caption
            localTask.createdDate = task.createdDate
            localTask.isCompleted = task.isCompleted
            localTask.category = task.category
            
            do {
                try self?.realm.write {
                    self?.realm.add(localTask)
                }
            } catch let error as NSError {
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                self?.present(alertController, animated: true, completion: nil)
            }
        }
        
        present(newTaskViewController, animated: true)
    }
    
    @IBAction func settingsButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "SettingsSegue", sender: nil)
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = tasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.id, for: indexPath) as! TaskTableViewCell
        
        cell.configure(withTask: task, taskTableViewCellDelegate: self)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            do {
                let localTask = realm.object(ofType: LocalTask.self, forPrimaryKey: task.id)
                try realm.write {
                    if let localTask = localTask {
                        realm.delete(localTask)
                    }
                }
            } catch let error as NSError {
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                present(alertController, animated: true, completion: nil)
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        let newTaskViewController = NewTaskViewController(task: task)
        newTaskViewController.configure { [weak self] task in
            self?.tasks[indexPath.row] = task
            self?.tableView.reloadData()
            
            let localTask = self?.realm.object(ofType: LocalTask.self, forPrimaryKey: task.id)
            if let localTask = localTask {
                do {
                    try self?.realm.write {
                        localTask.caption = task.caption
                        localTask.isCompleted = task.isCompleted
                        localTask.category = task.category
                    }
                } catch let error as NSError {
                    let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    self?.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
        
        present(newTaskViewController, animated: true)
    }
}

extension ViewController: TaskTableViewCellDelegate {
    func markTask(id: String, isComplete: Bool) {
        let index = tasks.firstIndex(where:  {$0.id == id}) // tasks.firstIndex { task in task.id == id}
        
        guard let index = index else {
            return
        }
        
        var task = tasks[index]
        task = Task(id: task.id, category: task.category, caption: task.caption, createdDate: task.createdDate, isCompleted: isComplete)
        tasks[index] = task
        tableView.reloadData()
    }
}
