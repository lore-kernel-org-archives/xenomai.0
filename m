Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1ED38F63A
	for <xenomai@lists.linux.dev>; Mon,  2 Mar 2026 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444307; cv=none; b=jB2omR8nLcgjBBMItskMh4TfRU+kGs1l5qkv7EwEu8sQwwIpCc8WAHQQ1gB5jYB5nMrKvRMibNYPUk/11Az3nJAnVpJ0LCeoBmNjeb+RVzN5K1QiRzPrwVkJj6Jt+Off1hglcy3v205RFJ1ltGfoVjpFCdk01ENm7wpnEoip1rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444307; c=relaxed/simple;
	bh=vNuo0M0tzZwhMgnFlocQJbyUOimooDqhFjyWdLD0yXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uk7b963gsk6aujhB1Ufpn4WXgw53oGXa9gpNvEzRtMNOEDVGx5bvMKTtV2xsQOkCuxG19NSnaXdfRGJ4tshTzg1bpVqSEsbwOdw4EbSXDH1rwpsvo/41Fu2QxVExEJcTW8lSI9R6wIJVaU9Ln7WHctk46bBYqOcP7qnCcn5ZMEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=FP2WFrB4; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="FP2WFrB4"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260302093810153f5c1b71000207f3
        for <xenomai@lists.linux.dev>;
        Mon, 02 Mar 2026 10:38:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=9hPHbn2PCM2QsdAjAL8okf130nZKUU08rIYSqcy7YPQ=;
 b=FP2WFrB4vRcjFBTRDsJzNVmQz1oY3u0XIXhfQbTPGIrn9MzYcX+/BFwpsOWztDwGFS0D0r
 PYafD1ZOTP5y3XFN2vpnWVjhM2mLkf4oibxwx6O7hLqpBqVyefriO6Fk7oth6mzzz2f6MqAR
 k4OXRUGwg2F7XRerURb64BQFy/+hW85sw6s7jzYPag9YVSfb0oQLyAiKjuzSUm6XWLiqDPDV
 wnX3PKMYbkz4t3P0XH7/xQ2Sf3gFTlhXIxpiSH+1yT4/Z66wScEIKJamRZeTn3NiFIMs1FtK
 u/M9uwjhMyf2NKMkXfhAKi+LQOC8NwgyQk46KtOoFPcIkV32Y3+DRrhA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 02 Mar 2026 10:38:16 +0100
Subject: [PATCH v2 17/20] lib/cobalt: Move XN_USE_TIME64_SYSCALL to
 wrappers_time64.c
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-wip-flo-fix-time64-32bit-native-v2-17-7caefce29bcd@siemens.com>
References: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
In-Reply-To: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The usage of XN_USE_TIME64_SYSCALL is now limited to wrappers_time64.c.
Moving to clean up.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/internal.h        | 5 -----
 lib/cobalt/wrappers_time64.c | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/cobalt/internal.h b/lib/cobalt/internal.h
index 049ab3fc4d1047a1cf0ed3bd9a193938be85826a..0703c721758fdc778708cae70a0e9d53c6fb8eef 100644
--- a/lib/cobalt/internal.h
+++ b/lib/cobalt/internal.h
@@ -25,11 +25,6 @@
 #include <cobalt/sys/cobalt.h>
 #include "current.h"
 
-#if defined(__USE_TIME_BITS64) || __WORDSIZE == 64 ||                          \
-	(defined(__SYSCALL_WORDSIZE) && __SYSCALL_WORDSIZE == 64)
-#define XN_USE_TIME64_SYSCALL
-#endif
-
 extern void *cobalt_umm_private;
 
 extern void *cobalt_umm_shared;
diff --git a/lib/cobalt/wrappers_time64.c b/lib/cobalt/wrappers_time64.c
index cd7f05197dc3a9b8aca71d9e0a7468933a220ebf..024d227046833ca8be6b8941ef99e8442c20e009 100644
--- a/lib/cobalt/wrappers_time64.c
+++ b/lib/cobalt/wrappers_time64.c
@@ -30,6 +30,11 @@
 #include <sys/time.h>
 #include <time.h>
 
+#if defined(__USE_TIME_BITS64) || __WORDSIZE == 64 ||                          \
+	(defined(__SYSCALL_WORDSIZE) && __SYSCALL_WORDSIZE == 64)
+#define XN_USE_TIME64_SYSCALL
+#endif
+
 /**
  * Get the resolution of the specified clock.
  * @ingroup cobalt_api_time

-- 
2.53.0

