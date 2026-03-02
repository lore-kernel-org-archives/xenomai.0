Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B47430BA1
	for <xenomai@lists.linux.dev>; Mon,  2 Mar 2026 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444906; cv=none; b=iICQ4XsHcTMev/xEPv12PJr1StiO9Hdqk4GDsF5Cdf8AdBFapqyDznddIXlTgrVHK+jcgSjcB0CgtMqCds7ZGgBWc+UFWMgiifKJCvAWRarI6NRC8srrzCrkoxXOBi4qWZmteLMBcxBJlzn9X8xDni9/pdf0urvtjF8h+0fpfa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444906; c=relaxed/simple;
	bh=aMNIm30MJPVF6Bm7XYg2VGpn++Z7ihsTjdwkfUXw0hQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FITK3sz7p6TSsnOmf0d6EvsgVf1zf1M443XoZ+7z1G7j5XGBD0u7ut34KcqxAQWcXz3qqvZdjMKFJmZKcxwcL3/GCyjnGeVFU9wbUigLhQnPPObP1L5gNcpvdfZ95i6MRp4bRXiIfmWKQeSYrBQ4XZhMWROGY9RDmUrS8iAuQB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=V1pgnD6N; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="V1pgnD6N"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202603020938111c4bd252c1000207c0
        for <xenomai@lists.linux.dev>;
        Mon, 02 Mar 2026 10:38:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=0hkR+MpvRklghHDZ87DWCyPweoh268vek8DEhDSxpCQ=;
 b=V1pgnD6NutyxByNpTEfy7ycwaqdQVC8G51EncVK4rEZzlgRrC9T7wIFBLwSlUf3h3xeJuA
 5/xIcnXn7rHCrhyMbXCEddc3PkSnFmDaHcNmiZjCjWYIBG/qaQhcz770S5YIFGYJJjjFQHbN
 M4wFOg0uf4IaGtmSVIbERjHFrdJsYPA8lbMDj1u+GQKUG6D6uy9uyh9WdQuF1vavI4fvYjx0
 TkazOZk1c9sIN54TA7ZVQuvzvrVLb3Cdk4lBXTN2AHVUYqCi05GDuyAoAZ/IHPmrrEpZQDIF
 gc3mggyjjs1l+uoVtCuO9T+YNQ3HZ8XY0vnVnnbBEG521ry7vl46diuA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 02 Mar 2026 10:38:17 +0100
Subject: [PATCH v2 18/20] lib/cobalt: Finally build the native time_t
 interfaces on top
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-wip-flo-fix-time64-32bit-native-v2-18-7caefce29bcd@siemens.com>
References: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
In-Reply-To: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

libcobalt was by default providing the time64_t based interfaces in
case time64_t (or y2038) support has been enabled.

We now separated all affected services into a separate compile unit
that allows us to build this compile unit twice. Once with and once
without time64_t support. With that we can build the native interfaces
on top.

libcobalt can now provide both interfaces at the same time. That should
improve backward compatibility a bit.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/wrappers.h | 13 ++++++-------
 lib/cobalt/Makefile.am    | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/include/cobalt/wrappers.h b/include/cobalt/wrappers.h
index a5645a1d48946c47bb117064589e883a250839a7..6d826eedf25c5f7708c4a88532101904fb60cd80 100644
--- a/include/cobalt/wrappers.h
+++ b/include/cobalt/wrappers.h
@@ -34,13 +34,12 @@
  * Make __RT() and __STD() usable in combination with time64_t related services.
  */
 #define COBALT_IMPL_TIME64(T, FN, FN_64, I)                                    \
-	__typeof__(T) __wrap_##FN_64 I                                         \
-		__attribute__((alias("__cobalt_" __stringify(FN)), weak));     \
-	COBALT_IMPL(T, FN, I)
-#define COBALT_DECL_TIME64(T, FN, A, I)                                        \
-	__typeof__(T) __STD(A) I;                                              \
-	extern T __REDIRECT_NTH(__STD(FN), I, __real_##A);                     \
-	COBALT_DECL(T, FN, I)
+	COBALT_IMPL(T, FN_64, I)
+#define COBALT_DECL_TIME64(T, FN, FN_64, I)                                    \
+	COBALT_DECL(T, FN_64, I);                                              \
+	extern T __REDIRECT_NTH(__STD(FN), I, __real_##FN_64);                 \
+	extern T __REDIRECT_NTH(__RT(FN), I, __cobalt_##FN_64);                \
+	extern T __REDIRECT_NTH(__WRAP(FN), I, __wrap_##FN_64)
 #else
 #define COBALT_IMPL_TIME64(T, FN, FN_64, I) COBALT_IMPL(T, FN, I)
 #define COBALT_DECL_TIME64(T, FN, FN_64, I) COBALT_DECL(T, FN, I)
diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
index be678eedf18f2d8a60afbf36060e27f2511383ec..7981e8990724f867c9c4fd97f770df3ccca0d48d 100644
--- a/lib/cobalt/Makefile.am
+++ b/lib/cobalt/Makefile.am
@@ -62,6 +62,25 @@ libcobaltext_la_CPPFLAGS =		\
 	-I$(top_srcdir)/include		\
 	-U_TIME_BITS -U_FILE_OFFSET_BITS
 
+if CONFIG_XENO_LIBS_TIME64
+# If time64_t has ben requested libcobalt is already providing time64_t
+# interfaces. The native interfaces have to be build on top.
+libcobaltnativetime_la_SOURCES =	\
+	wrappers.c			\
+	wrappers_time64.c
+
+libcobaltnativetime_la_LDFLAGS = @XENO_LIB_LDFLAGS@
+
+libcobaltnativetime_la_CPPFLAGS =	\
+	@XENO_COBALT_CFLAGS@		\
+        -I$(top_srcdir)/include/cobalt	\
+        -I$(top_srcdir)/include		\
+        -U_TIME_BITS -U_FILE_OFFSET_BITS
+
+noinst_LTLIBRARIES += libcobaltnativetime.la
+libcobalt_la_LIBADD += libcobaltnativetime.la
+endif
+
 libmodechk_la_LIBADD = libcobalt.la
 
 libmodechk_la_SOURCES =	\

-- 
2.53.0

