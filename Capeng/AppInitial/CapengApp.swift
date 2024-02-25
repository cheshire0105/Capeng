//
//  CapengApp.swift
//  Capeng
//
//  Created by cheshire on 1/18/24.
//

import SwiftUI

@main
struct CapengApp: App {
    let persistenceController = PersistenceController.shared
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
                MainView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext) // 메인 뷰에 managedObjectContext 주입
            }
        }
    }
}
