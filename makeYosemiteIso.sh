INSTALL=$1

# Mount the installer image
hdiutil attach /Applications/Install\ OS\ X\ ${INSTALL}.app/Contents/SharedSupport/InstallESD.dmg -noverify -nobrowse -mountpoint /Volumes/install_app

# Convert the boot image to a sparse bundle
hdiutil convert /Volumes/install_app/BaseSystem.dmg -format UDSP -o /tmp/${INSTALL}

# Increase the sparse bundle capacity to accommodate the packages
hdiutil resize -size 8g /tmp/${INSTALL}.sparseimage

# Mount the sparse bundle for package addition
hdiutil attach /tmp/${INSTALL}.sparseimage -noverify -nobrowse -mountpoint /Volumes/install_build

# Remove Package link and replace with actual files
rm /Volumes/install_build/System/Installation/Packages
cp -rp /Volumes/install_app/Packages /Volumes/install_build/System/Installation/

# COPY THESE TWO FILES (It is the solution for the common error - The operation couldn't be completed. Undefined error: 0)
cp /Volumes/install_app/BaseSystem.chunklist /Volumes/install_build/BaseSystem.chunklist
cp /Volumes/install_app/BaseSystem.dmg /Volumes/install_build/BaseSystem.dmg

# Unmount the installer image
hdiutil detach /Volumes/install_app

# Unmount the sparse bundle
hdiutil detach /Volumes/install_build

# Resize the partition in the sparse bundle to remove any free space
hdiutil resize -size `hdiutil resize -limits /tmp/${INSTALL}.sparseimage | tail -n 1 | awk '{ print $1 }'`b /tmp/${INSTALL}.sparseimage

# Convert the sparse bundle to ISO/CD master
hdiutil convert /tmp/${INSTALL}.sparseimage -format UDZO -o /tmp/${INSTALL}

# Remove the sparse bundle
rm /tmp/${INSTALL}.sparseimage

# Rename the ISO and move it to the desktop
mv /tmp/${INSTALL}* ~/Desktop/${INSTALL}_"$(date +"%m_%d_%y")".iso
