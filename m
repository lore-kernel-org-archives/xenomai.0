Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6764F377EC2
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221387; cv=none; b=s9qaxfvf54hVP6XYlSRBRoW9s5i1SgyB3DCetfQelyq7cisFoHIZEnyuFiRTHCDUJAs+hde/rXb6QIHAXoU3AoeTuaKXTmNala+KI1xSf3Tlpi4hDceC9BO50T6WSninrQAw5HLwjUTxpRKuMtViNNbV5afTifqnWruhBWKA+fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221387; c=relaxed/simple;
	bh=RzpH+09zdmIm7S7NORtnYMT6eGqQ4NufPr3QSChFYvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GIjB3POmSvJi77efONp+6yCSskeBvMZUFz8XC+nVsvgt5xlaSMnbHYtL25NgKIbG8dOTxveZe6sJyOXaVMn8dAagYNE/q4GXjoC2QX2RWJD+zA32uaJmn4ovfEqwBLTM/7Pfe1diaaowfKE8C/NzGXWzeWSA7gWStn0ciO2nFAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=i++EQIYZ; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="i++EQIYZ"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026050806225303ebcc0b990002071b
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:22:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=yXSfN0tvHwLuH/d3aIzpRuavij0gj9MOJAv5gf/MGfU=;
 b=i++EQIYZUbQx4d+2rDI3mFJJGQ0dUMNkMmuuXj1jLC3LcspopWX6zBIUoH+BPrCpB423Wv
 7X3adihInOS8VwEcEM/HX1uE2FcgcQzlgap0fKDPLL39KO+I9ohgXzRnSDugbsdzFGne2Kib
 h3/T5z9+3eOwniofmWcCBvchqgY/mCBhQYB88r4wlnlk7yiNg84WRN8VJR0+W4MGbZu9N5l3
 cgJJwoqhWDyMrV4kMXJNSGAUGvmxSUGjwZsn/wOMrufi/HVcXhM7v8qtQSC1RCOP85Bry2k+
 JazsH/ZYbK5Dwr01jF16DKvqArREtKhKrxWubB7GVbQNTRIfkS0X7ROQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:42 +0200
Subject: [PATCH 09/32] lib/smokey: Move do_fork macro to its single user
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-9-e449f2bd4fc2@siemens.com>
References: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
In-Reply-To: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

lib/smokey/helpers.c is the only user of that macro. Move the
definition close to the user.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/smokey/smokey.h | 6 ------
 lib/smokey/helpers.c    | 7 +++++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/smokey/smokey.h b/include/smokey/smokey.h
index 45dd0dcd017b092d86d0978713e67a92ab01e1df..64593c1a73d5b84fde286ed23b2f2d043d795db9 100644
--- a/include/smokey/smokey.h
+++ b/include/smokey/smokey.h
@@ -26,12 +26,6 @@
 #include <copperplate/clockobj.h>
 #include <xenomai/init.h>
 
-#ifdef HAVE_FORK
-#define do_fork fork
-#else
-#define do_fork vfork
-#endif
-
 #define SMOKEY_INT(__name) {		\
 	 .name = # __name,		\
 	 .parser = smokey_int,		\
diff --git a/lib/smokey/helpers.c b/lib/smokey/helpers.c
index fe52f48db08628b79df6e8331e0f67bdf45f7cfa..a22953a9f0f3784ac8b265bfe53ddd45ab2b9351 100644
--- a/lib/smokey/helpers.c
+++ b/lib/smokey/helpers.c
@@ -23,6 +23,13 @@
 #include <error.h>
 #include <stdlib.h>
 #include <sys/wait.h>
+#include <unistd.h>
+
+#ifdef HAVE_FORK
+#define do_fork fork
+#else
+#define do_fork vfork
+#endif
 
 int smokey_int(const char *s, struct smokey_arg *arg)
 {

-- 
2.54.0

