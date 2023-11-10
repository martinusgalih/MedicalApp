// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "FontConvertible.Font", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias Font = FontConvertible.Font

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length
// swiftlint:disable implicit_return

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
internal enum FontFamily {
  internal enum Gilroy {
    internal static let extraBold = FontConvertible(name: "Gilroy-ExtraBold", family: "Gilroy", path: "Gilroy-ExtraBold.otf")
    internal static let light = FontConvertible(name: "Gilroy-Light", family: "Gilroy", path: "Gilroy-Light.otf")
    internal static let all: [FontConvertible] = [extraBold, light]
  }
  internal enum ProximaNova {
    internal static let black = FontConvertible(name: "ProximaNova-Black", family: "Proxima Nova", path: "Proxima Nova Black.otf")
    internal static let bold = FontConvertible(name: "ProximaNova-Bold", family: "Proxima Nova", path: "Proxima Nova Bold.otf")
    internal static let extrabold = FontConvertible(name: "ProximaNova-Extrabld", family: "Proxima Nova", path: "Proxima Nova Extrabold.otf")
    internal static let regular = FontConvertible(name: "ProximaNova-Regular", family: "Proxima Nova", path: "Proxima Nova Regular.otf")
    internal static let thin = FontConvertible(name: "ProximaNovaT-Thin", family: "Proxima Nova", path: "Proxima Nova Thin.otf")
    internal static let all: [FontConvertible] = [black, bold, extrabold, regular, thin]
  }
  internal enum ProximaNovaAlt {
    internal static let bold = FontConvertible(name: "ProximaNovaA-Bold", family: "Proxima Nova Alt", path: "Proxima Nova Alt Bold.otf")
    internal static let light = FontConvertible(name: "ProximaNovaA-Light", family: "Proxima Nova Alt", path: "Proxima Nova Alt Light.otf")
    internal static let thin = FontConvertible(name: "ProximaNovaA-Thin", family: "Proxima Nova Alt", path: "Proxima Nova Alt Thin.otf")
    internal static let all: [FontConvertible] = [bold, light, thin]
  }
  internal static let allCustomFonts: [FontConvertible] = [Gilroy.all, ProximaNova.all, ProximaNovaAlt.all].flatMap { $0 }
  internal static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal struct FontConvertible {
  internal let name: String
  internal let family: String
  internal let path: String

  #if os(macOS)
  internal typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Font = UIFont
  #endif

  internal func font(size: CGFloat) -> Font! {
    return Font(font: self, size: size)
  }

  internal func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    return BundleToken.bundle.url(forResource: path, withExtension: nil)
  }
}

internal extension FontConvertible.Font {
  convenience init?(font: FontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(macOS)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
