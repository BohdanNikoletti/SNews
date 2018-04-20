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
//  
//  var params: String? {
//    didSet {
//      guard let params = params, !params.isEmpty else { return }
//      methodPath.append(params)
//    }
//  }
//  
  var methodPath = "top-headlines?"

  func makeModel(data: Data) -> [Article]? {
    do {
      return try decoder.decode(DataVrapper.self, from: data).articles
    } catch {
      print(error)
      return nil
    }
  }
}
