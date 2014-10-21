yosemite-vbox-setup
===================
Create your own virtual box for OS X Yosemite (Mac)

### Steps

1. Assuming you are still running Mavericks, download Yosemite from
   the App store but don’t install. Otherwise you will need to find
   another way to get the OS X Yosemite Install App.

2. Next you need to create the iso file. Use the script in this repo
   called makeYosemiteIso.sh. This will place the iso file on your
   desktop. If you do not want the desktop to be the location, just edit
   line 37 of the script.

3. Create VM in virtual box. Select OS X and the appropite system
   information (I selected 64 bit, 4gb of RAM, 25gb of virtual HD space).
   Once you have created the VM. You need to edit the settings in `System`
   so `Hardware Clock in UTC Time` is unchecked. Next, navigate to
   `Storage` and add the iso that was created with the script.

4. Now you need to open the terminal and navigate to where the new VM you created is located
   and run this command:
   ```shell
   VBoxManage modifyvm “NAME_OF_VM" --cpuidset 00000001 000306a9 00020800 80000201 178bfbff
   ```
   This will modify the VM to select the correct CPU.

5. Now start up the VM. You should see a wall of text followed by the
   setup screen.

6. Once sucessfully powered on, you should see the option to install OS
   X with the only storage option being the iso that was created. Open up
   Disk Utility (from the apple menu bar) and select the virtual Harddrive
   and erase it with the format as `Mac OS Extended (journaled)` and the
   Name `Macintosh HD`.

7. Close Disk Utility and now you can install OS X on the newly
   formatted HD.
