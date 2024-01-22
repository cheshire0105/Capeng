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
