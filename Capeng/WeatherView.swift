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

                        CoffeeBeanRecommendation(viewModel: weatherViewModel) // 수정됨
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

struct CoffeeBeanRecommendation: View {
    @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
        TabView {
            ForEach(viewModel.recommendedCoffeeBeans, id: \.origin) { coffeeBean in
                CoffeeBeanCard(coffeeBean: coffeeBean)
                    .frame(width: 300, height: 200) // 카드 크기 지정
                    .foregroundColor(Color("TextColorSet"))
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.3), radius: 10)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // 인디케이터 제거
        .frame(height: 240) // TabView 높이 지정
    }
}



struct CoffeeBeanCard: View {
    var coffeeBean: CoffeeBean

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("날씨와 원두")
                    .padding(.bottom)
                Text(coffeeBean.origin)
                    .font(.title)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(coffeeBean.type)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(coffeeBean.description)
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            Spacer() // 텍스트와 이미지 사이의 간격을 조정

            Image(coffeeBean.imageName) // 이미지 파일명을 사용하여 이미지 표시
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120) // 이미지 크기 조정
        }
        .padding()
        .frame(width: 300, height: 200)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("CardViewColor"), Color.gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.3), radius: 10)
        .foregroundColor(.white)
    }
}






struct CoffeeRecommendationCardView: View {
    @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
        // 그라데이션 색상 정의
        let gradient = LinearGradient(
            gradient: Gradient(colors: [Color(hex: "#602B06"), Color(hex: "#602B06").opacity(0.5)]),
            startPoint: .leading,
            endPoint: .trailing
        )

        return RoundedRectangle(cornerRadius: 20)
            .fill(gradient) // 그라데이션 적용
            .frame(width: 150, height: 200)
            .shadow(color: Color.black.opacity(0.5), radius: 10)
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
            .fill(viewModel.cardBackgroundGradient) // 커스텀 그라디언트 사용
            .frame(width: 150, height: 200)
            .shadow(color: Color.black.opacity(0.3), radius: 10)
            .overlay(
                VStack(alignment: .leading) {
                    if let cityName = viewModel.weatherData?.cityName {
                        Text(cityName)
                            .font(.title2)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom)
                    }

                    Text("\(Int(viewModel.weatherData?.temperature ?? 0))°C")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("\(Int(viewModel.weatherData?.humidity ?? 0))%")
                        .font(.largeTitle)
                        .fontWeight(.bold)
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
                CoffeeBean(origin: "인도네시아", type: "만델링", description: "흙 내음과 무거운 몸매", imageName: "indonesiaCoffee")
            ]
        default:
            return [
                CoffeeBean(origin: "베트남", type: "로부스타", description: "강한 바디감과 떫은 맛", imageName: "vietnamCoffee"),
                CoffeeBean(origin: "인도", type: "몬순", description: "독특한 맛과 향의 조화", imageName: "indiaCoffee"),
                CoffeeBean(origin: "하와이", type: "코나", description: "부드러운 몸매와 감미로운 맛", imageName: "hawaiiCoffee"),
                CoffeeBean(origin: "자메이카", type: "블루마운틴", description: "매끄러운 몸매와 깔끔한 마무리", imageName: "jamaicaCoffee")
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


struct CoffeeBean {
    var origin: String
    var type: String
    var description: String
    var imageName: String // 이미지 파일명을 저장하는 속성
}
