Content-Type: text/plain; charset="utf-8"
In-Reply-To: <0e1af119-ba94-5c15-4891-c182ada7841d@siemens.com>
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
Date: Wed, 09 Oct 2019 09:21:13 +0200
MIME-Version: 1.0
Message-ID: <30dd-5d9d8a80-29-21e4bb80@177086950>
Subject: =?utf-8?q?Re=3A?==?utf-8?q?_=5BPATCH=5D?= Allow RTNet to be builtin
 kernel
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: Xenomai <xenomai@xenomai.org>

From: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>

Subject: [PATCH] Allow RTNet to be builtin kernel

Makefile is changed because when builtin, the modules get loaded in the=
 link order. In the previous version protocols would get loaded before =
stackmgr which obviously fails.

Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>

---

This has been tested on Zynq 7000 Hardware (microzed board) with MACB/G=
EM RTNet driver, with linux 4.4.189 vanilla. Kernel boots up correctly,=
 and the following messages get printed on the console during the boot =
:

[   13.875451] sdhci-pltfm: SDHCI platform and OF driver helper
[   13.881627] sdhci-arasan e0100000.sdhci: No vmmc regulator found
[   13.887581] sdhci-arasan e0100000.sdhci: No vqmmc regulator found
[   13.927585] mmc0: SDHCI controller on e0100000.sdhci [e0100000.sdhci=
] using ADMA
[   13.945085] fpga=5Fmanager fpga0: Xilinx Zynq FPGA Manager registere=
d
[   13.951896]
[   13.951896] *** RTnet for Xenomai v3.0.9 ***
[   13.951896]
[   13.959156] RTnet: initialising real-time networking
[   13.964928] RTmac/TDMA: init time division multiple access control m=
echanism
[   13.972074] RTmac: init realtime media access control
[   13.977064] RTcfg: init real-time configuration distribution protoco=
l
[   13.983752] initializing loopback...
[   13.987295] RTnet: registered rtlo
[   13.993238] RTnet: registered rteth0
[   13.996832] libphy: MACB=5Fmii=5Fbus: probed
[   14.001140] rt=5Fmacb: rteth0: Cadence GEM at 0xe000b000 irq 26 (00:=
0a:35:00:01:22)
[   14.008630] rt=5Fmacb: rteth0: attached PHY driver [Marvell 88E1510]=
 (mii=5Fbus:phy=5Faddr=3De000b000.ethernet-ffffffff:00, irq=3D-1)
[   14.019845] RTcap: real-time capturing interface
[   14.026562] RTproxy attached to rteth0
[   14.031129] rtnetproxy installed as "rtproxy"
[   14.035693] NET: Registered protocol family 26
[   14.040309] NET: Registered protocol family 17
[   14.044686] can: controller area network core (rev 20120528 abi 9)
[   14.050957] NET: Registered protocol family 29
[   14.055329] can: raw protocol (rev 20120528)
[   14.059683] can: broadcast manager protocol (rev 20120528 t)

 kernel/drivers/net/Kconfig         |   1 -
 kernel/drivers/net/addons/Kconfig  |   4 +-
 kernel/drivers/net/drivers/Kconfig |  22 +++---
 kernel/drivers/net/stack/Makefile  |  16 ++---
 utils/net/rtnet.in                 | 138 ++++++++++++++++++++++++-----=
--------
 5 files changed, 110 insertions(+), 71 deletions(-)

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
diff --git a/kernel/drivers/net/drivers/Kconfig b/kernel/drivers/net/dr=
ivers/Kconfig
index 65f0855..6140f94 100644
--- a/kernel/drivers/net/drivers/Kconfig
+++ b/kernel/drivers/net/drivers/Kconfig
@@ -10,7 +10,7 @@ config XENO=5FDRIVERS=5FNET=5FDRV=5FPCNET32
 
 
 config XENO=5FDRIVERS=5FNET=5FDRV=5FTULIP
-    depends on XENO=5FDRIVERS=5FNET && PCI
+    depends on XENO=5FDRIVERS=5FNET && PCI && m
     tristate "DEC Tulip"
 
 
@@ -40,12 +40,12 @@ config XENO=5FDRIVERS=5FNET=5FDRV=5FEEPRO100=5FDBG
 
 
 config XENO=5FDRIVERS=5FNET=5FDRV=5FE1000
-    depends on XENO=5FDRIVERS=5FNET && PCI
+    depends on XENO=5FDRIVERS=5FNET && PCI && m
     tristate "Intel(R) PRO/1000 (Gigabit)"
     default y
 
 config XENO=5FDRIVERS=5FNET=5FDRV=5FE1000E
-    depends on XENO=5FDRIVERS=5FNET && PCI
+    depends on XENO=5FDRIVERS=5FNET && PCI && m
     tristate "New Intel(R) PRO/1000 PCIe (Gigabit)"
 
 
@@ -68,7 +68,7 @@ config XENO=5FDRIVERS=5FNET=5FDRV=5FVIA=5FRHINE
 config XENO=5FDRIVERS=5FNET=5FDRV=5FIGB
     select I2C
     select I2C=5FALGOBIT
-    depends on XENO=5FDRIVERS=5FNET && PCI
+    depends on XENO=5FDRIVERS=5FNET && PCI && m
     tristate "Intel(R) 82575 (Gigabit)"
 
 
