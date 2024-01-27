//
//  RecipeTimerView.swift
//  Capeng
//
//  Created by cheshire on 1/24/24.
//

import Foundation
import SwiftUI

struct RecipeTimerView: View {
    @State private var timers = [TimerData(title: "First Extraction", secondsElapsed: 0, timerRunning: false),
                                 TimerData(title: "Blooming", secondsElapsed: 0, timerRunning: false)]
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
                        title: Text("Add Timer"),
                        buttons: [
                            .default(Text("Blooming")) { addBloomingTimer() },
                                                        .default(Text("Additional Extraction")) { addExtractionTimer() },
                            .cancel()
                        ]
                    )
                }
                
            }
            .padding([.horizontal, .bottom])
        }
        .background(Color("BackGroundColor").edgesIgnoringSafeArea(.all))
        .navigationBarItems(trailing: Button("Complete Extraction") {
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
         timers.append(TimerData(title: "Blooming", secondsElapsed: 0, timerRunning: false))
     }

    func addExtractionTimer() {
        let nextExtractionNumber = getNextExtractionNumber()
        timers.append(TimerData(title: "\(ordinalString(from: nextExtractionNumber)) Extraction", secondsElapsed: 0, timerRunning: false))
    }

    func getNextExtractionNumber() -> Int {
        let extractionTimers = timers.filter { $0.title.contains("Extraction") }
        let lastNumber = extractionTimers.compactMap { timer -> Int? in
            let parts = timer.title.split(separator: " ")
            if parts.count > 1, let ordinal = parts.first {
                return ordinalNumber(from: ordinal)
            }
            return nil
        }.max() ?? 0
        return lastNumber + 1
    }

    func ordinalString(from number: Int) -> String {
        switch number {
        case 1: return "First"
        case 2: return "Second"
        case 3: return "Third"
        default: return "\(number)th"
        }
    }

    func ordinalNumber(from ordinal: Substring) -> Int? {
        switch ordinal {
        case "First": return 1
        case "Second": return 2
        case "Third": return 3
        default: return Int(ordinal.dropLast(2)) // "4th", "5th", etc.
        }
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
                Spacer()
                Button("Start") {
                    timerData.startTimer()
                }
                .disabled(timerData.timerRunning)

                Spacer()

                Button("Stop") {
                    timerData.stopTimer()
                }
                .disabled(!timerData.timerRunning)

                Spacer()

                Button("Reset") {
                    timerData.resetTimer()
                }

                Spacer()
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


