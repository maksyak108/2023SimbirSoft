//
//  DataItem.swift
//  Diary
//
//  Created by Максим Тарасов on 29.06.2023.
//

import Foundation
import RealmSwift

class DataItem: Object, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var date_start: Int = 0
    @objc dynamic var date_finish: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
}
