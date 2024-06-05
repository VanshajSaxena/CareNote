import SwiftUI
import Charts

struct CreatinineData: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}

struct ContentView: View {
    let data: [CreatinineData] = [
        CreatinineData(date: Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 1))!, value: 1.1),
        CreatinineData(date: Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 2))!, value: 1.2),
        CreatinineData(date: Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 3))!, value: 1.5),
        CreatinineData(date: Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 4))!, value: 1.7),
        CreatinineData(date: Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 5))!, value: 2.0),
        // Add more data points here
        CreatinineData(date: Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 28))!, value: 1.3),
        CreatinineData(date: Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 29))!, value: 1.1)
    ]

    var body: some View {
        VStack {
            Text("Creatinine Levels")
                .font(.title)
            Chart(data) { entry in
                LineMark(
                    x: .value("Date", entry.date, unit: .day),
                    y: .value("Creatinine", entry.value)
                )
                .foregroundStyle(.blue)
                .symbol(.circle)
                .lineStyle(.init(lineWidth: 2, lineCap: .round, lineJoin: .round))
            }
            .chartYScale(domain: 0...5)
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
