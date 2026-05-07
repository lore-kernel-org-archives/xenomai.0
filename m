Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B45C373C10
	for <xenomai@lists.linux.dev>; Thu,  7 May 2026 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156655; cv=none; b=je6xWHkaUIyZa8uWESCP2jSg44HW1dhfaAvFVdtT2SqguOuS0k6eU7cvAcvvIKBNYLmCNkWdU9v0lTgpBeiaCqzQxggs4S44Z2EaCwLbpGOFa4DylK0YkFsYCQROE3GioKuKxT/2pCQKPAkqXmeTQQGoTuVBmF3MHXs4HlrRpvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156655; c=relaxed/simple;
	bh=HkGho+MulP+hxntWZaCocERiUFyVAH4YvRgww+pk1I4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tx7M0W3YjJ5/ycH6dQ3DQ3ALq9SlPCKLXqEzFubobmjoeWzWa8hswPcuo9Xqc1JUcm/OGDAFRrh/RoHnn0/OTZ4ETwu54nkyll8TKPvtFdx2qY0s6zu8QGAfgtzRkE30NnZmEu/kpaFUTDQDPzk6qq2pP7o0kmlwbhdhOzThaKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 0B139298580
	for <xenomai@lists.linux.dev>; Thu,  7 May 2026 14:24:10 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id njkYs3noNM6y; Thu,  7 May 2026 14:24:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6DF14298599;
	Thu,  7 May 2026 14:24:09 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id T4eds5tqhGkO; Thu,  7 May 2026 14:24:09 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 36EFB298580;
	Thu,  7 May 2026 14:24:09 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>
Subject: [PATCH] Add build time guard to detect off_t mismatch
Date: Thu,  7 May 2026 14:23:57 +0200
Message-ID: <20260507122357.2463483-1-richard@nod.at>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When Xenomai is built without _FILE_OFFSET_BITS=3D64 on a 32 bit system,
which is the default, but the Xenomai application itself is built later
with _FILE_OFFSET_BITS=3D64, we get a nasty ABI mismatch. Since only very
few cobalt syscalls use off_t, the mismatch goes undiscovered for a
surprisingly long time. In my case it surfaced only after a realtime
application which uses mmap() failed sometimes at mmap() depending on
what functions it called before mmap(). In the good cases it used to
work by chance since the extra bytes used for off_t on the stack were
zero.

To save the next person in the same situation a lot of time, compute
the size of off_t at configure time and compare it against the
application's sizeof(off_t) via a static assertion in a new generated
header, which is included when building Xenomai applications.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 .gitignore                     |  1 +
 configure.ac                   |  4 ++++
 include/Makefile.am            |  2 +-
 include/boilerplate/libc.h     |  1 +
 include/xeno_off_t_assert.h.in | 10 ++++++++++
 5 files changed, 17 insertions(+), 1 deletion(-)
 create mode 100644 include/xeno_off_t_assert.h.in

diff --git a/.gitignore b/.gitignore
index 402604c59..8b35071c9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -26,6 +26,7 @@
 /configure
 /include/stamp-h?
 /libtool
+/include/xeno_off_t_assert.h
 /include/xeno_config.h
 /include/xeno_config.h.in*
 /.ccache
diff --git a/configure.ac b/configure.ac
index 0d6dd87b6..b3d08d6f0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -19,6 +19,10 @@ if test x$prefix =3D xNONE; then
    prefix=3D$ac_default_prefix
 fi
=20
+AC_CHECK_SIZEOF([off_t])
+AC_SUBST([SIZEOF_OFF_T], [$ac_cv_sizeof_off_t])
+AC_CONFIG_FILES([include/xeno_off_t_assert.h])
+
 version_code=3D`cat $srcdir/config/version-code`
 CONFIG_XENO_VERSION_MAJOR=3D`expr $version_code : '\([[0-9]]*\)'`
 CONFIG_XENO_VERSION_MINOR=3D`expr $version_code : '[[0-9]]*\.\([[0-9]]*\=
)'`
diff --git a/include/Makefile.am b/include/Makefile.am
index 1e9fe0210..05dda9539 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -1,4 +1,4 @@
-nodist_include_HEADERS=3D$(CONFIG_HEADER)
+nodist_include_HEADERS=3D$(CONFIG_HEADER) $(top_builddir)/include/xeno_o=
ff_t_assert.h
=20
 SUBDIRS =3D 		\
 	boilerplate	\
diff --git a/include/boilerplate/libc.h b/include/boilerplate/libc.h
index 44ddad5af..98d49648a 100644
--- a/include/boilerplate/libc.h
+++ b/include/boilerplate/libc.h
@@ -19,6 +19,7 @@
 #define _BOILERPLATE_LIBC_H
=20
 #include <limits.h>
+#include <xeno_off_t_assert.h>
=20
 #ifdef __IN_XENO__
 /*
diff --git a/include/xeno_off_t_assert.h.in b/include/xeno_off_t_assert.h=
.in
new file mode 100644
index 000000000..29b544b29
--- /dev/null
+++ b/include/xeno_off_t_assert.h.in
@@ -0,0 +1,10 @@
+#ifndef XENO_OFF_T_ASSERT_H
+#define XENO_OFF_T_ASSERT_H
+
+#include <sys/types.h>
+
+#define SIZEOF_OFF_T @SIZEOF_OFF_T@
+
+_Static_assert(SIZEOF_OFF_T =3D=3D sizeof(off_t), "off_t size mismatch")=
;
+
+#endif /* XENO_OFF_T_ASSERT_H */
--=20
2.51.0

