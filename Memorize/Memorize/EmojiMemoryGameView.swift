//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Helder on 08/21/2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    @State var emojiTheme = "vehicles"
    @State var emojiCount = 8
    
    var body: some View {
        VStack {
            Text(EmojiMemoryGame.theme.name)
                .font(.largeTitle)
                .padding(.vertical)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(game.cards) { card in
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(game.cards[0].color)
            Spacer()
            HStack {
                Text("Score: \(game.score)")
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
            game.newGame()
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
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: 12)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * 0.8)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
    }
}
