//
//  PlayerDetailsViewModel.swift
//  QooGlobalTask
//
//  Created by Ma7rous on 23/03/2023.
//

import Moya
import RxSwift
import RxRelay
import RxDataSources

class PlayerDetailsViewModel {
    //MARK: Properties
    private let playerSlug: String
    private(set) var exceptions = ["Age", "Market price", "Player number", "Rating"]
    private(set) var age = ""
    private(set) var position = ""
    private(set) var rating = ""
    private(set) var number = ""
    private(set) var marketPrice = ""
    var dataSource = RxTableViewSectionedReloadDataSource<SectionViewModel>(configureCell: { _, _, _, _ in
        fatalError()
    })
    private let provider = MoyaProvider<NetworkLayer>()
    private(set) var playerInfo: Info?
    private(set) lazy var indicators = BehaviorSubject(value: [Indicator]())
    private(set) lazy var statistics = BehaviorSubject(value: [Statistic]())
    private(set) lazy var events = BehaviorSubject(value: [Event]())
    private(set) lazy var medias = BehaviorSubject(value: [Media]())
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
                    let model =  try response.map(PlayerDetails.self)
                    self.playerInfo = model.data
        
                    self.statistics.on(.next(try response.map(PlayerDetails.self).data.statistics))
                    self.events.on(.next(try response.map(PlayerDetails.self).data.events))
                    self.medias.on(.next(try response.map(PlayerDetails.self).data.medias))
                    self.indicators.on(.next(try response.map(PlayerDetails.self).data.indicators))
                    for item in self.exceptions {
                        self.indicators.onNext(try self.indicators.value().filter { $0.key != item})
                    }
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
    
    ///This function resposible for filter player indicators
    func getExceptionIndicators(for indicators: [Indicator]) -> [Indicator]{
        let about = Indicator(key: "", value: self.playerInfo!.about.filter({ !"\n".contains($0) }))
        var temp = [Indicator]()
        temp.append(about)
        for i in (0 ..< indicators.count).reversed() {
            switch indicators[i].key {
            case "Age":
                age = indicators[i].value
            case "Market price":
                marketPrice = indicators[i].value
            case "Player number":
                number = indicators[i].value
            case "Rating":
                rating = indicators[i].value
            case "Main position":
                position = indicators[i].value
                fallthrough
            default:
                temp.append(indicators[i])
            }
        }
        return temp
    }
}

