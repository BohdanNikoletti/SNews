//
//  Article.swift
//  SNews
//
//  Created by Soft Project on 4/20/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import Foundation

struct Article: Decodable {
  
  // MARK: - Properties
  let author: String?
  let title: String?
  let description: String?
  let url: String?
  let urlToImage: String?
  let publishedAt: String?
  
  var isTemplateModel: Bool {
    return author == nil && title == nil && description == nil && url == nil && urlToImage == nil && publishedAt == nil
  }

  var newsLink: URL? {
    guard let newsUrlString = self.url else { return nil }
    return URL(string: newsUrlString)
  }
  
  var imageLink: URL? {
    guard let imageUrlString = self.urlToImage else { return nil }
    return URL(string: imageUrlString)
  }
  
  static var template: Article {
    return Article(author: nil, title: nil, description: nil, url: nil,
                   urlToImage: nil, publishedAt: nil)
  }
  
}
