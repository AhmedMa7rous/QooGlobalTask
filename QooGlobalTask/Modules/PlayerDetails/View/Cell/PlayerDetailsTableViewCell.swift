//
//  PlayerDetailsTableViewCell.swift
//  QooGlobalTask
//
//  Created by Ma7rous on 27/03/2023.
//

import UIKit

class PlayerDetailsTableViewCell: UITableViewCell {
    //MARK: - Outlet Connections
    
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
    }
    
    
/*=======================================*/
    //MARK: - Services Functions
    ///This function responsible for set the data to components
    func configure(key: String, value: String) {
        if key == "" {
            keyLabel.text = ""
            valueLabel.text = value
        } else {
            keyLabel.text = key + ":"
            valueLabel.text = value
        }
    }
    
    ///This function responsible for every thing related with UI
    func updateUi() {
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        self.layer.masksToBounds = true
        
    }
}
