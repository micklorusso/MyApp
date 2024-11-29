//
//  SettingsViewController.swift
//  MyApp
//
//  Created by Lorusso, Michele on 29/11/24.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var languagePickerView: UIPickerView!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    let languages = [("English".localized(), "en"), ("Italian".localized(), "it")]
    var selectedLanguageCode: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Settings".localized()
        
        confirmButton.setTitle("Confirm".localized(), for: .normal)
        
        languagePickerView.delegate = self
        languagePickerView.dataSource = self

        selectedLanguageCode = languages.first?.1
    }
    

    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        guard let languageCode = selectedLanguageCode else { return }

        LanguageManager.switchLanguage(to: languageCode)
        
        dismiss(animated: true, completion: nil)
    }
    
}


extension SettingsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(
        _ pickerView: UIPickerView, numberOfRowsInComponent component: Int
    ) -> Int {
        return languages.count
    }
}

extension SettingsViewController: UIPickerViewDelegate {
    func pickerView(
        _ pickerView: UIPickerView, titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        return languages[row].0
    }
    
    func pickerView(
        _ pickerView: UIPickerView, didSelectRow row: Int,
        inComponent component: Int
    ) {
        selectedLanguageCode = languages[row].1
    }
    
}
