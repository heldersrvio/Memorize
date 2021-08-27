//
//  ContentView.swift
//  Memorize
//
//  Created by Helder on 08/21/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    @State var emojiTheme = "vehicles"
    @State var emojiCount = 8
    
    var body: some View {
        VStack {
            Text(EmojiMemoryGame.theme.name)
                .font(.largeTitle)
                .padding(.vertical)
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
            .foregroundColor(viewModel.cards[0].color)
            Spacer()
            HStack {
                Text("Score: \(viewModel.score)")
                Spacer()
//                remove
//                Spacer()
//                add
//                chooseVehicles
//                Spacer()
//                chooseFlags
//                Spacer()
//                chooseAnimals
                newGame
            }
            .font(.title2)
            .padding()
        }
        .padding(.horizontal)
    }
    
    var newGame: some View {
        Button {
            viewModel.newGame()
        } label: {
            Text("New Game")
        }
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
            } else if card.isMatched {
                shape.opacity(0)
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
