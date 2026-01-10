//
//  NewTaskModalView.swift
//  TodoApp_uikit
//
//  Created by user on 18/12/2025.
//

import UIKit

class NewTaskModalView: UIView {
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var submitButton: RoundedButton!
    @IBOutlet private var contentView: UIView!
    
    private var task: Task?
    private var traitObserver: UITraitChangeRegistration?

    weak var newTaskDelegate: NewTaskDelegate?
    var onSubmit: ((Task) -> Void)?
    
    var caption: String {
        get {
            return descriptionTextView.text
        }
        
        set {
            descriptionTextView.text = newValue
        }
    }
    
    init(frame: CGRect, task: Task?) {
        super.init(frame: frame)

        self.task = task
        initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initSubviews()
    }
    
    @MainActor
    deinit {
        if let traitObserver {
            unregisterForTraitChanges(traitObserver)
        }
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "NewTaskModalView", bundle: nil)
        nib.instantiate(withOwner: self)
        
        descriptionTextView.layer.borderWidth = 0.5
        descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        descriptionTextView.layer.cornerRadius = 8
        descriptionTextView.delegate = self
        
        categoryPickerView.dataSource = self
        categoryPickerView.delegate = self
        
        if let task = task {
            descriptionTextView.text = task.description
            descriptionTextView.textColor = self.traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
            if let rowIndex = Category.allCases.firstIndex(of: task.category) {
                categoryPickerView.selectRow(rowIndex, inComponent: 0, animated: false)
            }
        } else {
            descriptionTextView.text = "Add caption..."
            descriptionTextView.textColor = UIColor.lightGray
            categoryPickerView.selectRow(1, inComponent: 0, animated: false)
        }
                
        contentView.frame = bounds
        setupTraitObserver()
        
        addSubview(contentView)
    }
    
    override func layoutSubviews() {
        contentView.layer.cornerRadius = 10
    }
    
    private func setupTraitObserver() {
        traitObserver = registerForTraitChanges([UITraitUserInterfaceStyle.self], handler: { (self: Self, previousTraitCollection: UITraitCollection) in
            if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                self.descriptionTextView.textColor = self.traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
            }
        })
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        newTaskDelegate?.closeView()
    }
    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let caption = descriptionTextView.text, caption.count >= 4 else {
            return
        }
        
        let selectedRow = categoryPickerView.selectedRow(inComponent: 0)
        let category = Category.allCases[selectedRow]
        
        if let task = task {
            let task = Task(id: task.id, category: category, description: caption, createdDate: task.createdDate, isCompleted: task.isCompleted)
            onSubmit?(task)
        } else {
            let id = UUID().uuidString
            let task = Task(id: id, category: category, description: caption, createdDate: Date(), isCompleted: false)
            onSubmit?(task)
        }
        
        newTaskDelegate?.closeView()
    }
}

extension NewTaskModalView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = self.traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            descriptionTextView.text = "Add caption..."
            descriptionTextView.textColor = UIColor.lightGray
        }
    }
}

extension NewTaskModalView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Category.allCases.count
    }
}

extension NewTaskModalView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = view as? UILabel
        
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            pickerLabel?.textAlignment = .center
        }
        
        let category = Category.allCases[row]
        pickerLabel?.text = category.rawValue
        
        return pickerLabel!
    }
}
