use std::ffi::CStr;
use std::os::raw::c_char;
use std::time::{SystemTime, UNIX_EPOCH};
use xotp::totp::TOTP;
use xotp::util::MacDigest;

#[repr(u8)]
pub enum Digest {
    SHA1 = 0x1,
    SHA256 = 0x2,
    SHA512 = 0x3
}

#[no_mangle]
pub extern "C" fn get_current_totp_from_utf8(secret: *const c_char, digest: Digest) -> u32 {
    let (mac_digest, time) = get_totp_info(digest);
    TOTP::from_utf8_with_digest(get_str_from_cstr(secret), mac_digest)
        .get_otp(time, 6)
}

#[no_mangle]
pub extern "C" fn get_current_totp_from_base32(secret: *const c_char, digest: Digest) -> u32 {
    let (mac_digest, time) = get_totp_info(digest);
    TOTP::from_base32_with_digest(get_str_from_cstr(secret), mac_digest)
        .get_otp(time, 6)
}

fn get_totp_info(digest: Digest) -> (MacDigest, u64) {
    let time = SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .expect("Failed to get time")
        .as_secs();
    let mac_digest = match digest {
        Digest::SHA1 => MacDigest::SHA1,
        Digest::SHA256 => MacDigest::SHA256,
        Digest::SHA512 => MacDigest::SHA512
    };
    (mac_digest, time)
}

fn get_str_from_cstr(cstr: *const c_char) -> &'static str {
    let str = unsafe { CStr::from_ptr(cstr) };
    str.to_str().expect("Failed to get string")
}