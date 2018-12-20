From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 1/2] Remove version name
Message-ID: <98fe2e20-bad6-7c24-945c-f2c0bd20a743@siemens.com>
Date: Thu, 20 Dec 2018 08:58:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

This drops the naming of each release, lowering the creative effort for
the release manager and, thus, potentially raising the motivation to
release more often.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

I'm inclined to backport this to stable as well because I strongly
suspect that no one outside of the core makes use of
[CONFIG_]XENO_VERSION_NAME.

 config/version-name       | 1 -
 configure.ac              | 2 --
 include/xenomai/version.h | 2 --
 kernel/cobalt/init.c      | 3 +--
 scripts/Kconfig.frag      | 4 ----
 scripts/prepare-kernel.sh | 2 --
 6 files changed, 1 insertion(+), 13 deletions(-)
 delete mode 100644 config/version-name

diff --git a/config/version-name b/config/version-name
deleted file mode 100644
index 8c515019d4..0000000000
--- a/config/version-name
+++ /dev/null
@@ -1 +0,0 @@
-Xenomai -next
diff --git a/configure.ac b/configure.ac
index e2a2d47cfa..b8fd2fbede 100644
--- a/configure.ac
+++ b/configure.ac
@@ -25,7 +25,6 @@ CONFIG_XENO_VERSION_MINOR=`expr $version_code : '[[0-9]]*\.\([[0-9]]*\)'`
 CONFIG_XENO_REVISION_LEVEL=`expr $version_code : '[[0-9]]*\.[[0-9]]*\.\([[0-9]]*\)'`
 CONFIG_XENO_UAPI_LEVEL=`cat $srcdir/config/apirev`
 CONFIG_XENO_VERSION_STRING="$PACKAGE_VERSION"
-CONFIG_XENO_VERSION_NAME=`cat $srcdir/config/version-name`
 topdir=`cd $srcdir && pwd`
 
 dnl Find out whether we build for Cobalt core, i.e. dual kernel mode,
@@ -601,7 +600,6 @@ AC_DEFINE_UNQUOTED(CONFIG_XENO_VERSION_MINOR,$CONFIG_XENO_VERSION_MINOR,[config]
 AC_DEFINE_UNQUOTED(CONFIG_XENO_REVISION_LEVEL,$CONFIG_XENO_REVISION_LEVEL,[config])
 AC_DEFINE_UNQUOTED(CONFIG_XENO_UAPI_LEVEL,$CONFIG_XENO_UAPI_LEVEL,[config])
 AC_DEFINE_UNQUOTED(CONFIG_XENO_VERSION_STRING,"$CONFIG_XENO_VERSION_STRING",[config])
-AC_DEFINE_UNQUOTED(CONFIG_XENO_VERSION_NAME,"$CONFIG_XENO_VERSION_NAME",[config])
 AC_DEFINE_UNQUOTED(CONFIG_XENO_PREFIX,"$prefix",[config])
 AC_DEFINE_UNQUOTED(CONFIG_XENO_BUILD_ARGS,"$XENO_BUILD_ARGS",[config])
 
diff --git a/include/xenomai/version.h b/include/xenomai/version.h
index b66b3cc28c..bf603be2a9 100644
--- a/include/xenomai/version.h
+++ b/include/xenomai/version.h
@@ -31,6 +31,4 @@
 
 #define XENO_VERSION_STRING	CONFIG_XENO_VERSION_STRING
 
-#define XENO_VERSION_NAME	CONFIG_XENO_VERSION_NAME
-
 #endif /* _XENOMAI_VERSION_H */
diff --git a/kernel/cobalt/init.c b/kernel/cobalt/init.c
index 22066953b2..dbe321c3b9 100644
--- a/kernel/cobalt/init.c
+++ b/kernel/cobalt/init.c
@@ -353,9 +353,8 @@ static int __init xenomai_init(void)
 
 	rtdm_fd_init();
 
-	printk(XENO_INFO "Cobalt v%s (%s) %s%s%s%s\n",
+	printk(XENO_INFO "Cobalt v%s %s%s%s%s\n",
 	       XENO_VERSION_STRING,
-	       XENO_VERSION_NAME,
 	       boot_debug_notice,
 	       boot_lat_trace_notice,
 	       boot_evt_trace_notice,
diff --git a/scripts/Kconfig.frag b/scripts/Kconfig.frag
index 2f327bb808..cd39f7670b 100644
--- a/scripts/Kconfig.frag
+++ b/scripts/Kconfig.frag
@@ -49,7 +49,3 @@ config XENO_REVISION_LEVEL
 config XENO_VERSION_STRING
        string
        default @VERSION_STRING@
-
-config XENO_VERSION_NAME
-       string
-       default "@VERSION_NAME@"
diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 37d7aa7d46..964e42e832 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -372,12 +372,10 @@ case $linux_VERSION.$linux_PATCHLEVEL in
 	version_minor=`expr $version_stamp : '[[0-9]]*\.\([[0-9]*]*\)' || true`
 	revision_level=`expr $version_stamp : '[[0-9]]*\.[[0-9]*]*\.\([[0-9]*]*\)' || true`
 	version_string=`cat $xenomai_root/config/version-label`
-	version_name=`cat $xenomai_root/config/version-name`
 	sed -e "s,@VERSION_MAJOR@,$version_major,g" \
 	    -e "s,@VERSION_MINOR@,$version_minor,g" \
 	    -e "s,@REVISION_LEVEL@,$revision_level,g" \
 	    -e "s,@VERSION_STRING@,$version_string,g" \
-	    -e "s,@VERSION_NAME@,$version_name,g" \
 	    $xenomai_root/scripts/Kconfig.frag |
             patch_append init/Kconfig
     fi
-- 
2.16.4

