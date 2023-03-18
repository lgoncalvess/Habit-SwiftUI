//
//  HabitDetailView.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 11/02/23.
//

import SwiftUI

struct HabitDetailView: View {
    @ObservedObject var viewModel: HabitDetailViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(viewModel: HabitDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 12) {
                Text(viewModel.name)
                    .foregroundColor(Color.orange)
                    .font(.title.bold())
                
                Text("Unidade: \(viewModel.label)")
            }
            
            VStack {
                TextField("Escreva aqui o valor conquistado", text: $viewModel.value)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.plain)
                    .keyboardType(.numberPad)
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }
            .padding(.horizontal,32)
            
            Text("Os registros devem ser feito em até 24h. \nHábitos se constroem diariamente :)")
            
            LoadingButtonView(action: {
                viewModel.save()
            }, disabled: self.viewModel.value.isEmpty, showProgress: self.viewModel.uiState == .loading, text: "Salvar")
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            Button("Cancelar") {
                self.presentationMode.wrappedValue.dismiss()
            }
            .modifier(ButtonStyle())
            .padding(.horizontal, 16)
            
            Spacer()
        }
        .padding(.horizontal, 8)
        .padding(.top, 32)
//        .onAppear {
//            viewModel.$uiState.sink { uiState in
//                if uiState == .success {
//                    self.presentationMode.wrappedValue.dismiss()
//                }
//            }.store(in: &viewModel.cancellables)
//        }
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailView(viewModel: HabitDetailViewModel(id: 1, name: "leo", label: "name", interactor: HabitDetailInteractor()))
    }
}
