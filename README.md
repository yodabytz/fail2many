# Fail2Ban IP Management

## Overview
This shell script is designed to manage banned IP addresses in Fail2Ban by monitoring the Fail2Ban log file and adding repeat offenders to a blacklist file (`fail2many.txt`). It ensures that only unique IP addresses are added to the blacklist to prevent duplicates.

## Features
- Monitors the Fail2Ban log file for banned IP addresses.
- Maintains a blacklist file (`fail2many.txt`) containing banned IP addresses.
- Ensures only unique IP addresses are added to the blacklist.
- Provides easy integration with Fail2Ban for enhanced IP management.

## Usage
1. Place the script (`fail2many.sh`) in a convenient location on your system.

2. Add a cron job to run the script regularly, e.g., once a day:
    ```bash
    0 0 * * * /path/to/fail2many.sh > /dev/null 2>&1
    ```
3. Ensure the script has executable permissions (`chmod +x fail2many.sh`).

4. Configure tcpwrapers to use the blacklist file (`fail2many.txt`) in the `hosts.deny` configuration.
ALL : /etc/fail2many.txt

## License
This project is licensed under the [MIT License](LICENSE).

## Contributions
Contributions are welcome! Feel free to submit issues or pull requests to improve this script.

---

Feel free to customize this README to include any additional information or instructions specific to your project. Let me know if you need further assistance!
