Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23743D8B
	for <xenomai@lists.linux.dev>; Sun,  3 Sep 2023 15:05:08 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2023090315050089b31e30398241422c
        for <xenomai@lists.linux.dev>;
        Sun, 03 Sep 2023 17:05:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=dhnJ5jukao3ZADEpxFihB1m8/bv5wh6t6dlSH4J4mGA=;
 b=NkIji1QDEiyOadElIHvmbI5d8iwRIp3qHnbuXXmdk8f6yy/ARN3U6G3sssw1wITrHLmnUz
 Uy18Sn0rD+z3fxrfTVI8nczA7mnlIDyupg/p05Q0w0Cdbnu9DhUgVo5e5PGE4hT7B1HeqOru
 wQIOYE+ie97BJqYzBKZaq/7xi5X3g=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 08/20] lib/cobalt: Drop tsc.h
Date: Sun,  3 Sep 2023 17:04:45 +0200
Message-Id: <9e18052e399744a9df12c61ff6c70cea1587b824.1693753497.git.jan.kiszka@siemens.com>
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

Was providing cobalt_read_legacy_tsc which is no longer used.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../arch/arm/include/asm/xenomai/Makefile.am  |  3 +-
 lib/cobalt/arch/arm/include/asm/xenomai/tsc.h | 48 -----------------
 .../arm64/include/asm/xenomai/Makefile.am     |  3 +-
 .../arch/arm64/include/asm/xenomai/tsc.h      | 54 -------------------
 .../arch/x86/include/asm/xenomai/Makefile.am  |  3 +-
 lib/cobalt/arch/x86/include/asm/xenomai/tsc.h | 38 -------------
 6 files changed, 3 insertions(+), 146 deletions(-)
 delete mode 100644 lib/cobalt/arch/arm/include/asm/xenomai/tsc.h
 delete mode 100644 lib/cobalt/arch/arm64/include/asm/xenomai/tsc.h
 delete mode 100644 lib/cobalt/arch/x86/include/asm/xenomai/tsc.h

diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/Makefile.am b/lib/cobalt/arch/arm/include/asm/xenomai/Makefile.am
index d308b06e62..a7dd090432 100644
--- a/lib/cobalt/arch/arm/include/asm/xenomai/Makefile.am
+++ b/lib/cobalt/arch/arm/include/asm/xenomai/Makefile.am
@@ -1,5 +1,4 @@
 
 noinst_HEADERS =	\
 	features.h	\
-	syscall.h	\
-	tsc.h
+	syscall.h
diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/tsc.h b/lib/cobalt/arch/arm/include/asm/xenomai/tsc.h
deleted file mode 100644
index 2be4009d84..0000000000
--- a/lib/cobalt/arch/arm/include/asm/xenomai/tsc.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- * Copyright (C) 2001,2002,2003,2004 Philippe Gerum <rpm@xenomai.org>.
- * Copyright (C) 2013 Gilles Chanteperdrix <gch@xenomai.org>.
- *
- * ARM port
- *   Copyright (C) 2005 Stelian Pop
- *
- * Copyright (C) 2007 Sebastian Smolorz <sesmo@gmx.net>
- *	Support for TSC emulation in user space for decrementing counters
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
- */
-#ifndef _LIB_COBALT_ARM_TSC_H
-#define _LIB_COBALT_ARM_TSC_H
-
-#include <asm/xenomai/uapi/tsc.h>
-#include <asm/xenomai/features.h>
-
-/*
- * Putting kuser_tsc_get and kinfo.counter in the same struct results
- * in less operations in PIC code, thus optimizes.
- */
-typedef unsigned long long __xn_rdtsc_t(volatile unsigned *vaddr);
-struct __xn_full_tscinfo {
-	__xn_rdtsc_t *kuser_tsc_get;
-	struct __xn_tscinfo kinfo;
-};
-extern struct __xn_full_tscinfo __xn_tscinfo;
-
-static inline __attribute__((always_inline))
-unsigned long long cobalt_read_legacy_tsc(void)
-{
-	return __xn_tscinfo.kuser_tsc_get(__xn_tscinfo.kinfo.counter);
-}
-
-#endif /* !_LIB_COBALT_ARM_TSC_H */
diff --git a/lib/cobalt/arch/arm64/include/asm/xenomai/Makefile.am b/lib/cobalt/arch/arm64/include/asm/xenomai/Makefile.am
index d308b06e62..a7dd090432 100644
--- a/lib/cobalt/arch/arm64/include/asm/xenomai/Makefile.am
+++ b/lib/cobalt/arch/arm64/include/asm/xenomai/Makefile.am
@@ -1,5 +1,4 @@
 
 noinst_HEADERS =	\
 	features.h	\
