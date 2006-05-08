Message-ID: <445EBCFC.2010604@domain.hid>
Date: Sun, 07 May 2006 23:37:32 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050209010707030506000607"
Subject: [Xenomai-core] [patch] prepare-kernel shouldnt alter files thru
	links
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------050209010707030506000607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


attached patch corrects a mistake in rev 985, which chmod'd a read-only 
file,
even if it was a symlink from a kernel-tree cloned with lndir.
This resulted in a bad original tree for use in building vanilla kernels.

with patch, script renames the symlink, copies it to the expected name,
and *then* chmods it, and appends to it.   Now vanilla kernel builds also
using same tree re-make w/o actually recompiling anything.


--------------050209010707030506000607
Content-Type: text/plain;
 name="patch-prep-kernel"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-prep-kernel"

Index: scripts/prepare-kernel.sh
===================================================================
--- scripts/prepare-kernel.sh	(revision 1029)
+++ scripts/prepare-kernel.sh	(working copy)
@@ -48,6 +48,10 @@
 patch_append() {
     file="$1"
     if test "x$output_patch" = "x"; then
+	if test -L "$linux_tree/$file" ; then
+	    mv "$linux_tree/$file" "$linux_tree/$file.orig"
+	    cp "$linux_tree/$file.orig" "$linux_tree/$file"
+	fi
 	chmod +w "$linux_tree/$file"
         cat >> "$linux_tree/$file"
     else

--------------050209010707030506000607--

