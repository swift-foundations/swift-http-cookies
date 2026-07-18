extension HTTPCookies {
    /// The `SameSite` attribute policy.
    public enum SameSitePolicy: String, Sendable, Hashable {
        case strict = "Strict"
        case lax = "Lax"
        case none = "None"
    }
}
