//
//  Color+.swift
//  GoogleStyleUI
//
//  Created by SwiftMan on 2023/01/18.
//

import SwiftUI

extension Color {
  
#if os(macOS)
  public static let background = Color(NSColor.windowBackgroundColor)
  public static let secondaryBackground = Color(NSColor.underPageBackgroundColor)
  public static let tertiaryBackground = Color(NSColor.controlBackgroundColor)
#else
  public static let background = Color(UIColor.systemBackground)
  public static let secondaryBackground = Color(UIColor.secondarySystemBackground)
  public static let tertiaryBackground = Color(UIColor.tertiarySystemBackground)
#endif
}
