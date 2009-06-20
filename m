Message-ID: <4A3CC746.3040605@domain.hid>
Date: Sat, 20 Jun 2009 13:25:58 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] debian specific kernel patching/unpatching problems
	with 2.6.29
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

applying the xenomai kernelpatch created during debian package building
results to a corrupt init/Kconfig file and 'make menuconfig' fails. The 
problem
starts with linux-2.6.29.  reason: growing init/Kconfig file, see  [1].
This patch [2] fixed it (tested with 2.6.28 and 2.6.29).

The second problem is unpatching the kernel:
Starting with 2.6.29 the Adoes-IPipe patches have a second hunk for 
init/Kconfig
to remove the last line [3]. This hunk fails while reverse patching the 
kernel. Its
conflicting with the generated Kconfig.frag-patch (see [2] too).
Removing the second init/Kconfig-Hunk from the adeos-patch [3] fixed it.

tested with 2.5-rc2, but please merge to xenomai-2.4.x too. thank you.
kisda

[1]
wc -l (unpatched sources from kernel.org)
764  ./linux-2.6.24.7/init/Kconfig
875  ./linux-2.6.25.20/init/Kconfig
925  ./linux-2.6.26.8/init/Kconfig
912  ./linux-2.6.27.25/init/Kconfig
937  ./linux-2.6.28.9/init/Kconfig
1067 ./linux-2.6.29.5/init/Kconfig
1156 ./linux-2.6.30.0/init/Kconfig

[2]
diff -uNrp xenomai-2.4.91.orig/debian/prepare-patch.sh 
xenomai-2.4.91/debian/prepare-patch.sh
--- xenomai-2.4.91.orig/debian/prepare-patch.sh    2009-03-30 
12:24:49.000000000 +0200
+++ xenomai-2.4.91/debian/prepare-patch.sh    2009-06-20 
11:40:13.000000000 +0200
@@ -78,7 +78,7 @@ diff_addons() {
 
     echo "--- linux/init/Kconfig    1970-01-01 01:00:00.000000000 
+0100" >> $patch_file
     echo "+++ linux-patched/init/Kconfig    2007-03-06 
17:55:58.000000000 +0000" >> $patch_file
-    echo "@@ -950,0 +950,$lines @@" >> $patch_file
+    echo "@@ -1400,0 +1400,$lines @@" >> $patch_file
     sed -e "s,@LINUX_ARCH@,$linux_arch,g" 
$xenomai_root/scripts/Kconfig.frag | sed 's/^/+/' >> $patch_file
     echo " " >> $patch_file
 }


[3]
diff --git a/init/Kconfig b/init/Kconfig
index 6a5c5fe..759609e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -73,6 +73,7 @@ config INIT_ENV_ARG_LIMIT
 
 config LOCALVERSION
     string "Local version - append to kernel release"
+    default "-ipipe"
     help
       Append an extra string to the end of your kernel version.
       This will show up when you type uname, for example.
@@ -1064,4 +1065,3 @@ source "block/Kconfig"
 
 config PREEMPT_NOTIFIERS
     bool
-


