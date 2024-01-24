//
//  ExtractionCompletedView.swift
//  Capeng
//
//  Created by cheshire on 1/24/24.
//

import Foundation
import SwiftUI

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
