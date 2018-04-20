//
//  AccountResource.swift
//  CareHome Schedule
//
//  Created by Soft Project on 3/30/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import Foundation

struct TopHeadLinesResource: ApiResource {
  
  struct DataVrapper: Decodable {
    let articles: [Article]
  }
  
  var methodPath = "top-headlines?country=us&category=business&apiKey=d69d7c224c7a476982cd86030b053072"

  func makeModel(data: Data) -> [Article]? {
    do {
      return try decoder.decode(DataVrapper.self, from: data).articles
    } catch {
      print(error)
      return nil
    }
  }
}
