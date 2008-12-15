Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <49466BAA.6000804@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Mon, 15 Dec 2008 15:34:36 +0100
Message-ID: <20081215143436.15493.67040.stgit@domain.hid>
In-Reply-To: <20081215143435.15493.94798.stgit@domain.hid>
References: <20081215143435.15493.94798.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 5/6] Replace --without-__tread with
	--enable-dlopen-skins
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

In practice, you only want to disable __thread support when Xenomai skin
libraries should be loadable via dlopen. Therefore rename the related
configure switch accordingly.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 configure.in |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/configure.in b/configure.in
index 6558ebf..ff6bf66 100644
--- a/configure.in
+++ b/configure.in
@@ -765,14 +765,21 @@ AC_CHECK_FUNCS([shm_open shm_unlink])
 LIBS="$save_LIBS"
 
 XENO_DLOPEN_CONSTRAINT=
-AC_ARG_WITH([__thread],
-	    AC_HELP_STRING([--without-__thread],
-			   [do not use TLS features (allows for dlopen'ing Xenomai libs)]),
-	    [use__thread=$withval],
-	    [use__thread=yes])
+AC_MSG_CHECKING(whether to enable dlopen support for skin libraries)
+AC_ARG_ENABLE(dlopen-skins,
+	AC_HELP_STRING([--enable-dlopen-skins], [Disable TLS features and automatic
+main thread mapping by the POSIX skin to allows dlopen'ing Xenomai libs.]),
+	[case "$enableval" in
+	y | yes) CONFIG_XENO_LIBS_DLOPEN=y ;;
+	*) unset CONFIG_XENO_LIBS_DLOPEN ;;
+	esac])
+AC_MSG_RESULT(${CONFIG_XENO_LIBS_DLOPEN:-no})
+if test x$CONFIG_XENO_LIBS_DLOPEN = xy; then
+	AC_DEFINE(CONFIG_XENO_LIBS_DLOPEN,1,[config])
+fi
 
 dnl Check whether the compiler supports the __thread keyword.
-if test "x$use__thread" != xno; then
+if test "x$CONFIG_XENO_LIBS_DLOPEN" != xy; then
 	AC_CACHE_CHECK([for __thread], libc_cv_gcc___thread,
 	[cat > conftest.c <<\EOF
 __thread int a __attribute__ ((tls_model ("initial-exec"))) = 42;


