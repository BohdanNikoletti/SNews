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
  
//  private enum CodingKeys: String, CodingKey {
//    case author
//    case title
//    case author
//    case title
//  }
//
//
//  // - MARK: - Initizalizers
//  init(from decoder: Decoder) throws {
//    let container = try decoder.container(keyedBy: CodingKeys.self)
//    self.id = try container.decode(Int.self, forKey: .id)
//    self.name = try container.decode(String.self, forKey: .name)
//
//    let isBranchManager = self.name.contains("manager")
//    if isBranchManager {
//      roleType = .manager
//    } else if self.name.contains("employee") {
//      roleType = .employee
//    } else {
//      roleType = .unAvailabel
//    }
//    self.title = isBranchManager ? "Branch Manager" : "Undefined"
//    self.access = isBranchManager ? "Branch access" : "Undefined"
//    self.isTemplateModel = false
//    self.imageURLString = nil
//  }
}
