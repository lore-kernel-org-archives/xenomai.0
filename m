Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070363D90
	for <xenomai@lists.linux.dev>; Sun,  3 Sep 2023 15:05:08 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202309031505002ab2e00636ba5c97dc
        for <xenomai@lists.linux.dev>;
        Sun, 03 Sep 2023 17:05:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=cGMUDH0utmQNv4er+DS2BPw/SREy0GWIvIeHEBBcin0=;
 b=W4A4udfGgF+3SPgrDmZxz1SEiaRoLHvwB9IL9PNDXtKTDIDfgtNCRTHJoxMcnEZDfe1d4F
 sA862MtqTecpzlowrMk3cJZ/P+SoeefwYfSE+YWFb6RzD77KDBgraX5vrX1WeGMAHovNMEct
 Rx4OD6Yx4ZEr6+bsI9SXXRIvL3RDc=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 10/20] lib/cobalt: Drop VDSO support
Date: Sun,  3 Sep 2023 17:04:47 +0200
Message-Id: <72f970ad8d0b1c2e8d6f6e4c016cd06a2c5ee0f9.1693753497.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1693753497.git.jan.kiszka@siemens.com>
References: <cover.1693753497.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

This only existed to provide clock services under I-pipe. There are no
other use cases in sight, so drop the related code from userspace first.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/cobalt/init.c |  2 +-
 lib/cobalt/umm.c  | 14 +++-----------
 lib/cobalt/umm.h  |  6 +-----
 3 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/lib/cobalt/init.c b/lib/cobalt/init.c
index 58051a2f26..7aa7c48de7 100644
--- a/lib/cobalt/init.c
+++ b/lib/cobalt/init.c
@@ -179,7 +179,7 @@ static void low_init(void)
 	trace_me("memory locked");
 	cobalt_ticks_init();
 	cobalt_features_init(f);
-	cobalt_init_umm(f->vdso_offset);
+	cobalt_init_umm();
 	trace_me("memory heaps mapped");
 	cobalt_init_current_keys();
 }
diff --git a/lib/cobalt/umm.c b/lib/cobalt/umm.c
index c30ada6a23..555bee8474 100644
--- a/lib/cobalt/umm.c
+++ b/lib/cobalt/umm.c
@@ -34,8 +34,6 @@
 #include "umm.h"
 #include "internal.h"
 
-struct xnvdso *cobalt_vdso;
-
 void *cobalt_umm_private = NULL;
 
 void *cobalt_umm_shared = NULL;
@@ -117,20 +115,14 @@ static void init_bind(void)
 }
 
 /* Will be called only once, upon call to xenomai_init(). */
-static void init_loadup(__u32 vdso_offset)
+void cobalt_init_umm(void)
 {
 	uint32_t size;
 
+	pthread_once(&init_bind_once, init_bind);
+
 	cobalt_umm_shared = map_umm(COBALT_MEMDEV_SHARED, &size);
 	if (cobalt_umm_shared == MAP_FAILED)
 		early_panic("cannot map shared umm area: %s",
 			    strerror(errno));
-
-	cobalt_vdso = (struct xnvdso *)(cobalt_umm_shared + vdso_offset);
-}
-
-void cobalt_init_umm(__u32 vdso_offset)
-{
-	pthread_once(&init_bind_once, init_bind);
-	init_loadup(vdso_offset);
 }
diff --git a/lib/cobalt/umm.h b/lib/cobalt/umm.h
index b592968832..7705f9cf94 100644
--- a/lib/cobalt/umm.h
+++ b/lib/cobalt/umm.h
@@ -20,12 +20,8 @@
 
 #include <linux/types.h>
 
-void cobalt_init_umm(__u32 vdso_offset);
+void cobalt_init_umm(void);
 
 void cobalt_unmap_umm(void);
 
-struct xnvdso;
-
-extern struct xnvdso *cobalt_vdso;
-
 #endif /* _LIB_COBALT_UMM_H */
-- 
2.35.3

