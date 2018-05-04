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
  
  // MARK: - Public methods
  func decode(_ data: Data) -> NetworkResponse<Resource.Model> {
    return  NetworkResponse(data: resource.makeModel(data: data), erros: resource.decodeError(data: data))
  }
  
  func send(data: [String: Any]) -> Observable<NetworkResponse<Resource.Model>> {
    return load(resource.requestUrl, method: .post, parameters: data)
  }
  
  func get(page: Int = 0) -> Observable<NetworkResponse<Resource.Model>> {
    return load(resource.requestUrl, method: .get, page: page)
  }
  
  // MARK: - Private methods
  private func load (_ requestUrl: String,
                     method: HTTPMethod,
                     parameters: [String: Any]? = nil,
                     page: Int = 0) -> Observable<NetworkResponse<Model>> {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    
    return Observable.create { observer in
      requestData(method, requestUrl + "&page=\(page)&apiKey=\(UserDefaults.User.APIKey)",
                  parameters: parameters,
                  encoding: JSONEncoding.default).debug()
        .subscribe(onNext: { resonse in
          let statusCode = resonse.0.statusCode
          let responseData = resonse.1
          let serverResponse = self.decode(responseData)
          #if DEBUG
          self.deBugPrintJson(responseData)
          #endif
          UIApplication.shared.isNetworkActivityIndicatorVisible = false
          if statusCode == 401 { //Handle Unathorized status code
            observer.onError(AppError(title: "Unauthorized", description: "User not authorized"))
          } else if statusCode < 200 || statusCode > 300 { //Handle wrong status codes from server
            if serverResponse.erros != nil { //Handle JSON Errors if any
              observer.onNext(self.decode(responseData))
              observer.on(.completed)
            } else { //Throw unexpected if server return with no errors
              observer.onError(AppError(title: "Unexpected Error", description: "Unexpected Server Error"))
            }
          } else {
            observer.onNext(serverResponse)
            observer.on(.completed)
          }
        }, onError: { error in
          UIApplication.shared.isNetworkActivityIndicatorVisible = false
          observer.onError(error)
        })
    }
  }
}
