//
//  Spinner.swift
//  Evento
//
//  Created by Sovorn on 12/4/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit

class Spinner {
    internal static var spinner: UIActivityIndicatorView?
    
    public static var style: UIActivityIndicatorView.Style = .whiteLarge
    public static var baseBackColor = UIColor(white: 0, alpha: 0.6)
    public static var baseColor = UIColor.mainColor()
    
    public static func start(style: UIActivityIndicatorView.Style = style, backColor: UIColor = baseBackColor, baseColor: UIColor = baseColor) {
        if spinner == nil, let window = UIApplication.shared.keyWindow {
            let frame = UIScreen.main.bounds
            spinner = UIActivityIndicatorView(frame: frame)
            spinner!.backgroundColor = backColor
            spinner!.style = style
            spinner?.color = baseColor
            window.addSubview(spinner!)
            spinner!.startAnimating()
        }
    }
    
    public static func stop() {
        if spinner != nil {
            spinner!.stopAnimating()
            spinner!.removeFromSuperview()
            spinner = nil
        }
    }
    
    public static func update() {
        if spinner != nil {
            stop()
            start()
        }
    }
}
