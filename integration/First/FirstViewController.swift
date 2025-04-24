//
//  ViewController.swift
//  integration
//
//  Created by Taras on 22.04.2025.
//

import UIKit
import WebKit
import FirebaseDatabase

class FirstViewController: FirstBaseViewController {
    
    private lazy var labelLoading: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        view.addSubview(labelLoading)
    }
    
    func setupConstraints() {
        labelLoading.translatesAutoresizingMaskIntoConstraints = false
        labelLoading.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        labelLoading.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    
    


}

