//
//  GamesViewController.swift
//  La3ebAssesment
//
//  Created by Sharaf on 24/05/2023.
//

import UIKit

class GamesViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel:  GamesViewModel
    private var gamesResult = [GameModelResult]()
    private var currentPage = 1
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
        fetchData(currentPage: currentPage)
        title = "Games"
    }
    
    private func fetchData(currentPage:Int) {
        
        parameter = ["page_size":10,"page":currentPage]
        viewModel.getAPIData(param: parameter, completion: {[weak self] result, error in
            guard let error = error else {
                
                guard let games = result?.results else {return}
                self?.gamesResult += games
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
}

extension GamesViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gamesResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =  tableView.dequeueReusableCell(withIdentifier: "GameTableViewCell", for: indexPath) as?  GameTableViewCell {
            cell.configure(gamesResult[indexPath.row])
            return cell
        }else {
            return UITableViewCell()
        }
       
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard (scrollView.contentSize.height - scrollView.contentOffset.y) < scrollView.frame.size.height  else { return }
        if !viewModel.isLoading {
            currentPage += 1
            fetchData(currentPage: currentPage)
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            parameter = ["page_size":10,"page":currentPage]
        }else{
            parameter = ["page_size":10,"page":currentPage,"search":searchText]
        }
      
        viewModel.getAPIData(param: parameter, completion: {[weak self] result, error in
            guard let error = error else {
                
                guard let games = result?.results else {return}
                self?.gamesResult = []
                self?.gamesResult += games
                DispatchQueue.main.async {
                   self?.tableView.reloadData()
                }
                return
            }
            print("error\(error.localizedDescription)")
        })
    }
}
