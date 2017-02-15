From: Thierry Bultel <tbultel@pixelsurmer.com>
Date: Wed, 15 Feb 2017 18:13:43 +0100
Message-Id: <1487178823-4062-1-git-send-email-tbultel@pixelsurmer.com>
Subject: [Xenomai] [PATCH] automake: add a conditionnal to rt devices install
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

When cross building from a build system (like buildroot),
it is not convenient to get the sudo prompt for the installation
of cobalt rt devices.
Calling mknod is the responsibility of the build system, that
will perform it under a fakeroot environnement
The fix simply checks the existence of NO_RT_DEVICES environment
that can be set when bootstrapping
---
 Makefile.am  | 2 ++
 configure.ac | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index eb3b147..3493bb1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -33,6 +33,7 @@ dist-hook:
 
 dev devices:
 if XENO_COBALT
+if !NO_RT_DEVICES
 	@$(mkinstalldirs) $(DESTDIR)/dev; \
 	if test x`id -u` = x0; then \
 	   sudo= ; \
@@ -69,6 +70,7 @@ echo '*** privileges.' ; \
 	   fi ; \
 	done
 endif
+endif
 
 install-exec-local: devices
 
diff --git a/configure.ac b/configure.ac
index 83bc809..b7a04c0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -48,6 +48,8 @@ AC_ARG_WITH(core,
     ])
 AC_MSG_RESULT($rtcore_type)
 
+AM_CONDITIONAL(NO_RT_DEVICES,[test x$NO_RT_DEVICES != x])
+
 AM_CONDITIONAL(XENO_COBALT,[test x$rtcore_type = xcobalt])
 test x$rtcore_type = xcobalt && AC_DEFINE(CONFIG_XENO_COBALT,1,[config])
 AM_CONDITIONAL(XENO_MERCURY,[test x$rtcore_type = xmercury])
-- 
1.9.1


