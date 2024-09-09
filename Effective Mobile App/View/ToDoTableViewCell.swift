//
//  ToDoTableViewCell.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 04.09.2024.
//

import UIKit

protocol CustomCellDelegate: AnyObject {
    func didTapButton(in cell: ToDoTableViewCell)
}


class ToDoTableViewCell: UITableViewCell {
    weak var delegate: CustomCellDelegate?

    
    lazy var taskNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .black)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var dueOrCompetedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    lazy var competedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var completeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
    //    button.setTitle("Нажми меня", for: .normal)
    //    button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
   //     button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button

    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = UIStackView.spacingUseSystem
//        stack.backgroundColor = UIColor.secondarySystemBackground
//        stack.isLayoutMarginsRelativeArrangement = true
//        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
//        stack.layer.cornerRadius = 20
//        stack.clipsToBounds = true
        return stack
    }()
    
    lazy var completeStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = UIStackView.spacingUseSystem
      //  stack.backgroundColor = UIColor.secondarySystemBackground
      //  stack.isLayoutMarginsRelativeArrangement = true
       // stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
      //  stack.layer.cornerRadius = 20
      //  stack.clipsToBounds = true
        return stack
    }()
    
    lazy var commonSteckView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.spacing = UIStackView.spacingUseSystem
        stack.backgroundColor = UIColor.secondarySystemBackground
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        stack.layer.cornerRadius = 20
        stack.clipsToBounds = true
        return stack
    }()
    
    
    @objc func buttonTapped(sender: UIButton) {
        delegate?.didTapButton(in: self)
        sender.isSelected.toggle()

        // Изменяем внешний вид кнопки в зависимости от состояния
        if sender.isSelected {
       //     sender.setTitle("Выбрано", for: .normal)
       //     sender.backgroundColor = .blue // Цвет фона для выбраной кнопки
       //    sender.setTitleColor(.white, for: .normal) // Цвет текста для выбраной кнопки
        } else {
        //    sender.setTitle("Нажми меня", for: .normal)
        //    sender.backgroundColor = .lightGray // Цвет фона для невыбранной кнопки
        //    sender.setTitleColor(.black, for: .normal) // Цвет текста для невыбранной кнопки
        }
    }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        selectionStyle = .none
        
        stackView.addArrangedSubview(taskNameLabel)
        stackView.addArrangedSubview(dueOrCompetedLabel)
        
       // completeStackView.addArrangedSubview(completeButton)
       // completeStackView.addArrangedSubview(competedLabel)
        
        commonSteckView.addArrangedSubview(stackView)
        commonSteckView.addArrangedSubview(completeButton)
        
        contentView.addSubview(commonSteckView)
        
//        [commonSteckView].forEach { subView in
//            contentView.addSubview(subView)
//        }
        
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            completeButton.widthAnchor.constraint(equalToConstant: 40),
            completeButton.heightAnchor.constraint(equalToConstant: 40),
            
         //   completeStackView.widthAnchor.constraint(equalToConstant: 50),

            
            commonSteckView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            commonSteckView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            commonSteckView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            commonSteckView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            
            
//            taskNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
//            taskNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            taskNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
    //        completeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
  //          completeButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 10),
  //          completeButton.leadingAnchor.constraint(equalTo: taskNameLabel.rightAnchor, constant: 10),
 
            
//            dueOrCompetedLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 16),
//            dueOrCompetedLabel.leadingAnchor.constraint(equalTo: taskNameLabel.leadingAnchor),
//            dueOrCompetedLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
//                completeStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
//                completeStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//                completeStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
         //   contentView.bottomAnchor.constraint(greaterThanOrEqualTo: taskNameLabel.bottomAnchor, constant: 8)
        ])
    }
    
    func configure(with task: TaskViewModel) {
        let attributedString = NSMutableAttributedString(string: task.name)

        if task.copmleted {
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                          value: NSUnderlineStyle.double.rawValue,
                                          range: NSMakeRange(0, attributedString.length))
            taskNameLabel.font = UIFont.italicSystemFont(ofSize: 16)
        } else {
            taskNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        }
        taskNameLabel.attributedText = attributedString
        
        dueOrCompetedLabel.text = task.copmleted ? "Completed on: \(task.copmletedOn.formatted(date: .abbreviated, time: .omitted))" : "Due on: \(task.dueOn.formatted(date: .abbreviated, time: .omitted))"
        
        competedLabel.text = task.copmleted ? "Completed" : "Not Completed"
        completeButton.backgroundColor = task.copmleted ? .systemGreen : .gray
        if task.copmleted {
            completeButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected) // Проверенный

        } else {
            completeButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal) // Непроверенный

        }

        competedLabel.textColor = task.copmleted ? .green : .red
    }
}

//extension UITableViewCell {
//    override open func layoutSubviews() {
//        super.layoutSubviews()
//        self.contentView.backgroundColor = .white
//        self.backgroundColor = .clear
//        self.layer.masksToBounds = false
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOpacity = 0.1
//        self.layer.shadowRadius = 3
//        self.layer.shadowOffset = CGSize(width: 0, height: 2)
//    }
//}
