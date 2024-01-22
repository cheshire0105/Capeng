//
//  WeatherView.swift
//  Capeng
//
//  Created by cheshire on 1/20/24.
//

import Foundation
import SwiftUI

struct WeatherView: View {
    // 현재 날짜를 저장하는 프로퍼티
    @State private var currentDate = Date()
    @ObservedObject private var weatherViewModel = WeatherViewModel()

    init(weatherViewModel: WeatherViewModel = WeatherViewModel()) {
        self.weatherViewModel = weatherViewModel
    }
    var body: some View {
        ZStack {
            Color("BackGroundColor").edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading) {
                Text(currentFormattedDate()) // 고정된 날짜 표시
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("TextColorSet"))
                    .padding(.horizontal)
                    .padding(.top)
                    .padding(.leading)

                ScrollView {
                    VStack(alignment: .leading) {
                        HStack{
                            WeatherCardView(viewModel: weatherViewModel)
                            CoffeeRecommendationCardView(viewModel: weatherViewModel)

                        }

                        CardView(title: "오늘의 커피 추천", content: "오늘은 어떤 커피를 마실까요?")
                        CardView(title: "오늘의 명언", content: "하루를 시작하는 좋은 말.")
                    }
                    .padding()
                }
            }
        }
    }

    private func currentFormattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        return formatter.string(from: currentDate)
    }
}

struct CardView: View {
    var title: String
    var content: String

    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.white)
            .frame(height: 100)
            .shadow(color: Color.black.opacity(0.3), radius: 10)
            .overlay(
                VStack {
                    Text(title)
                        .font(.headline)
                        .padding(.top)
                        .foregroundColor(.black)

                    Text(content)
                        .font(.body)
                        .padding(.bottom)
                        .foregroundColor(.black)

                }
            )
            .padding([.horizontal, .bottom])
    }
}

struct CoffeeRecommendationCardView: View {
    @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
        // 그라데이션 색상 정의
        let gradient = LinearGradient(
            gradient: Gradient(colors: [Color(hex: "#602B06"), Color(hex: "#602B06").opacity(0.7)]),
            startPoint: .top,
            endPoint: .bottom
        )

        return RoundedRectangle(cornerRadius: 20)
            .fill(gradient) // 그라데이션 적용
            .frame(width: 150, height: 200)
            .shadow(color: Color.black.opacity(0.3), radius: 10)
            .overlay(
                VStack(alignment: .leading) {
                    Text("오늘의 커피")
                        .fontWeight(.medium) // 굵기 조정
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)

                    Text(viewModel.coffeeRecommendationMessage)
                        .font(.body)
                        .padding()
                }
                    .foregroundColor(.white) // 텍스트 색상 변경
            )
            .padding([.horizontal, .bottom])
    }
}

// Color 확장을 통해 HEX 색상 코드 처리
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue:  Double(b) / 255, opacity: Double(a) / 255)
    }
}



struct WeatherCardView: View {
    @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(viewModel.cardBackgroundGradient) // 그라데이션 배경색 사용
            .frame(width: 150, height: 200)
            .shadow(color: Color.black.opacity(0.3), radius: 10)
            .overlay(
                VStack(alignment: .leading) {
                    // 지역 이름
                    if let cityName = viewModel.weatherData?.cityName {
                        Text(cityName)
                            .font(.title2) // 폰트 크기 조정
                            .fontWeight(.medium) // 굵기 조정
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom)
                    }

                    // 온도
                    Text("\(Int(viewModel.weatherData?.temperature ?? 0))°C")
                        .font(.largeTitle) // 폰트 크기 조정
                        .fontWeight(.bold) // 굵기 조정
                        .frame(maxWidth: .infinity, alignment: .leading)

                    // 습도
                    Text("\(Int(viewModel.weatherData?.humidity ?? 0))%")
                        .font(.largeTitle) // 폰트 크기 조정
                        .fontWeight(.bold) // 굵기 조정
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                    .foregroundColor(.white)
                    .padding()
            )
            .padding([.horizontal, .bottom])
    }
}





struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weatherViewModel: WeatherViewModel(isPreview: true))
    }
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




class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherData?
    private var locationManager = LocationManager()
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

        return LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .top, endPoint: .bottom)
    }


    init(isPreview: Bool = false) {
        self.isPreview = isPreview
        if isPreview {
            // 프리뷰를 위한 고정된 위치 정보 사용
            let fixedLocation = CLLocation(latitude: 37.5665, longitude: 126.9780) // 서울의 위도와 경도
            self.fetchWeatherData(for: fixedLocation)
        } else {
            locationManager.weatherViewModel = self
            locationManager.startUpdatingLocation()
        }
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




import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var currentLocation: CLLocation?
    var weatherViewModel: WeatherViewModel? // WeatherViewModel 참조 추가


    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() // 앱 사용 중에만 위치 정보 사용 요청
    }

    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        currentLocation = location
        print("현재 위치: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        manager.stopUpdatingLocation()

        // WeatherViewModel의 fetchWeatherData 호출
        weatherViewModel?.fetchWeatherData()
    }



    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("위치 정보를 가져오는데 실패했습니다: \(error.localizedDescription)")
    }
}
