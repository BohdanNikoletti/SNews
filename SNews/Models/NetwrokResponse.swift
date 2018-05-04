//
//  NetwrokResponse.swift
//  SNews
//
//  Created by Soft Project on 4/20/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import Foundation

struct NetworkResponse<Model> {
  let data: Model
  let erros: AppError?
}
