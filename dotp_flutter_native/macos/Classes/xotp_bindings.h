// Append to dotp.h

enum Digest {
  SHA1 = 1,
  SHA256 = 2,
  SHA512 = 3,
};
typedef uint8_t Digest;

uint32_t get_current_totp_from_utf8(const char *secret, Digest digest);

uint32_t get_current_totp_from_base32(const char *secret, Digest digest);
