Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E50E2E54B3
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578534; cv=none; b=TquyH3Luw/d1oI4YfDflMzdN0t+AfW5RJN2fAkQNvYqG4Em44lr0/aUDS1BHNWCX4e0cEZ+oHCpAgho83U4s0+F/e5fvCou/NTBbPzPb8Sw+iE1FAbap0h8Y1IkGGbE4nw1KNIKuqugXyXfI7v0kEiTSvAousz4kINn85dJvFJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578534; c=relaxed/simple;
	bh=dJ8n4jHet1gZtGkahAQnlP7NJTFEzCJGnpQHD/5tnqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HZdkcfV2Te8HlXVJ1JCM2s/5j4bcxh/nJ10/K2YOpVEbhfntzXmrESk+SgGa3dUX+TegyLv9bXtgZRMXFoxMUIWWBwy469devuD5lOQpowTtH4IGvWyhFqZ0ik0Feqn/BNlbX4IvZkexU3Y2kYSwwkGyh6MkRROx1HvAW20C1GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=fQIp5r3E; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="fQIp5r3E"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026022009084925369b9903000207fd
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 10:08:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=w9y+UoTQGMdLEkAqTrIFLvKDu+MWIOqon6bb64g7r0s=;
 b=fQIp5r3Erj1cJEHP9bL35iEwV8gk4ej5KBSFIigQ/eyElLmr7eMVbuPd/zsGs9mudf5uhZ
 aRE8DdDK1OBTonPFIgMUqFWYF5iR1LBRp8vUOJ1SwJ1q1sV8WI5wubp6SpTR08HUdj1dDRdP
 fJOA5L2CJgqNY4QLpVZmvm8LUGCQloNXTgIZfoBtZ6Yf08FWjGKWGSnZflT2vG7HU4f9yUjB
 hpSo4WzRgd+AspdAiPIJafNUX5120QVbi+9/vBvu6eENJnDgevF8aZgow8bCeZAFaRdOvEiB
 MUTFM27Fansq6ki4/oxIECZHu414oWC0ntfQHRQkFE9/tNxni6jsm8UQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 20 Feb 2026 10:09:01 +0100
Subject: [PATCH 18/20] lib/cobalt: Finally build the native time_t
 interfaces on top
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-wip-flo-fix-time64-32bit-native-v1-18-731c773e72cc@siemens.com>
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
In-Reply-To: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
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
index c31f030117dfc3ddf5ae386897fbc8a2435912a8..697c6ab9fcad8625e0fe604ee027309e992042f3 100644
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

