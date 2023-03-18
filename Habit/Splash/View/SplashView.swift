//
//  SplashView.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 27/01/23.
//

import SwiftUI

struct SplashView: View {
    @ObservedObject var viewModel: SplasViewModel
    var body: some View {
        Group {
            switch viewModel.uiState {
            case .loading:
                loadingView()
            case .goToHomeScreen:
                viewModel.homeView()
            case .goToSignInScreen:
                viewModel.sigInView()
            case .error(let msg):
                loadingView(error: msg)
            }
        }
        .onAppear(perform: {
            viewModel.onApper()
        })
    }
}

extension SplashView {
    func loadingView(error: String? = nil) -> some View {
        ZStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
                .ignoresSafeArea()
            
            if let error = error {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Habit"), message: Text(error), dismissButton: .default(Text("Ok")){
                            //nada
                        })
                    }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SplasViewModel(interactor: SplashViewInteractor())
        SplashView(viewModel: viewModel).preferredColorScheme(.dark)
    }
}
