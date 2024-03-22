//
//  HeroCell.swift
//  MarvelApp
//
//  Created by Berkay on 22.03.2024.
//

import UIKit
import Kingfisher
class HeroCell: UITableViewCell{
    static let HeroCellReuseID = "HeroCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(
            red: CGFloat(18) / 255.0,
            green: CGFloat(64) / 255.0,
            blue: CGFloat(118) / 255.0,
            alpha: 1.0
        )
        configure()
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell(){
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.black.cgColor
    }
    
    private var heroImageView: UIImageView = {
       var image = UIImageView(frame: CGRect(x: 100, y: 100, width: 120, height: 120))
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.black.cgColor
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = image.frame.size.height / 2
        image.clipsToBounds = true
        return image
    }()
    
    private var heroNameLabel: UILabel = {
        var label = UILabel()
        label.text = "Iron Man"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.numberOfLines = 2
        label.textColor = UIColor(
            red: CGFloat(223) / 255.0,
            green: CGFloat(245) / 255.0,
            blue: CGFloat(255) / 255.0,
            alpha: 1.0
        )
        return label
    }()
    
    func set(heroes: Hero) {
        heroImageView.kf.setImage(with: URL(string: heroes.thumbnail.url))
        heroNameLabel.text = heroes.name
    }
    
    private func configure(){
        addSubview(heroImageView)
        addSubview(heroNameLabel)
        
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        heroNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heroImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            heroImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            heroImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            heroImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            heroImageView.heightAnchor.constraint(equalToConstant: 120),
            heroImageView.widthAnchor.constraint(equalToConstant: 120),
            
            heroNameLabel.centerYAnchor.constraint(equalTo: heroImageView.centerYAnchor),
            heroNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            heroNameLabel.leadingAnchor.constraint(equalTo: heroImageView.trailingAnchor, constant: 14)
        ])
    }
}
