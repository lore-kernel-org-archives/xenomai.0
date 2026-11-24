Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528994;
	b=So9Z2I03iapo/mpuaajDUdJxzbnUBQLTTk4je1hVaSFlNtqNWaLp5BieH9QHdHQfbVvQ
	 Nn1FkDfSbzEqbosFqXvXWL3G16cMYHIH3tc3CAKCnDPAMxIVhjc7nQ5FTR5iHIA/TFfds
	 TzDrVxhGcMHbno9wqseMTP7YovlDqeEanbDX8VWAqaQLfvkJVcG09cly1QCXDB8J+2zR+
	 gYERkTaeJSbVeOpJ+xX6+VIE/wVxIet5GW+Fy7qlkBYTnr3A9wBV7oet01viujKrm2sVO
	 mXx0rN9XY0W5rQDegT5N2o1MiizQRQPYqHv7ksQZkudnXz0l/XRtVCzyLMJZsMv76Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528994;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NZPxoXxgLZip/uTto7unx/5eW3OmfSI2k9Bv5ZjlsWk=;
	b=jZLs5VbajGw3yY0TwzGeVlq5rXnP2hL1nuXM8LVLaYtqvcsnyxPFesa3FUmIDjfN8XdB
	 oK2A1xy29XGUwEIknfKDPwafM5b0Feh5glBzGGpsKQCqBhr/N/uCOWJgRZxxM+GLDSfwT
	 +fg+rtk4Ju09alD2dEJn1/jlZd9O9y1dPNuUMcJOVtjNzc1gElG7ApjSriTbACrkhAJKj
	 QKWaztFGMKQKPbpe4vJQxHUxJTwE389Jrc/JGDzPKPxW7AgvTQ/iwFnkgD+37v1q3Siz6
	 8AXqVgSOrtHpjadck9hrM3TOll4jxr+G8Y9CeXDyvnQyZOT6LdZhU2aNRmJrMwF6wvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=JRDyr9UN;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB82606A33D
	for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 14:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAB82606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=JRDyr9UN
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c50cc7540b7so628089866b.0
        for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 06:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795528992; x=1796133792; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NZPxoXxgLZip/uTto7unx/5eW3OmfSI2k9Bv5ZjlsWk=;
        b=JRDyr9UNqxiDc6PFCj/Y2Q0LGDeAVKUK3V0n+D4ZoQaooeNPV3qAkDoqI89Vx0nojO
         DdDgaQf28vXpV2t8QAtJbzFYMi9JxhL/ujUBAfcn7aaU66M3ha8ETolqvo5AA+UGX73V
         Oq1cXja2m1aqvHIuq/2qb/8X9mI6zZdchM/yUf+MEMetY8PeB1CsUOmGfkuEPUMi8VsI
         qs2CVl+sSAe1zqNxJuGJ29H/EiCHukM8zu3r4Xiu9BNOkyHlcI7GLU9Q38leiUiLiqnr
         R7gmY6/gWOtwf/U7vLVlx9FkaLPLcSX6mSbIs+YsSRaE4HQ67+ISFs6S7zmiR1Mo/jyz
         IzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795528992; x=1796133792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NZPxoXxgLZip/uTto7unx/5eW3OmfSI2k9Bv5ZjlsWk=;
        b=1VYocpEGveoW+mQ4543kurQ13FweBiztThvOJFlQKVJOGOXee5A4NIzqILv9d+uExI
         cReOhAUG4e0LKankMTcNi3VU8enlGc9vmKOS/PWao5LEpGwRftRze7ry9OLx4XEdDDtx
         FrbdPaxePP/V3f01HgEaE3Jlk9yeE0gtWO8d56DF+XOdBslDQZfVt1oSALVgLQC8QZmQ
         Vz1EVpZfwIvwYB4H3eA3PyeMJ7K6tozD6iEcPBTtWCPuwJvp7mxQ3/+3CDpF4FUoV12M
         1BI95R6Kfi+zYJLJ/OUe5sLmHRaDUgRUgH2uyruJ8pi4x1s8GJ11FGbeSp3doqSruo++
         UyCw==
X-Gm-Message-State: APuU4Z/XgvQFxUzK5+gXNx9TugnXvt/KejX3B3eruNY22W+3k2mlCv6O
	cz2zp9KAnEGQOkOr44LaJIHPTLJwzG+t2pb5d2/RGjEzId4RWhuRMsvo31B/0g==
