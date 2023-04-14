//
//  BoxChartView.swift
//  Habit
//
//  Created by Tiago Aguiar on 14/07/21.
//

import SwiftUI
import Charts

struct BoxChartView: UIViewRepresentable {
  typealias UIViewType = LineChartView
  
  @Binding var entries: [ChartDataEntry]
  @Binding var dates: [String]
  
  func makeUIView(context: Context) -> LineChartView {
    let uiView = LineChartView()
    
    uiView.legend.enabled = false
    uiView.chartDescription?.enabled = false
    uiView.xAxis.granularity = 1
    uiView.xAxis.labelPosition = .bottom
    uiView.rightAxis.enabled = false
    uiView.leftAxis.axisLineColor = .orange
    uiView.animate(yAxisDuration: 1.0)
    
    uiView.data = addData()
    
    return uiView
  }
  
  private func addData() -> LineChartData {
    let colors = [UIColor.white.cgColor, UIColor.orange.cgColor]
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let colorLocations: [CGFloat] = [0.0, 1.0]
        
    guard let gradient = CGGradient(colorsSpace: colorSpace,
               colors: colors as CFArray,
               locations: colorLocations)
    else { return LineChartData(dataSet: nil) }
    
    let dataSet = LineChartDataSet(entries: entries, label: "")
    
    dataSet.mode = .cubicBezier
    dataSet.lineWidth = 2
    dataSet.circleRadius = 4
    dataSet.setColor(.orange)
    dataSet.circleColors = [.red]
    dataSet.drawFilledEnabled = true
    dataSet.valueColors = [.red]
    dataSet.drawHorizontalHighlightIndicatorEnabled = false
    dataSet.fill = Fill(linearGradient: gradient, angle: 90.0)
    
    return LineChartData(dataSet: dataSet)
  }
  
  func updateUIView(_ uiView: LineChartView, context: Context) {
    
  }
  
}

struct BoxChartView_Previews: PreviewProvider {
  static var previews: some View {
    BoxChartView(entries: .constant([
      ChartDataEntry(x: 1.0, y: 2.0),
      ChartDataEntry(x: 2.0, y: 4.0),
      ChartDataEntry(x: 3.0, y: 3.0),
    ]), dates: .constant([
      "01/01/2021",
      "02/01/2021",
      "03/01/2021"
    ]))
    .frame(maxWidth: .infinity, maxHeight: 350)
  }
}
