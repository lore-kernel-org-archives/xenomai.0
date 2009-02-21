From: Paul <paul_c@domain.hid>
Date: Sat, 21 Feb 2009 14:06:44 +0000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0pAoJpZnWgc1f/o"
Message-Id: <200902211406.44439.paul_c@domain.hid>
Subject: [Xenomai-core] [PATCH] debian/prepare-patch
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

--Boundary-00=_0pAoJpZnWgc1f/o
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Now that Debian has gone "stable" with Lenny, I've been updating some of my 
local repositories - The current debian/rule set produces a horribly broken 
patch for 2.6.28 (on x86), and probably other kernels. The attached patch 
goes some way to resolving this problem for trunk and probably needs to be 
applied to the v2.4.x branch so that it can be picke up by the Debian team.


Regards, Paul.





--Boundary-00=_0pAoJpZnWgc1f/o
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="debian_kpatch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="debian_kpatch.diff"

Index: debian/prepare-patch.sh
===================================================================
--- debian/prepare-patch.sh	(revision 4639)
+++ debian/prepare-patch.sh	(working copy)
@@ -74,12 +74,11 @@ generate_patch() {
 }
 
 diff_addons() {
-    lines=`(echo ; echo ; cat $xenomai_root/scripts/Kconfig.frag) | wc -l`
+    lines=`cat $xenomai_root/scripts/Kconfig.frag | wc -l`
 
-    echo "--- linux/arch/$linux_arch/Kconfig	1970-01-01 01:00:00.000000000 +0100" >> $patch_file
-    echo "+++ linux-patched/arch/$linux_arch/Kconfig	2007-03-06 17:55:58.000000000 +0000" >> $patch_file
-    echo "@@ -40,2 +40,$lines @@" >> $patch_file
-    echo " source \"init/Kconfig\"" >> $patch_file
+    echo "--- linux/init/Kconfig	1970-01-01 01:00:00.000000000 +0100" >> $patch_file
+    echo "+++ linux-patched/init/Kconfig	2007-03-06 17:55:58.000000000 +0000" >> $patch_file
+    echo "@@ -950,0 +950,$lines @@" >> $patch_file
     sed -e "s,@LINUX_ARCH@,$linux_arch,g" $xenomai_root/scripts/Kconfig.frag | sed 's/^/+/' >> $patch_file
     echo " " >> $patch_file
 }

--Boundary-00=_0pAoJpZnWgc1f/o--

