//
//  AddSpenderView.swift
//  Spendtrack
//
//  Created by Mugurel Moscaliuc on 11/07/2020.
//

import SwiftUI

struct AddSpenderView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var date: Date = Date()
    @Binding var timeSpan: [Item]
    @State private var name: String = ""
    @State private var amount: String = ""
    @State private var categories: [String] = ["car.fill", "doc.fill", "cross.circle.fill", "airpodspro", "cart.fill", "signpost.right.fill", "creditcard.fill", "books.vertical.fill", "camera.fill", "phone.fill", "bag.fill", "paintbrush.pointed.fill", "bandage.fill", "hammer.fill", "printer.fill", "case.fill", "house.fill", "key.fill", "tv.fill", "iphone.homebutton", "hifispeaker.fill", "guitars.fill", "bus.fill", "tram.fill", "bed.double.fill", "pills.fill", "sportscourt", "photo.fill", "camera.aperture", "shield.lefthalf.fill", "gamecontroller.fill", "paintpalette.fill", "sdcard", "headphones", "gift.fill", "airplane", "banknote.fill", "minus.plus.batteryblock.fill", "lightbulb.fill", "at.circle.fill"]
    @State private var category: String = "cart.fill"
    @State private var itemType: [String] = ItemType.allCases.map { $0.rawValue }
    @State private var selectedType: String = "expense"
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            ScrollView {
                XmarkView()
                NameTextField(name: $name)
                ItemTypePicker(itemType: itemType, selectedType: $selectedType)
                AmountTextField(amount: $amount)
                CategoryPicker(categories: categories, category: $category)
                ItemDatePicker(date: $date)
                SaveButton(timeSpan: $timeSpan, name: name, amount: amount, category: category, date: date, selectedType: selectedType)
                //Spacer()
            }
            .padding()
            .background(AdaptColors.container)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
}





struct XmarkView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 20, height: 20, alignment: .trailing)
                .padding(.all, 30)
                .foregroundColor(Color.init("Adapt Text"))
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
        }
    }
}



struct NameTextField: View {
    
    @Binding var name: String
    
    var body: some View {
        HStack {
            Spacer().frame(width: 20, height: 10, alignment: .center)
            TextField("Name", text: $name)
                .accentColor(AdaptColors.theOrange)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: .black, radius: -4)
                .padding([.top, .bottom], 20)
            Spacer().frame(width: 20, height: 10, alignment: .center)
        }
    }
}



struct ItemTypePicker: View {
    
    var itemType: [String]
    @Binding var selectedType: String
    
    var body: some View {
        Picker(selection: $selectedType, label: Text("")) {
            ForEach(itemType, id: \.self) { type in
                Text(type)
            }
        }.pickerStyle(SegmentedPickerStyle())
    }
    
    
}




struct AmountTextField: View {
    
    @Binding var amount: String
    
    var body: some View {
        HStack {
            Spacer().frame(width: 20, height: 10, alignment: .center)
            TextField("Amount", text: $amount)
                .accentColor(AdaptColors.theOrange)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: .black, radius: -4)
                .padding([.top, .bottom], 20)
            Spacer().frame(width: 20, height: 10, alignment: .center)
        }
    }
    
}



struct CategoryPicker: View {
    
    var categories: [String]
    @Binding var category: String
    @State private var revealDetails: Bool = false
    
    let columns = [
        GridItem(.adaptive(minimum: 50))
    ]
    
    var body: some View {
        HStack {
            DisclosureGroup("Pick a category \(Image(systemName: category))", isExpanded: $revealDetails) {
                Spacer()
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(categories, id: \.self) { item in
                        Image(systemName: item)
                            .foregroundColor(self.category == item ? AdaptColors.theOrange : AdaptColors.adaptText)
                            .onTapGesture {
                                self.category = item
                            }
                    }
                }
            }.accentColor(AdaptColors.theOrange)
            Spacer()
        }
    }
}



struct ItemDatePicker: View {
    
    @Binding var date: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            DatePicker("Pick a date", selection: $date, displayedComponents: .date)
                .accentColor(AdaptColors.theOrange)
                .background(AdaptColors.container)
                .frame(maxHeight: 350)
            Spacer()
        }.background(AdaptColors.container)
    }
    
    
}



struct SaveButton: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var timeSpan: [Item]
    var name: String
    var amount: String
    var category: String
    var date: Date
    var selectedType: String
    
    
    
    var body: some View {
        Button("Save") {
            let item = Item(name: name, amount: Double(amount) ?? 10, category: category, description: "Schimbat distributia", date: date, type: selectedType)
            timeSpan.append(item)
            presentationMode.wrappedValue.dismiss()
        }
        .frame(width: UIScreen.main.bounds.width / 2, height: 50, alignment: .center)
        .background(AdaptColors.theOrange)
        .foregroundColor(AdaptColors.container)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .shadow(radius: 5)
        .padding(.all, 20)
    }
    
    
}
