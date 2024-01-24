//
//  LaunchScreenView.swift
//  Capeng
//
//  Created by cheshire on 1/22/24.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        VStack {
            ZStack {
                // 네모난 배경 뷰
                Rectangle()
                    .fill(Color("LaunchColor")) // 배경 색상
                    .frame(width: 320, height: 320) // 배경 크기
                    .cornerRadius(30) // 모서리 둥글기

                // 앱 로고 이미지
                Image("AppLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
            }

            // 텍스트 추가
            Text("powered by cheshire")
                .foregroundColor(.gray) // 텍스트 색상
                .padding() // 패딩 추가
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("BackGroundColor"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
