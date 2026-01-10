//
//  SettingsViewController.swift
//  TodoApp_uikit
//
//  Created by user on 10/01/2026.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var appThemeLabel: UILabel!
    @IBOutlet weak var settingsTitleLabel: UILabel!
    @IBOutlet weak var modalView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        modalView.layer.cornerRadius = 8
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        let window = UIApplication.shared.connectedScenes.flatMap {
            ($0 as? UIWindowScene)?.windows ?? []
        }.first { $0.isKeyWindow }
        
        if sender.selectedSegmentIndex == 0 {
            window?.overrideUserInterfaceStyle = .light
        } else if sender.selectedSegmentIndex == 1 {
            window?.overrideUserInterfaceStyle = .dark
        } else if sender.selectedSegmentIndex == 2 {
            window?.overrideUserInterfaceStyle = .unspecified
        }
    }
}
