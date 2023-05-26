//
//  FavoritesViewController.swift
//  La3ebAssesment
//
//  Created by Sharaf on 25/05/2023.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
     
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    
        title = "Favorites"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
    
    

    private func setupTableView() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName:"GameTableViewCell", bundle: nil), forCellReuseIdentifier: "GameTableViewCell")
    }

  
}

extension FavoritesViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  Favorites.shared.favorites.count == 0 {
            tableView.setMessage("There is no favourites found.")
        }else {
            tableView.clearBackground()
        }
        
        return Favorites.shared.favorites.count
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =  tableView.dequeueReusableCell(withIdentifier: "GameTableViewCell", for: indexPath) as?  GameTableViewCell {
            cell.configure(Favorites.shared.favorites[indexPath.row])
            
            return cell
        }else {
            return UITableViewCell()
        }
       
    }
    

     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
         let alert =    UIAlertController(title: "are you sure ?", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "yes", style: .default,handler: { _ in
                Favorites.shared.removeFromFavorites(id: Favorites.shared.favorites[indexPath.row].id , compeletion: nil)
                tableView.reloadData()
              
            }))
            
            alert.addAction(UIAlertAction(title: "cancel", style: .destructive,handler: { _ in
                self.dismiss(animated: true)
            }))
            present(alert, animated: true)
        }
    }
    
    
}
