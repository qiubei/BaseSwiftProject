//
//  UI+Ex.swift
//  FlowtimeUI
//
//  Created by Anonymous on 2019/4/9.
//  Copyright © 2019 Hangzhou Enter Electronic Technology Co., Ltd. All rights reserved.
//

import UIKit

extension UIColor {
    static func random() -> UIColor {
        let randomR = CGFloat(arc4random() % 255) / 255.0
        let randomG = CGFloat(arc4random() % 255) / 255.0
        let randomB = CGFloat(arc4random() % 255) / 255.0

        return UIColor(displayP3Red: randomR, green: randomG, blue: randomB, alpha: 1.0)
    }

    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}


extension UIFont {
    private func withTraits(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        let descriptor = self.fontDescriptor
            .withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits))
        return UIFont(descriptor: descriptor!, size: 0)
    }

    func boldItalic() -> UIFont {
        return withTraits([.traitBold, .traitItalic])
    }
}

extension UILabel {
    func setLine(space: CGFloat) {
        guard let txt = self.text else { return }
        let attributeString = NSMutableAttributedString(string: txt)
        let attributeStyle = NSMutableParagraphStyle()
        attributeStyle.lineSpacing = space
        attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: attributeStyle, range:NSMakeRange(0, attributeString.length))
        self.attributedText = attributeString
        self.sizeToFit()
    }

    func setWord(space: CGFloat) {
        guard let txt = self.text else { return }
        let attributeString = NSMutableAttributedString(string: txt, attributes: [NSAttributedString.Key.kern: space])
        let attributeStyle = NSMutableParagraphStyle()
        attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: attributeStyle, range: NSRange(location: 0, length: attributeString.length))
        self.attributedText = attributeString
        self.sizeToFit()
    }

    func setSapce(_ lineSpace: CGFloat, wordSpace: CGFloat) {
        self.setLine(space: lineSpace)
        self.setWord(space: wordSpace)
    }
}

extension UIView: TapScalable  {
    private struct AccociatedKeys {
        static var tapGesture = "IDONTKONWWHATISTHIS"
    }

    private var napAction: EmptyBlock? {
        set {
            objc_setAssociatedObject(self,
                                     &AccociatedKeys.tapGesture,
                                     newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }

        get {
            let action = objc_getAssociatedObject(self, &AccociatedKeys.tapGesture) as? EmptyBlock

            return action
        }
    }

    func tapAction(block: @escaping EmptyBlock) {
        self.napAction = block
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapHandle(_:)))
        self.addGestureRecognizer(tapGesture)
    }

    func longPressAction(block: @escaping EmptyBlock) {
        self.napAction = block
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressHandle(_:)))
        longPressGesture.minimumPressDuration = 0.8
        self.addGestureRecognizer(longPressGesture)
    }

    func tapAndLongPressAction(block: @escaping EmptyBlock) {
        self.tapAction(block: block)
        self.longPressAction(block: block)
    }

    @objc
    private func tapHandle(_ gesture: UITapGestureRecognizer) {
        if let view = gesture.view {
            view.tapped()

            let state = gesture.state
            switch state {
            case .ended:
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    self.napAction?()
                }
            default:
                break
            }
        }
    }

    @objc
    private func longPressHandle(_ gesture: UILongPressGestureRecognizer) {
        if let view = gesture.view {
            let state = gesture.state

            switch state {
            case .began:
                view.scale()
            case .ended:
                view.restore {
                    self.napAction?()
                }
            default: break
            }
        }
    }
}

extension UIAlertController {
    func present(in viewController: UIViewController? = nil, _ completion: (() -> Void)? = nil) {

        if UIDevice.current.userInterfaceIdiom == .pad && self.preferredStyle == .actionSheet {
            let popPresenter = self.popoverPresentationController;
            popPresenter?.permittedArrowDirections = .down
            popPresenter?.sourceView = self.view;
            popPresenter?.sourceRect = CGRect(x: self.view.bounds.width/2, y: self.view.bounds.height, width: 0, height: 0)
        }
        let mainWindow = UIApplication.shared.delegate!.window!
        (viewController ??
            mainWindow?.rootViewController)?.present(self, animated: true, completion: completion)
    }
}


extension UIView {
    func setLayerColors(_ colors: [CGColor]) {
        let layer = CAGradientLayer()
        layer.frame = bounds
        layer.colors = colors
        layer.startPoint = CGPoint(x: 0.0, y: 0.0)
        layer.endPoint = CGPoint(x: 1.0, y: 0.0)
        self.layer.addSublayer(layer)
    }
    
    func snapshotImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let snapshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snapshotImage
    }
}


extension UIScrollView {
    
    var capture: UIImage? {
        
        var image: UIImage? = nil
        UIGraphicsBeginImageContext(self.contentSize)
        do {
            let savedContentOffset = self.contentOffset
            let savedFrame = self.frame
            self.contentOffset = .zero
            self.frame = CGRect(x: 0, y: 0, width: self.contentSize.width, height: self.contentSize.height)
            
            UIGraphicsBeginImageContextWithOptions(CGSize(width: self.contentSize.width, height: self.contentSize.height), false, 0.0)
            
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            image = UIGraphicsGetImageFromCurrentImageContext()
            self.contentOffset = savedContentOffset
            self.frame = savedFrame
        }
        UIGraphicsEndImageContext()
        if let img = image {
            return img
        }
        return nil
    }
}

extension UIImage {
    func mergeImage(other: UIImage) -> UIImage {
        let width = self.size.width
        let height = self.size.height + other.size.height
        let resultSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(resultSize)
        
        let oneRect = CGRect(x: 0, y: 0, width: width, height: other.size.height)
        other.draw(in: oneRect)
        
        let twoRect = CGRect(x: 0, y: other.size.height, width: width, height: self.size.height)
        self.draw(in: twoRect)
        
        let rtImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return rtImage
        
    }
    
    
    func saveImage(imageName: String) -> String {
        let directory = NSHomeDirectory().appending("/Documents/")
        if !FileManager.default.fileExists(atPath: directory) {
            do {
                try FileManager.default.createDirectory(at: NSURL.fileURL(withPath: directory), withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error)
            }
        }
        let filePath = directory.appending(imageName)
        let url = NSURL.fileURL(withPath: filePath.appending(".jpeg"))
        do {
            //try self.jpegData(compressionQuality: 1.0)?.write(to: url, options: .atomic)
            let jpegFile = self.jpegData(compressionQuality: 1.0)
            try jpegFile?.write(to: url)
            return url.absoluteString
        } catch {
            print(error)
            return ""
        }
    }
    
    class func loadImage(imageName: String) -> UIImage {
        let directory = NSHomeDirectory().appending("/Documents/")
        let filePath = directory.appending(imageName)
        let url = NSURL.fileURL(withPath: filePath.appending(".jpeg"))
        let urlStr = url.path
        
        if FileManager.default.fileExists(atPath: urlStr) {
            return UIImage(contentsOfFile: urlStr)!
        }
        return #imageLiteral(resourceName: "img_yoga")
    }
}

extension UIView {
    func addRounderCorner(corners: UIRectCorner, radius: CGSize) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: radius)
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        self.layer.mask = shape
    }
}
