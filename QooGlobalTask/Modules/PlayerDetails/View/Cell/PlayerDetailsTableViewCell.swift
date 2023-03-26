//
//  PlayerDetailsTableViewCell.swift
//  QooGlobalTask
//
//  Created by Ma7rous on 25/03/2023.
//

import UIKit

class PlayerDetailsTableViewCell: UITableViewCell {
    
    //MARK: - Outlet Connections
    
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var isDone = true
/*=======================================*/
    //MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUi()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
    }
    
/*=======================================*/
    //MARK: - Services Functions
    ///This function responsible for every thing related with UI
    func updateUi() {
        self.contentView.layer.cornerRadius = 8
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.15)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 2
    }
    ///This function responsible for set the data to cell components
    func configure(playerDetails: Info, inRow row: Int) {
        if isDone {
            aboutLabel.text = playerDetails.about
            keyLabel.text = playerDetails.indicators[row].key
            valueLabel.text = playerDetails.indicators[row].value
            isDone = false
        } else {
            aboutLabel.text = ""
            keyLabel.text = playerDetails.indicators[row].key
            valueLabel.text = playerDetails.indicators[row].value
        }
        
        
    }
    
}
