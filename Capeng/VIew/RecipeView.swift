//
//  RecipeView.swift
//  Capeng
//
//  Created by cheshire on 1/20/24.
//

import Foundation
import SwiftUI

struct RecipeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackGroundColor").edgesIgnoringSafeArea(.all)

                // 오른쪽 상단의 네비게이션 버튼
                VStack {
                    HStack {
                        Spacer() // 왼쪽의 내용과 오른쪽 버튼 사이의 공간을 만듦

                        NavigationLink(destination: RecipeDetailView()) {
                            Image(systemName: "plus") // 아이콘 이미지 (예: 'plus')
                                .padding()
                                .background(Circle().fill(Color.white)) // 원형 배경
                        }
                        .padding(.trailing)
                        .shadow(color: Color.black.opacity(0.1), radius: 10)

                    }
                    Spacer() // 상단의 내용과 나머지 뷰 사이의 공간을 만듦
                }
            }
        }
    }
}

import SwiftUI

struct RecipeDetailView: View {
    @State private var recipeName: String = ""
    @State private var coffeeName: String = ""
    @State private var coffeeAmount: String = ""
    @State private var waterAmount: String = ""
    @State private var waterTemperature: String = ""
    @State private var roasting: String = ""
    @State private var grindSize: String = ""
    @State private var dripper: String = ""

    @State private var navigateToTimer = false


    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {

                Spacer()

                CustomTextField(
                    placeholder: "레시피 이름을 정해주세요!",
                    text: $recipeName,
                    placeholderColor: UIColor(Color("placeholderColor")),
                    textColor: UIColor(Color("recipeTextColor")) // 텍스트 색상 지정
                )
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
                .padding(.horizontal)

                // 원두 이름 입력
                CustomTextField(
                    placeholder: "원두 이름",
                    text: $recipeName,
                    placeholderColor: UIColor(Color("placeholderColor")),
                    textColor: UIColor(Color("recipeTextColor")) // 텍스트 색상 지정
                )
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
                .padding(.horizontal)

                // 원두 용량 입력
                CustomTextField(
                    placeholder: "원두 용량 (g)",
                    text: $recipeName,
                    placeholderColor: UIColor(Color("placeholderColor")),
                    textColor: UIColor(Color("recipeTextColor")) // 텍스트 색상 지정
                )
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
                .padding(.horizontal)



                CustomTextField(
                    placeholder: "물 용량 (ml)",
                    text: $recipeName,
                    placeholderColor: UIColor(Color("placeholderColor")),
                    textColor: UIColor(Color("recipeTextColor")) // 텍스트 색상 지정
                )
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
                .padding(.horizontal)



                CustomTextField(
                    placeholder: "물 온도 (°C)",
                    text: $recipeName,
                    placeholderColor: UIColor(Color("placeholderColor")),
                    textColor: UIColor(Color("recipeTextColor")) // 텍스트 색상 지정
                )
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
                .padding(.horizontal)

                CustomTextField(
                    placeholder: "로스팅",
                    text: $recipeName,
                    placeholderColor: UIColor(Color("placeholderColor")),
                    textColor: UIColor(Color("recipeTextColor")) // 텍스트 색상 지정
                )
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
                .padding(.horizontal)
                CustomTextField(
                    placeholder: "분쇄도",
                    text: $recipeName,
                    placeholderColor: UIColor(Color("placeholderColor")),
                    textColor: UIColor(Color("recipeTextColor")) // 텍스트 색상 지정
                )
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
                .padding(.horizontal)
                CustomTextField(
                    placeholder: "드리퍼",
                    text: $recipeName,
                    placeholderColor: UIColor(Color("placeholderColor")),
                    textColor: UIColor(Color("recipeTextColor")) // 텍스트 색상 지정
                )
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
                .padding(.horizontal)


                // 타이머 네비게이션 링크 (타이머 버튼 대신 사용)
                NavigationLink(destination: RecipeTimerView(), isActive: $navigateToTimer) {
                    EmptyView()
                }
            }
        }
        .background(Color("BackGroundColor").edgesIgnoringSafeArea(.all))
        .onTapGesture {
            self.hideKeyboard()
        }
        .navigationBarItems(trailing: Button(action: {
            self.navigateToTimer = true
        }) {
            Image(systemName: "timer") // 타이머 아이콘
        })
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView()
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
    }
}

// SwiftUI 뷰 내에서 사용할 수 있도록 UIKit의 UITextField를 래핑
// 텍스트 필드 커스텀
struct CustomTextField: UIViewRepresentable {
    var placeholder: String
    @Binding var text: String
    var placeholderColor: UIColor
    var textColor: UIColor

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
        textField.textColor = textColor
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
}


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

struct ExtractionCompletedView: View {
    let totalTime: Int
    @State private var extractionVolume: String = ""
    @State private var coffeeTasteNotes: String = ""

    var body: some View {
        ZStack {
            Color("BackGroundColor").edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 20) {
                    CardView {
                        VStack {
                            Text("커피가 완성 되었습니다!")
                                .font(.title)
                                .foregroundColor(Color("TextColorSet")) // 여기서 텍스트 색상을 변경

                            Text("추출 시간은 \(timeString(from: totalTime)) 입니다.")
                                .font(.title3)
                                .foregroundColor(Color("TextColorSet")) // 여기서 텍스트 색상을 변경
                        }
                        .padding()
                    }


                    CardView {
                        CustomTextField(
                            placeholder: "추출 완료 용량 (ml)",
                            text: $extractionVolume,
                            placeholderColor: UIColor(Color("placeholderColor")),
                            textColor: UIColor(Color("recipeTextColor")) // 텍스트 색상 지정
                        )
                        .padding()
                    }

                    CardView {
                        CustomTextField(
                            placeholder: "어떤 커피였나요?",
                            text: $coffeeTasteNotes,
                            placeholderColor: UIColor(Color("placeholderColor")),
                            textColor: UIColor(Color("recipeTextColor")) // 텍스트 색상 지정
                        )
                        .padding()
                    }
                }
                .padding()
            }
        }
    }

    func timeString(from totalSeconds: Int) -> String {
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct CardView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack {
            content
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}



struct ExtractionCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        ExtractionCompletedView(totalTime: 13)
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




// 키보드 숨기기
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
