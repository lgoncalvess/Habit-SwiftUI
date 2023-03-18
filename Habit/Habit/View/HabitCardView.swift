//
//  HabitCardView.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 09/02/23.
//

import SwiftUI
import Combine

struct HabitCardView: View {
    let isChart: Bool
    let viewModel: HabitCardViewModel
    var body: some View {
        ZStack(alignment: .trailing) {
            if isChart {
                NavigationLink(destination: viewModel.chartView(), label: {
                    HStack {
                        Spacer()
                        ImageView(url: viewModel.icon)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 32, height: 32)
                            .clipped()
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(viewModel.name)
                                    .foregroundColor(Color.orange)
                                
                                Text(viewModel.label)
                                    .foregroundColor(Color("textColor"))
                                    .bold()
                                
                                Text(viewModel.date)
                                    .foregroundColor(Color("textColor"))
                                    .bold()
                            }
                            .frame(maxWidth: 300, alignment: .leading)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Resgistrado")
                                    .foregroundColor(Color.orange)
                                    .bold()
                                    .multilineTextAlignment(.leading)
                                
                                Text(viewModel.value)
                                    .foregroundColor(Color("textColor"))
                                    .bold()
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }
                    .padding()
                    .cornerRadius(4)
                })
            } else {
                NavigationLink(destination: viewModel.habitDetailView(), label: {
                    HStack {
                        Spacer()
                        ImageView(url: viewModel.icon)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 32, height: 32)
                            .clipped()
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(viewModel.name)
                                    .foregroundColor(Color.orange)
                                
                                Text(viewModel.label)
                                    .foregroundColor(Color("textColor"))
                                    .bold()
                                
                                Text(viewModel.date)
                                    .foregroundColor(Color("textColor"))
                                    .bold()
                            }
                            .frame(maxWidth: 300, alignment: .leading)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Resgistrado")
                                    .foregroundColor(Color.orange)
                                    .bold()
                                    .multilineTextAlignment(.leading)
                                
                                Text(viewModel.value)
                                    .foregroundColor(Color("textColor"))
                                    .bold()
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }
                    .padding()
                    .cornerRadius(4)
                })
            }
            
            if !isChart {
                Rectangle()
                    .frame(width: 8)
                    .foregroundColor(viewModel.state)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 4)
                .stroke(.orange, lineWidth: 1.4)
                .shadow(color: .gray, radius: 2, x: 2, y: 2)
        )
        .padding(.horizontal, 4)
        .padding(.vertical, 8)
    }
}

struct HabitCardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                HabitCardView(isChart: false, viewModel: HabitCardViewModel(id: 1, icon: "https://via.placeholder.com/150", date: "01/01/2021 00:00:00", name: "Tocar guitarra", label: "horas", value: "2", state: .green, habitPublisher: PassthroughSubject<Bool, Never>()))
                
                HabitCardView(isChart: false,viewModel: HabitCardViewModel(id: 2, icon: "https://via.placeholder.com/150", date: "01/01/2021 00:00:00", name: "Tocar guitarra", label: "horas", value: "2", state: .green, habitPublisher: PassthroughSubject<Bool, Never>()))
            }
            .listStyle(.inset)
            .frame(maxWidth: .infinity)
            .navigationTitle("teste")
            
            
        }
        .preferredColorScheme(.light)
    }
}
