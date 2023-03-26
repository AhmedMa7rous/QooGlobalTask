//
//  PlayerDetailsViewController.swift
//  QooGlobalTask
//
//  Created by Ma7rous on 23/03/2023.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class PlayerDetailsViewController: UIViewController {
    
/*========================================================*/
    //MARK: - Outlet Connections

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerPositionLabel: UILabel!
    @IBOutlet weak var playerPhotoImageView: UIImageView!
    @IBOutlet weak var playerAgeLabel: UILabel!
    @IBOutlet weak var playerMarketPriceLabel: UILabel!
    @IBOutlet weak var playerNumberLabel: UILabel!
    @IBOutlet weak var playerRatingLabel: UILabel!
    @IBOutlet weak var teamLogoImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var playerInfoButton: UIButton!
    @IBOutlet weak var playerStatisticsButton: UIButton!
    @IBOutlet weak var playerEventsButton: UIButton!
    @IBOutlet weak var playerMediaButton: UIButton!
    @IBOutlet var allButtons: [UIButton]!
    @IBOutlet weak var playerDetailsTableView: UITableView!
    /*========================================================*/
    //MARK: - Properties
    private var viewModel: PlayerDetailsViewModel
/*========================================================*/
    //MARK: - LifeCycle
    
    init(player: Player) {
        self.viewModel = PlayerDetailsViewModel(with: player.slug)
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUi()
        viewModel.fetchData()
        bindTableView()
    }
/*=========================================================*/
    //MARK: - Action Connections
    
    @IBAction func playerInfoButtonTapped(_ sender: UIButton) {
        changeTappedButtonsUi(button: sender)
    }
    @IBAction func playerStatisticsButtonTapped(_ sender: UIButton) {
        changeTappedButtonsUi(button: sender)
    }
    @IBAction func playerEventsButtonTapped(_ sender: UIButton) {
        changeTappedButtonsUi(button: sender)
    }
    @IBAction func playerMediaButtonTapped(_ sender: UIButton) {
        changeTappedButtonsUi(button: sender)
    }
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
/*=========================================================*/
    //MARK: - Outside Services Functions
    
    func configureNavigationItems() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "back"),
            style: .done,
            target: self,
            action: #selector(back))
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                image: UIImage(named: "home"),
                style: .done,
                target: self,
                action: nil),
            UIBarButtonItem(
                image: UIImage(named: "settings"),
                style: .done,
                target: self,
                action: nil)
        ]
    }
    
/*=========================================================*/
    //MARK: - Inside Services Functions
    
    ///This function responsible for every thing related with UI
    private func updateUi() {
        setUpNavigationBar()
        setupTableView()
        setUpComponents(item: playerPhotoImageView, cornerRadius: 25, shadowRadius: 15, offSet: 6, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25), isButton: false)
        setUpComponents(item: playerInfoButton, cornerRadius: 8, shadowRadius: 10, offSet: 2, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.15), isButton: true)
        setUpComponents(item: playerStatisticsButton, cornerRadius: 8, shadowRadius: 10, offSet: 2, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.15), isButton: true)
        setUpComponents(item: playerEventsButton, cornerRadius: 8, shadowRadius: 10, offSet: 2, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.15), isButton: true)
        setUpComponents(item: playerMediaButton, cornerRadius: 8, shadowRadius: 10, offSet: 2, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.15), isButton: false)
    }
    ///This is a support function (support updateUi function) to set up navigation bar UI
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy cose not a clean one
    private func setUpNavigationBar() {
        navigationItem.titleView = searchBar
        searchBar.placeholder = " Search here"
        searchBar.searchTextField.tintColor = #colorLiteral(red: 0.9474149346, green: 0.2494795024, blue: 0.3013353646, alpha: 1)
        searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9803921569, blue: 0.9764705882, alpha: 1)
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9474149346, green: 0.2494795024, blue: 0.3013353646, alpha: 1)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9725490196, green: 0.9803921569, blue: 0.9764705882, alpha: 1)
    }
    
    ///This is a support function (support updateUi function) to set up components like buttons, labels and etc UI.
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy cose not a clean one
    private func setUpComponents(item: UIView, cornerRadius: CGFloat, shadowRadius: CGFloat, offSet: Int, shadowColor: CGColor, isButton: Bool) {
        item.layer.cornerRadius = cornerRadius
        item.layer.shadowOpacity = 2
        item.layer.shadowRadius = shadowRadius
        item.layer.shadowColor = shadowColor
        item.layer.borderWidth = 0.5
        item.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        item.layer.shadowOffset = CGSize(width: offSet, height: offSet)
        item.layer.masksToBounds = true
        
    }

    ///This Function used when tapped a button it changes it's UI
    private func changeTappedButtonsUi(button: UIButton) {
        for item in allButtons {
            if item == button {
                button.backgroundColor = #colorLiteral(red: 0.9474149346, green: 0.2494795024, blue: 0.3013353646, alpha: 1)
                button.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            } else {
                item.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                item.tintColor = #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
                item.setTitleColor(#colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1), for: .normal)
            }
        }
    }
    
    ///This is a support function (support updateUi function) to register a cell for TableView UI
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy cose not a clean one
    private func setupTableView() {
        
        //Register PlayersCell
        playerDetailsTableView.register(PlayerDetailsTableViewCell.nib, forCellReuseIdentifier: PlayerDetailsTableViewCell.identifier)
    }
    
    ///This function resposible for binding the data to UI Component
    private func bindData(for player: Player) {
        let imageUrl = URL(string: player.photo)
        playerPhotoImageView.sd_setImage(with: imageUrl, completed: nil)
        playerNameLabel.text = player.name
        playerPositionLabel.text = player.positionName.rawValue
        teamNameLabel.text = player.teamName
        teamLogoImageView.sd_setImage(with: URL(string: player.teamLogo), completed: nil)
        
        
    }
}
/*=================================================*/
extension PlayerDetailsViewController: UITableViewDelegate {
    
   //MARK: - PlayerDetailsTableView Functions
    func bindTableView() {
        playerDetailsTableView.rx.setDelegate(self).disposed(by: viewModel.disposeBag)
        viewModel.playerDetails.bind(to: playerDetailsTableView.rx.items(cellIdentifier: PlayerDetailsTableViewCell.identifier, cellType: PlayerDetailsTableViewCell.self)) { (row, item, cell) in
            cell.configure(playerDetails: item, inRow: row)
        } .disposed(by: viewModel.disposeBag)
    
//        playerDetailsTableView.rx.modelSelected(Player.self).subscribe { [weak self] player in
//            guard let self = self else { return }
//            guard let player = player.element else { return }
//            let vc = PlayerDetailsViewController(player: player)
//            vc.configureNavigationItems()
//            self.navigationController?.pushViewController(vc, animated: true)
//        }.disposed(by: viewModel.disposeBag)
    }
    
}
