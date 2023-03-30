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
    @IBOutlet weak var playerStackView: UIStackView!
    @IBOutlet weak var playerDetailsTableView: UITableView!
    @IBOutlet weak var teamStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak private var viewMessage: UIView!
    @IBOutlet weak private var lblMessage: UILabel!
    @IBOutlet weak private var imgMeessage: UIImageView!
    
/*========================================================*/
    //MARK: - Properties
    
    private var viewModel: PlayerDetailsViewModel
    private lazy var aboutPlayerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor =  .gray
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        viewModel.fetchData()
        updateUi()
        //bindTableView()
        
        
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
        setupIntialView()
        setupTableView()
        setupObservables()
        changeTappedButtonsUi(button: self.playerInfoButton)
        setUpComponents(item: playerPhotoImageView, cornerRadius: 25, shadowRadius: 15, offSet: 6, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25), isButton: false)
        setUpComponents(item: playerInfoButton, cornerRadius: 8, shadowRadius: 10, offSet: 2, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.15), isButton: true)
        setUpComponents(item: playerStatisticsButton, cornerRadius: 8, shadowRadius: 10, offSet: 2, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.15), isButton: true)
        setUpComponents(item: playerEventsButton, cornerRadius: 8, shadowRadius: 10, offSet: 2, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.15), isButton: true)
        setUpComponents(item: playerMediaButton, cornerRadius: 8, shadowRadius: 10, offSet: 2, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.15), isButton: false)
    }
    ///This is a support function (support updateUi function) to set up navigation bar UI
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy code not a clean one
    private func setUpNavigationBar() {
        navigationItem.titleView = searchBar
        searchBar.placeholder = " Search here"
        searchBar.searchTextField.tintColor = #colorLiteral(red: 0.9474149346, green: 0.2494795024, blue: 0.3013353646, alpha: 1)
        searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9803921569, blue: 0.9764705882, alpha: 1)
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9474149346, green: 0.2494795024, blue: 0.3013353646, alpha: 1)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9725490196, green: 0.9803921569, blue: 0.9764705882, alpha: 1)
    }
    
    ///This is a support function (support updateUi function) to set up initial state for  UI
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy code not a clean one
    private func setupIntialView() {
        //Set Intial state
        playerDetailsTableView.isHidden = true
        playerNameLabel.isHidden = true
        playerPositionLabel.isHidden = true
        playerPhotoImageView.isHidden = true
        scrollView.isHidden = true
        playerStackView.isHidden = true
        teamStackView.isHidden = true
        viewMessage.isHidden = false
        lblMessage.text = "Getting Player Details..."
        imgMeessage.image = #imageLiteral(resourceName: "Loading")
    }
    
    ///This is a support function (support updateUi function) to register a cell for TableView UI
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy cose not a clean one
    private func setupTableView() {
        //playerDetailsTableView.rowHeight = UITableView.automaticDimension
        //playerDetailsTableView.estimatedRowHeight = 70
        playerDetailsTableView.sectionHeaderHeight = 50
        playerDetailsTableView.layer.cornerRadius = 8
        playerDetailsTableView.layer.borderWidth = 1
        playerDetailsTableView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        playerDetailsTableView.layer.masksToBounds = true
        
        //Register PlayersCell
        playerDetailsTableView.register(PlayerDetailsTableViewCell.nib, forCellReuseIdentifier: PlayerDetailsTableViewCell.identifier)
    }
    
    ///This is a support function (support updateUi function) to change UI according to data network call
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy code not a clean one
    private func setupObservables() {
        //Set success state
        viewModel.onSuccess.subscribe { [weak self] _ in
            guard let self = self else { return }
            self.bindTableView()
            self.setData()
            self.viewMessage.isHidden = true
            self.playerDetailsTableView.isHidden = false
            self.playerNameLabel.isHidden = false
            self.playerPositionLabel.isHidden = false
            self.playerPhotoImageView.isHidden = false
            self.playerStackView.isHidden = false
            self.teamStackView.isHidden = false
            self.scrollView.isHidden = false
        }.disposed(by: viewModel.disposeBag)
        
        //Set error state
        viewModel.onError.subscribe { [weak self] error in
            guard let self = self else { return }
            self.playerDetailsTableView.isHidden = true
            self.playerNameLabel.isHidden = true
            self.playerPositionLabel.isHidden = true
            self.playerPhotoImageView.isHidden = true
            self.playerStackView.isHidden = true
            self.teamStackView.isHidden = true
            self.scrollView.isHidden = true
            self.viewMessage.isHidden = false
            print(error.debugDescription)
            self.lblMessage.text = "Oops! something wrong try again later.!!"
            self.imgMeessage.image = #imageLiteral(resourceName: "Error")
        }.disposed(by: viewModel.disposeBag)
    }
    
    ///This is a support function (support updateUi function) to set up components like buttons, labels and etc UI.
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy code not a clean one
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
    
    ///This function resposible for set the data to UI Component
    private func setData() {
        guard let info = viewModel.playerInfo else { return }
        let imageUrl = URL(string: info.playerPhoto)
        playerPhotoImageView.sd_setImage(with: imageUrl, completed: nil)
        playerNameLabel.text = info.playerName
        teamNameLabel.text = info.teamName
        countryNameLabel.text = info.playerCountry.capitalizingFirstLetter()
        teamLogoImageView.sd_setImage(with: URL(string: info.teamPhoto), completed: nil)
        playerAgeLabel.text = viewModel.age
        playerMarketPriceLabel.text = viewModel.marketPrice.filter({ !"+".contains($0) })
        playerNumberLabel.text = viewModel.number
        playerRatingLabel.text = viewModel.rating
        playerPositionLabel.text = viewModel.position
    }
}
/*===============================================*/
extension PlayerDetailsViewController: UITableViewDelegate {
    
    //MARK: - Table View Functions
    private func bindTableView() {
        guard let info = viewModel.playerInfo else { return }
        playerDetailsTableView.rx.setDelegate(self).disposed(by: viewModel.disposeBag)
        
        viewModel.dataSource.configureCell = { (dataSource, tableView, indexPath, item ) in
            let cell = tableView.dequeueReusableCell(withIdentifier: PlayerDetailsTableViewCell.identifier, for: indexPath) as! PlayerDetailsTableViewCell
            cell.configure(key: item.key, value: item.value)
            return cell
        }
        
        viewModel.dataSource.titleForHeaderInSection = { (dataSource, index) in
            return dataSource[index].header
        }
        
        let sections = Observable.just([
            SectionViewModel(header: "About Player", items: viewModel.getExceptionIndicators(for: info.indicators)),
            SectionViewModel(header: "Rating", items: info.rating)
        ])
        
        sections
            .bind(to: playerDetailsTableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: viewModel.disposeBag)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .white
            headerView.backgroundView?.backgroundColor = .black
            headerView.textLabel?.textColor = #colorLiteral(red: 0.8705882353, green: 0.1450980392, blue: 0.2274509804, alpha: 1)
            headerView.textLabel?.textAlignment = .center
            headerView.textLabel?.lineBreakMode = .byWordWrapping
            headerView.textLabel?.numberOfLines = 2
            headerView.textLabel?.adjustsFontSizeToFitWidth = true
            headerView.textLabel?.font = UIFont(name: "SF Pro", size: 25)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return UITableView.automaticDimension
            } else {
                return 40
            }
        } else {
            return 40
        }
    }
}
