//
//  MainPresenter.swift
//  Diary
//
//  Created by Максим Тарасов on 29.06.2023.
//

import Foundation
import RealmSwift

class MainPresenter {
    weak var view: MainViewController?
    private let diaryService = DiaryService()
    
    func setView(view: MainViewController) {
        self.view = view
    }
    
    var data = [DataItem]()
    
    private let realm: Realm
        
    init() {
        realm = diaryService.realm
    }
    
    func loadData() {
        diaryService.loadData()
        data = realm.objects(DataItem.self).map({ $0 })
    }
    
    func removeItem(item: DataItem) {
        diaryService.removeItem(item: item)
        data = realm.objects(DataItem.self).map({ $0 })
        view?.refresh()
    }
    
    func selectItemsWithDate(_ selectedDate: Date) {
        data = realm.objects(DataItem.self).map({ $0 })
        data = data.filter { item in
            let itemDate = Date(timeIntervalSince1970: TimeInterval(item.date_start))
            return Calendar.current.isDate(itemDate, inSameDayAs: selectedDate)
        }.sorted { item1, item2 in
            return item1.date_start < item2.date_start
        }
        view?.refresh()
    }
    
    func getAllData() {
        data = realm.objects(DataItem.self).map({ $0 })
        view?.refresh()
    }
    
    func saveItem(item: DataItem) {
        diaryService.saveItem(item: item)
        data = realm.objects(DataItem.self).map({ $0 })
        view?.refresh()
    }
    
    func getNewId() -> Int {
        (data.map({ $0.id }).max() ?? 0) + 1
    }
}
