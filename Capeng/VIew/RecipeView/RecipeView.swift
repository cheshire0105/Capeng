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


struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
    }
}













