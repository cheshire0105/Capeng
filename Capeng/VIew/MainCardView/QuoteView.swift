//
//  QuoteView.swift
//  Capeng
//
//  Created by cheshire on 1/24/24.
//

import Foundation
import SwiftUI

struct QuoteView: View {
    @ObservedObject var viewModel: QuoteViewModel

    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [Color("QuoteColor"), Color("QuoteColor").opacity(0.7)]),
                    startPoint: .bottomLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(height: 150)
            .shadow(color: Color.black.opacity(0.3), radius: 10)
            .overlay(
                VStack(alignment: .leading) { // VStack을 왼쪽 정렬로 설정
                    Text("오늘의 명언")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading) // 텍스트를 왼쪽 정렬
                        .padding(.leading)
                        .padding(.top)
                    Text(viewModel.advice)
                        .font(.body)
                        .padding()
                        .multilineTextAlignment(.center)
                }
                    .foregroundColor(.white)
            )
            .padding([.horizontal, .bottom])
    }
}
