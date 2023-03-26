//
//  PlayerDetailsViewModel.swift
//  QooGlobalTask
//
//  Created by Ma7rous on 23/03/2023.
//

import UIKit
import Moya
import RxSwift
import RxRelay

class PlayerDetailsViewModel {
    //MARK: Properties
    private let playerSlug: String
    private let provider = MoyaProvider<NetworkLayer>()
    private var playerInfo: Info
    private(set) var playerAbout = BehaviorSubject(value: [Indicator]())
    var disposeBag: DisposeBag = DisposeBag()
    var onSuccess: PublishSubject<Void> = PublishSubject<Void>()
    var onError: PublishSubject<String> = PublishSubject<String>()
    var showLoader: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    
    
/*============================================================*/
    //MARK: - Intializer
    init(with playerSlug: String) {
        self.playerSlug = playerSlug
    }
    
    //MARK: - Intents
    func fetchData() {
        provider.request(.playerDetails(playerSlug: playerSlug)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    //self.playerDetails.on(.next(try response.map(PlayerDetails.self).data))
                    let uploade =  try response.map(PlayerDetails.self)
                    self.playerInfo = uploade.data
                    //self.playerDetails = BehaviorSubject<[Info]>(value: self.infoArray)
                    self.playerAbout.on(.next(uploade.data.indicators))
                    self.onSuccess.onNext(())
                } catch {
                    print(error.localizedDescription)
                    self.onError.onNext(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.onError.onNext(error.localizedDescription)
            }
        }
    }
}

