From: Paul <paul_c@domain.hid>
Date: Mon, 12 Mar 2007 17:56:08 +0000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4QZ9FmOacgV9IXL"
Message-Id: <200703121756.08070.paul_c@domain.hid>
Subject: [Xenomai-core] debian/rules update
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

--Boundary-00=_4QZ9FmOacgV9IXL
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Attached, a patch to include code examples in the final -dev package along 
with some cleanup of the patches. Also contains a bug fix for the postinst 
script that I hit on when installing a new build.

A question for the project admins: Do you have a Release Manager to coordinate 
package releases ?


Regards, Paul.




--Boundary-00=_4QZ9FmOacgV9IXL
Content-Type: text/x-diff; charset="us-ascii"; name="debian_rules-o4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="debian_rules-o4.diff"

Index: debian/control
===================================================================
--- debian/control	(revision 2291)
+++ debian/control	(working copy)
@@ -14,7 +14,12 @@ Description: Linux kernel patches for Xe
  Xenomai kernel patches - See www.xenomai.org
  .
  Patches for 2.6 series kernels - These are intended for use with kernel-package
- and a virgin linux source tree.
+ and a virgin linux source tree. Note: These patches include the base adeos-ipipe
+ patch along with all the additional material normally added by the prepare-kernel.sh
+ script.
+ .
+ This package contains the following patches:
+ .
 
 Package: xenomai
 Section: devel
@@ -37,6 +42,9 @@ Description: Headers and static libs for
  .
  This package also contains the static libraries and scripts used
  to compile realtime applications.
+ .
+ User space and kernel examples can be found in /usr/share/xenomai
+ along with suitable make files.
 
 Package: xenomai-docs
 Section: devel
Index: debian/xenomai.postinst
===================================================================
--- debian/xenomai.postinst	(revision 2291)
+++ debian/xenomai.postinst	(working copy)
@@ -1,5 +1,6 @@
 #!/bin/sh
 
-ln -s ../xenomai.rules /etc/udev/rules.d/xenomai.rules
+rm -f /etc/udev/rules.d/xenomai.rules
+ln -sf ../xenomai.rules /etc/udev/rules.d/xenomai.rules
 
 #DEBHELPER#
Index: debian/prepare-patch.sh
===================================================================
--- debian/prepare-patch.sh	(revision 2291)
+++ debian/prepare-patch.sh	(working copy)
@@ -64,8 +64,9 @@ echo " cp $xenomai_root/$target_dir/$f $
 generate_patch() {
     (
     cd "$temp_tree"
+    find . -name demos -o -name snippets -exec rm -fR {} \+ &&
     find . -type f |
-    while read f; do
+    while read f ; do
         diff -Naurd "$linux_tree/$f" "$f" |
         sed -e "s,^--- ${linux_tree}/\.\(/.*\)$,--- linux\1," \
             -e "s,^+++ \.\(/.*\)$,+++ linux-patched\1,"
@@ -139,8 +140,6 @@ echo "Patch-name: Xenomai realtime kerne
 echo "Patch-id: xenomai" >> $xenomai_root/debian/linux-patch-xenomai.kpatches
 echo "Architecture: all" >> $xenomai_root/debian/linux-patch-xenomai.kpatches
 
-echo "" >> $xenomai_root/debian/linux-patch-xenomai.kpatches
-
 find $xenomai_root/ksrc/ -name "adeos-ipipe-2.6.*.patch" |
 while read f ; do
 
Index: debian/changelog
===================================================================
--- debian/changelog	(revision 2291)
+++ debian/changelog	(working copy)
@@ -1,3 +1,18 @@
+xenomai (2.3.50-04) unstable; urgency=low
+
+  * Remove demo & snippets from the patches - Installed in xenomai-dev
+  * linux-patches-xenomai lists patches, architectures, & kernel version
+    in the package description meta-data.
+
+ -- Paul Corner <paul_c@domain.hid>  Mon, 12 Mar 2007 17:30:00 +0000
+
+xenomai (2.3.50-03) unstable; urgency=low
+
+  * Revision 2281
+  * Fix bug in postinst script - Need to overwrite the symlink
+
+ -- Paul Corner <paul_c@domain.hid>  Sun, 11 Mar 2007 20:30:00 +0000
+
 xenomai (2.3.50-02) unstable; urgency=low
 
   * Apply patch to fix includedir bug - rules updated..
Index: debian/rules
===================================================================
--- debian/rules	(revision 2291)
+++ debian/rules	(working copy)
@@ -86,17 +86,26 @@ install: build
 #	test applications.
 	mkdir -p $(CURDIR)/debian/xenomai/usr/share
 	mv -f $(CURDIR)/debian/tmp/usr/share/xenomai $(CURDIR)/debian/xenomai/usr/share
-	mkdir -p $(CURDIR)/debian/xenomai/etc/udev
 #	install $(CURDIR)/ksrc/nucleus/udev/*.rules $(CURDIR)/debian/xenomai/etc/udev
+	mkdir -p $(CURDIR)/debian/xenomai/etc/udev
 	for f in $(CURDIR)/ksrc/nucleus/udev/*.rules ; do \
 	    cat $$f >> $(CURDIR)/debian/xenomai/etc/udev/xenomai.rules ; \
 	done
+#	Install examples in the dev package.
+	mkdir -p $(CURDIR)/debian/xenomai-dev/usr/share/xenomai
+	cp -fR $(CURDIR)/examples $(CURDIR)/debian/xenomai-dev/usr/share/xenomai
+#	 then kernel demos & snippets
+	cd $(CURDIR)/ksrc && find . -name demos -o  -name snippets | \
+	    while read d ; do \
+	        mkdir -p $(CURDIR)/debian/xenomai-dev/usr/share/xenomai/examples/kernel/$$d ; \
+	        install -m 0644 $$d/* $(CURDIR)/debian/xenomai-dev/usr/share/xenomai/examples/kernel/$$d ; \
+	    done ; \
+	cd $(CURDIR)
 #	The kernel patches get installed next..
 	dh_installkpatches
 
-
 # Build architecture-independent files here.
-binary-indep: build install
+binary-indep: install
 	dh_testdir
 	dh_testroot
 	dh_installdocs
@@ -110,6 +119,12 @@ binary-indep: build install
 	dh_shlibdeps -L xenomai -L xenomai-dev
 #	dh_shlibdeps
 	dh_gencontrol
+#	 Here follows a little hackery to insert the patch list        
+#	 into the control file for linux-patch-xenomai
+	cat $(CURDIR)/debian/linux-patch-xenomai.kpatches | \
+	    awk 'NR>4 {sub(/^/," ");print}' >> \
+	        $(CURDIR)/debian/linux-patch-xenomai/DEBIAN/control
+#	 End of hackery.
 	dh_md5sums
 	dh_builddeb
 

--Boundary-00=_4QZ9FmOacgV9IXL--

