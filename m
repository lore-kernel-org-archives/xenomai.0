Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB038E106
	for <xenomai@lists.linux.dev>; Mon,  2 Mar 2026 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444300; cv=none; b=IP5TMmtPulxnv8dMvL4oX4QqmlfJaH00O34ne4WHCydwMfbZwH/eRKnCfiWM7yIk4YViK5pLaCCuoh4J9uulKizoAPQvzuKnOGvRplYGjzUDgYkHzxXdrF+Zyk+VC8L8SF1fsmBzN1mO3VyS7rxEMMy3tu9DlIULgFtBpMIuqDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444300; c=relaxed/simple;
	bh=MFBHHjjuOBDuGB5Uptqr3ZTR/izKR0mXkqOS5VPAkmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DZzJCTeoaRl43gmNiqptQoXY0pizIKMslsuVBeWta7G/k+FfVTch7WGv+k0I2mGevnThjiHYhsT4oRSoiSBn4UyCZsT4Oke5bcizGyFXrrSEFzSaSPkZLo2I9Tj2Dzt5jk+9ocSDYo4SAWhd6OEA06NW/k+Qwxm+GZxm724NRKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=AAY+Iyt9; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="AAY+Iyt9"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260302093807cd2d73f75e0002070d
        for <xenomai@lists.linux.dev>;
        Mon, 02 Mar 2026 10:38:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=VrUXkbG4rsWX1JlHKHfoiat6h19oiNGDZbGOT1Esy7M=;
 b=AAY+Iyt9EiJ+76fPIjKDwvcsh9xi5tDoXFPjkbxQWonf6YMw02sVyYMfrnDZZFANrWtMI/
 R65HP2fH8zx/LV27R47wCpjvhBDdcitpgjuxIRv2DuWcnKhB5IHGHGrF+pMGEpcxXFbPF16N
 d0AU1xmXpgKUGQDKjm169cdew8FyNmsujITaJ5F/G8HL85JIK/yQm77DjpjBOzozc8ltfxIR
 iK+8WpMOHugA2cQDv7aK+KMVGVkt5QwSXn6tbjRj+yldP3H0Tn2fZH+SATqhKCUHRYIK9NIJ
 KatyJ7zow8ALOYK2a466/EQN9bDyqO2upZelXGOMTZ+8lsX08B/+rmXg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 02 Mar 2026 10:38:04 +0100
Subject: [PATCH v2 05/20] lib/cobalt: Introduce wrappers_time64.c
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-wip-flo-fix-time64-32bit-native-v2-5-7caefce29bcd@siemens.com>
References: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
In-Reply-To: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

All COBALT_IMPL_TIME64() services will be moved afterwards - step by
step - into the newly introduced wrappers_time64.c. At the end that
should allow us to compile libcobalt with time64_t support leaving
the native time_t services in place.

Currently, all native time_t services are replaced by the 64 bit
variants. That is OK as long as applications are rebuild after
libcobalt, but we try to remove this limitation now.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/Makefile.am       |  3 ++-
 lib/cobalt/wrappers_time64.c | 12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
index 0a8041dc30efae3eebacd376ac72f4b317f621b3..68900c35104ff9bd94d1cb7534dfdc10b9795a18 100644
--- a/lib/cobalt/Makefile.am
+++ b/lib/cobalt/Makefile.am
@@ -43,7 +43,8 @@ libcobalt_la_SOURCES =		\
 	timerfd.c		\
 	trace.c			\
 	umm.c			\
-	wrappers.c
+	wrappers.c		\
+	wrappers_time64.c
 
 libcobalt_la_CPPFLAGS =			\
 	@XENO_COBALT_CFLAGS@		\
diff --git a/lib/cobalt/wrappers_time64.c b/lib/cobalt/wrappers_time64.c
new file mode 100644
index 0000000000000000000000000000000000000000..6ae0c6d162b4cd1468d30ea46e6da6bb14e3c174
--- /dev/null
+++ b/lib/cobalt/wrappers_time64.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: LGPL-2.0-or-later
+
+/*
+ * Copyright (C) 2026 Florian Bezdeka <florian.bezdeka@siemens.com>.
+ */
+
+/*
+ * Magic ahead:
+ * This file is compiled twice in case y2038/time64_t support is necessary
+ * and requested. The first time with time64_t and a second time with native
+ * time_t.
+ */

-- 
2.53.0

