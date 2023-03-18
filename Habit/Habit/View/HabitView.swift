//
//  HabitView.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 08/02/23.
//

import SwiftUI

struct HabitView: View {
    @ObservedObject var viewModel: HabitViewModel
    var body: some View {
        ZStack {
            if case HabitUIState.loading = viewModel.uiState {
                progress
            } else {
                
                NavigationView {
                    ScrollView(showsIndicators: false, content: {
                        VStack(spacing: 12) {
                            if !viewModel.isCharts {
                                topContainer
                                
                                addButton
                            }
                        
                            if case HabitUIState.emptyList = viewModel.uiState {
                                
                                VStack {
                                    Image(systemName: "exclamationmark.octagon.fill")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 24,height: 24,alignment: Alignment.center)
                                    
                                    Text("Nenhum hábito encontrado :(")
                                }
                                
                            } else if case HabitUIState.fullList(let rows) = viewModel.uiState {
                                LazyVStack {
                                    ForEach(rows) { row in
                                        HabitCardView(isChart: viewModel.isCharts, viewModel: row)
                                    }
                                }
                                .padding(.horizontal, 14)
                                
                            } else if case HabitUIState.error(let msg) = viewModel.uiState {
                                Text("")
                                    .alert(isPresented: .constant(true)) {
                                        Alert(title: Text("Ops! \(msg)"),
                                              message: Text("Tentar novamente? "),
                                              primaryButton: .default(Text("Sim")){
                                            viewModel.onApper()
                                        },
                                              secondaryButton: .cancel(Text("Não")))
                                    }
                            }
                        }
                    })
                    .navigationTitle("Meus hábitos")
                }
            }
        }
        .onAppear{
            if !viewModel.opened {
                viewModel.onApper()
            }
        }
    }
}

extension HabitView {
    var topContainer: some View {
        VStack(alignment: .center, spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            
            Text(viewModel.title)
                .font(Font.system(.title).bold())
                .foregroundColor(Color.orange)
            
            Text(viewModel.headline)
                .font(Font.system(.title3).bold())
                .foregroundColor(Color("textColor"))
            
            Text(viewModel.desc)
                .font(Font.system(.subheadline).bold())
                .foregroundColor(Color("textColor"))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.gray, lineWidth: 1)
        )
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
    
}

extension HabitView {
    var progress: some View {
        ProgressView()
    }
}

extension HabitView {
    var addButton: some View {
        NavigationLink(destination: Text("Tela de adicionar").frame(maxWidth: .infinity, maxHeight: .infinity), label: {
            Label("Criar hábito", systemImage: "plus.app")
                .modifier(ButtonStyle())
        })
        .padding(Edge.Set.horizontal, 16) //.horizontal meaning Edge.Set.horizontal
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView(viewModel: HabitViewModel(isCharts: true, interactor: HabitInteractor()))
    }
}
