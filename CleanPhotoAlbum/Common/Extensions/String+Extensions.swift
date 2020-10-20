//
//  String+Extensions.swift
//  CleanPhotoAlbum
//
//  Created by Daniel Mendoza Zamores on 19/10/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import Foundation

extension String {
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
