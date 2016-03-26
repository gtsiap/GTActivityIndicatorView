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

    // MARK: private vars
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        return activityIndicator
    }()

    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: public vars
    public var text: String = "Loading.." {
        didSet {
            self.textLabel.text = self.text
        }
    }

    public var color: UIColor = UIColor.whiteColor() {
        didSet {
            self.textLabel.textColor = self.color
            self.activityIndicator.color = self.color
        }
    }

    public init() {
        super.init(frame: CGRectZero)
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        addSubview(self.activityIndicator)
        addSubview(self.textLabel)

        self.activityIndicator.snp_makeConstraints() { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).multipliedBy(0.7)
        }

        self.textLabel.snp_makeConstraints() { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).multipliedBy(0.8)
        }

        setupDefaults()
    }

    // MARK: funcs

    public func startAnimating() {

        layoutIfNeeded()

        self.layer.zPosition = 1.0
        self.hidden = false

        UIView.animateWithDuration(0.5) {
            self.layoutIfNeeded()
        }

        self.activityIndicator.startAnimating()
    }

    public func stopAnimating() {
        self.activityIndicator.stopAnimating()
        self.hidden = true
    }

    public override func didMoveToSuperview() {
        guard let superview = self.superview else {
            return
        }

        snp_makeConstraints() { make in
            make.centerX.equalTo(superview)
            make.centerY.equalTo(superview).multipliedBy(0.7)
            make.width.equalTo(superview).multipliedBy(0.4)
            make.height.equalTo(superview).multipliedBy(0.2).priorityHigh()
            make.height.equalTo(self.snp_width)
        }
    }

    private func setupDefaults() {
        self.textLabel.text = self.text
        self.textLabel.textColor = UIColor.whiteColor()

        self.alpha = 0.9
        self.backgroundColor = UIColor.blackColor()
        self.layer.cornerRadius = 10.0
        self.hidden = true
    }
}
