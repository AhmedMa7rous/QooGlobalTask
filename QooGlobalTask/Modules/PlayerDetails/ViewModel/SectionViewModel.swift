//
//  SectionViewModel.swift
//  QooGlobalTask
//
//  Created by Ma7rous on 29/03/2023.
//

import RxDataSources

struct SectionViewModel {
  var header: String
  var items: [Item]
}

extension SectionViewModel: SectionModelType {
  typealias Item = Indicator

   init(original: SectionViewModel, items: [Item]) {
    self = original
    self.items = items
  }
}
