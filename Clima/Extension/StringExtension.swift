//
//  StringExtension.swift
//  Clima
//
//  Created by Anderson Chagas on 17/04/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

extension String {
  func stringByAddingPercentEncodingForRFC3986() -> String? {
    let unreserved = "-._~/?"
    let allowed = NSMutableCharacterSet.alphanumeric()
    allowed.addCharacters(in: unreserved)
    return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
  }
}
