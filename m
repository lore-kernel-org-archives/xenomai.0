From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 1/2] build: fix make distcheck
Date: Fri, 20 Nov 2020 18:17:10 +0100
Message-Id: <20201120171711.2784854-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

Uninstall udev rules.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 Makefile.am | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index ec1d0a07e..891e53f66 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -29,7 +29,7 @@ dist-hook:
 	rm -fr `find $(distdir) -name '.svn' -o -name CVS  -o -name '.#*' \
 		-o -name '*~' -o -name autom4te.cache`
 
-udev-rules:
+install-udev-rules:
 if XENO_COBALT
 	if test -r $(DESTDIR)/$(sysconfdir)/udev/udev.rules ; then \
 	    for f in $(srcdir)/kernel/cobalt/udev/*.rules ; do \
@@ -45,10 +45,19 @@ if XENO_COBALT
 	fi
 endif
 
+uninstall-udev-rules:
+if XENO_COBALT
+	cd $(srcdir)/kernel/cobalt/udev && for f in *.rules; do \
+	    rm -f $(DESTDIR)/$(sysconfdir)/udev/rules.d/$$f ; \
+	done
+endif
+
 # legacy alias
 install-user: install
 
-install-exec-local: udev-rules
+install-exec-local: install-udev-rules
+
+uninstall-local: uninstall-udev-rules
 
 uninstall-local:
 if XENO_COBALT
-- 
2.26.2


