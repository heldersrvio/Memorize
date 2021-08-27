//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Helder on 08/22/2021.
//

import SwiftUI



class EmojiMemoryGame: ObservableObject {
    static let vehicleTheme = Theme(name: "vehicles", emojis: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛴", "🚲", "🛵", "🏍", "🛺", "🚔", "✈️", "🛫", "🛬", "🛩", "🚆", "🚂", "🚅", "🚡", "🚠"], numberOfPairs: 5, color: Color.red)
    static let flagTheme = Theme(name: "flags", emojis: ["🇰🇭", "🇨🇱", "🇭🇰", "🇪🇺", "🇷🇼", "🇰🇷", "🇳🇱", "🇲🇷", "🇲🇦", "🇳🇴", "🇱🇻", "🇱🇧", "🇲🇼", "🇲🇨", "🇲🇸", "🇲🇺", "🇱🇷", "🇯🇵"
    ], numberOfPairs: 3, color: Color.blue)
    static let animalTheme = Theme(name: "animals",emojis: ["🐥", "🪲", "🦞", "🦕", "🐙", "🐮", "🐷", "🐡", "🐊", "🦈", "🦧", "🐄", "🦙", "🐓", "🦚", "🐿", "🦥"
    ], numberOfPairs: 4, color: Color.green)
    static let landscapeTheme = Theme(name: "landscape", emojis: ["🗿", "🗽", "🗼", "🏰", "🏯", "🎢", "🗻", "🏩", "🕍", "🌅", "🗾", "🌉", "🏙"], numberOfPairs: 4, color: Color.orange)
    static let facesTheme = Theme(name: "faces", emojis: ["😊", "🙂", "🙃", "😔", "😞", "😖", "😰", "🤬", "😶‍🌫️", "🤕", "🤐", "😷", "🤮", "🤐", "🤥", "😓", "🥵"], numberOfPairs: 3, color: Color.yellow)
    static let objectsTheme = Theme(name: "objects", emojis: ["🧰", "🪛", "⏱", "🧯", "🏺", "🧫", "🪣", "📫", "📒", "📍", "🔍", "🔮", "🛢", "💵", "🎥", "📱", "💈", "🗝", "☎️", "🕯"], numberOfPairs: 5, color: Color.gray)
    static let themes = [vehicleTheme, flagTheme, animalTheme, landscapeTheme, facesTheme, objectsTheme]
    
    static var theme: Theme!
    
    static let emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛴", "🚲", "🛵", "🏍", "🛺", "🚔", "✈️", "🛫", "🛬", "🛩", "🚆", "🚂", "🚅", "🚡", "🚠"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        theme = themes.shuffled()[0]
        let shuffledEmojis = theme.emojis.shuffled()
        
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs <= theme.emojis.count / 2 ? theme.numberOfPairs : theme.emojis.count / 2, color: theme.color) { pairIndex in
            shuffledEmojis[pairIndex]
        }
    }
    
    @Published private(set) var model: MemoryGame<String> = createMemoryGame()
        
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
