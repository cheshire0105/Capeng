//
//  WeatherView.swift
//  Capeng
//
//  Created by cheshire on 1/20/24.
//

import Foundation
import SwiftUI
import WeatherKit


struct WeatherView: View {

    // 현재 날짜를 저장하는 프로퍼티
    @State private var currentDate = Date()
    // 날씨 데이터를 저장할 프로퍼티
    @ObservedObject private var viewModel = WeatherViewModel.shared

    private var locationManager = LocationManager()


    var body: some View {

        ZStack {
            Color("BackGroundColor").edgesIgnoringSafeArea(.all)

            VStack {
                Text(currentFormattedDate()) // 현재 날짜를 텍스트로 표시
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()


                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(height: 100)
                    .shadow(radius: 10)
                    .overlay(
                        HStack {
                                 Text("\(viewModel.weatherData.country) \(viewModel.weatherData.city)")
                                 Text("온도: \(viewModel.weatherData.temperature, specifier: "%.0f")°C")
                                 Image(systemName: viewModel.weatherData.conditionSymbol)
                             }

                    )
                    .padding()

                HStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(height: 200)
                        .shadow(radius: 10)
                        .padding()
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(height: 200)
                        .shadow(radius: 10)
                        .padding()

                }

            }
            .onAppear {
                LocationManager.shared.start()
            }

        }
    }

    // 현재 날짜를 포맷하는 함수
    private func currentFormattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: currentDate)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


import Foundation
import WeatherKit
import CoreLocation

class WeatherViewModel: ObservableObject {
    static let shared = WeatherViewModel()
    private let weatherService = WeatherService()

    // 내부 클래스로 이동
    class WeatherData: ObservableObject {
        @Published var country: String = "Loading..."
        @Published var city: String = "Loading..."
        @Published var temperature: Double = 0
        @Published var conditionSymbol: String = ""

        init() { }
    }

    @Published var weatherData = WeatherData()

    // 위치 정보 바인딩 메서드
    func fetchLocation(for location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }

            if let error = error {
                print("위치 정보를 가져오는데 실패했습니다: \(error.localizedDescription)")
                return
            }

            guard let placemark = placemarks?.first else {
                print("플레이스마크 정보가 없습니다.")
                return
            }

            // 플레이스마크 정보 로그 출력
            print("플레이스마크: 국가 - \(placemark.country ?? "알 수 없음"), 도시 - \(placemark.locality ?? "알 수 없음")")

            DispatchQueue.main.async {
                // WeatherData 인스턴스 생성 후 속성 설정
                let newWeatherData = WeatherData()
                newWeatherData.country = placemark.country ?? "Unknown Country"
                newWeatherData.city = placemark.locality ?? "Unknown City"
                self.weatherData = newWeatherData
            }

            // 날씨 정보 바인딩
            self.fetchWeather(for: location)
        }
    }



    // 날씨 정보 바인딩 메서드
    // 날씨 정보 바인딩 메서드
    func fetchWeather(for location: CLLocation) {
        Task {
            do {
                let weather = try await self.weatherService.weather(for: location)
                let temperature = Int(weather.currentWeather.temperature.value.rounded())

                DispatchQueue.main.async {
                    // 기존 WeatherData 객체의 속성을 직접 업데이트
                    self.weatherData.temperature = Double(temperature)
                    self.weatherData.conditionSymbol = weather.currentWeather.symbolName

                    // 디버그 로그 추가
                    print("업데이트된 온도: \(self.weatherData.temperature)°C")
                }
            } catch {
                print("날씨 정보를 가져오는데 실패했습니다: \(error.localizedDescription)")
            }
        }
    }




}







import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    private let locationManager = CLLocationManager()
    var location: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    func start() {
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first, self.location == nil else { return }
        self.location = location

        // 위치 정보 업데이트 확인 로그
        print("위치 정보 업데이트: \(location.coordinate.latitude), \(location.coordinate.longitude)")

        // 위치 정보 바인딩
        WeatherViewModel.shared.fetchLocation(for: location)
    }

}

