//
//  RecipeDetailView.swift
//  Capeng
//
//  Created by cheshire on 1/24/24.
//

import Foundation
import SwiftUI
import CoreData


struct RecipeDetailView: View {

    @Environment(\.managedObjectContext) private var viewContext


    @State private var recipeName: String = ""
    @State private var coffeeName: String = ""
    @State private var coffeeAmount: String = ""
    @State private var waterAmount: String = ""
    @State private var waterTemperature: String = ""
    @State private var roasting: String = ""
    @State private var grindSize: String = ""
    @State private var dripper: String = ""

    @State private var navigateToTimer = false
    var recipe: Recipe? // 기존 레시피를 수정하는 경우 사용할 수 있습니다.



    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {

                Spacer()

                CustomTextField(
                    placeholder: "Enter the recipe name",
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
                    placeholder: "Name of the coffee beans",
                    text: $coffeeName,
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
                    placeholder: "Amount of coffee beans (g)",
                    text: $coffeeAmount,
                    placeholderColor: UIColor(Color("placeholderColor")),
                    textColor: UIColor(Color("recipeTextColor")), // 텍스트 색상 지정
                    keyboardType: .numberPad // 숫자 키보드 지정

                )
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
                .padding(.horizontal)
                



                CustomTextField(
                    placeholder: "Amount of water (ml)",
                    text: $waterAmount,
                    placeholderColor: UIColor(Color("placeholderColor")),
                    textColor: UIColor(Color("recipeTextColor")), // 텍스트 색상 지정
                    keyboardType: .numberPad // 숫자 키보드 지정

                )
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
                .padding(.horizontal)



                CustomTextField(
                    placeholder: "Water temperature (°C)",
                    text: $waterTemperature,
                    placeholderColor: UIColor(Color("placeholderColor")),
                    textColor: UIColor(Color("recipeTextColor")), // 텍스트 색상 지정
                    keyboardType: .numberPad // 숫자 키보드 지정

                )
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
                .padding(.horizontal)

                CustomTextField(
                    placeholder: "Type of roasting",
                    text: $roasting,
                    placeholderColor: UIColor(Color("placeholderColor")),
                    textColor: UIColor(Color("recipeTextColor")) // 텍스트 색상 지정
                )
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
                .padding(.horizontal)
                CustomTextField(
                    placeholder: "Grind size",
                    text: $grindSize,
                    placeholderColor: UIColor(Color("placeholderColor")),
                    textColor: UIColor(Color("recipeTextColor")) // 텍스트 색상 지정
                )
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
                .padding(.horizontal)
                CustomTextField(
                    placeholder: "Type of dripper",
                    text: $dripper,
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
            Button("Save") {
                     addRecipe()
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

    private func addRecipe() {
        let newRecipe = Recipe(context: viewContext)
        newRecipe.recipeName = recipeName
        newRecipe.coffeeName = coffeeName
        newRecipe.coffeeAmount = Double(coffeeAmount) ?? 0
        newRecipe.waterAmount = Double(waterAmount) ?? 0
        newRecipe.waterTemperature = Double(waterTemperature) ?? 0
        newRecipe.roasting = roasting
        newRecipe.grindSize = grindSize
        newRecipe.dripper = dripper

        // 디버깅을 위해 저장되는 정보 출력
        print("Saving new recipe with the following details:")
        print("Recipe Name: \(newRecipe.recipeName ?? "N/A")")
        print("Coffee Name: \(newRecipe.coffeeName ?? "N/A")")
        print("Coffee Amount: \(newRecipe.coffeeAmount)")
        print("Water Amount: \(newRecipe.waterAmount)")
        print("Water Temperature: \(newRecipe.waterTemperature)")
        print("Roasting: \(newRecipe.roasting ?? "N/A")")
        print("Grind Size: \(newRecipe.grindSize ?? "N/A")")
        print("Dripper: \(newRecipe.dripper ?? "N/A")")

        do {
            try viewContext.save()
            print("Recipe saved successfully.")
        } catch {
            // 오류 처리와 함께 오류 메시지 출력
            print("Failed to save recipe: \(error.localizedDescription)")
        }
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
    var keyboardType: UIKeyboardType = .default

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
        textField.textColor = textColor
        textField.keyboardType = keyboardType
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CustomTextField

        init(_ textField: CustomTextField) {
            self.parent = textField
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
    }
}




// 키보드 숨기기
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
