//
//  ChartView.swift
//  Habit
//
//  Created by Leonardo Gonçalves on 15/02/23.
//

import SwiftUI
import Charts

struct ChartView: View {
    var body: some View {
        TestView()
            .frame(maxWidth: .infinity, maxHeight: 40)
            .background(Color.red)

    }
}

struct TestView:UIViewRepresentable {
    typealias UIViewType = UILabel
    
    func makeUIView(context: Context) -> UILabel {
        let lb = UILabel()
        lb.backgroundColor = UIColor.red
        lb.text = "olá"
        return lb
    }
        
    func updateUIView(_ uiView: UILabel, context: Context) {
        
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
