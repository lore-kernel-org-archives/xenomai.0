Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Date: Wed, 02 Oct 2019 14:35:37 +0200
Subject: =?utf-8?q?=5BPATCH=5D?= Allow RTNet to be builtin kernel
Message-ID: <30dd-5d949980-11-21e4bb80@177051178>
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>

Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>

Subject: [PATCH] Allow RTNet to be builtin kernel

---
 kernel/drivers/net/Kconfig        |   1 -
 kernel/drivers/net/addons/Kconfig |   4 +-
 kernel/drivers/net/stack/Makefile |  16 ++---
 utils/net/rtnet.in                | 148 +++++++++++++++++++++++-------=
--------
 4 files changed, 101 insertions(+), 68 deletions(-)

diff --git a/kernel/drivers/net/Kconfig b/kernel/drivers/net/Kconfig
index ac3bced..49d2402 100644
--- a/kernel/drivers/net/Kconfig
+++ b/kernel/drivers/net/Kconfig
@@ -1,7 +1,6 @@
 menu "RTnet"
 
 config XENO=5FDRIVERS=5FNET
-    depends on m
     select NET
     tristate "RTnet, TCP/IP socket interface"
 
diff --git a/kernel/drivers/net/addons/Kconfig b/kernel/drivers/net/add=
ons/Kconfig
index baa6cbc..616ed40 100644
--- a/kernel/drivers/net/addons/Kconfig
+++ b/kernel/drivers/net/addons/Kconfig
@@ -2,7 +2,7 @@ menu "Add-Ons"
     depends on XENO=5FDRIVERS=5FNET
 
 config XENO=5FDRIVERS=5FNET=5FADDON=5FRTCAP
-    depends on XENO=5FDRIVERS=5FNET && m
+    depends on XENO=5FDRIVERS=5FNET
     select ETHERNET
     tristate "Real-Time Capturing Support"
     default n
@@ -18,7 +18,7 @@ config XENO=5FDRIVERS=5FNET=5FADDON=5FRTCAP
     For further information see Documentation/README.rtcap.
 
 config XENO=5FDRIVERS=5FNET=5FADDON=5FPROXY
-    depends on XENO=5FDRIVERS=5FNET=5FRTIPV4 && m
+    depends on XENO=5FDRIVERS=5FNET=5FRTIPV4
     select ETHERNET
     tristate "IP protocol proxy for Linux"
     default n
diff --git a/kernel/drivers/net/stack/Makefile b/kernel/drivers/net/sta=
ck/Makefile
index d055dc2..f8db6fa 100644
--- a/kernel/drivers/net/stack/Makefile
+++ b/kernel/drivers/net/stack/Makefile
@@ -1,13 +1,5 @@
 ccflags-y +=3D -Idrivers/xenomai/net/stack/include -Ikernel/
 
-obj-$(CONFIG=5FXENO=5FDRIVERS=5FNET=5FRTIPV4) +=3D ipv4/
-
-obj-$(CONFIG=5FXENO=5FDRIVERS=5FNET=5FRTPACKET) +=3D packet/
-
-obj-$(CONFIG=5FXENO=5FDRIVERS=5FNET=5FRTMAC) +=3D rtmac/
-
-obj-$(CONFIG=5FXENO=5FDRIVERS=5FNET=5FRTCFG) +=3D rtcfg/
-
 obj-$(CONFIG=5FXENO=5FDRIVERS=5FNET) +=3D rtnet.o
 
 rtnet-y :=3D  \
@@ -23,4 +15,12 @@ rtnet-y :=3D  \
 	stack=5Fmgr.o \
 	eth.o
 
+obj-$(CONFIG=5FXENO=5FDRIVERS=5FNET=5FRTIPV4) +=3D ipv4/
+
+obj-$(CONFIG=5FXENO=5FDRIVERS=5FNET=5FRTPACKET) +=3D packet/
+
+obj-$(CONFIG=5FXENO=5FDRIVERS=5FNET=5FRTMAC) +=3D rtmac/
+
+obj-$(CONFIG=5FXENO=5FDRIVERS=5FNET=5FRTCFG) +=3D rtcfg/
+
 rtnet-$(CONFIG=5FXENO=5FDRIVERS=5FNET=5FRTWLAN) +=3D rtwlan.o
