//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Helder on 08/22/2021.
//

import SwiftUI



class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static let vehicleTheme = Theme(name: "vehicles", emojis: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛴", "🚲", "🛵", "🏍", "🛺", "🚔", "✈️", "🛫", "🛬", "🛩", "🚆", "🚂", "🚅", "🚡", "🚠"], numberOfPairs: 5, color: Color.red)
    private static let flagTheme = Theme(name: "flags", emojis: ["🇰🇭", "🇨🇱", "🇭🇰", "🇪🇺", "🇷🇼", "🇰🇷", "🇳🇱", "🇲🇷", "🇲🇦", "🇳🇴", "🇱🇻", "🇱🇧", "🇲🇼", "🇲🇨", "🇲🇸", "🇲🇺", "🇱🇷", "🇯🇵"
    ], numberOfPairs: 3, color: Color.blue)
    private static let animalTheme = Theme(name: "animals",emojis: ["🐥", "🪲", "🦞", "🦕", "🐙", "🐮", "🐷", "🐡", "🐊", "🦈", "🦧", "🐄", "🦙", "🐓", "🦚", "🐿", "🦥"
    ], numberOfPairs: 4, color: Color.green)
    private static let landscapeTheme = Theme(name: "landscape", emojis: ["🗿", "🗽", "🗼", "🏰", "🏯", "🎢", "🗻", "🏩", "🕍", "🌅", "🗾", "🌉", "🏙"], numberOfPairs: 4, color: Color.orange)
    private static let facesTheme = Theme(name: "faces", emojis: ["😊", "🙂", "🙃", "😔", "😞", "😖", "😰", "🤬", "😶‍🌫️", "🤕", "🤐", "😷", "🤮", "🤐", "🤥", "😓", "🥵"], numberOfPairs: 3, color: Color.yellow)
    private static let objectsTheme = Theme(name: "objects", emojis: ["🧰", "🪛", "⏱", "🧯", "🏺", "🧫", "🪣", "📫", "📒", "📍", "🔍", "🔮", "🛢", "💵", "🎥", "📱", "💈", "🗝", "☎️", "🕯"], numberOfPairs: 5, color: Color.gray)
    private static let themes = [vehicleTheme, flagTheme, animalTheme, landscapeTheme, facesTheme, objectsTheme]
    
    static var theme: Theme!
    
    private static let emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛴", "🚲", "🛵", "🏍", "🛺", "🚔", "✈️", "🛫", "🛬", "🛩", "🚆", "🚂", "🚅", "🚡", "🚠"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        theme = themes.shuffled()[0]
        let shuffledEmojis = theme.emojis.shuffled()
        
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs <= theme.emojis.count / 2 ? theme.numberOfPairs : theme.emojis.count / 2, color: theme.color) { pairIndex in
            shuffledEmojis[pairIndex]
        }
    }
    
    @Published private(set) var model: MemoryGame<String> = createMemoryGame()
        
    
    var cards: [Card] {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
