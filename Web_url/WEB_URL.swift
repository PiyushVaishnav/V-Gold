//
//  WEB_URL.swift
//  gold
//
//  Created by Akash Padhiyar on 3/19/18.
//  Copyright © 2018 Akash Padhiyar. All rights reserved.
//

import UIKit

class WEB_URL: UIViewController {

    static var main_url = "http://localhost/IOS/Api-admin/"
    static var SCROLL_URL = main_url + "scroll-list.php"
    static var IMAGE_URL = "http://localhost/IOS/Api-admin/"
    static var CATEGORY_URL = main_url + "category-list.php"
    static var SUBCATEGORY_URL = main_url + "subcategory-list.php?catid="
    static var PRODUCT_URL = main_url + "product-list.php?scatid="
    static var PROIMAGE_URL = ""
    static var PRODUCTIMAGE_URL = main_url + "product-image.php?pid="
    static var DETAIL_URL = main_url + "product-list.php?pid="
    static var SINGUP_URL = main_url + "signup-user.php"
    static var TRYHOME_URL = main_url + "tryathome-insert.php"
    static var TRYHOMEDETAIL_URL = main_url + "tryathome-update.php"
    static var ORDERINSER_URL = main_url + "order-insert.php"
    static var ORDERDESPLAY_URL = main_url + "order-display.php"
    static var ORDERCANCEL_URL = main_url + "order-cancel.php?cart_id="
    static var LOGIN_URL = main_url + "login.php"
    static var FORGET_URL = main_url + "ForgotPasswordAPI.php"
}

