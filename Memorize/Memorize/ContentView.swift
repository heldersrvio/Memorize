//
//  ContentView.swift
//  Memorize
//
//  Created by Helder on 08/21/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var vehicleEmojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛴", "🚲", "🛵", "🏍", "🛺", "🚔", "✈️", "🛫", "🛬", "🛩", "🚆", "🚂", "🚅", "🚡", "🚠"]
    var flagEmojis = ["🇰🇭", "🇨🇱", "🇭🇰", "🇪🇺", "🇷🇼", "🇰🇷", "🇳🇱", "🇲🇷", "🇲🇦", "🇳🇴", "🇱🇻", "🇱🇧", "🇲🇼", "🇲🇨", "🇲🇸", "🇲🇺", "🇱🇷", "🇯🇵"
    ]
    var animalEmojis = ["🐥", "🪲", "🦞", "🦕", "🐙", "🐮", "🐷", "🐡", "🐊", "🦈", "🦧", "🐄", "🦙", "🐓", "🦚", "🐿", "🦥"
    ]
    @State var emojiTheme = "vehicles"
    @State var emojiCount = 8
    
    var body: some View {
        VStack {
            Text("Memorize!")
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
//                remove
//                Spacer()
//                add
                chooseVehicles
                Spacer()
                chooseFlags
                Spacer()
                chooseAnimals
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    var remove: some View {
        Button {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
        }
    }
    var add: some View {
        Button {
            let emojis = emojiTheme == "vehicles" ? vehicleEmojis : emojiTheme == "flags" ? flagEmojis : animalEmojis
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        } label: {
            Image(systemName: "plus.circle")
        }
    }
    var chooseVehicles: some View {
        Button {
            emojiTheme = "vehicles"
            emojiCount = 12
        } label: {
            VStack {
                Image(systemName: "car.fill")
                Text("Vehicles")
            }.padding(.vertical)
        }.font(.subheadline)
    }
    var chooseFlags: some View {
        Button {
            emojiTheme = "flags"
            emojiCount = 10
        } label: {
            VStack {
                Image(systemName: "flag.fill")
                Text("Flags")
            }.padding(.vertical)
        }.font(.subheadline)
    }
    var chooseAnimals: some View {
        Button {
            emojiTheme = "animals"
            emojiCount = 8
        } label: {
            VStack {
                Image(systemName: "ladybug.fill")
                Text("Animals")
            }.padding(.vertical)
        }.font(.subheadline)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 12)
                Text(card.content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
    }
}
