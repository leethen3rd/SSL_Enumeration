
# SSL Cerificate Enumeration

This GitHub repo offers code snippets to extract SSL cert data. It covers multiple languages, providing easy methods to retrieve issuer, subject, validity dates, and key details. Ideal for web apps, network tools, or security projects.
<hr>

*Note: As this repo grows, more items will be added to the ReadME file.*

<hr>

## Serial Number Extracion

### Bash Script: `ssl_seialNum.sh`
**How To:**

* Add as many IP's as needed in the file `ip_addresses.txt`
* Make it excutable by running this command in your command line `chmod +x ssl_serialNum.sh`
* Execute script by running this command in your command line `./ssl_serialNum.sh`
* When completed, the script will save results to a CSV file.
* Requires OpenSSL (see Requirements Resources Section for getting this resource)

Example Output
| IP Address | Serial Number |
|------------|---------------|
|127.0.0.1 | 123456789982|


<p>


</p>

<hr>


## Requirement Resources

### OpenSSL Requirement
Before installing OpenSSL, check to see if you have it installed already by running the command `openssl version` in your command line or terminal. If insalled, the OpenSSL version will be displayed.

**Installing OpenSSL**
1. Visit the OpenSSL official website (https://www.openssl.org) and go to the "Downloads" section.

2. Download the appropriate OpenSSL binary package for Windows or binary package for macOS. Choose the version that matches your system architecture and the desired OpenSSL version.

3. Once the download is complete, locate the downloaded file and run the installer. (double click installer package on Mac)

4. Follow the on-screen instructions to install OpenSSL. You may need to specify the installation directory during the installation process.

5. After the installation is finished, open the command prompt by pressing Win + R, typing "cmd," and pressing Enter. or if on MacOS, You can find it in the Applications folder under Utilities or by searching for "Terminal" using Spotlight.

6. Verify the OpenSSL installation by running the command: `openssl version`. If installed correctly, it will display the OpenSSL version information.
