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
    
    private var gameViewModel =  GamesViewModel()
    private var gamesResult = [GameModelResult]()
    private var currentPage = 1
    var parameter :[String:Any] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
        fetchData(currentPage: currentPage)
        title = "Games"
    }
    
    private func fetchData(currentPage:Int) {
        
        parameter = ["page_size":10,"page":currentPage]
        gameViewModel.getAPIData(param: parameter, completion: {[weak self] result, error in
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName:"GameTableViewCell", bundle: nil), forCellReuseIdentifier: "GameTableViewCell")
    }

    private func setupSearchBar() {
        searchBar.delegate = self
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
      
        gameViewModel.getAPIData(param: parameter, completion: {[weak self] result, error in
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
