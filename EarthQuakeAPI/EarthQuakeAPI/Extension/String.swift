//
//  String.swift
//  EarthQuakeAPI
//
//  Created by Dang Duy Cuong on 3/12/21.
//  Copyright © 2021 duycuong. All rights reserved.
//

import Foundation

extension String {
    func toInt() -> Int {
        if let value = Int(self) {
            return value
        }
        return 0
    }
    
    func unaccent() -> String {
        return self.folding(options: .diacriticInsensitive, locale: .current)
    }
}
