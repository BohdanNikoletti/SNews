//
//  NetworkRequest.swift
//  CareHome Schedule
//
//  Created by Soft Project on 3/19/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import RxSwift

protocol NetworkRequest {
  associatedtype Model
  func send(data: [String: Any]) -> Observable<NetworkResponse<Model>>
  func decode(_ data: Data) -> NetworkResponse<Model>
}

extension NetworkRequest {
  func deBugPrintJson(_ data: Data) {
    do {
      let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
      print(jsonData ?? "JSON data is Empty")
      
    } catch {
      print(error.localizedDescription)
    }
  }
}
