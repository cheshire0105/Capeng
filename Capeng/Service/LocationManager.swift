//
//  LocationManager.swift
//  Capeng
//
//  Created by cheshire on 1/24/24.
//

import Foundation
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


