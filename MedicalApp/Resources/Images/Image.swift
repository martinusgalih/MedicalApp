// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen
import UIKit

enum ImageAsset {
    enum Image: String {
        case iconArrowRight = "icon_arrow_right"
        case iconBuilding = "icon_building"
        case iconCCircle = "icon_c_circle"
        case iconClose = "icon_close"
        case iconDashiconsMenu = "icon_dashicons_menu"
        case iconDotRed = "icon_dot_red"
        case iconFacebook = "icon_facebook"
        case iconFilter = "icon_filter"
        case iconInstagram = "icon_instagram"
        case iconLocation = "icon_location"
        case iconNotification = "icon_notification"
        case iconSearch = "icon_search"
        case iconShoppingCart = "icon_shopping_cart"
        case iconStar = "icon_star"
        case iconTwitter = "icon_twitter"
        case illustrationBanner = "illustration_banner"
        case illustrationDate = "illustration_date"
        case illustrationDummyProfile = "illustration_dummy_profile"
        case illustrationFooter = "illustration_footer"
        case illustrationMagnifier = "illustration_magnifier"
        case illustrationMedicine = "illustration_medicine"
        case illustrationProductDummy = "illustration_product_dummy"
        case illustrationProductDummy1 = "illustration_product_dummy1"
        case illustrationProductDummy2 = "illustration_product_dummy2"

        var image: UIImage {
            UIImage(named: self.rawValue)!
        }
        var name: String {
            self.rawValue
        } 
    }
}