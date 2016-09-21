// Copyright (c) 2015-2016 Giorgos Tsiapaliokas <giorgos.tsiapaliokas@mykolab.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import SnapKit

public class ActivityIndicatorView: UIView {

    public struct Configuration {
        let text: String
        let textColor: UIColor
        let indicatorColor: UIColor
        let backgroundColor: UIColor
        let cornerRadius: CGFloat
        let alpha: CGFloat

        public init(
            text: String = "Loading",
            textColor: UIColor = UIColor.white,
            indicatorColor: UIColor = UIColor.white,
            backgroundColor: UIColor = UIColor.black,
            cornerRadius: CGFloat = 10.0,
            alpha: CGFloat = 0.9
        ) {
            self.text = text
            self.textColor = textColor
            self.indicatorColor = indicatorColor
            self.backgroundColor = backgroundColor
            self.cornerRadius = cornerRadius
            self.alpha = alpha
        }
    }

    // MARK: private vars
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        return activityIndicator
    }()

    private let configuration: Configuration

    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    public init(configuration: Configuration) {
        self.configuration = configuration
        super.init(frame: CGRect())
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("Missing Implementation")
    }

    private func commonInit() {
        addSubview(self.activityIndicator)
        addSubview(self.textLabel)

        self.activityIndicator.snp.makeConstraints() { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).multipliedBy(0.7)
        }

        self.textLabel.snp.makeConstraints() { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).multipliedBy(0.8)
        }

        setupDefaults()
    }

    // MARK: funcs

    public func startAnimating() {

        layoutIfNeeded()

        self.layer.zPosition = 1.0
        self.isHidden = false

        UIView.animate(withDuration: 0.5, animations: {
            self.layoutIfNeeded()
        }) 

        self.activityIndicator.startAnimating()
    }

    public func stopAnimating() {
        self.activityIndicator.stopAnimating()
        self.isHidden = true
    }

    public override func didMoveToSuperview() {
        guard let superview = self.superview else {
            return
        }

        snp.makeConstraints() { make in
            make.centerX.equalTo(superview)
            make.centerY.equalTo(superview).multipliedBy(0.7)
            make.width.equalTo(superview).multipliedBy(0.4)
            make.height.equalTo(superview).multipliedBy(0.2).priority(UILayoutPriorityDefaultHigh)
            make.height.equalTo(self.snp.width)
        }
    }

    private func setupDefaults() {
        self.textLabel.text = self.configuration.text
        self.textLabel.textColor = self.configuration.textColor

        self.activityIndicator.color = self.configuration.indicatorColor
        self.alpha = self.configuration.alpha
        self.backgroundColor = self.configuration.backgroundColor
        self.layer.cornerRadius = self.configuration.cornerRadius
        self.isHidden = true
    }
}
