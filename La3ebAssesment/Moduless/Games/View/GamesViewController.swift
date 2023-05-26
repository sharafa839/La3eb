//
//  GamesViewController.swift
//  La3ebAssesment
//
//  Created by Sharaf on 24/05/2023.
//


import UIKit

class GamesViewController: UIViewController, DidOpenGameDetail, DidFavorite {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel:  GamesViewModel
    private var gamesResult = [GameDetailUIModel]()
    private var currentPage = 1
    private var searchText:String?
    var parameter :[String:Any] = [:]
    
    
    init(viewModel:GamesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
        fetchData(currentPage: currentPage, search: nil)
        title = "Games"
    }
    
    
    private func fetchData(currentPage:Int,search:String?) {
        parameter = search?.isEmpty ?? false ? search == "" ?  ["page_size":10,"page":currentPage,"search":search!] : ["page_size":10,"page":currentPage] :  ["page_size":10,"page":currentPage]
        
        viewModel.getAPIData(param: parameter, completion: {[weak self] result, error in
            guard let error = error else {
                
                guard let games = result?.results else {return}
                let gameUIModel =  games.map ({$0.toGameUIModel})
                self?.gamesResult += gameUIModel
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                return
            }
            print("error\(error.localizedDescription)")
        })
    }
    
    
    private func setupTableView() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName:"GameTableViewCell", bundle: nil), forCellReuseIdentifier: "GameTableViewCell")
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search for the games"
    }
    
    func didOpenGameDetail(id: Int) {
        guard let index = gamesResult.firstIndex(where: {$0.id == id}) else {return}
        gamesResult[index].openBefore = true
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func didFavoriteGame(id: Int,isFavorite:Bool) {
        guard let index = gamesResult.firstIndex(where: {$0.id == id}) else {return}
        gamesResult[index].favourite = isFavorite
    }
}

extension GamesViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  gamesResult.count == 0 {
            tableView.setMessage("No game has been searched.")
        }else {
            tableView.clearBackground()
        }
        return gamesResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =  tableView.dequeueReusableCell(withIdentifier: "GameTableViewCell", for: indexPath) as?  GameTableViewCell {
            if gamesResult.count > indexPath.row {
                cell.configure(gamesResult[indexPath.row])
                return cell
            }else{
                return UITableViewCell()
            }
            
        }else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = gamesResult[indexPath.row].id
        let gameDetailsViewModel = GamesDetailsViewModel(gameId: id, isFavorite: gamesResult[indexPath.row].favourite )
        let gameDetailsViewController = GameDetailsViewController(viewModel: gameDetailsViewModel)
        gameDetailsViewController.didOpenBeforeDelegate = self
        gameDetailsViewController.didFavoriteDelegate = self
        navigationController?.pushViewController(gameDetailsViewController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard (scrollView.contentSize.height - scrollView.contentOffset.y) < scrollView.frame.size.height  else { return }
        if !viewModel.isLoading {
            currentPage += 1
            fetchData(currentPage: currentPage, search: searchText)
        }
        
    }
 
}

extension GamesViewController:UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        gamesResult = []
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        fetchData(currentPage: 1, search: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard searchText.count > 3 else {return}
        self.searchText = searchText
        fetchData(currentPage: currentPage, search: searchText)
    }
}
