//
//  UIScrollView.swift
//  airbnb
//
//  Created by JB on 2021/05/28.
//

import UIKit

public enum ScrollDirection {
    case top
    case center
    case bottom
}

extension UIScrollView {
    func scroll(to direction: ScrollDirection) {

            DispatchQueue.main.async {
                switch direction {
                case .top:
                    self.scrollToTop()
                case .center:
                    self.scrollToCenter()
                case .bottom:
                    self.scrollToBottom()
                }
            }
        }

        private func scrollToTop() {
            setContentOffset(.zero, animated: true)
        }

        private func scrollToCenter() {
            let centerOffset = CGPoint(x: 0, y: 150)
            setContentOffset(centerOffset, animated: true)
        }

        private func scrollToBottom() {
            let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
            if(bottomOffset.y > 0) {
                setContentOffset(bottomOffset, animated: true)
            }
        }
}
