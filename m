From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fd7363b0-ea79-3f59-08ea-b6617e1d5422@siemens.com>
Date: Wed, 10 Oct 2018 17:23:03 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] build: Modernize device installation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Drop the obsoleted mknod calls - all modern systems use devtmpfs, and
that creates the rtp nodes for us.

Furthermore, switch the remaining installation of udev rules to proper
automake, using sysconfdir, INSTALL_DATA etc., dropping sudo from those
steps (installation into privileged folders implies "sudo make install"
or running as root in the first place).

Finally, only differentiate between pre-existing udev.rules and default
installation into rules.d.

This removes the need for the install-user target - drop it.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Makefile.am | 54 ++++++++++++++----------------------------------------
 1 file changed, 14 insertions(+), 40 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index eb3b147658..ef78bee898 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -31,48 +31,22 @@ dist-hook:
 	rm -fr `find $(distdir) -name '.svn' -o -name CVS  -o -name '.#*' \
 		-o -name '*~' -o -name autom4te.cache`
 
-dev devices:
+udev-rules:
 if XENO_COBALT
-	@$(mkinstalldirs) $(DESTDIR)/dev; \
-	if test x`id -u` = x0; then \
-	   sudo= ; \
-	else if test \! "x`type $(SUDO)`" = x ; then \
-	   echo "sudo found (sudo is $(SUDO)), testing it..." ; \
-	   $(SUDO) sh -c "( mknod $(DESTDIR)/dev/dummy c 150 0 && rm -f $(DESTDIR)/dev/dummy )" && \
-	   sudo="$(SUDO)" || { \
-echo '*** Warning: you are not super-user and sudo does not work, real-time devices' ; \
-echo '*** nodes will not be created.' ; \
-echo '*** If you do not create these devices by hand, Xenomai test programs will not' ; \
-echo '*** work.' ; \
-echo '*** To create these devices please run "make devices" with super-user' ; \
-echo '*** privileges.' ; \
-	     exit 0 ; } ; \
-	   echo 'sudo is working.' ; \
-	   fi ; \
-	fi ; \
-	if test -r $(DESTDIR)/etc/udev/udev.rules ; then \
-	   for f in $(srcdir)/kernel/cobalt/udev/*.rules ; do \
-	   b=`basename $$f` ; \
-	   grep -q Xenomai:`basename $$b .rules` $(DESTDIR)/etc/udev/udev.rules || \
-	   $$sudo sh -c "( echo ; cat $$f ) >> $(DESTDIR)/etc/udev/udev.rules" ; \
-	   done ; \
-	else if test -d $(DESTDIR)/etc/udev/rules.d ; then \
-	      for f in $(srcdir)/kernel/cobalt/udev/*.rules ; do \
-		 $$sudo cp $$f $(DESTDIR)/etc/udev/rules.d/ ; \
-	      done ; \
-	   fi ; \
-	fi ; \
-	for n in `seq 0 31` ; do \
-	   f="$(DESTDIR)/dev/rtp$$n" ; \
-	   if test \! -c $$f ; then \
-	      $$sudo mknod -m 666 $$f c 150 $$n ; \
-	   fi ; \
-	done
+	if test -r $(DESTDIR)/$(sysconfdir)/udev/udev.rules ; then \
+	    for f in $(srcdir)/kernel/cobalt/udev/*.rules ; do \
+		b=`basename $$f` ; \
+		grep -q Xenomai:`basename $$b .rules` $(DESTDIR)/$(sysconfdir)/udev/udev.rules || \
+		( echo ; cat $$f ) >> $(DESTDIR)/$(sysconfdir)/udev/udev.rules ; \
+	    done ; \
+	else \
+	    $(mkinstalldirs) $(DESTDIR)/$(sysconfdir)/udev/rules.d; \
+	    for f in $(srcdir)/kernel/cobalt/udev/*.rules ; do \
+		$(INSTALL_DATA) $$f $(DESTDIR)/$(sysconfdir)/udev/rules.d/ ; \
+	    done ; \
+	fi
 endif
 
-install-exec-local: devices
-
-install-user:
-	$(MAKE) SUDO=false install
+install-exec-local: udev-rules
 
 .PHONY: FORCE
-- 
2.16.4

