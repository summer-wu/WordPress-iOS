import UIKit

@IBDesignable
class PeopleRoleBadgeView: UILabel {

    // MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        font = WPStyleGuide.People.RoleBadge.font
        textAlignment = .Center
        layer.borderWidth = WPStyleGuide.People.RoleBadge.borderWidth
        layer.cornerRadius = WPStyleGuide.People.RoleBadge.cornerRadius
        layer.masksToBounds = true
    }

    // MARK: Padding

    override func drawTextInRect(rect: CGRect) {
        let padding = WPStyleGuide.People.RoleBadge.padding
        let insets = UIEdgeInsetsMake(0, padding, 0, padding)
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }

    override func intrinsicContentSize() -> CGSize {
        var paddedSize = super.intrinsicContentSize()
        paddedSize.width += 2 * WPStyleGuide.People.RoleBadge.padding
        return paddedSize
    }

    // MARK: Private methods

    private func updateText() {
        let roleText = role.localizedName()
        if pending {
            text = String(format: NSLocalizedString("%@ - pending", comment: "User role indicator, when there's a pending invite. Placeholder is role (e.g. Admin, Editor,...)"), roleText)
        } else {
            text = roleText
        }
    }

    private func updateColor() {
        let baseColor = role.color()
        let alternateColor = WPStyleGuide.People.RoleBadge.textColor

        layer.borderColor = baseColor.CGColor

        if pending {
            textColor = baseColor
            backgroundColor = alternateColor
        } else {
            textColor = alternateColor
            backgroundColor = baseColor
        }
    }

    private func updateView() {
        updateColor()
        updateText()
    }

    // MARK: Inspectable properties

    @IBInspectable var pending: Bool = false {
        didSet {
            updateView()
        }
    }

    // MARK: Public properties

    /**
    Sets the role from Interface Builder

    Since IB doesn't support inspectable enum values, we map an integer to `role`.
    Code should use `role` instead.
    */
    @IBInspectable var roleValue: Int {
        get {
            return role.rawValue
        }
        set {
            role = Role(rawValue: newValue) ?? .Admin
        }
    }

    // MARK: Properties
    var role: Role = .Admin {
        didSet {
            updateView()
        }
    }

    /* If we don't override this, when the view is highlighted (e.g. tapping on
    a PeopleCell), it will lose its background color and look weird */
    override var highlighted: Bool {
        get {
            return super.highlighted
        }
        set {
            super.highlighted = newValue
            updateView()
        }
    }

    // MARK: Custom Types
    enum Role: Int {
        case SuperAdmin = 0
        case Admin = 1
        case Editor = 2
        case Author = 3
        case Contributor = 4

        func color() -> UIColor {
            switch self {
            case .SuperAdmin:
                return WPStyleGuide.People.RoleBadge.superAdminColor
            case .Admin:
                return WPStyleGuide.People.RoleBadge.adminColor
            case .Editor:
                return WPStyleGuide.People.RoleBadge.editorColor
            case .Author:
                return WPStyleGuide.People.RoleBadge.authorColor
            case .Contributor:
                return WPStyleGuide.People.RoleBadge.contributorColor
            }
        }

        func localizedName() -> String {
            switch self {
            case .SuperAdmin:
                return NSLocalizedString("Super Admin", comment: "User role badge")
            case .Admin:
                return NSLocalizedString("Admin", comment: "User role badge")
            case .Editor:
                return NSLocalizedString("Editor", comment: "User role badge")
            case .Author:
                return NSLocalizedString("Author", comment: "User role badge")
            case .Contributor:
                return NSLocalizedString("Contributor", comment: "User role badge")
            }
        }
    }
}
