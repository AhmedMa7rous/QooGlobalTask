//
//  HomeViewController.swift
//  QooGlobalTask
//
//  Created by Ma7rous on 22/03/2023.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    
    //MARK: - Outlet Connections
    @IBOutlet weak var showPlayerBtn: UIButton!

/*===============================================*/
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUi()
    }

/*===============================================*/
    //MARK: - Action Connections
    @IBAction func showPlayersBtnTapped(_ sender: UIButton) {
        let vc = PlayersViewController()
        vc.configureNavigationItems()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
/*==============================================*/
    //MARK: - Services Functions
    func updateUi() {
        showPlayerBtn.layer.cornerRadius = 25
        
    }
    
}
