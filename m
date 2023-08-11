Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75885226
	for <xenomai@lists.linux.dev>; Fri, 11 Aug 2023 07:37:59 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230811073751ca5afa7c9c6159e458
        for <xenomai@lists.linux.dev>;
        Fri, 11 Aug 2023 09:37:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=8FZO6qv/zxwasJKtJ3MzLfHsmhyW7IC/mBJ67ceHWHM=;
 b=W12f93jjIZt3B855YsfdGOlPNWFNPZJVQOb69H75JeQoIYyWSDWPOsF5FHNR6vi9UNdX0B
 FFIqOVbixZCwjlOp3ijfFUVwoklFQPdcCEJOL21jI4wqOWmxsXStGWDoE3gtTexMagRFYNeb
 eDzrPmyhgd5r5GQthdCRKy3h8GiRs=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 11 Aug 2023 09:37:39 +0200
Subject: [PATCH 4/7] y2038: build: Introduce new build parameter
 --disable-y2038
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-florian-y2038-2-v1-4-d1cfe2f394a3@siemens.com>
References: <20230809-florian-y2038-2-v1-0-d1cfe2f394a3@siemens.com>
In-Reply-To: <20230809-florian-y2038-2-v1-0-d1cfe2f394a3@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The new --disable-y2038 build parameter will be used to disable
additional function wrapping when the architecture we build for is
affected by the y2038 problem.

The default value is "no" so y2038 support is enabled by default.

If --disable-y2038 is given for an architecture that is not affected it
will be ignored.

CONFIG_XENO_LIBS_Y2038 will be set to 1 if the following conditions
are met:
  - y2038 support was requested (default, no --disable-y2038 given)
  - the target platform is affected by the y2038 problem
  - glibc is used as libc
  - glibc has y2038 support (glibc >= 2.34)

CONFIG_XENO_LIBS_Y2038 will be used later to add necessary glibc
wrappers.

If y2038 support was requested and is available in glibc the CFLAGS
-D_TIME_BITS=64 and -D_FILE_OFFSET_BITS=64 will be added to
affect all compile units.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 configure.ac | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/configure.ac b/configure.ac
index a601f94cd..dade7e9d7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -138,19 +138,23 @@ case "$build_for" in
 	use_tls=yes
 	target_cpu_arch=x86
 	CONFIG_XENO_DEFAULT_PERIOD=100000
+	y2038_affected=yes
 	;;
  arm*-*)
 	target_cpu_arch=arm
 	CONFIG_XENO_DEFAULT_PERIOD=1000000
+	y2038_affected=yes
 	;;
  aarch64-*)
 	target_cpu_arch=arm64
 	CONFIG_XENO_DEFAULT_PERIOD=1000000
+	y2038_affected=no
 	;;
  x86_64-*|amd64-*)
 	use_tls=yes
 	target_cpu_arch=x86
 	CONFIG_XENO_DEFAULT_PERIOD=100000
+	y2038_affected=no
 	;;
  *)
 	if test $rtcore_type = cobalt; then
@@ -781,6 +785,49 @@ AC_ARG_ENABLE([tls],
 	    [use_tls=$enableval])
 AC_MSG_RESULT($use_tls)
 
+AC_MSG_CHECKING(whether glibc has y2038 support)
+AC_TRY_COMPILE([#include <features.h>],
+	[
+		#if !(__GLIBC__ > 2 || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 34))
+			#error "No y2038 support"
+		#endif
+	],
+	glibc_has_y2038_support=yes,
+	glibc_has_y2038_support=no)
+AC_MSG_RESULT($glibc_has_y2038_support)
+
+AC_MSG_CHECKING(whether to enable y2038 support in Xenomai libraries)
+AC_ARG_ENABLE(y2038,
+	AC_HELP_STRING([--disable-y2038], [Disable y2038 support]),
+	[
+		CONFIG_XENO_LIBS_TIME64=no
+	],
+	[
+		if test "$y2038_affected" = "yes"; then
+			CONFIG_XENO_LIBS_TIME64="$glibc_has_y2038_support"
+		else
+			CONFIG_XENO_LIBS_TIME64=no
+		fi
+	])
+AC_MSG_RESULT(${CONFIG_XENO_LIBS_TIME64})
+
+if test "$CONFIG_XENO_LIBS_TIME64" = "yes"; then
+	AC_DEFINE(CONFIG_XENO_LIBS_TIME64,1,[config])
+	XENO_TIME64_CFLAGS="-D_TIME_BITS=64 -D_FILE_OFFSET_BITS=64"
+	XENO_USER_CFLAGS="$XENO_USER_CFLAGS $XENO_TIME64_CFLAGS"
+	XENO_USER_APP_CFLAGS="$XENO_USER_APP_CFLAGS $XENO_TIME64_CFLAGS"
+	AC_SUBST(CONFIG_XENO_LIBS_TIME64)
+else
+	if test "$y2038_affected" = "yes"; then
+		AC_MSG_WARN([You're affected by the time_t overflow in 2038])
+		if test "$glibc_has_y2038_support" = "yes"; then
+			AC_MSG_WARN([You should consider removing --disable-y2038])
+		fi
+	fi
+fi
+AM_CONDITIONAL(CONFIG_XENO_LIBS_TIME64,[test "$CONFIG_XENO_LIBS_TIME64" = "yes"])
+
+
 dnl Check whether the compiler supports the __thread keyword.
 if test "x$use_tls" != xno; then
 	AC_CACHE_CHECK([for __thread keyword], libc_cv_gcc_tls,

-- 
2.39.2

