//
//  NewsSection.swift
//  SNews
//
//  Created by Soft Project on 4/20/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import RxDataSources

struct NewsSection: SectionModelType {
  
  typealias Item = Article
  
  var header: String
  var items: [Item]
  
  init(original: NewsSection, items: [Item]) {
    self = original
    self.items = items
  }
  
  init(header: String, items: [Item]) {
    self.header = header
    self.items = items
  }
}
