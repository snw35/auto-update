# auto-update

Easy automated updates for Linux distributions.

These scripts use techniques borrowed from container images and cloud infrastructure to update standard Linux distributions automatically.

## Ubuntu

Automatic updates for Ubuntu. Simply install using the command below and never think about updates again.

Copy the below into a terminal and run it to install the 'needrestart' package, the update script, and the associated cron job:
```
sudo apt-get install -y needrestart && sudo curl https://github.com/snw35/auto-update/blob/master/ubuntu/update-cron.sh -o /usr/local/bin/update-cron.sh && sudo chmod +x /usr/local/bin/update-cron.sh && sudo curl https://github.com/snw35/auto-update/blob/master/ubuntu/update-reboot -o /etc/cron.d/update-reboot;
```

Try it out by running the script manually, e.g. run `/usr/local/bin/update-cron.sh` in a terminal. It will wait for 2 minutes before going ahead and automatically updating your system. If it works correctly then you're all set.

If a new Kernel is installed, the script will pop up a notification titled "Auto-Updater" that reads "New kernel installed, reboot required". You can either reboot sooner, or just carry on as normal.

## Considerations

Your machine will initiate a potentially large download 2 minutes after login. If you are on a metered connection, e.g tethered to your phone, be aware of the potential data use.

The more you use your machine, the more often it will update, and the smaller and faster the updates will be. If your machine has been off for a long time (e.g months) and is started with this script installed, it will likely be downloading a lot of data and experiencing a lot of disk I/O and CPU use before it finishes the large number of pending updates. If this is the case, you may want to start it and leave it alone for a while to get through the updates before trying to use it.

## Why, when there are official/existing solutions?

Because they don't do what I want.

I want a computer to never, ever bother the user about something that is entirely related to its own running and maintenance. There are two main reasons for this:

 * User time is the most precious time, and eating into that to present dialogues with buttons that have to be clicked and text that has to be read, when the end result is *always* clicking 'Install', is not what I consider a good use of it.

 * Don't delay security updates by requiring a user to press a button. If a package has an update available when the machine starts, just download and install it in the background immediately so the OS is protected. Don't wait for them to get around to reading dialogues and eventually clicking 'Install'.

Yes, this is opinionated and others will have different thoughts. The reason (as far as I can tell) that other auto-update solutions don't do this is that it can result in non-updated config files or potentially broken packages. I've been running this script on several machines for over two years now and have never seen this, so I'm happy that it is reliable and stable enough for day to day use.

## Disclaimer

These scripts will:

 * Update everything they can to the maximum degree (purging old packages, installing new deps, replacing deprecated packages, etc) to achieve the most hands-off approach.
 * Keep your existing config files, even if the new packages have updated ones. This should result in minimum breakage, but may result in new features being disabled etc.

This *could* result in a broken package manager or an unstable system. I feel I have to put this warning here as there is no guarantee that it will work perfectly every single time. Most package manager issues can be resolved with some googling, and I think this is fine for a personal laptop/desktop, but I'd think twice about running this on a critical production system.
