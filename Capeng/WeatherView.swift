//
//  WeatherView.swift
//  Capeng
//
//  Created by cheshire on 1/20/24.
//

import Foundation
import SwiftUI

struct WeatherView: View {
    var body: some View {
        ZStack {
            Color("BackGroundColor").edgesIgnoringSafeArea(.all) // 배경색
            Text("날씨 정보") // 실제 컨텐츠
        }
    }
}
