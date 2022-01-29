use std::ffi::CStr;
use std::os::raw::c_char;
use std::time::{SystemTime, UNIX_EPOCH};
use xotp::util::{parse_otpauth_uri, ParseResult};

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
pub extern "C" fn hotp_get_otp(hotp: *const HOTP, counter: u64) -> u32 {
    if hotp == std::ptr::null() { return 0 }
    let hotp = *unsafe { Box::from_raw(hotp as *mut HOTP) };
    hotp.get_otp(counter)
}

#[no_mangle]
pub extern "C" fn totp_get_otp(totp: *const TOTP) -> u32 {
    if totp == std::ptr::null() { return 0 }
    let time = SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .expect("Failed to get time")
        .as_secs();
    let totp = unsafe { &*totp };
    totp.get_otp(time)
}

// fn get_otp_totp(totp: *const TOTP)

fn get_str_from_cstr(cstr: *const c_char) -> &'static str {
    let str = unsafe { CStr::from_ptr(cstr) };
    str.to_str().expect("Failed to get string")
}