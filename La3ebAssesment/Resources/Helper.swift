//
//  Helper.swift
//  La3ebAssesment
//
//  Created by Sharaf on 26/05/2023.
//

import Foundation
import UIKit
extension UITableView {

    func setMessage(_ message: String) {
        let lblMessage = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        lblMessage.text = message
        lblMessage.textColor = .black
        lblMessage.numberOfLines = 0
        lblMessage.textAlignment = .center
        lblMessage.font = UIFont(name: "SFProDisplayBold", size: 15)
        lblMessage.sizeToFit()
        self.backgroundView = lblMessage
        backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        self.separatorStyle = .none
    }

    func clearBackground() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
