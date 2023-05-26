//
//  GameTableViewCell.swift
//  La3ebAssesment
//
//  Created by Sharaf on 23/05/2023.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var metricsValueLabel: UILabel!
    @IBOutlet weak var metricsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ with:GameDetailUIModel) {
        gameImageView.loadImageUsingCache(withUrl: with.backgroundImage )
      //  categoryLabel.text = getGeners(with.genres ?? []).joined(separator: ",")
        titleLabel.text = with.name
        metricsLabel.text = "metrics"
        metricsValueLabel.text = "\(with.reviewsCount )"
        self.backgroundColor =  with.openBefore ? .opendCellColor : .white
    }
    
    func getGeners(_ with:[Genre]) -> [String]{
        return with.map { genre in
            genre.name ?? ""
        }
    }
    
    
}

extension UIColor {
    static var opendCellColor:UIColor {
        return UIColor(named: "opendCellColor")!
    }
}
let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        if url == nil {return}
        self.image = nil

        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }

        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .gray)
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.center

        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                    activityIndicator.removeFromSuperview()
                }
            }

        }).resume()
    }
}
