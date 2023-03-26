//
//  PlayersViewController.swift
//  QooGlobalTask
//
//  Created by Ma7rous on 22/03/2023.
//

import UIKit
import RxSwift
import RxCocoa

class PlayersViewController: UIViewController {

    //MARK: - Outlet Connections
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var topPlayersLabel: UILabel!
    @IBOutlet weak var allPlayersLabel: UILabel!
    @IBOutlet weak var TopPlayersCollectionView: UICollectionView!
    @IBOutlet weak var playersTableView: UITableView!
    @IBOutlet weak private var viewMessage: UIView!
    @IBOutlet weak private var lblMessage: UILabel!
    @IBOutlet weak private var imgMeessage: UIImageView!

/*=================================================*/
    //MARK: Properties
    private var viewModel = PlayersViewModel()
    private var tableTopAnchor = NSLayoutYAxisAnchor()
    private var searching = false
    
/*===============================================*/
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateUi()
        viewModel.fetchData()
        bindCollectionView()
        bindTableView()
        startsearch()
    }

/*===============================================*/
    //MARK: - Action Connections
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
        
    }
 
/*=================================================*/
    //MARK: Inside Services Functions
    
    ///This function responsible for every thing related with UI
    private func updateUi() {
        setUpNavigationBar()
        setupCollectionView()
        setupTableView()
        setupIntialView()
        setupObservables()
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
    
    ///This is a support function (support updateUi function) to set up initial state for  UI
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy cose not a clean one
    private func setupIntialView() {
        //Set Intial state
        tableTopAnchor = playersTableView.topAnchor
        topPlayersLabel.isHidden = true
        allPlayersLabel.isHidden = true
        playersTableView.isHidden = true
        TopPlayersCollectionView.isHidden = true
        viewMessage.isHidden = false
        lblMessage.text = "Getting Players..."
        imgMeessage.image = #imageLiteral(resourceName: "Loading")
    }
    
    ///This is a support function (support updateUi function) to register a cell for CollectionView UI
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy cose not a clean one
    private func setupCollectionView() {
        //Register TopPlatersCell
        TopPlayersCollectionView.register(TopPlayersCollectionViewCell.nib, forCellWithReuseIdentifier: TopPlayersCollectionViewCell.identifier)
    }
    
    ///This is a support function (support updateUi function) to register a cell for TableView UI
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy cose not a clean one
    private func setupTableView() {
        playersTableView.layer.cornerRadius = 8
        playersTableView.layer.borderWidth = 1
        playersTableView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        playersTableView.separatorStyle = .none
        //Register PlayersCell
        playersTableView.register(AllPlayersTableViewCell.nib, forCellReuseIdentifier: AllPlayersTableViewCell.identifier)
    }
    
    ///This is a support function (support updateUi function) to change UI according to data network call
    ///Note that: You can call this function only inside updateUi function otherwise your code will be a legacy cose not a clean one
    private func setupObservables() {
        //Set success state
        viewModel.onSuccess.subscribe { [weak self] _ in
            guard let self = self else { return }
            self.viewMessage.isHidden = true
            self.playersTableView.isHidden = false
            self.topPlayersLabel.isHidden = false
            self.allPlayersLabel.isHidden = false
            self.TopPlayersCollectionView.isHidden = false
    }.disposed(by: viewModel.disposeBag)
                
        //Set error state
        viewModel.onError.subscribe { [weak self] error in
            guard let self = self else { return }
            self.playersTableView.isHidden = true
            self.topPlayersLabel.isHidden = true
            self.allPlayersLabel.isHidden = true
            self.TopPlayersCollectionView.isHidden = true
            self.viewMessage.isHidden = false
            print(error.debugDescription)
            self.lblMessage.text = "Oops! something wrong try again later.!!"
            self.imgMeessage.image = #imageLiteral(resourceName: "Error")
        }.disposed(by: viewModel.disposeBag)
    }
    
    private func startsearch() {
        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .debug()
            .bind(to: viewModel.searchObserver)
            .disposed(by: viewModel.disposeBag)
    }
    
/*==============================================*/
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
    
}

/*=================================================*/
extension PlayersViewController: UITableViewDelegate {
    
   //MARK: - Players TableView Functions
    func bindTableView() {
        playersTableView.rx.setDelegate(self).disposed(by: viewModel.disposeBag)
        viewModel.filteredItems.bind(to: playersTableView.rx.items(cellIdentifier: AllPlayersTableViewCell.identifier, cellType: AllPlayersTableViewCell.self)) { (row, item, cell) in
            cell.configure(player: item)

        } .disposed(by: viewModel.disposeBag)
        
        playersTableView.rx.modelSelected(Player.self).subscribe { [weak self] player in
            guard let self = self else { return }
            guard let player = player.element else { return }
            let vc = PlayerDetailsViewController(player: player)
            vc.configureNavigationItems()
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: viewModel.disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
/*=======================================================*/
    //MARK: - TopPlayers CollectionView Functions
    func bindCollectionView() {
        TopPlayersCollectionView.rx.setDelegate(self).disposed(by: viewModel.disposeBag)
        viewModel.filteredItems.bind(to: TopPlayersCollectionView.rx.items(cellIdentifier: TopPlayersCollectionViewCell.identifier, cellType: TopPlayersCollectionViewCell.self)) { (row, item, cell) in
            cell.configure(player: item)
        } .disposed(by: viewModel.disposeBag)
        
        TopPlayersCollectionView.rx.modelSelected(Player.self).subscribe { [weak self] player in
            guard let self = self else { return }
            guard let player = player.element else { return }
            let vc = PlayerDetailsViewController(player: player)
            vc.configureNavigationItems()
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: viewModel.disposeBag)
    }
    
}
/*======================================================*/
extension PlayersViewController: UISearchBarDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.5, height: collectionView.frame.height)
        }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if  searchText != "" {
            TopPlayersCollectionView.isHidden = true
            NSLayoutConstraint.activate([playersTableView.topAnchor.constraint(equalTo: self.view.topAnchor)])
            searching = true
        }
    }
}

