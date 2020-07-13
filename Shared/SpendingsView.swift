//
//  SpendingsView.swift
//  Spendtrack
//
//  Created by Mugurel Moscaliuc on 10/07/2020.
//

import SwiftUI


enum ItemType: String, CaseIterable {
    case expense, income
}


struct Item: Hashable, Identifiable {
    let id = UUID()
    var name: String
    var amount: Double
    var category: String
    var description: String
    var date: Date
    var type: String
}



extension Date {
    
    func shortString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_UK")
        return dateFormatter.string(from: self)
    }
    
}


struct SpendingsView: View {
    
    @EnvironmentObject var viewModel: SpendingVM
    @State var timeSpan: [Item] = []
    @State var showModal: Bool = false
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            SpendingsListView(timeSpan: timeSpan)
            HStack {
                Text("Total: \(String(format: "%.2f", viewModel.total))")
                    .font(.custom("HelveticaNeue-Bold", size: 24))
                    .padding([.leading, .bottom], 20)
                Spacer()
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60, alignment: .center)
                    .foregroundColor(AdaptColors.theOrange)
                    .shadow(radius: 2)
                    .transition(.scale)
                    .padding([.trailing, .bottom], 20)
                    .onTapGesture {
                        showModal.toggle()
                    }
                    .sheet(isPresented: $showModal) {
                        AddSpenderView(timeSpan: $timeSpan).environmentObject(viewModel)
                    }
            }
        }.background(AdaptColors.container)
    }
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor.init(named: "Container")
        UITableView.appearance().backgroundColor = UIColor.init(named: "Container")
    }
    
    
    
}



struct SpendingsListView: View {
    
    var timeSpan: [Item]
    
    
    var body: some View {
        List {
            ForEach(timeSpan.sorted(by: { $0.date.compare($1.date) == .orderedDescending }), id: \.self) { item in
                HStack(spacing: 20) {
                    Label("", systemImage: item.category).font(.largeTitle)
                    VStack(alignment: .leading) {
                        Text("\(item.name)")
                            .font(.custom("HelveticaNeue-Bold", size: 20))
                        Text(item.date.shortString())
                            .font(.custom("HelveticaNeue-Light", size: 14))
                    }
                    Spacer()
                    Text(amountString(item: item))
                        .font(.custom("HelveticaNeue-Bold", size: 20))
                    Spacer().frame(width: 20, height: 80, alignment: .leading)
                }
                .frame(width: UIScreen.main.bounds.width, height: 80, alignment: .leading)
                .shadow(radius: 2)
            }
            .listRowBackground(AdaptColors.container)
        }
    }
    
    
    
    private func amountString(item: Item) -> String {
        switch item.type {
        case "expense": return "- £ \(String(format: "%.2f", item.amount))"
        default: return "+ £ \(String(format: "%.2f", item.amount))"
        }
    }
    
    
}



struct SpendingsView_Previews: PreviewProvider {
    static var previews: some View {
        SpendingsView()
    }
}
