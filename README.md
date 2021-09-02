# smtp-starttls-ciphers
BASH script to test the MTA ciphers supported based on the [NCSC security guidelines for TLS](https://www.ncsc.nl/documenten/publicaties/2021/januari/19/ict-beveiligingsrichtlijnen-voor-transport-layer-security-2.1) (Dutch)

Requires a linux environment with openssl and tls 1.3 support. WSL on Windows is also supported.

This script is only intended to ensure the correct ciphers are available. This scripts does not test the correct sequence oth the cipers.
A good way to complicancy is testing on [internet.nl](https://internet.nl).

The following ciphers are tested (note that TLS 1.3 is only tested generally):

#### GOOD:

- ECDHE-ECDSA-AES256-GCM-SHA384 (TLS_AES_256_GCM_SHA384 in 1.3) [1.2]
- ECDHE-ECDSA-CHACHA20-POLY1305 (TLS_CHACHA20_POLY1305_SHA256 in 1.3) [1.2]
- ECDHE-ECDSA-AES128-GCM-SHA256 (TLS_AES_128_GCM_SHA256 in 1.3) [1.2]
- ECDHE-RSA-AES256-GCM-SHA384 (TLS_AES_256_GCM_SHA384 in 1.3) [1.2]
- ECDHE-RSA-CHACHA20-POLY1305 (TLS_CHACHA20_POLY1305_SHA256 in 1.3) [1.2]
- ECDHE-RSA-AES128-GCM-SHA256 (TLS_AES_128_GCM_SHA256 in 1.3) [1.2]

#### SUFFIENT:

- ECDHE-ECDSA-AES256-SHA384 [1.2]
- ECDHE-ECDSA-AES256-SHA [1.0]
- ECDHE-ECDSA-AES128-SHA256 [1.2]
- ECDHE-ECDSA-AES128-SHA [1.0]
- ECDHE-RSA-AES256-SHA384 [1.2]
- ECDHE-RSA-AES256-SHA [1.0]
- ECDHE-RSA-AES128-SHA256 [1.2]
- ECDHE-RSA-AES128-SHA [1.0]
- DHE-RSA-AES256-GCM-SHA384 [1.2]
- DHE-RSA-CHACHA20-POLY1305 [1.2]
- DHE-RSA-AES128-GCM-SHA256 [1.2]
- DHE-RSA-AES256-SHA256 [1.2]
- DHE-RSA-AES256-SHA [1.0]
- DHE-RSA-AES128-SHA256 [1.2]
- DHE-RSA-AES128-SHA [1.0]

#### FASE OUT:

- ECDHE-ECDSA-DES-CBC3-SHA [1.0]
- ECDHE-RSA-DES-CBC3-SHA [1.0]
- DHE-RSA-DES-CBC3-SHA [1.0]
- AES256-GCM-SHA384 [1.2]
- AES128-GCM-SHA256 [1.2]
- AES256-SHA256 [1.2]
- AES256-SHA [1.0]
- AES128-SHA256 [1.2]
- AES128-SHA [1.0]
- DES-CBC3-SHA [1.0]

## Install
- Copy the the `starttls-ciphers` script to your system.
- Make sure the script is executable: `chmod +x starttls-ciphers`
- Determine the hostname or IP address of MTA you wat to test, e.g.: `dig -t mx gmail.com` or `nslookup -type=mx gmail.com`
- Pick the host with the lowest order number: `gmail-smtp-in.l.google.com`
- Run the script in the current dir (as user): `./smtp-ciphers gmail-smtp-in.l.google.com`
- You should get a result like below:

![image](https://user-images.githubusercontent.com/7188918/131850223-0a237cc9-b7a5-46cd-9a98-f3e8c66be8b1.png)

> Note that only TLS 1.2 or TLS 1.3 are advised protocols to use regardless of the used ciphers.
