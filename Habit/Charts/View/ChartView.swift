//
//  ChartView.swift
//  Habit
//
//  Created by Tiago Aguiar on 12/07/21.
//

import SwiftUI
import Charts

struct ChartView: View {
  
  @ObservedObject var viewModel: ChartVieModel
  
  var body: some View {
    BoxChartView(entries: $viewModel.entries, dates: $viewModel.dates)
      .frame(maxWidth: .infinity, maxHeight: 350)
  }
}

struct ChartView_Previews: PreviewProvider {
  static var previews: some View {
    ChartView(viewModel: ChartVieModel())
  }
}
