Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <499AEE93.10908@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Tue, 17 Feb 2009 18:04:19 +0100
Message-ID: <20090217170419.1425.28041.stgit@domain.hid>
In-Reply-To: <20090217170418.1425.56126.stgit@domain.hid>
References: <20090217170418.1425.56126.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH v2 3/4] Add --enable-dlopen-skins configure
	switch
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

To clarify the relation between disabling TLS support and allowing to
dlopen Xenomai skin library, introduce an explicit configure switch.
This way we will also have a control to disable auto-shadowing in the
POSIX skin for dlopen scenarios.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 configure.in |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/configure.in b/configure.in
index 1d7f5fa..679af96 100644
--- a/configure.in
+++ b/configure.in
@@ -758,15 +758,30 @@ LIBS="$LIBS -lrt"
 AC_CHECK_FUNCS([shm_open shm_unlink])
 LIBS="$save_LIBS"
 
+AC_MSG_CHECKING(whether to enable dlopen support for skin libraries)
+AC_ARG_ENABLE(dlopen-skins,
+	AC_HELP_STRING([--enable-dlopen-skins], [Disable TLS features and
+automatic main thread mapping by the POSIX skin to allows dlopen'ing Xenomai
+libs.]),
+	[case "$enableval" in
+	y | yes) CONFIG_XENO_LIBS_DLOPEN=y ;;
+	*) unset CONFIG_XENO_LIBS_DLOPEN ;;
+	esac])
+AC_MSG_RESULT(${CONFIG_XENO_LIBS_DLOPEN:-no})
+if test x$CONFIG_XENO_LIBS_DLOPEN = xy; then
+	AC_DEFINE(CONFIG_XENO_LIBS_DLOPEN,1,[config])
+fi
+
 XENO_DLOPEN_CONSTRAINT=
+
 AC_ARG_WITH([__thread],
 	    AC_HELP_STRING([--without-__thread],
-			   [do not use TLS features (allows for dlopen'ing Xenomai libs)]),
+			   [do not use TLS features]),
 	    [use__thread=$withval],
 	    [use__thread=yes])
 
 dnl Check whether the compiler supports the __thread keyword.
-if test "x$use__thread" != xno; then
+if test "x$use__thread" != xno -a "x$CONFIG_XENO_LIBS_DLOPEN" != xy; then
 	AC_CACHE_CHECK([for __thread], libc_cv_gcc___thread,
 	[cat > conftest.c <<\EOF
 __thread int a __attribute__ ((tls_model ("initial-exec"))) = 42;


