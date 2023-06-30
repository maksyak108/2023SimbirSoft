//
//  DiaryTests.swift
//  DiaryTests
//
//  Created by Максим Тарасов on 29.06.2023.
//

import XCTest
@testable import Diary

final class DiaryTests: XCTestCase {
    
    var viewController: MainViewController!
    var mockPresenter: MockMainPresenter!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "Main") as? MainViewController
        mockPresenter = MockMainPresenter()
        viewController.presenter = mockPresenter
        viewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        viewController = nil
        mockPresenter = nil
        super.tearDown()
    }
    
    func testTableViewNumberOfRows() {
        let numberOfRows = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, mockPresenter.data.count)
    }
    
    func testRemoveItem() {
        let mockItem = DataItem()
        mockPresenter.mockData.append(mockItem)
        mockPresenter.removeItem(item: mockItem)
        XCTAssertFalse(mockPresenter.mockData.contains(mockItem))
    }
        
}

class MockMainPresenter: MainPresenter {
    
    var mockData: [DataItem] = []
        
    override func loadData() {
        data = []
        view?.refresh()
    }
    
    override func removeItem(item: DataItem) {
        mockData.removeAll(where: { $0 === item })
        view?.refresh()
    }
    
    
}

