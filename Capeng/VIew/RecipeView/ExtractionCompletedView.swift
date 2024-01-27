//
//  ExtractionCompletedView.swift
//  Capeng
//
//  Created by cheshire on 1/24/24.
//

import Foundation
import SwiftUI
import PhotosUI // 사진 라이브러리 접근을 위해 필요

struct ExtractionCompletedView: View {

    let totalTime: Int
    @State private var extractionVolume: String = ""
    @State private var coffeeTasteNotes: String = ""
    @State private var isImagePickerPresented: Bool = false // 이미지 피커 상태
    @State private var selectedImage: UIImage? // 선택된 이미지

    var body: some View {
        ZStack {
            Color("BackGroundColor").edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 20) {
                    CardView {
                        VStack {
                            Text("Coffee is ready!")
                                .font(.title)
                                .foregroundColor(Color("TextColorSet"))

                            Text("Extraction time : \(timeString(from: totalTime))")
                                .font(.title3)
                                .foregroundColor(Color("TextColorSet"))
                        }
                        .padding()
                        .frame(maxWidth: .infinity) // 텍스트 필드와 같은 가로 크기로 설정



                        Image("penguincamera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .cornerRadius(14) // 모서리 둥글기

                    }
                    .padding()
                }




                CustomTextField(
                    placeholder: "Final extraction volume (ml)",
                    text: $extractionVolume,
                    placeholderColor: UIColor(Color("placeholderColor")),
                    textColor: UIColor(Color("recipeTextColor"))
                )
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
                .padding(.horizontal)

                CustomTextField(
                    placeholder: "How was the coffee?",
                    text: $coffeeTasteNotes,
                    placeholderColor: UIColor(Color("placeholderColor")),
                    textColor: UIColor(Color("recipeTextColor"))
                )
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
                .padding(.horizontal)
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