X-Gm-Gg: AZFdTZfdlgSVZ5PjLWs+qm0opETsaOaN98xW7ZjXpeWWyZTTJx1OnIYmuJXMjWeWisO
	CXqTL1vW/Ky5afnzouCr2bmnkGVCajJGtNNS+w3De7PBtRiHDxpktLIoUB2c7ovzdNeoH7oWxfl
	McZWZUk2bCkiGA11njRACeJh4FbAaehWD/GRocMbCxnmeTY/aEgv3mGsN11cTMq1aVG/jCMkfWZ
	MKI8dUgZhlb5soERDi+ogfrikQuh7jyr7k8uSCImG+kIRt1e4PtJMR2k9XT3opBzwrO05sQW8xi
	WoqvhziyRAbyoyPu6yuSFfgo0vQP7REZ/w9Jc0ussrmhGOZGClsJLpT5EZsVC/XaJtNAgH1CB8F
	dCMPq4rOsAvAz03UKVNkdrVTdlm57RBUkkRKoazCyeRyjRJyq/W05Ac/y5BKFCu74NKQTFu51+w
	PfS0Y6tVyTM8FuC+AxKpZiPxoH11agm+WF2yBc1Bzs8fceSn8aflv7sDG4dyR17IwaLq0FA6GA5
	gl390jOPxOy57peWbIdJCmIoPByto9pIA8jiM9J3yTfPXUrXPXiWdMTMIYFsBpxWDlIUuKOPkSQ
	8p3rGkYJbe7hFylv8QC2Unt3cyvt6ZZwTRvH7FOGnuJ8M4dUr8DRwY77lkEJsYxV23yXX6XbaIG
	Iad4+4duc
X-Received: by 2002:a17:907:a892:b0:c51:5589:355f with SMTP id a640c23a62f3a-c515589b2e2mr1128536166b.5.1795528991795;
        Tue, 24 Nov 2026 06:03:11 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513a8678cdsm510486566b.0.2026.11.24.06.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:03:09 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Yegor Yefremov <yegorslists@googlemail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 2/4] lib/cobalt: Provide getauxval() fallback for the vDSO parser
Date: Tue, 24 Nov 2026 15:03:01 +0100
Message-Id: <20261124140303.3336015-3-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124140303.3336015-1-yegorslists@googlemail.com>
References: <20261124140303.3336015-1-yegorslists@googlemail.com>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uClibc-ng only provides getauxval() and <sys/auxv.h> since 1.0.43, so
libcobalt fails to build with older releases:

  parse_vdso.c:18:10: fatal error: sys/auxv.h: No such file or directory

Check for getauxval() in configure and otherwise look up the auxiliary
vector entry in /proc/self/auxv.

Fixes: f8cd2923b0b0 ("lib/cobalt: dovetail: use clock_gettime() vcall for reading timestamps")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 configure.ac            |  3 ++-
 lib/cobalt/parse_vdso.c | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 0d6dd87b6..6e8d8d549 100644
--- a/configure.ac
+++ b/configure.ac
@@ -572,7 +572,8 @@ AC_CHECK_FUNCS([pthread_mutexattr_setprotocol	\
 		clock_nanosleep			\
 		shm_open			\
 		shm_unlink			\
-		backtrace])
+		backtrace			\
+		getauxval])
 LIBS="$save_LIBS"
 
 save_CPPFLAGS="$CPPFLAGS"
diff --git a/lib/cobalt/parse_vdso.c b/lib/cobalt/parse_vdso.c
index 37b997b78..f65af1191 100644
--- a/lib/cobalt/parse_vdso.c
+++ b/lib/cobalt/parse_vdso.c
@@ -15,7 +15,6 @@
  * architecture that has a vDSO.
  */
 
-#include <sys/auxv.h>
 #include <stdbool.h>
 #include <string.h>
 #include <limits.h>
@@ -25,6 +24,36 @@
 #include <elf.h>
 #include "internal.h"
 
+#ifdef HAVE_GETAUXVAL
+#include <sys/auxv.h>
+#else
+#include <fcntl.h>
+#include <unistd.h>
+
+/* For C libraries without getauxval(), e.g. uClibc-ng before 1.0.43. */
+static unsigned long getauxval(unsigned long type)
+{
+	unsigned long entry[2], val = 0;
+	int fd;
+
+	fd = __STD(open("/proc/self/auxv", O_RDONLY));
+	if (fd < 0)
+		return 0;
+
+	while (__STD(read(fd, entry, sizeof(entry))) == sizeof(entry) &&
+	       entry[0] != AT_NULL) {
+		if (entry[0] == type) {
+			val = entry[1];
+			break;
+		}
+	}
+
+	__STD(close(fd));
+
+	return val;
+}
+#endif
+
 #ifndef ELF_BITS
 # if ULONG_MAX > 0xffffffffUL
 #  define ELF_BITS 64
-- 
2.34.1

