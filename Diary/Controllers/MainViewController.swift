//
//  MainViewController.swift
//  Diary
//
//  Created by Максим Тарасов on 29.06.2023.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    public var presenter = MainPresenter()

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        presenter.setView(view: self)
        presenter.loadData()
        tableView.register(DiaryCell.self, forCellReuseIdentifier: "DiaryCell")
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 13.0, *) {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "calendar")?.withTintColor(.label, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(datePicker))
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Выбор даты", style: .plain, target: self, action: #selector(datePicker))
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DiaryCell.indertifier, for: indexPath) as! DiaryCell
        let item = presenter.data[indexPath.row]
        cell.setItem(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = presenter.data[indexPath.row]
        if #available(iOS 13.0, *) {
            guard let vc = storyboard?.instantiateViewController(identifier: "view") as? ViewViewController else {return}
            vc.item = item
            vc.presenter = self.presenter
            vc.navigationItem.largeTitleDisplayMode = .never
            vc.title = item.name
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = ViewViewController()
            vc.item = item
            vc.presenter = self.presenter
            vc.navigationItem.largeTitleDisplayMode = .never
            vc.title = item.name
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func didTapAddButton() {
        if #available(iOS 13.0, *) {
            guard let vc = storyboard?.instantiateViewController(identifier: "enter") as? EntryViewController else { return }
            vc.presenter = self.presenter
            vc.title = "Создание"
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = EntryViewController()
            vc.presenter = self.presenter
            vc.title = "Создание"
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func refresh() {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let myDel = UIContextualAction(style: .destructive, title: nil){ [self]
            (_, _, complitionHand) in
            let item = presenter.data[indexPath.row]
            presenter.removeItem(item: item)
        }
        if #available(iOS 13.0, *) {
            myDel.image = UIImage(systemName: "trash")
        } else {
            myDel.title = "Удалить"
        }
        myDel.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [myDel])
    }
    
    @objc private func datePicker() {
        let myDatePicker: UIDatePicker = UIDatePicker()
        myDatePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            myDatePicker.preferredDatePickerStyle = .wheels
            myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
            let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
            alertController.view.addSubview(myDatePicker)
            let selectAction = UIAlertAction(title: "Выбрать", style: .default, handler: { _ in
                self.presenter.selectItemsWithDate(myDatePicker.date)
            })
            selectAction.setValue(UIColor.systemGray, forKey: "titleTextColor")
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
            let showAllAction = UIAlertAction(title: "Все", style: .default, handler: { _ in
                self.presenter.getAllData()
            })
            showAllAction.setValue(UIColor.systemGray, forKey: "titleTextColor")
            alertController.addAction(selectAction)
            alertController.addAction(showAllAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true)
        } else {
            myDatePicker.datePickerMode = .date
            myDatePicker.frame = CGRect(x: 65, y: 10, width: 150, height: 40)
            let alertController = UIAlertController(title: "\n", message: nil, preferredStyle: .alert)
            alertController.view.addSubview(myDatePicker)
            let selectAction = UIAlertAction(title: "Выбрать", style: .default, handler: { _ in
                self.presenter.selectItemsWithDate(myDatePicker.date)
            })
            selectAction.setValue(UIColor.systemGray, forKey: "titleTextColor")
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
            let showAllAction = UIAlertAction(title: "Все", style: .default, handler: { _ in
                self.presenter.getAllData()
            })
            showAllAction.setValue(UIColor.systemGray, forKey: "titleTextColor")
            alertController.addAction(selectAction)
            alertController.addAction(showAllAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true)
        }
    }

}

