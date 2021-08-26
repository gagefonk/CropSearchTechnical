//
//  ViewController.swift
//  CropSearchTechnical
//
//  Created by Gage Fonk on 8/25/21.
//

import UIKit

class ViewController: UIViewController {
    
    var areasOfObservations = ["Surrounding Areas / Adjacent Activities", "Building Grounds", "Building Structure", "Water System", "Other"]
    var listComplete: Bool = false
    let user = "Gage Fonk"
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.reuseIdentifier)
        tableView.separatorColor = .none
        tableView.sectionHeaderHeight = 50
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    let footerView: UIStackView = {
        let saveButton: UIButton = {
            let button = UIButton()
//            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Save Changes", for: .normal)
            button.setTitleColor(.systemOrange, for: .normal)
            button.addTarget(self, action: #selector(checkCompletion), for: .touchUpInside)
            return button
        }()
        let submitButton: UIButton = {
            let button = UIButton()
//            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Final Submit", for: .normal)
            button.setTitleColor(.systemOrange, for: .normal)
            return button
        }()
        let footerView = UIStackView(arrangedSubviews: [saveButton, submitButton])
        footerView.backgroundColor = .systemFill
        footerView.axis = .horizontal
        footerView.distribution = .fillEqually
        footerView.spacing = 5
        
        return footerView
    }()
    
    let largeTitle: UILabel = {
        let label = UILabel()
        label.text = "Cooler Facility Risk Assessment"
        label.font = .boldSystemFont(ofSize: 25)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //add views
        view.addSubview(largeTitle)
        view.addSubview(footerView)
        view.addSubview(tableView)
        
        //add delegate/datasource
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //layout title
        largeTitle.translatesAutoresizingMaskIntoConstraints = false
        largeTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        largeTitle.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        largeTitle.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        
        //layout footer
        footerView.translatesAutoresizingMaskIntoConstraints = false
        footerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        footerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        footerView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        //layout tableview
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: largeTitle.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -48).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
    
    //check if list is complete
    @objc func checkCompletion() {
        listComplete = true
        tableView.reloadData()
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areasOfObservations.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.reuseIdentifier, for: indexPath) as? CustomCell else { return UITableViewCell()}
        
        cell.configureCell(label: areasOfObservations[indexPath.row])
        cell.backgroundColor = (indexPath.row % 2 == 0) ? .systemBackground : .systemGray3
        cell.button.addAction(UIAction(handler: { UIAction in
            tableView.reloadData()
        }), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if listComplete {
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .none)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let width = tableView.bounds.size.width
        let height = tableView.bounds.size.height
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        headerView.backgroundColor = listComplete ? .systemGreen : .systemGray
        
        let label = UILabel()
        label.text = "Areas of observation - please note concerns(s) if any, as well as corrective actions(s)"
        label.textColor = .white
        
        headerView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 20).isActive = true
        label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true

        return headerView
    }
    
    
}
