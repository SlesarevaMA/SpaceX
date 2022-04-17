//
//  LaunchCell.swift
//  SpaceX
//
//  Created by Margarita Slesareva on 17.04.2022.
//

import UIKit

final class LaunchCell: UITableViewCell {
    
    private let maskingView = UIView()
    private let nameLabel = UILabel()
    private let datelabel = UILabel()
    private let stateImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel.font = .systemFont(ofSize: 20, weight: .regular)
        datelabel.font = .systemFont(ofSize: 16, weight: .regular)
        datelabel.textColor = UIColor(hex: 0x8E8E8F)
        
        backgroundColor = .black
        maskingView.backgroundColor = UIColor(hex: 0x212121)
        maskingView.layer.cornerRadius = 24
        
        contentView.addSubview(maskingView)
        
        maskingView.addSubview(nameLabel)
        maskingView.addSubview(datelabel)
        maskingView.addSubview(stateImageView)
        
        maskingView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        datelabel.translatesAutoresizingMaskIntoConstraints = false
        stateImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            maskingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            maskingView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            maskingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            maskingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            nameLabel.leadingAnchor.constraint(equalTo: maskingView.leadingAnchor, constant: 24),
            nameLabel.topAnchor.constraint(equalTo: maskingView.topAnchor, constant: 24),
            
            datelabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            datelabel.leadingAnchor.constraint(equalTo: maskingView.leadingAnchor, constant: 24),
            datelabel.bottomAnchor.constraint(equalTo: maskingView.bottomAnchor, constant: -24),
            
            stateImageView.centerYAnchor.constraint(equalTo: maskingView.centerYAnchor),
            stateImageView.trailingAnchor.constraint(equalTo: maskingView.trailingAnchor, constant: 24)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: LaunchViewModel) {
        nameLabel.text = viewModel.name
        datelabel.text = viewModel.date
        stateImageView.image = viewModel.launchImage
    }
    
}
