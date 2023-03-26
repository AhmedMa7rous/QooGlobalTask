//
//  AllPlayersTableViewCell.swift
//  QooGlobalTask
//
//  Created by Ma7rous on 23/03/2023.
//

import UIKit
import SDWebImage

class AllPlayersTableViewCell: UITableViewCell {
    
    //MARK: - Outlet Connections
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var ratingSatckView: UIStackView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var positionNameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
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
        playerImageView.layer.cornerRadius = 8
        ratingSatckView.layer.cornerRadius = 8
    }
    ///This function responsible for set the data to cell components
    func configure(player: Player) {
        let imageUrl = URL(string: player.photo)
        playerImageView.sd_setImage(with: imageUrl, completed: nil)
        playerNameLabel.text = player.name
        teamNameLabel.text = player.teamName
        positionNameLabel.text = player.positionName.rawValue
        rateLabel.text = player.rating
    }
    
}
