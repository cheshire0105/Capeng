//
//  WeatherViewModel.swift
//  Capeng
//
//  Created by cheshire on 1/24/24.
//

import Foundation
import SwiftUI
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherData?
    private var locationManager = LocationManager()
    @Published var quoteViewModel = QuoteViewModel()


    private let apiKey = "6b2a1e19c8fdb59ce8b102e4949644f4"
    var isPreview: Bool // 프리뷰 모드를 위한 플래그

    // 커피 추천 멘트
    var coffeeRecommendationMessage: String {
        guard let temperature = weatherData?.temperature else {
            return "오늘은 온도 정보가 없습니다. 기본 설정을 사용해보세요."
        }

        switch temperature {
        case ..<10:
            return "오늘은 날씨가 꽤 추워요. 굵은 분쇄로 따뜻한 커피 어떠세요?"
        case 10..<20:
            return "오늘은 산뜻한 날씨네요. 중간 분쇄로 기분 좋은 하루를 시작해보세요."
        default:
            return "오늘은 날씨가 더워요. 세밀한 분쇄로 시원한 아이스 커피는 어떠세요?"
        }
    }

    // 온도에 따른 그라데이션 배경 색상 계산
    var cardBackgroundGradient: LinearGradient {
        let startColor: Color
        let endColor: Color

        guard let temperature = weatherData?.temperature else {
            // 기본 그라데이션
            startColor = Color.white
            endColor = Color.gray
            return LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .top, endPoint: .bottom)
        }

        switch temperature {
        case ..<0:
            startColor = Color.blue
            endColor = Color.blue.opacity(0.5)
        case 0..<15:
            startColor = Color.green
            endColor = Color.green.opacity(0.5)
        case 15..<25:
            startColor = Color.yellow
            endColor = Color.yellow.opacity(0.5)
        default:
            startColor = Color.red
            endColor = Color.red.opacity(0.5)
        }

        return LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .leading, endPoint: .trailing)
    }

    // 온도에 따른 원두 추천
    var recommendedCoffeeBeans: [CoffeeBean] {
        guard let temperature = weatherData?.temperature else { return [] }

        switch temperature {
        case ..<10:
            return [
                CoffeeBean(origin: "에티오피아", type: "아라비카", description: "플로럴한 향미", imageName: "ethiopiaCoffee"),
                CoffeeBean(origin: "케냐", type: "SL28", description: "강렬한 산미와 과일 향미", imageName: "kenyaCoffee"),
                CoffeeBean(origin: "예멘", type: "모카", description: "진한 몸매와 복합적인 맛", imageName: "yemenCoffee"),
                CoffeeBean(origin: "르완다", type: "부르봉", description: "달콤한 베리류의 향미", imageName: "rwandaCoffee")
            ]
        case 10..<20:
            return [
                CoffeeBean(origin: "브라질", type: "부르봉", description: "초콜릿과 견과류 향미", imageName: "brazilCoffee"),
                CoffeeBean(origin: "콜롬비아", type: "카투라", description: "밝은 산미와 달콤함", imageName: "colombiaCoffee"),
                CoffeeBean(origin: "과테말라", type: "아라비카", description: "균형 잡힌 산미와 풍부한 향미", imageName: "guatemalaCoffee"),
                CoffeeBean(origin: "인도네시아", type: "만델링", description: "흙 내음과 무거운 바디", imageName: "indonesiaCoffee")
            ]
        default:
            return [
                CoffeeBean(origin: "베트남", type: "로부스타", description: "강한 바디감과 떫은 맛", imageName: "vietnamCoffee"),
                CoffeeBean(origin: "인도", type: "몬순", description: "독특한 맛과 향의 조화", imageName: "indiaCoffee"),
                CoffeeBean(origin: "하와이", type: "코나", description: "부드러운 바디감과 감미로운 맛", imageName: "hawaiiCoffee"),
                CoffeeBean(origin: "자메이카", type: "블루마운틴", description: "매끄러운 바디감과 깔끔한 마무리", imageName: "jamaicaCoffee")
            ]
        }
    }




    init(isPreview: Bool = false) {
        self.isPreview = isPreview
        if isPreview {
            // 프리뷰를 위한 고정된 위치 정보 사용
            let fixedLocation = CLLocation(latitude: 18.0195, longitude: -76.7795) // 자메이카 밥 말리 박물관
            self.fetchWeatherData(for: fixedLocation)
        } else {
            locationManager.weatherViewModel = self
            locationManager.startUpdatingLocation()
        }
    }

    func loadQuote() {
        quoteViewModel.loadAdvice()
    }

    func fetchWeatherData() {
        guard !isPreview, let location = locationManager.currentLocation else {
            return
        }
        fetchWeatherData(for: location)
    }

    private func fetchWeatherData(for location: CLLocation) {
        let latitude = String(format: "%.4f", location.coordinate.latitude)
        let longitude = String(format: "%.4f", location.coordinate.longitude)

        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        fetchWeather(from: urlString)
    }


    private func fetchWeather(from urlString: String) {
        guard let url = URL(string: urlString) else { return }

        print("날씨 데이터 요청 URL: \(urlString)")

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("날씨 데이터 요청 실패: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("데이터가 없습니다.")
                return
            }
            print("응답 데이터: \(String(data: data, encoding: .utf8) ?? "No data")")
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }

            if let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.weatherData = WeatherData(temperature: weatherResponse.main.temp,
                                                   humidity: weatherResponse.main.humidity,
                                                   cityName: weatherResponse.name
                    )
                }
            } else {
                print("JSON 디코딩 실패: \(String(data: data, encoding: .utf8) ?? "Unknown error")")
            }

        }.resume()
    }
}






