//
//  SNewsTests.swift
//  SNewsTests
//
//  Created by Soft Project on 4/20/18.
//  Copyright © 2018 Bohdan. All rights reserved.
//

import XCTest
import Quick
import Nimble
import RxSwift
import RxTest
import RxCocoa
import RxBlocking
import Alamofire
import RxAlamofire

@testable import SNews

final class AuthorizationSpec: QuickSpec {
  override func spec() {
    describe("News Feed") {
      var networkService: NetworkService<TopHeadLinesResource>!

      describe("Default settings") {
        it("with correct data") {
          var topHeadLinesResource = TopHeadLinesResource()
          topHeadLinesResource.methodPath.append("country=us&category=business")
          networkService = NewsService(resource: topHeadLinesResource)
          do {
            let networkResponse = try networkService.request?.get()
              .toBlocking()
              .first()
            expect(networkResponse).toNot(beNil())
            expect(networkResponse?.data).toNot(beNil())
            expect(networkResponse?.data?.count == 20).to(beTrue())
          } catch {
            fail(error.localizedDescription)
          }
          
        }
        it("with wrong data") {
          var topHeadLinesResource = TopHeadLinesResource()
          topHeadLinesResource.methodPath.append("countries=ff")
          networkService = NewsService(resource: topHeadLinesResource)
          do {
            let networkResponse = try networkService.request?.get()
              .toBlocking()
              .first()
            expect(networkResponse).toNot(beNil())
            expect(networkResponse?.data).to(beNil())
          } catch {
            fail(error.localizedDescription)
          }
        }
      }
    }
  }
}
