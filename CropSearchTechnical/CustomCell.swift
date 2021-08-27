//
//  CustomCell.swift
//  CropSearchTechnical
//
//  Created by Gage Fonk on 8/26/21.
//

import UIKit

class CustomCell: UITableViewCell {
    static let reuseIdentifier = "customCell"
    var isExpanded: Bool = false
    var updateCell: (() -> Void)?
    lazy var commentFieldHeightAnchor = commentTextField.heightAnchor.constraint(equalToConstant: 0)
    lazy var commentLabelHeightAnchor = commentLabel.heightAnchor.constraint(equalToConstant: 0)
    
    //create main label
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
    //create comment label
    let commentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
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
        
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(mainLabel)
        contentView.addSubview(commentLabel)
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
        mainLabel.text = label
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //customize label
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        mainLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        
        //customize comment label
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commentLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            commentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            commentLabel.topAnchor.constraint(equalTo: tab.bottomAnchor, constant: -10),
            commentLabelHeightAnchor
        ])
        
        //customize tab
        tab.translatesAutoresizingMaskIntoConstraints = false
        tab.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        tab.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        
        //custom icon
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerYAnchor.constraint(equalTo: tab.centerYAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: tab.leftAnchor, constant: -10).isActive = true
        
        //customize textfield
        commentTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commentTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.95),
            commentTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            commentTextField.topAnchor.constraint(equalTo: tab.bottomAnchor, constant: 10),
            commentTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            commentFieldHeightAnchor
        ])
    }
    
    //comment button clicked
    @objc func commentClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        isExpanded = !isExpanded
        let newHeight: CGFloat = isExpanded ? 34 : 0
        commentFieldHeightAnchor.constant = newHeight
        updateCell?()
        
        
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

