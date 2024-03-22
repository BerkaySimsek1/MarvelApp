import UIKit

class MainPageVC: UIViewController {
    
    var tableView = UITableView()
    var heroes: [Hero] = []
    var isLoading = false
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        getHeroes()
    }
    
    func configureCollectionView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 140
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(
            red: CGFloat(18) / 255.0,
            green: CGFloat(64) / 255.0,
            blue: CGFloat(118) / 255.0,
            alpha: 1.0
        )
        
        tableView.register(HeroCell.self, forCellReuseIdentifier: HeroCell.HeroCellReuseID)
        
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    func getHeroes(name: String? = nil, page: Int = 0) {
        isLoading = true
        activityIndicator.startAnimating() // Start animating
        MarvelAPI.loadHeroes(name: name, page: page) { result in
            if let result = result {
                self.heroes.append(contentsOf: result.data.results)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating() // Stop animating
                    self.isLoading = false
                }
            }
        }
    }
}

extension MainPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeroCell.HeroCellReuseID) as! HeroCell
        let hero = heroes[indexPath.row]
        cell.set(heroes: hero)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height * 2 && !isLoading {
            getHeroes(name: nil, page: heroes.count / MarvelAPI.limit + 1)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let hero = heroes[indexPath.row]
        let destVC = HeroDetailVC(comicID: hero.id)
        destVC.set(hero: hero)
        self.navigationController?.pushViewController(destVC, animated: true)
    }
}