-	syscall.h	\
-	tsc.h
+	syscall.h
diff --git a/lib/cobalt/arch/arm64/include/asm/xenomai/tsc.h b/lib/cobalt/arch/arm64/include/asm/xenomai/tsc.h
deleted file mode 100644
index e664adb07a..0000000000
--- a/lib/cobalt/arch/arm64/include/asm/xenomai/tsc.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- * Copyright (C) 2001,2002,2003,2004 Philippe Gerum <rpm@xenomai.org>.
- * Copyright (C) 2013 Gilles Chanteperdrix <gch@xenomai.org>.
- *
- * ARM port
- *   Copyright (C) 2005 Stelian Pop
- *
- * Copyright (C) 2007 Sebastian Smolorz <sesmo@gmx.net>
- *	Support for TSC emulation in user space for decrementing counters
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
- */
-#ifndef _LIB_COBALT_ARM64_TSC_H
-#define _LIB_COBALT_ARM64_TSC_H
-
-#include <asm/xenomai/uapi/tsc.h>
-#include <asm/xenomai/features.h>
-#include <inttypes.h>
-#include <sys/time.h>
-
-typedef unsigned long long __xn_rdtsc_t(volatile unsigned *vaddr);
-struct __xn_full_tscinfo {
-	struct __xn_tscinfo kinfo;
-};
-extern struct __xn_full_tscinfo __xn_tscinfo;
-
-static inline uint64_t get_counter(void)
-{
-        uint64_t cval;
-
-	asm volatile("isb; mrs %0, cntvct_el0; isb; " : "=r" (cval) :: "memory");
-
-	return cval;
-}
-
-static inline __attribute__((always_inline))
-unsigned long long cobalt_read_legacy_tsc(void)
-{
-	return get_counter();
-}
-
-#endif /* !_LIB_COBALT_ARM64_TSC_H */
diff --git a/lib/cobalt/arch/x86/include/asm/xenomai/Makefile.am b/lib/cobalt/arch/x86/include/asm/xenomai/Makefile.am
index d308b06e62..a7dd090432 100644
--- a/lib/cobalt/arch/x86/include/asm/xenomai/Makefile.am
+++ b/lib/cobalt/arch/x86/include/asm/xenomai/Makefile.am
@@ -1,5 +1,4 @@
 
 noinst_HEADERS =	\
 	features.h	\
-	syscall.h	\
-	tsc.h
+	syscall.h
diff --git a/lib/cobalt/arch/x86/include/asm/xenomai/tsc.h b/lib/cobalt/arch/x86/include/asm/xenomai/tsc.h
deleted file mode 100644
index bf400e8505..0000000000
--- a/lib/cobalt/arch/x86/include/asm/xenomai/tsc.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- * Copyright (C) 2001,2002,2003,2007 Philippe Gerum <rpm@xenomai.org>.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
- */
-
-#ifndef _LIB_COBALT_X86_TSC_H
-#define _LIB_COBALT_X86_TSC_H
-
-static inline unsigned long long cobalt_read_legacy_tsc(void)
-{
-#ifdef __i386__
-	unsigned long long t;
-
-	__asm__ __volatile__ ("rdtsc" : "=A" (t));
-	return t;
-
-#else /* x86_64 */
-	unsigned int __a,__d;
-
-	__asm__ __volatile__ ("rdtsc" : "=a" (__a), "=d" (__d));
-	return ((unsigned long)__a) | (((unsigned long)__d) << 32);
-#endif /* x86_64 */
-}
-
-#endif /* !_LIB_COBALT_X86_TSC_H */
-- 
2.35.3

