//
//  DiaryService.swift
//  Diary
//
//  Created by Максим Тарасов on 29.06.2023.
//

import Foundation
import RealmSwift

class DiaryService {
    
    let realm = try! Realm()
    
    public func loadData() {

        let jsonString = """
        [
            {
                "id": 1,
                "date_start": 147600000,
                "date_finish": 147610000,
                "name": "My task",
                "desc": "Описание моего дела"
            },
            {
                "id": 10,
                "date_start": 1686882600,
                "date_finish": 1686883200,
                "name": "Сложная задача",
                "desc": "Закончить практику"
            }
        ]
        """
        
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let decoder = JSONDecoder()
                let dataItems = try decoder.decode([DataItem].self, from: jsonData)
                
                for dataItem in dataItems {
                    let id = dataItem.id
                
                    let existingItem = realm.objects(DataItem.self).filter("id == %@", id).first
                    if existingItem == nil {
                        self.realm.beginWrite()
                        self.realm.add(dataItem)
                        try! self.realm.commitWrite()
                    } else {
                        print("DataItem уже есть в Realm")
                    }
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    public func removeItem(item: DataItem) {
        self.realm.beginWrite()
        self.realm.delete(item)
        try! realm.commitWrite()
    }
    
    public func saveItem(item: DataItem) {
        realm.beginWrite()
        realm.add(item)
        try! realm.commitWrite()
    }
}
