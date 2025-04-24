//
//  SecondViewController.swift
//  integration
//
//  Created by Taras on 23.04.2025.
//

import UIKit

class SecondViewController: UIViewController {
    
    private lazy var labelLoading: UILabel = {
        let label = UILabel()
        label.text = "Second View Controller"
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
