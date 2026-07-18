import Testing

@testable import HTTP_Cookies

extension HTTPCookies {
    @Suite
    struct Tests {
        @Suite
        struct Unit {
            @Test
            func `raw cookie header`() throws(HTTPCookies.EncodingPolicy.Error) {
                let cookie = HTTPCookies.Cookie(name: "session", value: .init(string: "abc123"))
                #expect(try cookie.headerValue() == "session=abc123")
            }

            @Test
            func `session cookie attributes`() throws(HTTPCookies.EncodingPolicy.Error) {
                let cookie = HTTPCookies.SetCookie(
                    name: "session",
                    value: .init(token: "abc123"),
                    configuration: .init(maxAge: 604_800, path: "/")
                )
                #expect(try cookie.headerValue() == "session=abc123; Max-Age=604800; Path=/; Secure; HttpOnly; SameSite=Lax")
            }
        }

        @Suite
        struct `Edge Case` {
            @Test
            func `raw policy rejects separators`() {
                #expect(throws: HTTPCookies.EncodingPolicy.Error.invalidCharacter(";")) {
                    try HTTPCookies.Value(string: "a;b").encoded()
                }
            }

            @Test
            func `percent encoding round trips`() throws(HTTPCookies.EncodingPolicy.Error) {
                let value = HTTPCookies.Value(string: "hello world/✓")
                let encoded = try value.encoded(using: .percentEncoded)
                #expect(encoded == "hello%20world/%E2%9C%93")
                #expect(try HTTPCookies.Value(string: encoded).decoded(using: .percentEncoded).string == value.string)
            }
        }

        @Suite
        struct Integration {
            @Test
            func `all response attributes serialize in wire order`() throws(HTTPCookies.EncodingPolicy.Error) {
                let cookie = HTTPCookies.SetCookie(
                    name: "id",
                    value: .init(string: "1"),
                    configuration: .init(
                        expires: "Wed, 21 Oct 2015 07:28:00 GMT",
                        maxAge: 0,
                        domain: "example.com",
                        path: "/account",
                        isSecure: false,
                        isHTTPOnly: false,
                        sameSitePolicy: .strict
                    )
                )
                #expect(try cookie.headerValue() == "id=1; Expires=Wed, 21 Oct 2015 07:28:00 GMT; Max-Age=0; Domain=example.com; Path=/account; SameSite=Strict")
            }
        }
    }
}
