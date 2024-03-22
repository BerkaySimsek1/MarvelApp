//
//  ComicCell.swift
//  MarvelApp
//
//  Created by Berkay on 25.03.2024.
//

import UIKit
import Kingfisher
class SeriesCell: UICollectionViewCell{
    static let SeriesReuseID = "SeriesCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    private var comicImageView: UIImageView = {
       var image = UIImageView(frame: CGRect(x: 100, y: 100, width: 120, height: 120))
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.black.cgColor
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = image.frame.size.height / 2
        image.clipsToBounds = true
        return image
    }()
    
    private var comicNameLabel: UILabel = {
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
    
    func set(series: Series) {
        comicImageView.kf.setImage(with: URL(string: series.thumbnail.url))
        comicNameLabel.text = series.title
    }
    
    private func configure(){
        addSubview(comicImageView)
        addSubview(comicNameLabel)
        
        comicImageView.translatesAutoresizingMaskIntoConstraints = false
        comicNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            comicImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            comicImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            comicImageView.heightAnchor.constraint(equalToConstant: 160),
            comicImageView.widthAnchor.constraint(equalToConstant: 100),
            
            comicNameLabel.topAnchor.constraint(equalTo: comicImageView.bottomAnchor, constant: 12),
            comicNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            comicNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
