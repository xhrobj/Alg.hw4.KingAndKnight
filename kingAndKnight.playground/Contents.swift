func printMask(_ mask: UInt64, with symbol: String = "*") {
    var mask = mask
    var maskStr = Array(repeating: "0", count: 64)
    var i = 0
    while mask > 0 {
        maskStr[i] = (String(mask % 2))
        i += 1
        mask /= 2
    }
    
    var line = ""
    for i in 0..<64 {
        if i % 8 == 0 {
            print(line)
            line = ""
        }
        line += maskStr[i] == "1" ? symbol : "."
    }
    print(line, "\n")
}

func getMask(for index: Int) -> UInt64 {
    1 << index
}

func getKingBitboardMoves(for index: Int) -> UInt64 {
    let k = getMask(for: index)
    let noA: UInt64 = 0xfefefefefefefefe
    let noH: UInt64 = 0x7f7f7f7f7f7f7f7f
    let kA = k & noA
    let kH = k & noH
    return kA >> 9 | k >> 8 | kH >> 7 |
           kA >> 1 |          kH << 1 |
           kA << 7 | k << 8 | kH << 9
}

func getKnightBitboardMoves(for index: Int) -> UInt64 {
    let k = getMask(for: index)
    let noA: UInt64 = 0xfefefefefefefefe
    let noAB: UInt64 = 0xFcFcFcFcFcFcFcFc;
    let noH: UInt64 = 0x7f7f7f7f7f7f7f7f
    let noGH: UInt64 = 0x3f3f3f3f3f3f3f3f;
    return noGH & (k <<  6 | k >> 10) |
           noH & (k << 15 | k >> 17) |
           noA & (k << 17 | k >> 15) |
           noAB & (k << 10 | k >>  6)
}

// King

var kingPos = 19
printMask(getMask(for: kingPos), with: "K")
printMask(getKingBitboardMoves(for: kingPos), with: "X")

kingPos = 15
printMask(getMask(for: kingPos), with: "K")
printMask(getKingBitboardMoves(for: kingPos), with: "X")

// Knight

var knightPos = 19
printMask(getMask(for: knightPos), with: "H")
printMask(getKnightBitboardMoves(for: knightPos), with: "X")

knightPos = 14
printMask(getMask(for: knightPos), with: "H")
printMask(getKnightBitboardMoves(for: knightPos), with: "X")
