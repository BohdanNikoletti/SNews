//
//  Article.swift
//  SNews
//
//  Created by Soft Project on 4/20/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import Foundation

struct Article: Decodable {
  
  let author: String?
  let title: String?
  let description: String?
  let url: String?
  let urlToImage: String?
  let publishedAt: String?
  
  var newsLink: URL? {
    guard let newsUrlString = self.url else { return nil }
    return URL(string: newsUrlString)
  }
  static var template: Article {
    return Article(author: nil, title: nil, description: nil, url: nil,
                   urlToImage: nil, publishedAt: nil, isTemplateModel: true)
  }
  
  let isTemplateModel: Bool
}
