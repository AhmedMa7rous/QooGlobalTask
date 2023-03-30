//
//  String+Extension.swift
//  QooGlobalTask
//
//  Created by Ma7rous on 27/03/2023.
//

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
