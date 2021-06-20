//
//  Vibrations.swift
//  Hangman Game
//
//  Created by Benjamin Clarke on 20/06/2021.
//  Copyright © 2021 Ben Clarke. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation

enum Vibration {
      case error
      case success
      case warning
      case light
      case medium
      case heavy
      @available(iOS 13.0, *)
      case soft
      @available(iOS 13.0, *)
      case rigid
      case selection
      case oldSchool

      public func vibrate() {
          switch self {
          case .error:
              UINotificationFeedbackGenerator().notificationOccurred(.error)
          case .success:
              UINotificationFeedbackGenerator().notificationOccurred(.success)
          case .warning:
              UINotificationFeedbackGenerator().notificationOccurred(.warning)
          case .light:
              UIImpactFeedbackGenerator(style: .light).impactOccurred()
          case .medium:
              UIImpactFeedbackGenerator(style: .medium).impactOccurred()
          case .heavy:
              UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
          case .soft:
              if #available(iOS 13.0, *) {
                  UIImpactFeedbackGenerator(style: .soft).impactOccurred()
              }
          case .rigid:
              if #available(iOS 13.0, *) {
                  UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
              }
          case .selection:
              UISelectionFeedbackGenerator().selectionChanged()
          case .oldSchool:
              AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
          }
      }
  }

