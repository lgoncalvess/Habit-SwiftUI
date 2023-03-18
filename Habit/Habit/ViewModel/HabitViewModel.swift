//
//  HabitViewModel.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 08/02/23.
//

import Foundation
import Combine
import SwiftUI

class HabitViewModel: ObservableObject {
    @Published var uiState: HabitUIState = .loading
    
    @Published var title = ""
    @Published var headline = ""
    @Published var desc = ""
    
    @Published var opened = false
    
    private var cancellable: AnyCancellable?
    private let interactor: HabitInteractor
    
    private var cancellableNotify: AnyCancellable?
    private let habitPublisher = PassthroughSubject<Bool, Never>()
    let isCharts: Bool
    
    init(isCharts: Bool, interactor: HabitInteractor) {
        self.isCharts = isCharts
        self.interactor = interactor
        
        cancellableNotify = habitPublisher.sink(receiveValue: { saved in
            print("saved \(saved)")
            self.onApper()
        })
    }
    
    deinit {
        cancellable?.cancel()
        cancellableNotify?.cancel()
    }
    
    func onApper() {
        opened = true
        self.uiState = .loading
        
        cancellable = interactor.fetchHabits()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                case .finished:
                    break
                }
            }, receiveValue: {response in
                if response.isEmpty {
                    self.uiState = .emptyList
                    self.title = " "
                    self.headline = "Fique ligado!"
                    self.desc = "Você ainda não possui hábitos!"
                } else {
                    self.uiState = .fullList(
                        response.map {
                            let lastDate = $0.lastDate?.toDate(sourcePattern: "yyyy-MM-dd'T'HH:mm:ss", destPattern: "dd/MM/yyyy HH:mm") ?? ""
                            
                            var state = Color.green
                            self.title = "Muito bom!"
                            self.headline = "Seus hábitos estão em dia"
                            self.desc = ""
                                                        
                            if $0.lastDate?.toDate(sourcePattern: "yyyy-MM-dd'T'HH:mm:ss") ?? Date() < Date() {
                                state = .red
                                self.headline = "Fique ligado!"
                                self.desc = "Você está atrasado nos hábitos"
                            }
                            
                            
                            return HabitCardViewModel(id: $0.id, icon: $0.iconUrl ?? "", date: lastDate, name: $0.name, label: $0.label, value: "\($0.value ?? 0)", state: state, habitPublisher: self.habitPublisher)
                        }
                    )
                }
            })
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//            var rows: [HabitCardViewModel] = []
//
//            rows.append(HabitCardViewModel(id: 1, icon: "https://via.placeholder.com/150", date: "01/01/2021 00:00:00", name: "Tocar guitarra", label: "horas", value: "2", state: .green))
//
//            rows.append(HabitCardViewModel(id: 2, icon: "https://via.placeholder.com/150", date: "01/01/2021 00:00:00", name: "Caminhar", label: "km", value: "5", state: .green))
//
//            rows.append(HabitCardViewModel(id: 3, icon: "https://via.placeholder.com/150", date: "01/01/2021 00:00:00", name: "Caminhar", label: "km", value: "5", state: .green))
//
//            rows.append(HabitCardViewModel(id: 4, icon: "https://via.placeholder.com/150", date: "01/01/2021 00:00:00", name: "Caminhar", label: "km", value: "5", state: .green))
//
//            rows.append(HabitCardViewModel(id: 5, icon: "https://via.placeholder.com/150", date: "01/01/2021 00:00:00", name: "Caminhar", label: "km", value: "5", state: .green))
//
//            self.uiState = .fullList(rows)
//        })
    }
}
