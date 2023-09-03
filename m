Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374623FDC
	for <xenomai@lists.linux.dev>; Sun,  3 Sep 2023 15:05:08 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202309031505006ab76ef5d3ffdd4442
        for <xenomai@lists.linux.dev>;
        Sun, 03 Sep 2023 17:05:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=E3ZKbbuVMet66lYEgNSkAxqYAR92EyUf/lhaY/XMXU8=;
 b=Jc3PLQoYeCi7DPrnen+vdR/p7ylNnPAQpNDNDyvFz1g7v4z32Mez59AcYEnUxSSgTOU6bu
 aLZbFHwuZfZ94ivO+Pa1KeM3yV4TtJtgQcOun/JQSRBZ4q+sIbfQ01/CInIU7jZzaE/isU1+
 MfAeVLRkSiN19J05Iqb261OH4ot08=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 09/20] cobalt/uapi: Drop tsc.h
Date: Sun,  3 Sep 2023 17:04:46 +0200
Message-Id: <21080cd94309eb834132b5497d54d84ae78ceb3c.1693753497.git.jan.kiszka@siemens.com>
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

No longer used.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../arch/arm/include/asm/xenomai/uapi/tsc.h   | 25 -------------------
 .../arch/arm64/include/asm/xenomai/uapi/tsc.h | 25 -------------------
 2 files changed, 50 deletions(-)
 delete mode 100644 kernel/cobalt/arch/arm/include/asm/xenomai/uapi/tsc.h
 delete mode 100644 kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/tsc.h

diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/tsc.h b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/tsc.h
deleted file mode 100644
index b17cfb24fc..0000000000
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/tsc.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * Copyright (C) 2013 Gilles Chanteperdrix <gch@xenomai.org>.
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
-#ifndef _COBALT_ARM_ASM_UAPI_TSC_H
-#define _COBALT_ARM_ASM_UAPI_TSC_H
-
-struct __xn_tscinfo {
-	volatile unsigned int *counter;
-};
-
-#endif /* !_COBALT_ARM_ASM_UAPI_TSC_H */
diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/tsc.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/tsc.h
deleted file mode 100644
index 20a4eaa882..0000000000
--- a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/tsc.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * Copyright (C) 2013 Gilles Chanteperdrix <gch@xenomai.org>.
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
-#ifndef _COBALT_ARM64_ASM_UAPI_TSC_H
-#define _COBALT_ARM64_ASM_UAPI_TSC_H
-
-struct __xn_tscinfo {
-	volatile unsigned int *counter;
-};
-
-#endif /* !_COBALT_ARM64_ASM_UAPI_TSC_H */
-- 
2.35.3

