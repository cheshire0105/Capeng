//
//  Model.swift
//  Capeng
//
//  Created by cheshire on 1/24/24.
//

import Foundation

struct CoffeeBean {
    var origin: String
    var type: String
    var description: String
    var imageName: String // 이미지 파일명을 저장하는 속성
}


struct AdviceSlip: Codable {
    let slip: Slip
}

struct Slip: Codable {
    let id: Int
    let advice: String
}


struct WeatherResponse: Codable {
    let main: WeatherMain
    let name: String // 지역 이름
}

struct WeatherMain: Codable {
    let temp: Double
    let humidity: Double
}

struct WeatherData {
    let temperature: Double
    let humidity: Double
    let cityName: String // 지역 이름
}

