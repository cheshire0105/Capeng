//
//  RecipeTimerView.swift
//  Capeng
//
//  Created by cheshire on 1/24/24.
//

import Foundation
// 타이머 뷰
import SwiftUI

struct RecipeTimerView: View {
    @State private var timers = [TimerData(title: "1차 추출", secondsElapsed: 0, timerRunning: false),
                                 TimerData(title: "뜸 들이기", secondsElapsed: 0, timerRunning: false)]
    @State private var showingActionSheet = false
    @State private var navigateToExtractionCompleted = false
    @State private var totalTime = 0 // 총 추출 시간을 저장하는 상태 변수


    var body: some View {
        ScrollView {
            Spacer()
            VStack(spacing: 20) {
                ForEach(timers.indices, id: \.self) { index in
                    TimerCardView(timerData: timers[index])
                }

                Button(action: {
                    showingActionSheet = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)
                }
                .padding([.top, .leading, .trailing])
                .actionSheet(isPresented: $showingActionSheet) {
                    ActionSheet(
                        title: Text("타이머 추가"),
                        buttons: [
                            .default(Text("뜸 들이기")) { addBloomingTimer() },
                            .default(Text("추가 추출")) { addExtractionTimer() },
                            .cancel()
                        ]
                    )
                }
            }
            .padding([.horizontal, .bottom])
        }
        .background(Color("BackGroundColor").edgesIgnoringSafeArea(.all))
        .navigationBarItems(trailing: Button("추출 완료") {
            totalTime = calculateTotalTime()
            navigateToExtractionCompleted = true
        })
        .background(
            NavigationLink(destination: ExtractionCompletedView(totalTime: totalTime), isActive: $navigateToExtractionCompleted) {
                EmptyView()
            }
        )
    }

    func calculateTotalTime() -> Int {
        timers.reduce(0) { $0 + $1.secondsElapsed }
    }


    func addBloomingTimer() {
        timers.append(TimerData(title: "뜸 들이기", secondsElapsed: 0, timerRunning: false))
    }

    func addExtractionTimer() {
        let nextExtractionNumber = getNextExtractionNumber()
        timers.append(TimerData(title: "\(nextExtractionNumber)차 추출", secondsElapsed: 0, timerRunning: false))
    }

    func getNextExtractionNumber() -> Int {
        let extractionTimers = timers.filter { $0.title.contains("차 추출") }
        let lastNumber = extractionTimers.compactMap { timer -> Int? in
            let parts = timer.title.split(separator: "차")
            return Int(parts.first ?? "")
        }.max() ?? 0
        return lastNumber + 1
    }
}


struct TimerCardView: View {
    @ObservedObject var timerData: TimerData

    var body: some View {
        VStack {
            Text(timerData.title)
                .font(.headline)
                .foregroundColor(Color("CardViewColor"))

            Text(timeString(from: timerData.secondsElapsed))
                .font(.largeTitle)
                .foregroundColor(Color.black)
                .padding()

            HStack {
                Button("시작") {
                    timerData.startTimer()
                }
                .disabled(timerData.timerRunning)

                Button("정지") {
                    timerData.stopTimer()
                }
                .disabled(!timerData.timerRunning)

                Button("리셋") {
                    timerData.resetTimer()
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
    }

    func timeString(from totalSeconds: Int) -> String {
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct RecipeTimerView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTimerView()
    }
}


