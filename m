From: Paul <paul_c@domain.hid>
Date: Mon, 19 Mar 2007 00:28:36 +0000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0kd/FSABFkeIAXT"
Message-Id: <200703190028.36626.paul_c@domain.hid>
Subject: [Xenomai-core] More debian/rule diffs
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

--Boundary-00=_0kd/FSABFkeIAXT
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



Attached, a small patch to add a build dependency for findutils. Also includes 
the top level CREDITS and ChangeLog in each package.

 The configure options used to build the user space libraries now get included 
in the package metadata which may be of interest to the user - Usefull if any 
of the strong bindings are likely to cause problems.


Regards, Paul.




--Boundary-00=_0kd/FSABFkeIAXT
Content-Type: text/x-diff;
  charset="us-ascii";
  name="debian_rules.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="debian_rules.diff"

Index: debian/control
===================================================================
--- debian/control	(revision 2299)
+++ debian/control	(working copy)
@@ -2,7 +2,7 @@ Source: xenomai
 Section: devel
 Priority: extra
 Maintainer: Paul Corner <paul_c@domain.hid>
-Build-Depends: debhelper (>= 5), build-essential, dh-kpatches
+Build-Depends: debhelper (>= 5), build-essential, dh-kpatches, findutils (>= 4.2.28)
 Standards-Version: 3.7.2
 
 Package: linux-patch-xenomai
Index: debian/changelog
===================================================================
--- debian/changelog	(revision 2299)
+++ debian/changelog	(working copy)
@@ -1,3 +1,10 @@
+xenomai (2.3.50-05+r2299) unstable; urgency=low
+
+  * Add top level ChangeLog and CREDITS to each package.
+  * rebuilt from SVN tag 2299
+
+ -- Paul Corner <paul_c@domain.hid>  Thu, 15 Mar 2007 11:03:14 +0000
+
 xenomai (2.3.50-04) unstable; urgency=low
 
   * Remove demo & snippets from the patches - Installed in xenomai-dev
Index: debian/rules
===================================================================
--- debian/rules	(revision 2299)
+++ debian/rules	(working copy)
@@ -30,11 +30,12 @@ endif
 ifeq ($(DEB_BUILD_ARCH), arm)
 	CONFIG_OPTS =
 endif
+	CONFIG_OPTS += --prefix=/usr \
+	            --includedir=/usr/include/xenomai \
+	            --mandir=/usr/share/man
 
 build: build-stamp
-	./configure $(CONFIG_OPTS) --prefix=/usr \
-	                    --includedir=/usr/include/xenomai \
-	                    --mandir=/usr/share/man
+	./configure $(CONFIG_OPTS)
 	$(MAKE)
 #	The kernel patches get generated next - Likely to involve some
 #	additional scripting..
@@ -68,8 +69,10 @@ install: build
 	mkdir -p $(CURDIR)/debian/xenomai-dev/usr/lib
 	mv -f $(CURDIR)/debian/tmp/usr/lib/*.a $(CURDIR)/debian/xenomai-dev/usr/lib
 	mv -f $(CURDIR)/debian/tmp/usr/include $(CURDIR)/debian/xenomai-dev/usr/
-	mkdir -p $(CURDIR)/debian/xenomai-dev/usr/bin
+#	Need posix.wrappers for xeno-config
+	mv -f $(CURDIR)/debian/tmp/usr/lib/posix.wrappers $(CURDIR)/debian/xenomai-dev/usr/lib
 #	The xeno-config only makes sense with headers & stuff.
+	mkdir -p $(CURDIR)/debian/xenomai-dev/usr/bin
 	mv -f $(CURDIR)/debian/tmp/usr/bin/xeno-config $(CURDIR)/debian/xenomai-dev/usr/bin
 #	Now for the documentation.
 	mkdir -p $(CURDIR)/debian/xenomai-docs/usr/share/
@@ -103,6 +106,13 @@ install: build
 	cd $(CURDIR)
 #	The kernel patches get installed next..
 	dh_installkpatches
+#	Add CREDITS, ChangeLog, and READMEs to all packages.
+	for p in linux-patch-xenomai xenomai xenomai-dev xenomai-docs ; do \
+	    mkdir -p $(CURDIR)/debian/$$p/usr/share/doc/$$p ; \
+	    for f in CREDITS ChangeLog README.INSTALL TROUBLESHOOTING ; do \
+	        install -m 0644 $$f $(CURDIR)/debian/$$p/usr/share/doc/$$p/ ; \
+	    done ; \
+	done
 
 # Build architecture-independent files here.
 binary-indep: install
@@ -124,6 +134,12 @@ binary-indep: install
 	cat $(CURDIR)/debian/linux-patch-xenomai.kpatches | \
 	    awk 'NR>4 {sub(/^/," ");print}' >> \
 	        $(CURDIR)/debian/linux-patch-xenomai/DEBIAN/control
+#	 Echo config options to control.
+	echo " ." >> $(CURDIR)/debian/xenomai/DEBIAN/control
+	echo " Compiled with the following options." >> \
+	        $(CURDIR)/debian/xenomai/DEBIAN/control
+	echo "$(CONFIG_OPTS)" | awk '{ for ( i=1 ; i<=NF ; i++ ) print "   "$$i }' >> \
+	        $(CURDIR)/debian/xenomai/DEBIAN/control
 #	 End of hackery.
 	dh_md5sums
 	dh_builddeb

--Boundary-00=_0kd/FSABFkeIAXT--

