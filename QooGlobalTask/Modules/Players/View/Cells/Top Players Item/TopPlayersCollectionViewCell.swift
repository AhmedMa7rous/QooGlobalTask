//
//  TopPlayersCollectionViewCell.swift
//  QooGlobalTask
//
//  Created by Ma7rous on 23/03/2023.
//

import UIKit

class TopPlayersCollectionViewCell: UICollectionViewCell {
    //MARK: - Outlet Connections
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    
/*=======================================*/
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUi()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
    }
/*=======================================*/
    //MARK: - Services Functions
    ///This function responsible for every thing related with UI
    func updateUi() {
        self.contentView.layer.cornerRadius = 18
        self.contentView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.15)
        self.contentView.layer.shadowRadius = 10
        self.contentView.layer.shadowOpacity = 2
        self.contentView.layer.shadowOffset = CGSize(width: 6, height: 6)
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        
        //self.contentView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    ///This function responsible for set the data to cell components
    func configure(player: Player) {
        let imageUrl = URL(string: player.photo)
        playerImageView.sd_setImage(with: imageUrl, completed: nil)
        playerNameLabel.text = player.name
        teamNameLabel.text = player.teamName
    }
    

}
