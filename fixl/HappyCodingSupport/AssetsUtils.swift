#if os(OSX)
    typealias Image     = NSImage
    typealias ImageName = NSImage.Name
#elseif os(iOS)
    import UIKit

    typealias Image     = UIImage
    typealias ImageName = String
#endif

extension Image {
    static var assetsAppicon: Image { return Image(named: ImageName("AppIcon"))! }
    static var assetsFirst: Image { return Image(named: ImageName("first"))! }
    static var assetsSecond: Image { return Image(named: ImageName("second"))! }
    static var assetsSfBiglad: Image { return Image(named: ImageName("SF_BIGLAD"))! }
    static var assetsSfChevronRightSquareFill: Image { return Image(named: ImageName("SF_chevron_right_square_fill"))! }
    static var assetsSfChevronRightSquareFill1: Image { return Image(named: ImageName("SF_chevron_right_square_fill-1"))! }
    static var assetsSfDollarsignCircle: Image { return Image(named: ImageName("SF_dollarsign_circle"))! }
    static var assetsSfWrench: Image { return Image(named: ImageName("SF_wrench"))! }
}