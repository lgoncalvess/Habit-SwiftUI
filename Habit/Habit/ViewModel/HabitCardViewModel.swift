//
//  HabitCardViewModel.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 09/02/23.
//

import Foundation
import SwiftUI
import Combine

struct HabitCardViewModel: Identifiable, Equatable {
    var id: Int = 0
    var icon: String = ""
    var date: String = ""
    var name: String = ""
    var label: String = ""
    var value: String = ""
    var state: Color = .green
    
    var habitPublisher: PassthroughSubject<Bool, Never>
    
    static func == (lhs: HabitCardViewModel, rhs: HabitCardViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}

extension HabitCardViewModel {
    func habitDetailView() -> some View {
        return HabitCardViewRouter.makeHabitDetailView(id: id, name: label, label: name, habitPublisher: habitPublisher)
    }
    
    func chartView() -> some View {
        return HabitCardViewRouter.makeChartView(id: id)
    }
}
