Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79A72DEA8C
	for <xenomai@lists.linux.dev>; Thu, 16 Oct 2025 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760596357; cv=none; b=V6gDkmwoSsLBZvPjIsQvo9pMQbRbd6vCfL75xnhahfwWwdS6ymbrYQR84Xx9A0jdVaSBUoXaT1t1TIGmQHxMyksRhvBYowO7qCaCi+qIN0gMU+JCGDxCz1lhsw0O079bLQ0m6gJSnyxlOKEQt3afZUPRHwh2athL+wUEWafRvIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760596357; c=relaxed/simple;
	bh=5eF/gUcnguYWRvisw0oTbRQSDAhLcdeRADgftwLNMoY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIJD55gw1CoTaHIgwlcrZhEAEPYAEtQHGe5jvM2OlH7Lr3savK0mYYWej0PCd5xnUyVp1ZvGCqV41+76UElNrYeHYqHUNAJEY8MZwVyeDuxcLFVZxAw6ANemK9sCEDMSXetmjdjxa/cxmH9WrRyjio+IhtZ0Eq+u3pbPD2hkL0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=m0dI03Nv; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="m0dI03Nv"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20251016063226fccb83fa2100020742
        for <xenomai@lists.linux.dev>;
        Thu, 16 Oct 2025 08:32:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Shmx5pmUkxe3JGpzi2JZCuRAuS/1zVKFzB08CHVRub0=;
 b=m0dI03Nv5UeipTGjBD5drEBUcAWT6GipAJPH8N8sqezTacborby80gojsOfLM9LibQDh9X
 gnoy535vV8/EN5ibG6G2tlX5rGSMG1U7uq5NTouag6sf+vEzYeMGxNSM3CLpSGbWw4CIBNSN
 uM034yK133Uj4BTV0Ijs80cDy8/qIfZVXHM4X0glaUfmV3CcPClCFiWgeeNrYDLj1YjTsg0/
 kJWwFqjAepTf4f1GzJu+IFHY3vkp+TpzOMQ9wr9nxog9J+yfFO+SPFQ+mzrM6JfwPuExqiga
 sZe8wuKOWenpz3JVbCAm4jAZ9fRdogF6EFDlVbXc9KxY4TcMuTCIAHLw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH v2 5/7] lib/cobalt: arm: Skip SIGSHADOW_ACTION_BACKTRACE over asynchronous signals
Date: Thu, 16 Oct 2025 08:32:22 +0200
Message-ID: <ea117c860ff9ca025e4830e69bfe16b2040090d7.1760596344.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1760596344.git.jan.kiszka@siemens.com>
References: <cover.1760596344.git.jan.kiszka@siemens.com>
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

The unwinders of libgcc and libunwind prefer the ARM exception handling
table over debug information. Unwinding this way is not designed to
handle asynchronous signals, causing wrong backtraces in the best case
but also too often even crashes.

Avoid running into that trap by skipping the request to create a
backtrace via SIGSHADOW on ARM in case either the migration reason was a
signal, or PTHREAD_WARNSW is enabled for the current thread. In both
cases, the SIGSHADOW could be raised over the first instruction of
another signal handler, causing the unwinder to fail.

Improving the unwinding libraries themselves is likely no longer worth
the effort for this phase-out architecture.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../arch/arm/include/asm/xenomai/Makefile.am  |  1 +
 .../arch/arm/include/asm/xenomai/debug.h      | 27 +++++++++++++++++++
 .../arm64/include/asm/xenomai/Makefile.am     |  1 +
 .../arch/arm64/include/asm/xenomai/debug.h    | 18 +++++++++++++
 .../arch/x86/include/asm/xenomai/Makefile.am  |  1 +
 .../arch/x86/include/asm/xenomai/debug.h      | 18 +++++++++++++
 lib/cobalt/sigshadow.c                        | 12 ++++++---
 7 files changed, 74 insertions(+), 4 deletions(-)
 create mode 100644 lib/cobalt/arch/arm/include/asm/xenomai/debug.h
 create mode 100644 lib/cobalt/arch/arm64/include/asm/xenomai/debug.h
 create mode 100644 lib/cobalt/arch/x86/include/asm/xenomai/debug.h

diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/Makefile.am b/lib/cobalt/arch/arm/include/asm/xenomai/Makefile.am
index a7dd090432..8cc767030f 100644
--- a/lib/cobalt/arch/arm/include/asm/xenomai/Makefile.am
+++ b/lib/cobalt/arch/arm/include/asm/xenomai/Makefile.am
@@ -1,4 +1,5 @@
 
 noinst_HEADERS =	\
+	debug.h		\
 	features.h	\
 	syscall.h
diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/debug.h b/lib/cobalt/arch/arm/include/asm/xenomai/debug.h
new file mode 100644
index 0000000000..e49b928516
--- /dev/null
+++ b/lib/cobalt/arch/arm/include/asm/xenomai/debug.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (c) Siemens, 2025
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _LIB_COBALT_ARM_DEBUG_H
+#define _LIB_COBALT_ARM_DEBUG_H
+
+#include <signal.h>
+#include "current.h"
+
+static inline int cobalt_avoid_backtrace(int reason)
+{
+	if (reason == SIGDEBUG_MIGRATE_SIGNAL)
+		return 1;
+
+	if (cobalt_get_current_mode() & PTHREAD_WARNSW)
+		return 1;
+
+	return 0;
+}
+
+#endif /* !_LIB_COBALT_ARM_DEBUG_H */
diff --git a/lib/cobalt/arch/arm64/include/asm/xenomai/Makefile.am b/lib/cobalt/arch/arm64/include/asm/xenomai/Makefile.am
index a7dd090432..8cc767030f 100644
--- a/lib/cobalt/arch/arm64/include/asm/xenomai/Makefile.am
+++ b/lib/cobalt/arch/arm64/include/asm/xenomai/Makefile.am
@@ -1,4 +1,5 @@
 
 noinst_HEADERS =	\
+	debug.h		\
 	features.h	\
 	syscall.h
diff --git a/lib/cobalt/arch/arm64/include/asm/xenomai/debug.h b/lib/cobalt/arch/arm64/include/asm/xenomai/debug.h
new file mode 100644
index 0000000000..6ca1d42a34
--- /dev/null
+++ b/lib/cobalt/arch/arm64/include/asm/xenomai/debug.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (c) Siemens, 2025
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _LIB_COBALT_ARM64_DEBUG_H
+#define _LIB_COBALT_ARM64_DEBUG_H
+
+static inline int cobalt_avoid_backtrace(int reason)
+{
+	return 0;
+}
+
+#endif /* !_LIB_COBALT_ARM64_DEBUG_H */
diff --git a/lib/cobalt/arch/x86/include/asm/xenomai/Makefile.am b/lib/cobalt/arch/x86/include/asm/xenomai/Makefile.am
index a7dd090432..8cc767030f 100644
--- a/lib/cobalt/arch/x86/include/asm/xenomai/Makefile.am
+++ b/lib/cobalt/arch/x86/include/asm/xenomai/Makefile.am
@@ -1,4 +1,5 @@
 
 noinst_HEADERS =	\
+	debug.h		\
 	features.h	\
 	syscall.h
diff --git a/lib/cobalt/arch/x86/include/asm/xenomai/debug.h b/lib/cobalt/arch/x86/include/asm/xenomai/debug.h
new file mode 100644
index 0000000000..9d39233d12
--- /dev/null
+++ b/lib/cobalt/arch/x86/include/asm/xenomai/debug.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (c) Siemens, 2025
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _LIB_COBALT_X86_DEBUG_H
+#define _LIB_COBALT_X86_DEBUG_H
+
+static inline int cobalt_avoid_backtrace(int reason)
+{
+	return 0;
+}
+
+#endif /* !_LIB_COBALT_X86_DEBUG_H */
diff --git a/lib/cobalt/sigshadow.c b/lib/cobalt/sigshadow.c
index 10736b113f..b98e4a1d55 100644
--- a/lib/cobalt/sigshadow.c
+++ b/lib/cobalt/sigshadow.c
@@ -18,6 +18,7 @@
 
 #include <pthread.h>
 #include <signal.h>
+#include <asm/xenomai/debug.h>
 #include <asm/xenomai/syscall.h>
 #include "internal.h"
 
@@ -43,7 +44,7 @@ static bool past_constructors;
 int cobalt_sigshadow_handler(int sig, siginfo_t *si, void *ctxt)
 {
 	void *frames[SIGSHADOW_BACKTRACE_DEPTH];
-	int action, arg, nr, skip;
+	int action, reason, nr, skip;
 
 	if (si->si_code != SI_QUEUE)
 		return 0;
@@ -55,11 +56,14 @@ int cobalt_sigshadow_handler(int sig, siginfo_t *si, void *ctxt)
 		XENOMAI_SYSCALL1(sc_cobalt_migrate, COBALT_PRIMARY);
 		break;
 	case SIGSHADOW_ACTION_BACKTRACE:
-		arg = sigshadow_arg(si->si_int);
-		nr = backtrace(frames, ARRAY_SIZE(frames));
+		reason = sigshadow_arg(si->si_int);
+		nr = 0;
+		if (!cobalt_avoid_backtrace(reason))
+			nr = backtrace(frames, ARRAY_SIZE(frames));
 		/* Skip the sighandler context. */
 		skip = nr > 3 ? 3 : 0;
-		XENOMAI_SYSCALL3(sc_cobalt_backtrace, nr - skip, frames + skip, arg);
+		XENOMAI_SYSCALL3(sc_cobalt_backtrace, nr - skip, frames + skip,
+				 reason);
 		break;
 	case SIGSHADOW_ACTION_HOME:
 		/*
-- 
2.51.0

