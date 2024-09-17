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
    
    lazy var completeButton: UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button

    }()
    
    lazy var stackView: UIStackView = {
        
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = UIStackView.spacingUseSystem
        return stack
    }()
    
    lazy var completeStackView: UIStackView = {
        
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = UIStackView.spacingUseSystem
        return stack
    }()
    
    lazy var commonSteckView: UIStackView = {
        
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.spacing = UIStackView.spacingUseSystem
        stack.backgroundColor = .cell
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        stack.layer.cornerRadius = 20
        stack.clipsToBounds = true
        return stack
    }()
    
    
    @objc func buttonTapped(sender: UIButton) {
        delegate?.didTapButton(in: self)
        sender.isSelected.toggle()
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
        
        commonSteckView.addArrangedSubview(stackView)
        commonSteckView.addArrangedSubview(completeButton)
        
        contentView.addSubview(commonSteckView)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            completeButton.widthAnchor.constraint(equalToConstant: 40),
            completeButton.heightAnchor.constraint(equalToConstant: 40),
            
            commonSteckView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            commonSteckView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            commonSteckView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            commonSteckView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    func configure(with task: TaskEntityDTO) {
        
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
        
        dueOrCompetedLabel.text = task.copmleted ?
                                            "Completed on: \(task.copmletedOn.formatted(date: .numeric, time: .shortened))" :
                                            "Due on: \(task.dueOn.formatted(date: .numeric, time: .shortened))"
        //formatted(date: .abbreviated, time: .omitted))"
        
        completeButton.backgroundColor = task.copmleted ? .systemGreen : .gray
        if task.copmleted {
            completeButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)

        } else {
            completeButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)

        }
    }
}
