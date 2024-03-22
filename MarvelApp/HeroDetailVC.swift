//
//  HeroDetailVC.swift
//  MarvelApp
//
//  Created by Berkay on 23.03.2024.
//

import UIKit
import Kingfisher

class HeroDetailVC: UIViewController, UIScrollViewDelegate {

    var comics: [Comic] = []
    var series: [Series] = []
    var comicCollectionView: UICollectionView!
    var seriesCollectionView: UICollectionView!
    var comicID: Int!
    
    init(comicID: Int) {
            self.comicID = comicID
            super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(
            red: CGFloat(18) / 255.0,
            green: CGFloat(64) / 255.0,
            blue: CGFloat(118) / 255.0,
            alpha: 1.0
        )
        view.addSubview(scrollView)
        configureCollectionView()
        getComics(id: comicID)
        getSeries(id: comicID)
        configure()
        
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 1000)
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 250)
        layout.scrollDirection = .horizontal
        
        // Comic CollectionView
        comicCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 250), collectionViewLayout: layout)
        comicCollectionView.dataSource = self
        comicCollectionView.delegate = self
        comicCollectionView.register(ComicCell.self, forCellWithReuseIdentifier: ComicCell.ComicReuseID)
        scrollView.addSubview(comicCollectionView)
        
        // Series CollectionView
        let seriesLayout = UICollectionViewFlowLayout()
        seriesLayout.itemSize = CGSize(width: 200, height: 250)
        seriesLayout.scrollDirection = .horizontal
        seriesCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 250), collectionViewLayout: seriesLayout)
        seriesCollectionView.dataSource = self
        seriesCollectionView.delegate = self
        seriesCollectionView.register(SeriesCell.self, forCellWithReuseIdentifier: SeriesCell.SeriesReuseID)
        scrollView.addSubview(seriesCollectionView)
        
        // Scrollview içeriği güncelleniyor
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 1000)
    }

    
    func getComics(id: Int, page: Int = 0) {
        MarvelAPI.loadComicsbyID(id: id) { result in
            if let result = result {
                self.comics.append(contentsOf: result.data.results)
                DispatchQueue.main.async {
                    self.comicCollectionView.reloadData()
                }
            }
        }
    }
    
    func getSeries(id: Int, page: Int = 0) {

        MarvelAPI.loadSeriesbyID(id: id) { results in
            if let results = results {
                self.series.append(contentsOf: results.data.results)
                DispatchQueue.main.async {
                    self.seriesCollectionView.reloadData()
                }
            }
        }
    }
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.delegate = self
        // contentSize boyutunu belirle
        return scroll
    }()

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
                let layout = view.safeAreaLayoutGuide
                scrollView.centerXAnchor.constraint(equalTo: layout.centerXAnchor).isActive = true
                scrollView.centerYAnchor.constraint(equalTo: layout.centerYAnchor).isActive = true
                scrollView.widthAnchor.constraint(equalTo: layout.widthAnchor).isActive = true
                scrollView.heightAnchor.constraint(equalTo: layout.heightAnchor).isActive = true
    }


    private var heroImage: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = .red
        return image
    }()
    
    private var heroName: UILabel = {
        var label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textColor = UIColor(
            red: CGFloat(223) / 255.0,
            green: CGFloat(245) / 255.0,
            blue: CGFloat(255) / 255.0,
            alpha: 1.0
        )
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = UIColor(
            red: CGFloat(223) / 255.0,
            green: CGFloat(245) / 255.0,
            blue: CGFloat(255) / 255.0,
            alpha: 1.0
        )
        return label
    }()
    
    
    private var comicLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.text = "Comics"
        label.textColor = UIColor(
            red: CGFloat(223) / 255.0,
            green: CGFloat(245) / 255.0,
            blue: CGFloat(255) / 255.0,
            alpha: 1.0
        )
        return label
    }()
    
    
    private var seriesLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.text = "Series"
        label.textColor = UIColor(
            red: CGFloat(223) / 255.0,
            green: CGFloat(245) / 255.0,
            blue: CGFloat(255) / 255.0,
            alpha: 1.0
        )
        return label
    }()
    
    
    
    private func configure() {
        scrollView.addSubview(heroImage)
        scrollView.addSubview(heroName)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(comicLabel)
        scrollView.addSubview(seriesLabel)

        
        heroImage.translatesAutoresizingMaskIntoConstraints = false
        heroName.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        comicLabel.translatesAutoresizingMaskIntoConstraints = false
        seriesLabel.translatesAutoresizingMaskIntoConstraints = false
        comicCollectionView.translatesAutoresizingMaskIntoConstraints = false
        seriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heroImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
            heroImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            heroImage.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            heroImage.widthAnchor.constraint(equalToConstant: view.bounds.width),
            heroImage.heightAnchor.constraint(equalToConstant: view.bounds.height / 3.33),
            
            heroName.topAnchor.constraint(equalTo: heroImage.bottomAnchor, constant: 12),
            heroName.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: heroName.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            comicLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            comicLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            
            comicCollectionView.topAnchor.constraint(equalTo: comicLabel.bottomAnchor, constant: 8),
            comicCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            comicCollectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            comicCollectionView.heightAnchor.constraint(equalToConstant: 300),
                
            seriesLabel.topAnchor.constraint(equalTo: comicCollectionView.bottomAnchor, constant: 12),
            seriesLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                    
            seriesCollectionView.topAnchor.constraint(equalTo: seriesLabel.bottomAnchor, constant: 8),
            seriesCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            seriesCollectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            seriesCollectionView.heightAnchor.constraint(equalToConstant: 300),
            
            // ScrollView'ın içeriğinin alt kısmını belirtmek için en alt constraint ekleyin
            seriesCollectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20) // Örnek bir değer
        ])
    }
    
    func set(hero: Hero) {
        heroImage.kf.setImage(with: URL(string: hero.thumbnail.url))
        heroName.text = hero.name
        descriptionLabel.text = hero.description
    }
}

extension HeroDetailVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == comicCollectionView {
            print(comics.count)
            return comics.count
        }else{
            return series.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == comicCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCell.ComicReuseID, for: indexPath) as! ComicCell
            let comic = comics[indexPath.row]
            cell.set(comics: comic)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeriesCell.SeriesReuseID, for: indexPath) as! SeriesCell
            let serie = series[indexPath.row]
            cell.set(series: serie)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 250)
    }
    
}
