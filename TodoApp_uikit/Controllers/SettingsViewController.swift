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
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
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
            saveThemeMode(themeIndex: 0)
        } else if sender.selectedSegmentIndex == 1 {
            window?.overrideUserInterfaceStyle = .dark
            saveThemeMode(themeIndex: 1)
        } else {
            window?.overrideUserInterfaceStyle = .unspecified
            saveThemeMode(themeIndex: 2)
        }
    }
    
    func setUpView() {
        let window = UIApplication.shared.connectedScenes.flatMap {
            ($0 as? UIWindowScene)?.windows ?? []
        }.first { $0.isKeyWindow }
        
        if let window = window {
            switch window.overrideUserInterfaceStyle {
            case .light:
                segmentedControl.selectedSegmentIndex = 0
            case .dark:
                segmentedControl.selectedSegmentIndex = 1
            case .unspecified:
                segmentedControl.selectedSegmentIndex = 2
            default:
                segmentedControl.selectedSegmentIndex = 2
            }
        }
    }
    
    func saveThemeMode(themeIndex index: Int) {
        UserDefaults.standard.set(index, forKey: "interfacePreference")
    }
}
