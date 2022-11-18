//
//  ContentView.swift
//  YSCalculator
//
//  Created by 葛燕生 on 2022/9/1.
//

import SwiftUI

struct ContentView: View {
  let scale: CGFloat = UIScreen.main.bounds.width / 414
  var body: some View {
    VStack(spacing: 12) {
      Text("0")
        .font(.system(size: 76))
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
      YSCalculatorPad()
    }.scaleEffect(scale)
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
    }
}

struct YSCalculatorButton: View {
  
  let fontSize: CGFloat = 38
  let title: String
  let size: CGSize
  let backgroundColorName: String
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      Text(title)
        .font(.system(size: fontSize))
        .foregroundColor(.white)
        .frame(width: size.width, height: size.height)
        .background(Color(backgroundColorName))
        .cornerRadius(size.width/2.0)
    }
  }
}

enum YSCalculatorButtonItem {
  enum YSOp: String {
    case plus = "➕"
    case minus = "➖"
    case divide = "➗"
    case multiply = "✖️"
    case equal = "="
  }
  
  enum YSCommand: String {
    case clear = "AC"
    case flip = "+/-"
    case percent = "%"
  }
  
  case digit(Int)
  case dot
  case op(YSOp)
  case command(YSCommand)
  
}

extension YSCalculatorButtonItem {
  var title: String {
    switch self {
    case .digit(let value):
      return String(value)
    case .dot:
      return "."
    case .op(let op):
      return op.rawValue
    case .command(let command):
      return command.rawValue
    }
  }
  
  var size: CGSize {
    if case .digit(let value) = self, value == 0 {
      return CGSize(width: 88 * 2 + 8, height: 88)
    }
    return CGSize(width: 88, height: 88)
  }
  
  var backgroundColorName: String {
    switch self {
    case .digit, .dot: return "digitBackground"
    case .op: return "operatorBackground"
    case .command: return "commandBackground"
    }
  }
  
}

extension YSCalculatorButtonItem: Hashable {}

struct YSCalculatorButtonRow: View {
  let row: [YSCalculatorButtonItem]
  var body: some View {
    HStack {
      ForEach(row, id: \.self) { item in
        YSCalculatorButton(title: item.title,
                           size: item.size,
                           backgroundColorName: item.backgroundColorName) {
          print("Button: \(item.title)")
        }
      }
    }
  }
}

struct YSCalculatorPad: View {
  let pad: [[YSCalculatorButtonItem]] = [[.command(.clear), .command(.flip), .command(.percent), .op(.divide)],
                                       [.digit(7), .digit(8), .digit(9), .op(.multiply)],
                                       [.digit(4), .digit(5), .digit(6), .op(.minus)],
                                       [.digit(1), .digit(2), .digit(3), .op(.plus)],
                                       [.digit(0), .dot, .op(.equal)]]
  var body: some View {
    VStack(spacing: 8) {
      ForEach(pad, id: \.self) { row in
        YSCalculatorButtonRow(row: row)
      }
    }
  }
}