diff --git a/utils/net/rtnet.in b/utils/net/rtnet.in
index f81a7bb..3c3cab9 100644
--- a/utils/net/rtnet.in
+++ b/utils/net/rtnet.in
@@ -31,44 +31,62 @@ EOF
 }
 
 init=5Frtnet() {
-    modprobe rtnet >/dev/null || exit 1
-    modprobe rtipv4 >/dev/null || exit 1
-    modprobe $RT=5FDRIVER $RT=5FDRIVER=5FOPTIONS >/dev/null || exit 1
+    if [ ! -d /proc/rtnet ]; then
+        modprobe rtnet >/dev/null || exit 1
+    fi
 
-    for dev in $REBIND=5FRT=5FNICS; do
-	if [ -d /sys/bus/pci/devices/$dev/driver ]; then
-	    echo $dev > /sys/bus/pci/devices/$dev/driver/unbind
-	fi
-	echo $dev > /sys/bus/pci/drivers/$RT=5FDRIVER/bind
-    done
+    if [ ! -d /proc/rtnet/ipv4 ]; then
+        modprobe rtipv4 >/dev/null || exit 1
+        for PROTOCOL in $RT=5FPROTOCOLS; do
+            modprobe rt$PROTOCOL >/dev/null || exit 1
+        done
+    fi
 
-    for PROTOCOL in $RT=5FPROTOCOLS; do
-	modprobe rt$PROTOCOL >/dev/null || exit 1
-    done
+    $(cat /proc/rtnet/devices | grep -q rteth0)
+    if [ $? -eq 1 ]; then
+        modprobe $RT=5FDRIVER $RT=5FDRIVER=5FOPTIONS >/dev/null || exi=
t 1
+
+        for dev in $REBIND=5FRT=5FNICS; do
+            if [ -d /sys/bus/pci/devices/$dev/driver ]; then
+                echo $dev > /sys/bus/pci/devices/$dev/driver/unbind
+            fi
+            echo $dev > /sys/bus/pci/drivers/$RT=5FDRIVER/bind
+        done
+    fi
 
     if [ $RT=5FLOOPBACK =3D "yes" ]; then
-	modprobe rt=5Floopback >/dev/null || exit 1
+        $(cat /proc/rtnet/devices | grep -q rtlo)
+        if [ $? -eq 1 ]; then
+
+            modprobe rt=5Floopback >/dev/null || exit 1
+        fi
     fi
 
-    if [ $RTCAP =3D "yes" ]; then
-	modprobe rtcap >/dev/null || exit 1
+    if [ $RTCAP =3D "yes" -a ! -d /sys/modules/rtcap ]; then
+        modprobe rtcap >/dev/null || exit 1
     fi
 
     if [ $RT=5FLOOPBACK =3D "yes" ]; then
-	$RTIFCONFIG rtlo up 127.0.0.1
+        $RTIFCONFIG rtlo up 127.0.0.1
     fi
 
     if [ $RTCAP =3D "yes" ]; then
-	ifconfig rteth0 up
-	ifconfig rteth0-mac up
-	if [ $RT=5FLOOPBACK =3D "yes" ]; then
-	    ifconfig rtlo up
-	fi
+        ifconfig rteth0 up
+        ifconfig rteth0-mac up
+        if [ $RT=5FLOOPBACK =3D "yes" ]; then
+            ifconfig rtlo up
+        fi
     fi
 
-    modprobe rtcfg >/dev/null
-    modprobe rtmac >/dev/null
-    modprobe tdma >/dev/null
+    if [ ! -d /proc/rtnet/rtcfg ]; then
+        modprobe rtcfg >/dev/null
+    fi
+    if [ ! -d /proc/rtnet/rtmac ]; then
+        modprobe rtmac >/dev/null
+    fi
+    if [ ! -f /proc/tdma ]; then
+        modprobe tdma >/dev/null
+    fi
 }
 
 submit=5Fcfg() {
@@ -329,43 +347,59 @@ case "$1" in
 	;;
 
     master)
-	shift
-	init=5Frtnet
-	TDMA=5FSLAVES=3D$*
-	start=5Fmaster
-	;;
+        shift
+        init=5Frtnet
+        TDMA=5FSLAVES=3D$*
+        start=5Fmaster
+        ;;
 
     capture)
-	modprobe rtnet >/dev/null || exit 1
-	modprobe $RT=5FDRIVER $RT=5FDRIVER=5FOPTIONS >/dev/null || exit 1
-	modprobe rtcap >/dev/null || exit 1
-	$RTIFCONFIG rteth0 up promisc
-	ifconfig rteth0 up
-	ifconfig rteth0-mac up
-	;;
+        if [ ! -d /proc/rtnet ]; then
+            modprobe rtnet >/dev/null || exit 1
+        fi
+        $(cat /proc/rtnet/devices | grep -q rteth0)
+        if [ $? -eq 1 ]; then
+            modprobe $RT=5FDRIVER $RT=5FDRIVER=5FOPTIONS >/dev/null ||=
 exit 1
+        fi
+        if [ ! -d /sys/modules/rtcap ]; then
+            modprobe rtcap >/dev/null || exit 1
+        fi
+        $RTIFCONFIG rteth0 up promisc
+        ifconfig rteth0 up
+        ifconfig rteth0-mac up
+        ;;
 
     loopback)
-	modprobe rtnet >/dev/null || exit 1
-	modprobe rtipv4 >/dev/null || exit 1
-
-	for PROTOCOL in $RT=5FPROTOCOLS; do
-	    modprobe rt$PROTOCOL >/dev/null || exit 1
-	done
-
-	modprobe rt=5Floopback >/dev/null || exit 1
-
-	if [ $RTCAP =3D "yes" ]; then
-	    modprobe rtcap >/dev/null || exit 1
-	fi
-
-	$RTIFCONFIG rtlo up 127.0.0.1
-
-	if [ $RTCAP =3D "yes" ]; then
-	    ifconfig rtlo up
-	fi
-	;;
+        if [ ! -d /proc/rtnet ]; then
+            modprobe rtnet >/dev/null || exit 1
+        fi
+        if [ ! -d /proc/rtnet/ipv4 ]; then
+            modprobe rtipv4 >/dev/null || exit 1
+            for PROTOCOL in $RT=5FPROTOCOLS; do
+                modprobe rt$PROTOCOL >/dev/null || exit 1
+            done
+        fi
+
+        if [ $RT=5FLOOPBACK =3D "yes" ]; then
+            $(cat /proc/rtnet/devices | grep -q rtlo)
+            if [ $? -eq 1 ]; then
+
+                modprobe rt=5Floopback >/dev/null || exit 1
+            fi
+        fi
+
+        if [ $RTCAP =3D "yes" -a ! -d /sys/modules/rtcap ]; then
+            modprobe rtcap >/dev/null || exit 1
+        fi
+
+        $RTIFCONFIG rtlo up 127.0.0.1
+
+        if [ $RTCAP =3D "yes" ]; then
+            ifconfig rtlo up
+        fi
+        ;;
 
     *)
-	usage
-	exit 1
+        usage
+        exit 1
 esac
-- 
2.1.4


