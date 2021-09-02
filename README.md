# smtp-starttls-ciphers
BASH script to test the MTA ciphers supported

Requires a linux environment with openssl and tls 1.3 support.


*** Install
- Copy the the `starttls-ciphers` script to your system.
- Make sure the script is executable: `chmod +x starttls-ciphers`
- Determine the hostname or IP address of MTA you wat to test, e.g.: `dig -t mx gmail.com`
- Pick the host with the lowest order number: `gmail-smtp-in.l.google.com`
- Run the script in the current dir (as user): `./smtp-ciphers gmail-smtp-in.l.google.com`
- You should get a result like below:

![image](https://user-images.githubusercontent.com/7188918/131850223-0a237cc9-b7a5-46cd-9a98-f3e8c66be8b1.png)

