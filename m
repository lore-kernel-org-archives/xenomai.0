From: Romain Lenglet <rlenglet@domain.hid>
Date: Mon, 6 Mar 2006 17:17:18 +0900
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OA/CE87SX+pN1dd"
Message-Id: <200603061717.18391.rlenglet@domain.hid>
Subject: [Xenomai-core] System-V initialization script
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--Boundary-00=_OA/CE87SX+pN1dd
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Here is a patch that adds a System-V init script to the 
distribution. This script creates/deletes the devices in /dev 
and sets the latency through /proc/xenomai/latency.
Please re-run automake before committing (if committing).

Is there anything more it should do? For instance, is there a way 
to start the timer through one of the /proc/xenomai/* 
pseudo-files?

-- 
Romain LENGLET

--Boundary-00=_OA/CE87SX+pN1dd
Content-Type: text/x-diff; charset="us-ascii";
	name="initscript_2006-03-06.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="initscript_2006-03-06.patch"

--- xenomai/ChangeLog	2006-03-06 12:51:03.624869000 +0900
+++ xenomai-new/ChangeLog	2006-03-06 17:03:52.806802824 +0900
@@ -1,3 +1,9 @@
+2006-03-06  Romain Lenglet <rlenglet@domain.hid>
+
+	* scripts/etc/init.d/xenomai, scripts/etc/default/xenomai,
+	scripts/etc/README scripts/Makefile.am: Add a System-V-like init script
+	for creating devices and setting the scheduling latency at boot time.
+
 2006-03-05  Philippe Gerum  <rpm@xenomai.org>
 
 	* ksrc/skins/vxworks/taskLib.c (taskPrioritySet): Return ERROR
--- xenomai/scripts/Makefile.am	2006-02-27 09:51:18.379979776 +0900
+++ xenomai-new/scripts/Makefile.am	2006-03-06 17:03:27.412663320 +0900
@@ -8,4 +8,5 @@
 
 EXTRA_DIST = bootstrap prepare-kernel.sh xeno-info \
 	Kconfig.frag Modules.frag defconfig.frag \
+	etc/init.d/xenomai etc/default/xenomai etc/README \
 	$(wildcard postinstall.sh)
diff -Naurd xenomai/scripts/etc/default/xenomai xenomai-new/scripts/etc/default/xenomai
--- xenomai/scripts/etc/default/xenomai	1970-01-01 09:00:00.000000000 +0900
+++ xenomai-new/scripts/etc/default/xenomai	2006-03-06 16:40:30.264021736 +0900
@@ -0,0 +1,6 @@
+# The group that owns the Xenomai devices in /dev/.
+GROUP=root
+# The access mode to the Xenomai devices in /dev/.
+MODE=0770
+# The real-time scheduling latency.
+LATENCY=0
diff -Naurd xenomai/scripts/etc/init.d/xenomai xenomai-new/scripts/etc/init.d/xenomai
--- xenomai/scripts/etc/init.d/xenomai	1970-01-01 09:00:00.000000000 +0900
+++ xenomai-new/scripts/etc/init.d/xenomai	2006-03-06 17:12:24.006088720 +0900
@@ -0,0 +1,98 @@
+#! /bin/sh
+#
+# xenomai	Xenomai Real-time framework for Linux.
+#		This script sets up devices in /dev if Udev is not running,
+#		and sets the real-time scheduling latency.
+#
+#		Written by Romain Lenglet <rlenglet@domain.hid>.
+#
+
+PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
+NAME=xenomai
+DESC=Xenomai
+
+# Include xenomai defaults if available
+if [ -f /etc/default/xenomai ] ; then
+	. /etc/default/xenomai
+fi
+
+# Set default values in case /etc/default/xenomai does not exist or is not
+# correctly specified
+GROUP=${GROUP:=root}
+MODE=${MODE:=0770}
+LATENCY=${LATENCY:=0}
+
+set -e
+
+case "$1" in
+  start|reload|restart|force-reload)
+	echo -n "Starting $DESC: "
+
+	# Create devices if Udev is not running (otherwise, Udev should have
+	# been configured to create the devices itself).
+	UDEV_STARTED="N"
+	if [ -e /dev/.udev ]; then
+	    if mountpoint -q /dev/; then
+		UDEV_STARTED="Y"
+	    fi
+	fi
+	if [ "$UDEV_STARTED" = "N" ]; then
+	    for N in `seq 0 31`; do
+		F="/dev/rtp$n"
+		if [ ! -c "$F" ]; then
+		    /bin/mknod -m 666 "$F" c 150 "$N"
+		    /bin/chown ":$GROUP" "$F"
+		    /bin/chmod "$MODE" "$F"
+		fi
+	    done
+	    F=/dev/rtheap
+	    if [ ! -c "$F" ]; then
+		/bin/mknod -m 666 "$F" c 10 254
+		/bin/chown ":$GROUP" "$F"
+		/bin/chmod "$MODE" "$F"
+	    fi
+	    echo -n "devices, "
+	fi
+
+	# Set the scheduling latency.
+	if [ -w /proc/xenomai/latency ]; then
+	    echo "$LATENCY" > /proc/xenomai/latency
+	    echo -n "latency, "
+	fi
+
+	echo "done."
+	;;
+  stop)
+	echo -n "Stopping $DESC: "
+
+	# Delete devices if Udev is not running.
+	UDEV_STARTED="N"
+	if [ -e /dev/.udev ]; then
+	    if mountpoint -q /dev/; then
+		UDEV_STARTED="Y"
+	    fi
+	fi
+	if [ "$UDEV_STARTED" = "N" ]; then
+	    for N in `seq 0 31`; do
+		F="/dev/rtp$n"
+		if [ -c "$F" ]; then
+		    rm -f "$F"
+		fi
+	    done
+	    F=/dev/rtheap
+	    if [ -c "$F" ]; then
+		rm -f "$F"
+	    fi
+	    echo -n "devices, "
+	fi
+
+	echo "done."
+	;;
+  *)
+	N=/etc/init.d/$NAME
+	echo "Usage: $N {start|stop|reload|restart|force-reload}" >&2
+	exit 1
+	;;
+esac
+
+exit 0
diff -Naurd xenomai/scripts/etc/README xenomai-new/scripts/etc/README
--- xenomai/scripts/etc/README	1970-01-01 09:00:00.000000000 +0900
+++ xenomai-new/scripts/etc/README	2006-03-06 16:58:37.002812328 +0900
@@ -0,0 +1,22 @@
+This directory contains a System-V-style initialization script for Xenomai.
+That script creates the real-time devices in /dev/, and sets the scheduling
+latency through the /proc/xenomai/latency interface.
+
+To install this script, as root:
+> cp init.d/xenomai /etc/init.d/xenomai
+> chown root:root /etc/init.d/xenomai
+> chmod 0755 /etc/init.d/xenomai
+
+The configuration values are stored in the /etc/default/xenomai file.
+A skeleton is provided in this directory. To install it:
+> cp default/xenomai /etc/default/xenomai
+> chown root:root /etc/default/xenomai
+> chmod 0644 /etc/default/xenomai
+And adapt the values in /etc/default/xenomai.
+
+Then, make the initialization script start in the required runlevels.
+On Debian, you can use update-rc.d(8) or rcconf(8) to do so.
+Or you can also do it manually:
+> for L in 0 1 6; do (cd /etc/rc${L}.d ; ln -s ../init.d/xenomai K20xenomai) ; done
+> for L in 2 3 4 5; do (cd /etc/rc${L}.d ; ln -s ../init.d/xenomai S20xenomai) ; done
+

--Boundary-00=_OA/CE87SX+pN1dd--

