Message-ID: <434B7A27.7020704@domain.hid>
Date: Tue, 11 Oct 2005 02:39:03 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
References: <434A4719.60503@domain.hid> <434A49CB.5080009@domain.hid>
In-Reply-To: <434A49CB.5080009@domain.hid>
Content-Type: multipart/mixed; boundary="------------090008060309070802030705"
Subject: [Xenomai-core] [patch] xeno-config --verbose
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

This is a multi-part message in MIME format.
--------------090008060309070802030705
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

attached patch gives xeno-config a --verbose option, ie:

soekris:/usr/realtime/2.6.13-ski6-v1/bin# xeno-config --v
xeno-config --verbose
    --version="2.0"
    --cc="gcc"
    --cross-compile=""
    --arch="i386"
    --subarch=""
    --prefix="/usr/realtime/2.6.13-ski6-v1"
    --config="/usr/realtime/2.6.13-ski6-v1/share/xenomai/config-xenomai-2.0"
    --kernel-cflags="-I. -I/usr/realtime/2.6.13-ski6-v1/include 
-D__XENO__ -ffast-math -mhard-float" aka --mod*-cflags
    --xeno-cflags="-I. -I/usr/realtime/2.6.13-ski6-v1/include -O2 
-I/lib/modules/2.6.13-ski6-v1/build/include -D_GNU_SOURCE -D_REENTRANT 
-D__XENO__  -march=pentium-mmx -Wall -pipe -fstrict-aliasing 
-Wno-strict-aliasing" aka --fusion-cflags
    --xeno-ldflags="-L/usr/realtime/2.6.13-ski6-v1/lib -lpthread" aka 
--fusion-ldlags
    --posix-cflags="-I. -I/usr/realtime/2.6.13-ski6-v1/include 
-I/usr/realtime/2.6.13-ski6-v1/include/posix -O2 
-I/lib/modules/2.6.13-ski6-v1/build/include -D_GNU_SOURCE -D_REENTRANT 
-D__XENO__  -march=pentium-mmx -Wall -pipe -fstrict-aliasing 
-Wno-strict-aliasing"
    --posix-ldflags="-L/usr/realtime/2.6.13-ski6-v1/lib -lpthread_rt 
-lpthread -lrt"
    --uvm-cflags="=-I. -I/usr/realtime/2.6.13-ski6-v1/include -O2 
-I/lib/modules/2.6.13-ski6-v1/build/include -D_GNU_SOURCE -D_REENTRANT 
-D__XENO__  -march=pentium-mmx -Wall -pipe -fstrict-aliasing 
-Wno-strict-aliasing -D__XENO_UVM__ "
    --uvm-ldflags="=-u__xeno_skin_init 
-L/usr/realtime/2.6.13-ski6-v1/lib -luvm -lnucleus -lpthread"
    --mod*-dir="=/usr/realtime/2.6.13-ski6-v1/modules"
    --sym*-dir="/usr/realtime/2.6.13-ski6-v1/symbols"
    --libdir="/usr/realtime/2.6.13-ski6-v1/lib"
    --linux-dir="/lib/modules/2.6.13-ski6-v1/build"
    --linux-ver*="2.6.13"


When called w/o args, it outputs the above, then prints the (current) 
usage message too.

hth
jimc

--------------090008060309070802030705
Content-Type: text/plain;
 name="patch-xeno-config-3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-xeno-config-3"

Index: scripts/xeno-config.in
===================================================================
--- scripts/xeno-config.in	(revision 22)
+++ scripts/xeno-config.in	(working copy)
@@ -44,10 +44,10 @@
         --subarch
         --prefix
         --config
-        --module-cflags
-        --module-cxxflags
-        --xeno-cflags
-        --xeno-ldflags
+        --module-cflags,--kernel-cflags
+        --module-cxxflags,--kernel-cxxflags
+        --xeno-cflags,--fusion-cflags
+        --xeno-ldflags,--fusion-ldflags
         --posix-cflags
         --posix-ldflags
         --uvm-cflags
@@ -61,12 +61,44 @@
     exit $1
 }
 
+verbose ()
+{
+    echo xeno-config --verbose
+
+    echo "   " --version="\"${XENO_VERSION}\""
+    echo "   " --cc="\"$XENO_CC\""
+    echo "   " --cross-compile="\"$CROSS_COMPILE\""
+    echo "   " --arch="\"$XENO_TARGET_ARCH\""
+    echo "   " --subarch="\"$XENO_TARGET_SUBARCH\""
+    echo "   " --prefix="\"$XENO_PREFIX\""
+    echo "   " --config="\"$XENO_CONFIG\""
+    echo "   " --kernel-cflags="\"$XENO_KERNEL_CFLAGS\""
+
+    echo "   " --xeno-cflags="\"$XENO_BASE_CFLAGS\""
+    echo "   " --xeno-ldflags="\"$XENO_BASE_LDFLAGS\""
+    echo "   " --posix-cflags="\"$XENO_POSIX_CFLAGS\""
+    echo "   " --posix-ldflags="\"$XENO_POSIX_LDFLAGS\""
+    echo "   " --uvm-cflags="\"=$XENO_UVM_CFLAGS \""
+    echo "   " --uvm-ldflags="\"=$XENO_UVM_LDFLAGS\""
+
+    echo "   " --mod*-dir="\"=$XENO_MODULE_DIR\""
+    echo "   " --sym*-dir="\"$XENO_SYMBOL_DIR\""
+    echo "   " --libdir="\"$XENO_LIBRARY_DIR\""
+    echo "   " --linux-dir="\"$XENO_LINUX_DIR\""
+    echo "   " --linux-ver*="\"$XENO_LINUX_VERSION\""
+}
+
 if test $# -eq 0; then
+    verbose $*
     usage 1 1>&2
 fi
 
 while test $# -gt 0; do
     case "$1" in
+        --v|--verbose)
+            verbose $*
+            exit 0
+            ;;
         --version)
             echo ${XENO_VERSION}
             ;;

--------------090008060309070802030705--

