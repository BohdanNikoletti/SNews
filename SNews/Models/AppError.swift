//
//  AppError.swift
//  SNews
//
//  Created by Soft Project on 5/3/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import Foundation

struct AppError: LocalizedError {
  // MARK: - Proeprties
  let title: String
  var errorDescription: String? { return _description }
  var failureReason: String? { return _description }
  
  private var _description: String
  
  // MARK: - Initializers
  init(title: String? = nil, description: String) {
    self.title = title ?? "Error"
    self._description = description
  }
  
  init(form systemError: Error) {
    self.init(description: systemError.localizedDescription)
  }
}
// MARK: - AppError Decodable extension
extension AppError: Decodable {
  
  private enum CodingKeys: String, CodingKey {
    case title = "code"
    case _description = "message"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.title = try container.decode(String.self, forKey: .title)
    self._description = try container.decode(String.self, forKey: ._description)
  }
}
