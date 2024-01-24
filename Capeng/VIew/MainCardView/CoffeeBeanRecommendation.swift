//
//  CoffeeBeanRecommendation.swift
//  Capeng
//
//  Created by cheshire on 1/24/24.
//

import Foundation
import SwiftUI

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


