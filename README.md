# dosemu-launcher

[README FILE FOR launchemu DATE Mon 01 Jun 2015 12:46:46 PM EDT]
1.0 Intro
2.0 How to use
2.1 Command­line arguments
2.2 Error messages and exit codes
2.3 About launcher.conf
3.0 Contact info
3.1 Info to devs
1. Introduction
This software is designed to give users wh do not know the proper command line parameters a menudriven
interface to launch DosEmu. It allows you to view the current options you have set and also save
them for later use. The software is easy to install, simply unpack the archive. You are then good to go!
2. How to use
2.1 Command­line arguments
To run the launchemu software, change to the directory where you unpacked the archive and type:
$ launchemu <args>
If the above does not work, try:
$ ./launchemu <args>
Where <args> is either "ver" or "run". The two can do different things. If you type:
$ launchemu ver
launchemu will display the version number and then exit. If you type:
$ launchemu run
Then launchemu will skip the menus and load your saved settings and run dosemu. **NOTE: if you
run dosemu manually, IT WILL NOT LOAD YOUR SETTINGS FROM launchemu. Be careful when
doing so to avoid problems.**
If you simply run launchemu with no arguments, it will launch into a screen that looks something like
this **NOTE: the first time you run launchemu, there will not be a launcher.conf file. See 2.3 for more
info.**:
This shows the results of the file check and then launchemu will run. From there, there are many
options, available by the menus that appear:
Change Boot Drive ­
Changes the boot drive between the default setting, drive A: (/dev/fd0 in Fedora and Red Hat), and
drive C: (typically FreeDos).
Change Display Configuration ­
Changes display function from X window, SDL window, and default setting.
Save Settings for future use ­ 
Saves the settings you have set in launcher.conf for future loading and use.
View current settings ­
Shows what you have set in certian settings.
Run dosemu ­
Run dosemu with the settings (saved or not) currently set.
Exit this program ­
Exit the launcher without saving or running dosemu
2.2 Error messages and exit codes
launchemu has two software stages: the initial file read­execute check and the menu­driven program.
During the initial file check, two errors are possible:
 Error #1: launcher.conf is not executable. The user can choose whether or not to proceed, and if
they choose not to then launchemu exits with a code of 1.
 Error #2: The second software stage, launcher.sh, is not executable. If the file exists, then try
going to the directory where launchemu is located and type:
$ chmod +x launcher.sh
This should fix the issue. If not, then unpack launcher.sh from the original archive.
After this error occurs, launchemu cannot continue and exits with a code of 2.
The second stage is contained within launcher.sh and replaces the launchemu strap­loader when it
begins. The error codes here are all internal. If launchemu unexpectedly quits or displays the text:
INTERNAL ERROR: BAD OPTS
then an error has occurred that typically requires debugging of launcher.sh and/or launchemu. Usually,
it is best to go ahead and replace the files with the originals from the archive at this point.
2.3 About launcher.conf
launcher.conf is a file that contains the settings from your last save when using launchemu. The first
time you use launchemu, there will be no launcher.conf file because you have not yet saved any
settings. As such, launchemu invokes Error #1. Do not panic, this is normal. Press 'y' to continue and
strike the enter key. Once you save your settings, the error will stop occurring unless there is a real
problem.
3. Contact info
You can email me at noahkeck72@gmail.com if you have any questions. Be sure to put “launchemu”
as the subject line or I may not respond.
3.1 Info for developers
If you have suggestions for my next updates or want to help develop software (such as my indev OS),
email me as above and put “Developer” in the subject line. I am always thankful for help!
[END README]
