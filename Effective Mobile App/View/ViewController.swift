//
//  ViewController.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 31.08.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .yellow
        title = "ToDo"
        view.addSubview(lable)
        addConstraints()
    }
    
    lazy var lable: UILabel = {
        let lab = UILabel()
        lab.text = "hhhhasdasdasdasdasdasd"
        lab.textAlignment = .center
        lab.backgroundColor = .green
        lab.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        return lab
    }()
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            lable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 11),
            lable.topAnchor.constraint(equalTo: view.topAnchor, constant: -11),
            lable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 11)
        ])
    }


}

