//
//  AppConstants.swift
//  SNews
//
//  Created by Soft Project on 4/20/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import Foundation
import UIKit

struct  Endpoints {
  
  private init() { }
  
  static let serverRoot = "https://newsapi.org"
  static let apiEndpoint = "\(serverRoot)/v2/"
}

extension UserDefaults {
  enum User {
    static let defaultLocation = "us"
    static let defaultCategory = "business"
    static let APIKey = "d69d7c224c7a476982cd86030b053072"
  }
}
