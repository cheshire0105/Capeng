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


class TimerData: ObservableObject {
    var title: String
    @Published var secondsElapsed: Int
    @Published var timerRunning: Bool

    private var timer: Timer?

    init(title: String, secondsElapsed: Int, timerRunning: Bool) {
        self.title = title
        self.secondsElapsed = secondsElapsed
        self.timerRunning = timerRunning
    }

    func startTimer() {
        timerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.secondsElapsed += 1
        }
    }

    func stopTimer() {
        timerRunning = false
        timer?.invalidate()
        timer = nil
    }

    func resetTimer() {
        stopTimer()
        secondsElapsed = 0
    }
}

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "RecipeModel") 
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
