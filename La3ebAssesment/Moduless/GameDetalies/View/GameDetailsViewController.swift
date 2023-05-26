//
//  GameDetailsViewController.swift
//  La3ebAssesment
//
//  Created by Sharaf on 25/05/2023.
//

import UIKit

class GameDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gameDescriptionValueLabel: UILabel!
    @IBOutlet weak var gameDescriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    
    
    var viewModel:GamesDetailsViewModel
    var didOpenBeforeDelegate:DidOpenGameDetail?
    var didFavoriteDelegate:DidFavorite?
    var gameDetail:GameDetailUIModel?
    var sites = [Sites]()
    var rightBarButton: UIBarButtonItem?
    init(viewModel:GamesDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getGameDetail()
        
    }
    
    private func setupUI() {
        rightBarButton  =  UIBarButtonItem(title: viewModel.isFavorite ? "Favorited": "Favorite", style: .plain, target: self, action: #selector(favorite))
        
        navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    @objc
    private func favorite() {
        addToFavorite()
        viewModel.isFavorite.toggle()
        rightBarButton =   UIBarButtonItem(title: viewModel.isFavorite ? "Favorited": "Favorite", style: .plain, target: self, action: #selector(favorite))
        navigationItem.rightBarButtonItem = rightBarButton
        
        didFavoriteDelegate?.didFavoriteGame(id: gameDetail?.id ?? 0, isFavorite: viewModel.isFavorite)

    }
    
    func addToFavorite() {
        if viewModel.isFavorite {
            Favorites.shared.removeFromFavorites(id: gameDetail?.id ?? 0, compeletion: nil)
        }else {
            Favorites.shared.favorites.append(gameDetail!)
        }
    }
    private func getGameDetail() {
        viewModel.getAPIData { [weak self] result, error in
            guard error != nil else {
                guard let gameDetail = result else {return}
                self?.gameDetail = gameDetail.toGameDetailUIModel
                self?.setData()
                return
            }
        }
    }
    
    private func setData() {
        didOpenBeforeDelegate?.didOpenGameDetail(id: gameDetail?.id ?? 0)
        
        DispatchQueue.main.async {
            self.gameImageView.loadImageUsingCache(withUrl: self.gameDetail?.backgroundImage ?? "")
            self.titleLabel.text = self.gameDetail?.name
            self.gameDescriptionValueLabel.text = self.gameDetail?.description
            self.getTableViewData()
            self.setupUI()

        }
        
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "GameDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "GameDetailTableViewCell")
    }
    private func openSafari(url:String) {
        
        guard  let url = URL(string: url) else {return}
        UIApplication.shared.open(url)
        
    }
    
    
    private func getTableViewData() {
        sites = [Sites(name: "Visit reddit", link: gameDetail?.redditURL ?? ""),Sites(name: "Visit WebSite", link: gameDetail?.website ?? "")]
        tableView.reloadData()
    }
    
    
}

extension GameDetailsViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameDetailTableViewCell", for: indexPath) as! GameDetailTableViewCell
        
        cell.configure(sites[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openSafari(url:sites[indexPath.row].link )
    }
    
}

protocol DidOpenGameDetail {
    func didOpenGameDetail(id:Int)
}

protocol DidFavorite{
    func didFavoriteGame(id:Int,isFavorite:Bool)
}


extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
