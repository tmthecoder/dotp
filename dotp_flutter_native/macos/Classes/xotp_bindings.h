// Append to dotp.h

typedef struct HOTP HOTP;

typedef struct TOTP TOTP;

typedef struct ParseError ParseError;

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
