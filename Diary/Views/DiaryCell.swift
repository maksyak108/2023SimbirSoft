//
//  DiaryCell.swift
//  Diary
//
//  Created by Максим Тарасов on 29.06.2023.
//

import UIKit

class DiaryCell: UITableViewCell {
    public static let indertifier = "DiaryCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
            
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var nameLabel: UILabel = .init()
    private var dateLabel: UILabel = .init()
    private var timeLabel: UILabel = .init()
    
    func setItem(item: DataItem) {
        nameLabel.text = "\(item.name)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        dateLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(item.date_start)))
        dateLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        timeLabel.text = "С \(timeFormatter.string(from:  Date(timeIntervalSince1970: TimeInterval(item.date_start)))) до \(timeFormatter.string(from:  Date(timeIntervalSince1970: TimeInterval(item.date_finish))))"
    }
    
    private func setup() {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 2
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.addArrangedSubview(dateLabel)
        verticalStackView.addArrangedSubview(timeLabel)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
            
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(verticalStackView)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            verticalStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.45)
        ])
    }
}

