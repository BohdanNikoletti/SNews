//
//  ApiResource.swift
//  CareHome Schedule
//
//  Created by Soft Project on 3/20/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import Foundation

protocol ApiResource {
  
  associatedtype Model: Decodable
  
  var methodPath: String { get }
  var requestUrl: String { get }
  
  func makeModel(data: Data) -> Model
}

extension ApiResource {
  
  var requestUrl: String {
    let baseUrl = Endpoints.apiEndpoint
    let url = baseUrl + methodPath
    return url
  }
  
  var decoder: JSONDecoder {
    return JSONDecoder()
  }
}
