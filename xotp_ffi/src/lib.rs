use std::ffi::CStr;
use std::os::raw::c_char;
use std::time::{SystemTime, UNIX_EPOCH};
use xotp::util::{MacDigest, parse_otpauth_uri, ParseResult};

#[repr(u8)]
pub enum Digest {
    SHA1 = 0x1,
    SHA256 = 0x2,
    SHA512 = 0x3
}

pub type HOTP = xotp::hotp::HOTP;
pub type TOTP = xotp::totp::TOTP;
pub type ParseError = xotp::util::ParseError;

#[repr(C)]
pub enum OTPResult {
    ParsedHOTP(*const HOTP, u64),
    ParsedTOTP(*const TOTP),
    Error(*const ParseError)
}

#[no_mangle]
pub extern "C" fn get_otp_from_uri(uri: *const c_char) -> *const OTPResult {
   let otp_result = match parse_otpauth_uri(get_str_from_cstr(uri)) {
       Ok(ParseResult::HOTP(x, count)) => OTPResult::ParsedHOTP(Box::into_raw(Box::new(x)), count),
       Ok(ParseResult::TOTP(x)) => OTPResult::ParsedTOTP(Box::into_raw(Box::new(x))),
       Err(e) => OTPResult::Error(Box::into_raw(Box::new(e)))
   };
    Box::into_raw(Box::new(otp_result))
}

#[no_mangle]
pub extern "C" fn get_hotp_instance(secret: *const c_char, digits: u32) -> *const HOTP {
    let hotp = HOTP::new_from_base32(get_str_from_cstr(secret), digits);
    Box::into_raw(Box::new(hotp))
}

pub extern "C" fn get_totp_instance(secret: *const c_char, digest: Digest, digits: u32, period: u64) -> *const TOTP {
    let mac_digest = match digest {
        Digest::SHA1 => MacDigest::SHA1,
        Digest::SHA256 => MacDigest::SHA256,
        Digest::SHA512 => MacDigest::SHA512,
    };
    let totp = TOTP::new_from_base32(get_str_from_cstr(secret), mac_digest, digits, period);
    Box::into_raw(Box::new(top))
}

pub extern "C" fn hotp_get_otp(hotp: *const HOTP, counter: u64) -> u32 {
    *&hotp.get_otp(counter)
}

pub extern "C" fn totp_get_otp(totp: *const TOTP) -> u32 {
    let time = SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .expect("Failed to get time")
        .as_secs();
   *&totp.get_otp(time)
}

// #[no_mangle]
// pub extern "C" fn get_current_totp_from_utf8(secret: *const c_char, digest: Digest) -> u32 {
//     let (mac_digest, time) = get_totp_info(digest);
//     TOTP::from_utf8_with_digest(get_str_from_cstr(secret), mac_digest)
//         .get_otp(time, 6)
// }
//
// #[no_mangle]
// pub extern "C" fn get_current_totp_from_base32(secret: *const c_char, digest: Digest) -> u32 {
//     let (mac_digest, time) = get_totp_info(digest);
//     TOTP::from_base32_with_digest(get_str_from_cstr(secret), mac_digest)
//         .get_otp(time, 6)
// }
//
// fn get_totp_info(digest: Digest) -> (MacDigest, u64) {
//     let time = SystemTime::now()
//         .duration_since(UNIX_EPOCH)
//         .expect("Failed to get time")
//         .as_secs();
//     let mac_digest = match digest {
//         Digest::SHA1 => MacDigest::SHA1,
//         Digest::SHA256 => MacDigest::SHA256,
//         Digest::SHA512 => MacDigest::SHA512
//     };
//     (mac_digest, time)
// }
//
fn get_str_from_cstr(cstr: *const c_char) -> &'static str {
    let str = unsafe { CStr::from_ptr(cstr) };
    str.to_str().expect("Failed to get string")
}