@@ -83,22 +83,22 @@ comment "Embedded MPC Drivers"
     depends on XENO=5FDRIVERS=5FNET
 
 config XENO=5FDRIVERS=5FNET=5FDRV=5FFCC=5FENET
-    depends on XENO=5FDRIVERS=5FNET
+    depends on XENO=5FDRIVERS=5FNET && m
     tristate "MPC8260 FCC Ethernet"
 
 
 config XENO=5FDRIVERS=5FNET=5FDRV=5FFEC=5FENET
-    depends on XENO=5FDRIVERS=5FNET
+    depends on XENO=5FDRIVERS=5FNET && m
     tristate "MPC8xx FEC Ethernet"
 
 
 config XENO=5FDRIVERS=5FNET=5FDRV=5FSCC=5FENET
-    depends on XENO=5FDRIVERS=5FNET
+    depends on XENO=5FDRIVERS=5FNET && m
     tristate "MPC8xx SCC Ethernet"
 
 
 config XENO=5FDRIVERS=5FNET=5FDRV=5FMPC52XX=5FFEC
-    depends on XENO=5FDRIVERS=5FNET
+    depends on XENO=5FDRIVERS=5FNET && m
     tristate "MPC52xx FEC Ethernet"
 
 endif
@@ -124,9 +124,9 @@ config XENO=5FDRIVERS=5FNET=5FDRV=5FAT91=5FETHER
     tristate "AT91RM9200 Board Ethernet Driver"
 
 config XENO=5FDRIVERS=5FNET=5FDRV=5FMACB
-    depends on XENO=5FDRIVERS=5FNET && ARCH=5FAT91
-    select AT91=5FPROGRAMMABLE=5FCLOCKS
-    tristate "MACB AT91SAM926x devices"
+    depends on XENO=5FDRIVERS=5FNET
+    select AT91=5FPROGRAMMABLE=5FCLOCKS if ARCH=5FAT91
+    tristate "Cadence MACB/GEM devices"
     ---help---
     Driver for internal MAC-controller on AT91SAM926x microcontrollers=
.
     Porting by Cristiano Mantovani and Stefano Banzi (Marposs SpA).
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
index f81a7bb..7e6264c 100644
--- a/utils/net/rtnet.in
+++ b/utils/net/rtnet.in
@@ -31,44 +31,65 @@ EOF
 }
 
 init=5Frtnet() {
-    modprobe rtnet >/dev/null || exit 1
-    modprobe rtipv4 >/dev/null || exit 1
-    modprobe $RT=5FDRIVER $RT=5FDRIVER=5FOPTIONS >/dev/null || exit 1
-
-    for dev in $REBIND=5FRT=5FNICS; do
-	if [ -d /sys/bus/pci/devices/$dev/driver ]; then
-	    echo $dev > /sys/bus/pci/devices/$dev/driver/unbind
-	fi
-	echo $dev > /sys/bus/pci/drivers/$RT=5FDRIVER/bind
-    done
+    if [ ! -d /proc/rtnet ]; then
+        modprobe rtnet >/dev/null || exit 1
+    fi
 
+    if [ ! -d /proc/rtnet/ipv4 ]; then
+        modprobe rtipv4 >/dev/null || exit 1
+    fi
     for PROTOCOL in $RT=5FPROTOCOLS; do
-	modprobe rt$PROTOCOL >/dev/null || exit 1
+        if [ ! -d /sys/module/rt$PROTOCOL ]; then
+            if [ "$PROTOCOL" =3D "packet" ]; then
+                modprobe rt$PROTOCOL >/dev/null 2>&1
+            else
+                modprobe rt$PROTOCOL >/dev/null || exit 1
+            fi
+        fi
     done
 
+    if ! grep q rteth0 /proc/rtnet/devices; then
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
+
     if [ $RT=5FLOOPBACK =3D "yes" ]; then
-	modprobe rt=5Floopback >/dev/null || exit 1
+        if ! grep q rtlo /proc/rtnet/devices; then
+            modprobe rt=5Floopback >/dev/null || exit 1
+        fi
     fi
 
-    if [ $RTCAP =3D "yes" ]; then
-	modprobe rtcap >/dev/null || exit 1
+    if [ $RTCAP =3D "yes" -a ! -d /sys/module/rtcap ]; then
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
@@ -336,34 +357,53 @@ case "$1" in
 	;;
 
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
+        if ! grep q rteth0 /proc/rtnet/devices; then
+            modprobe $RT=5FDRIVER $RT=5FDRIVER=5FOPTIONS >/dev/null ||=
 exit 1
+        fi
+        if [ ! -d /sys/module/rtcap ]; then
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
+        fi
+        for PROTOCOL in $RT=5FPROTOCOLS; do
+            if [ ! -d /sys/module/rt$PROTOCOL ]; then
+                if [ "$PROTOCOL" =3D "packet" ]; then
+                    modprobe rt$PROTOCOL >/dev/null 2>&1
+                else
+                    modprobe rt$PROTOCOL >/dev/null || exit 1
+                fi
+            fi
+        done
+
+        if [ $RT=5FLOOPBACK =3D "yes" ]; then
+            if ! grep q rtlo /proc/rtnet/devices; then
+                modprobe rt=5Floopback >/dev/null || exit 1
+            fi
+        fi
+
+        if [ $RTCAP =3D "yes" -a ! -d /sys/module/rtcap ]; then
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
 	usage
-- 
2.1.4


