//
//  EntryViewController.swift
//  Diary
//
//  Created by Максим Тарасов on 29.06.2023.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    var presenter: MainPresenter!
        
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var startTimePicker: UIDatePicker!
    @IBOutlet var finishTimePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.becomeFirstResponder()
        nameTextField.delegate = self
        
        descTextField.becomeFirstResponder()
        descTextField.delegate = self
        
        datePicker.setDate(Date(), animated: true)
        startTimePicker.setDate(Date(), animated: true)
        finishTimePicker.setDate(Date(), animated: true)
        if #available(iOS 13.0, *) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "externaldrive.fill")?.withTintColor(.label, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(didTapSaveButton))
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left")?.withTintColor(.label, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(exit))
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(exit))
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(didTapSaveButton))
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func didTapSaveButton() {
        if let name = nameTextField.text, !name.isEmpty, let desc = descTextField.text, !desc.isEmpty {
            let calendar = Calendar.current
            let combinedDate1 = calendar.date(bySettingHour: calendar.component(.hour, from: startTimePicker.date), minute: calendar.component(.minute, from: startTimePicker.date), second: 0, of: datePicker.date)!
            let combinedDate2 = calendar.date(bySettingHour: calendar.component(.hour, from: finishTimePicker.date), minute: calendar.component(.minute, from: finishTimePicker.date), second: 0, of: datePicker.date)!

            let timestamp1 = combinedDate1.timeIntervalSince1970
            let timestamp2 = combinedDate2.timeIntervalSince1970
            if timestamp1 < timestamp2 {
                let item = DataItem()
                item.id = presenter.getNewId()
                item.name = name
                item.desc = desc
                item.date_start = Int(timestamp1)
                item.date_finish = Int(timestamp2)
                presenter.saveItem(item: item)
                navigationController?.popToRootViewController(animated: true)
            } else {
                let alertController = UIAlertController(title: "Исправьте время", message: "Установлено некорректное время", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "ОК", style: .default) { _ in
                    self.dismiss(animated: true)
                }
                okAction.setValue(UIColor.systemGray, forKey: "titleTextColor")
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
            }
        } else {
            let alertController = UIAlertController(title: "Заполните название и описание", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ОК", style: .default) { _ in
                self.dismiss(animated: true)
            }
            okAction.setValue(UIColor.systemGray, forKey: "titleTextColor")
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc private func exit() {
        navigationController?.popToRootViewController(animated: true)
    }
}
