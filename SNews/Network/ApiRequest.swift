//
//  ApiRequest.swift
//  CareHome Schedule
//
//  Created by Soft Project on 3/19/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import RxSwift
import RxCocoa
import RxAlamofire
import Alamofire

struct ApiRequest<Resource: ApiResource> {
  let resource: Resource
}

extension ApiRequest: NetworkRequest {
  
  func decode(_ data: Data) -> NetworkResponse<Resource.Model> {
    return  NetworkResponse(data: resource.makeModel(data: data), erros: nil)
  }
  
  func send(data: [String: Any]) -> Observable<NetworkResponse<Resource.Model>> {
    return load(resource.requestUrl, method: .post, parameters: data)
  }
  
  func get() -> Observable<NetworkResponse<Resource.Model>> {
    return load(resource.requestUrl, method: .get)
  }
  
  private func load (_ requestUrl: String,
                     method: HTTPMethod,
                     parameters: [String: Any]? = nil ) -> Observable<NetworkResponse<Model>> {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    return Observable.create { observer in
      requestData(method, requestUrl,
                  parameters: parameters,
                  encoding: JSONEncoding.default).debug()
        .subscribe(onNext: { resonse in
//          let statusCode = resonse.0.statusCode
          let responseData = resonse.1
          let serverResponse = self.decode(responseData)
          #if DEBUG
            self.deBugPrintJson(responseData)
          #endif
          UIApplication.shared.isNetworkActivityIndicatorVisible = false
          observer.onNext(serverResponse)
          observer.on(.completed)
        }, onError: { error in
          UIApplication.shared.isNetworkActivityIndicatorVisible = false
          observer.onError(error)
        })
    }
  }
}
