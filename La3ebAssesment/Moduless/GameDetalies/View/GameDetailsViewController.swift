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
    
    init(viewModel:GamesDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func getData(id:String) {
        let param = ["":id,]
        
//        viewModel.getAPIData(param: param) { <#GameModel?#>, <#ServiceError?#> in
//            <#code#>
//        }
 
    }

}
