//
//  NetworkService.swift
//  SNews
//
//  Created by Soft Project on 4/20/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import RxCocoa
import RxSwift

class NetworkService<Resource: ApiResource> {
  
  // MARK: - Properties
  let request: ApiRequest<Resource>?
  let isLoading = BehaviorRelay(value: false)
  let isSuccess = BehaviorRelay(value: false)
  let errorMessage = BehaviorRelay<Error?>(value: nil)
  let disposeBag = DisposeBag()
  
  // MARK: - Initializer
  init(resource: Resource) {
    request = ApiRequest(resource: resource)
  }
  
  // MARK: - Methods
  func errohandler( _ error: Error) {
    isLoading.accept(false)
    errorMessage.accept(error)
  }
}
