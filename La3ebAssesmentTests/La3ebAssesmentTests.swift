//
//  La3ebAssesmentTests.swift
//  La3ebAssesmentTests
//
//  Created by Sharaf on 26/05/2023.
//

import XCTest
@testable import La3ebAssesment
final class La3ebAssesmentTests: XCTestCase {

 
    
    func test_api_for_Games() {
        let api = GameService()
        let param = [Constants.APIHeaders.apiKey:Constants.APIHeaders.apiKeyValue,"page_size":"10","page":"1"]
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(param),let url = URL(string: APIPath().games),let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "", headerFields: nil) {
            let response = try? api.parseResponse(data: jsonData, response: response)
            XCTAssertEqual(response?.count, 10)
        }
    }
    
    func test_api_for_search() {
        let api = GameService()
        let param = [Constants.APIHeaders.apiKey:Constants.APIHeaders.apiKeyValue,"page_size":"10","page":"1","search":"gtav"]
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(param),let url = URL(string: APIPath().games),let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "", headerFields: nil) {
            let response = try? api.parseResponse(data: jsonData, response: response)
            XCTAssertEqual(response?.results?.first?.name, "Grand Theft Auto V")
        }
    }
    
    func test_api_for_GameDetail() {
        let api = GameDetailService(id: 3498)
        let param = [Constants.APIHeaders.apiKey:Constants.APIHeaders.apiKeyValue]
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(param),let url = URL(string: APIPath().games),let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "", headerFields: nil) {
            let response = try? api.parseResponse(data: jsonData, response: response)
            XCTAssertEqual(response?.reviewsCount, 6427)
        }
    }

}
