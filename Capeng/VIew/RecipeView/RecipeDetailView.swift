//
//  RecipeDetailView.swift
//  Capeng
//
//  Created by cheshire on 1/24/24.
//

import Foundation
import SwiftUI

struct RecipeDetailView: View {
    @State private var recipeName: String = ""
    @State private var coffeeName: String = ""
    @State private var coffeeAmount: String = ""
    @State private var waterAmount: String = ""
    @State private var waterTemperature: String = ""
    @State private var roasting: String = ""
    @State private var grindSize: String = ""
    @State private var dripper: String = ""

    @State private var navigateToTimer = false


    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {

                Spacer()

                CustomTextField(
                    placeholder: "레시피 이름을 정해주세요!",
                    text: $recipeName,
                    placeholderColor: UIColor(Color("placeholderColor")),
                    textColor: UIColor(Color("recipeTextColor")) // 텍스트 색상 지정
                )
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
                .padding(.horizontal)

                // 원두 이름 입력
                CustomTextField(
                    placeholder: "원두 이름",
                    text: $recipeName,
                    placeholderColor: UIColor(Color("placeholderColor")),
                    textColor: UIColor(Color("recipeTextColor")) // 텍스트 색상 지정
                )
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
                .padding(.horizontal)

                // 원두 용량 입력
                CustomTextField(
                    placeholder: "원두 용량 (g)",
                    text: $recipeName,
                    placeholderColor: UIColor(Color("placeholderColor")),
                    textColor: UIColor(Color("recipeTextColor")) // 텍스트 색상 지정
                )
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
                .padding(.horizontal)



                CustomTextField(
                    placeholder: "물 용량 (ml)",
                    text: $recipeName,
                    placeholderColor: UIColor(Color("placeholderColor")),
                    textColor: UIColor(Color("recipeTextColor")) // 텍스트 색상 지정
                )
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
                .padding(.horizontal)



                CustomTextField(
                    placeholder: "물 온도 (°C)",
                    text: $recipeName,
                    placeholderColor: UIColor(Color("placeholderColor")),
                    textColor: UIColor(Color("recipeTextColor")) // 텍스트 색상 지정
                )
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
                .padding(.horizontal)

                CustomTextField(
                    placeholder: "로스팅",
                    text: $recipeName,
                    placeholderColor: UIColor(Color("placeholderColor")),
                    textColor: UIColor(Color("recipeTextColor")) // 텍스트 색상 지정
                )
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
                .padding(.horizontal)
                CustomTextField(
                    placeholder: "분쇄도",
                    text: $recipeName,
                    placeholderColor: UIColor(Color("placeholderColor")),
                    textColor: UIColor(Color("recipeTextColor")) // 텍스트 색상 지정
                )
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
                .padding(.horizontal)
                CustomTextField(
                    placeholder: "드리퍼",
                    text: $recipeName,
                    placeholderColor: UIColor(Color("placeholderColor")),
                    textColor: UIColor(Color("recipeTextColor")) // 텍스트 색상 지정
                )
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
                .padding(.horizontal)


                // 타이머 네비게이션 링크 (타이머 버튼 대신 사용)
                NavigationLink(destination: RecipeTimerView(), isActive: $navigateToTimer) {
                    EmptyView()
                }
            }
        }
        .background(Color("BackGroundColor").edgesIgnoringSafeArea(.all))
        .onTapGesture {
            self.hideKeyboard()
        }
        .navigationBarItems(trailing: Button(action: {
            self.navigateToTimer = true
        }) {
            Image(systemName: "timer") // 타이머 아이콘
        })
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView()
    }
}


// SwiftUI 뷰 내에서 사용할 수 있도록 UIKit의 UITextField를 래핑
// 텍스트 필드 커스텀
struct CustomTextField: UIViewRepresentable {
    var placeholder: String
    @Binding var text: String
    var placeholderColor: UIColor
    var textColor: UIColor

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
        textField.textColor = textColor
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
}



// 키보드 숨기기
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
