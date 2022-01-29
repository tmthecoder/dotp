// Append to dotp.h

typedef HOTP HOTP;

typedef TOTP TOTP;

typedef ParseError ParseError;

typedef enum OTPResult_Tag {
  ParsedHOTP,
  ParsedTOTP,
  Error,
} OTPResult_Tag;

typedef struct ParsedHOTP_Body {
  const HOTP *_0;
  uint64_t _1;
} ParsedHOTP_Body;

typedef struct OTPResult {
  OTPResult_Tag tag;
  union {
    ParsedHOTP_Body parsed_hotp;
    struct {
      const TOTP *parsed_totp;
    };
    struct {
      const ParseError *error;
    };
  };
} OTPResult;

const struct OTPResult *get_otp_from_uri(const char *uri);

uint32_t hotp_get_otp(const HOTP *hotp, uint64_t counter);

uint32_t totp_get_otp(const TOTP *totp);
