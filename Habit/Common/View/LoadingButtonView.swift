//
//  LoadingButtonView.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 01/02/23.
//

import SwiftUI

struct LoadingButtonView: View {
    var action: () -> Void
    var disabled: Bool = false
    var showProgress: Bool = true
    var text: String
    
    var body: some View {
        ZStack {
            Button(action: {
                action()
            }, label: {
                Text(showProgress ? "" : text)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 16)
                    .font(Font.system(.title3).bold())
                    .background(disabled ? Color("lightOrange") : Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(4.0)
            })
            .disabled(disabled || showProgress)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .opacity(showProgress ? 1 : 0)
        }
    }
}

struct LoadingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingButtonView(action: {print("Hello click")}, disabled: false, text: "Cadastrar")
            .preferredColorScheme(.light)
            .padding()
    }
}
