//
//  ViewViewController.swift
//  Diary
//
//  Created by Максим Тарасов on 29.06.2023.
//

import UIKit

class ViewViewController: UIViewController {
    var presenter: MainPresenter!
    public var item: DataItem?
    
    @IBOutlet var infoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        infoTextView.text = "\(item!.desc)\n\nЗапланировано на \(dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(item!.date_start)))) с \(timeFormatter.string(from:  Date(timeIntervalSince1970: TimeInterval(item!.date_start)))) до \(timeFormatter.string(from:  Date(timeIntervalSince1970: TimeInterval(item!.date_finish))))"
        
        if #available(iOS 13.0, *) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash")?.withTintColor(.label, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(didTapDeleteButton))
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left")?.withTintColor(.label, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(exit))
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(exit))
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Удалить", style: .plain, target: self, action: #selector(didTapDeleteButton))
        }
    }

    @objc private func didTapDeleteButton() {
        guard let item = self.item else {return}
        presenter.removeItem(item: item)
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func exit() {
        navigationController?.popToRootViewController(animated: true)
    }

}
