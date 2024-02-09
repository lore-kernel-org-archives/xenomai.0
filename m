Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F0E31A98
	for <xenomai@lists.linux.dev>; Fri,  9 Feb 2024 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707479478; cv=none; b=scnXbbsm8T+lzJw8TBjhNDqncmOzhFCoKTE8Berd3NM0Ujg/oioYcwntbqJvRLyzaYx5dZeTnguVWDY2pttkokfSx6BfthjltEsqzkRAxER3opxfXcjmOC2rZq3HRGcM3IN5oSKEisMob8ndvsNQYyF1wY39j9IcHHOZe0TARJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707479478; c=relaxed/simple;
	bh=BauUIsN9sBuO2kUW/8oc3zB9BiQFUxND8OdydP38Eag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mZnR7/1iFlnXA8CyPqT6aNCibmSm0DN7YcCfjBpI5uLvhLEdGM9RYBwupLeIYPB1npw8JDB/HnB383bycWC1vpAJBRuDnXxkK6c5js0K3h7QiGCVvOHq0VyAjW/iPDutitNUwAAf/KC7K6XPUCqoZdjcpuB5UuixtCeDWeCaj54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=mWjauoaI; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="mWjauoaI"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240209115113f983c3abf2fd3262d1
        for <xenomai@lists.linux.dev>;
        Fri, 09 Feb 2024 12:51:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=1vpzeoUfiuUFFi5F3djMo+wSPebjjrs3Fs6S/t5Qxgo=;
 b=mWjauoaIqtgSvMdLP5hfbaAp+mOQYPQrNAvSempVZB9z0VOKbygXc0lHL6AAHEJwGnh51t
 9goIxdydWsZvXlvvwFE4xNKjPR84ouKdGw0AEWxwqOWZGMT/M75V3WskO5ZBfDnfNEjV/GjM
 yJoEjZNOzaitzxYPIu8PFO0TH25gw=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH v2 4/7] compat support: cobalt: Bump ABI revision
Date: Fri,  9 Feb 2024 12:50:22 +0100
Message-Id: <20240209115025.1884451-5-clara.kowalsky@siemens.com>
In-Reply-To: <20240209115025.1884451-1-clara.kowalsky@siemens.com>
References: <20240209115025.1884451-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

With introduction of the compat support, arm and arm64 are linked and
therefore the ABI revision is aligned by setting it in a shared file.
The ABI revision of arm is incremented and arm64 is bumped to the same
version.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 .../arm/include/asm/xenomai/uapi/abirevision.h   |  1 +
 .../arch/arm/include/asm/xenomai/uapi/features.h |  3 +--
 .../arm64/include/asm/xenomai/uapi/abirevision.h | 16 ++++++++++++++++
 .../arm64/include/asm/xenomai/uapi/features.h    |  3 +--
 4 files changed, 19 insertions(+), 4 deletions(-)
 create mode 120000 kernel/cobalt/arch/arm/include/asm/xenomai/uapi/abirevision.h
 create mode 100644 kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/abirevision.h

diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/abirevision.h b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/abirevision.h
new file mode 120000
index 000000000..e4b49fffc
--- /dev/null
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/abirevision.h
@@ -0,0 +1 @@
+../../../../../arm64/include/asm/xenomai/uapi/abirevision.h
\ No newline at end of file
diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h
index 4a87c6732..0db0cd3eb 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/features.h
@@ -21,8 +21,7 @@
 #ifndef _COBALT_ARM_ASM_UAPI_FEATURES_H
 #define _COBALT_ARM_ASM_UAPI_FEATURES_H
 
-/* The ABI revision level we use on this arch. */
-#define XENOMAI_ABI_REV   19UL
+#include <asm/xenomai/uapi/abirevision.h>
 
 #define XENOMAI_FEAT_DEP (__xn_feat_generic_mask)
 
diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/abirevision.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/abirevision.h
new file mode 100644
index 000000000..1d17c113b
--- /dev/null
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/abirevision.h
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ABI revision
+ *
+ * Copyright (c) Siemens AG 2024
+ *
+ * Authors:
+ *  Clara Kowalsky <clara.kowalsky@siemens.com>
+ */
+#ifndef _COBALT_ASM_UAPI_ABIREVISION_H
+#define _COBALT_ASM_UAPI_ABIREVISION_H
+
+/* The ABI revision level we use on this arch. */
+#define XENOMAI_ABI_REV   20UL
+
+#endif /* !_COBALT_ASM_UAPI_ABIREVISION_H */
diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
index fba1db391..c03a0bc7e 100644
--- a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/features.h
@@ -21,8 +21,7 @@
 #ifndef _COBALT_ARM64_ASM_UAPI_FEATURES_H
 #define _COBALT_ARM64_ASM_UAPI_FEATURES_H
 
-/* The ABI revision level we use on this arch. */
-#define XENOMAI_ABI_REV   3UL
+#include <asm/xenomai/uapi/abirevision.h>
 
 #define XENOMAI_FEAT_DEP (__xn_feat_generic_mask)
 
-- 
2.39.2

