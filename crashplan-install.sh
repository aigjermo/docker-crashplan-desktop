#!/bin/bash
## Thanks to the maintainer of https://aur.archlinux.org/packages/crashplan/
volume_name=crashplan_data
pkgname=crashplan
pkgver=$CRASHPLAN_VERSION
srcdir=/src/

## Setup initial variables for installation
cd "$srcdir/CrashPlan-install"

echo ""
echo "You must review and agree to the EULA before using Crashplan."
echo "You can do so at:"
echo "  - http://support.crashplan.com/doku.php/eula"
echo "  - /usr/share/licenses/${pkgname}/LICENSE"
echo ""

echo "" > install.vars
echo "JAVACOMMON=/usr/bin/java" >> install.vars
echo "#APP_BASENAME=CrashPlan" >> install.vars
echo "TARGETDIR=/opt/$pkgname" >> install.vars
echo "BINSDIR=" >> install.vars
echo "MANIFESTDIR=${CRASHPLAN_ARCHIVE_DIR}" >> install.vars
echo "INITDIR=" >> install.vars
echo "RUNLVLDIR=" >> install.vars
NOW=`date +%Y%m%d`
echo "INSTALLDATE=$NOW" >> install.vars

mkdir -p /opt/$pkgname

sed -imod "s|Exec=.*|Exec=/opt/$pkgname/bin/CrashPlanDesktop|" $srcdir/CrashPlan-install/scripts/CrashPlan.desktop
sed -imod "s|Icon=.*|Icon=/opt/$pkgname/skin/icon_app_64x64.png|" $srcdir/CrashPlan-install/scripts/CrashPlan.desktop
sed -imod "s|Categories=.*|Categories=System;|" $srcdir/CrashPlan-install/scripts/CrashPlan.desktop

cd /opt/$pkgname

cat $srcdir/CrashPlan-install/CrashPlan_$pkgver.cpi | gzip -d -c - | cpio -i --no-preserve-owner
chmod 777 /opt/$pkgname/log

# Fix for encoding troubles (CrashPlan ticket 178827)
# Make sure the daemon is running using the same localization as
# the (installing) user
echo "" >> $srcdir/CrashPlan-install/scripts/run.conf
echo "export LC_ALL=$LANG" >> $srcdir/CrashPlan-install/scripts/run.conf

install -D -m 644 $srcdir/CrashPlan-install/install.vars /opt/$pkgname/install.vars
install -D -m 644 $srcdir/CrashPlan-install/EULA.txt /opt/$pkgname/EULA.txt
install -D -m 644 $srcdir/CrashPlan-install/EULA.txt "/usr/share/licenses/${pkgname}/LICENSE"
install -D -m 755 $srcdir/CrashPlan-install/scripts/CrashPlanDesktop /opt/$pkgname/bin/CrashPlanDesktop
install -D -m 644 $srcdir/CrashPlan-install/scripts/run.conf /opt/$pkgname/bin/run.conf
install -D -m 755 $srcdir/CrashPlan-install/scripts/CrashPlanEngine /opt/$pkgname/bin/CrashPlanEngine
