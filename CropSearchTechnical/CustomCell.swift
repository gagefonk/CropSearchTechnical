//
//  CustomCell.swift
//  CropSearchTechnical
//
//  Created by Gage Fonk on 8/26/21.
//

import UIKit

class CustomCell: UITableViewCell {
    static let reuseIdentifier = "customCell"
    var showTextField: Bool = true
    
    //create tab accessory
    let tab: UISegmentedControl = {
        let selections = ["Acceptable", "Unacceptable", "N/A"]
        let tab = UISegmentedControl(items: selections)
        tab.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        
        return tab
    }()
    
    //comment icon
    let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.bubble"), for: .normal)
        button.setImage(UIImage(systemName: "xmark"), for: .selected)
        button.tintColor = .systemOrange
        
        return button
        
    }()
    
    //textfield
    let commentTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10.0
        textField.layer.borderWidth = 1.0
        textField.isHidden = true
        
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(tab)
        tab.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        contentView.addSubview(button)
        button.addTarget(self, action: #selector(commentClicked), for: .touchUpInside)
        contentView.addSubview(commentTextField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //configure cell
    func configureCell(label: String) {
        textLabel?.text = label
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //customize tab
        tab.translatesAutoresizingMaskIntoConstraints = false
        tab.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        tab.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        //custom icon
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: tab.leftAnchor, constant: -10).isActive = true
        
        //customize textfield
        commentTextField.translatesAutoresizingMaskIntoConstraints = false
        commentTextField.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        commentTextField.topAnchor.constraint(equalTo: tab.bottomAnchor, constant: 10).isActive = true
        commentTextField.clipsToBounds = true
    }
    
    //comment button clicked
    @objc func commentClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        commentTextField.isHidden = !commentTextField.isHidden
        
    }
    
    //change color values for segment control
    @objc func segmentChanged(_ segment: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0:
            segment.selectedSegmentTintColor = .systemGreen
        case 1:
            segment.selectedSegmentTintColor = .systemRed
        default:
            segment.selectedSegmentTintColor = .systemGray
        }
    }
}

