//
//  CoffeeBeanCard.swift
//  Capeng
//
//  Created by cheshire on 1/24/24.
//

import Foundation
import SwiftUI

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
                .cornerRadius(20)

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
