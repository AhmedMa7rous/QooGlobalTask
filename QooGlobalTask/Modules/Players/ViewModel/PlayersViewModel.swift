//
//  PlayersViewModel.swift
//  QooGlobalTask
//
//  Created by Ma7rous on 23/03/2023.
//

import UIKit
import Moya
import RxSwift
import RxCocoa
import RxRelay


class PlayersViewModel {
    //MARK: Properties
    private let provider = MoyaProvider<NetworkLayer>()
    private(set) var players = BehaviorSubject(value: [Player]())
    private(set) var topPlayers = BehaviorSubject(value: [Player]())
    var disposeBag: DisposeBag = DisposeBag()
    var onSuccess: PublishSubject<Void> = PublishSubject<Void>()
    var onError: PublishSubject<String> = PublishSubject<String>()
    var showLoader: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    
    //search bar inputs
    var filteredItems = BehaviorSubject(value: [Player]())
    lazy var items: Observable<[Player]> = self.players.asObservable()
    lazy var filteredItemsObservable: Observable<[Player]> = self.filteredItems.asObservable()
    private let searchSubject = PublishSubject<String>()
    var searchObserver: AnyObserver<String> {
        return searchSubject.asObserver()
    }
    //search bar outputs
    private let loadingSubject = PublishSubject<Bool>()
    var isLoading: Driver<Bool> {
        return loadingSubject.asDriver(onErrorJustReturn: false)
    }
    
    
/*============================================================*/
    //MARK: - Intializer
    init() {
        searchOnValue()
    }
    
    //MARK: - Intents
    func fetchData() {
        provider.request(.players) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    self.players.on(.next(try response.map(Players.self).data))
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
    
    fileprivate func searchOnValue() {
        searchSubject.subscribe { [weak self] (value) in
            guard let self = self else { return }
            guard let element = value.element else { return }
            print("the value recieved: \(value)")
            self.items.map({ $0.filter({
                if element.isEmpty { return true }
                return $0.name.lowercased().contains(element.lowercased())
            })
            }).bind(to: self.filteredItems)
                .disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
    }
}

