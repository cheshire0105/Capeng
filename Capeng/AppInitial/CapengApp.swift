//
//  CapengApp.swift
//  Capeng
//
//  Created by cheshire on 1/18/24.
//

import SwiftUI

@main
struct CapengApp: App {
    @State private var isShowingLaunchScreen = true

    var body: some Scene {
        WindowGroup {
            if isShowingLaunchScreen {
                LaunchScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // 3초 후에
                            isShowingLaunchScreen = false // 런칭 화면을 숨김
                        }
                    }
            } else {
                MainView() // 메인 화면으로 전환
            }
        }
    }
}

