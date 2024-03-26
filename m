Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D3374BE2
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711435283; cv=none; b=AZPW7vNIzZqqs5UtW4naXCIQ5EYJJWVSVjO6x2zRW6k4BMwVgqh0InqOsk/hx28at1mKCRBPvMKryKhzum7RW92DS7Qy26DmmjKvhYnSQGn25AtBQ0SDE9zfAvzROyBIeMb7m79StGFdJEFXqQ3hr+khpgYKiGrsh+o02e8/P3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711435283; c=relaxed/simple;
	bh=9bR5fxN8jNsKZb+o5PHzq/UZqlA0VOGJTCR65wVe+HU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G/S39dQ6m/ecjZ2bcXweYcgaHMSdzlPtvOjLH+pEeRMn9BQtd3b5dXjuFDO9xDUJK+oxV3IwdhsCQweaS4g3AaX55meb5oJPZ51+raPkycuIRjAvH8uGGVANuczstYu9lxMG+Eb2uwIIpeD8Wu7tbLFCX2s95WRWDywAGBsCZAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=P/KXY/Wy; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="P/KXY/Wy"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240326063107ed75995467ff84a9e4
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=D0opFMD/1YWxqr1HA6S65QvFXmiLXckvCcay8eRBnPw=;
 b=P/KXY/WyrGZjKri6BRtpzwdPxYJ1QgkUGDs6QwRh8vxNeKL8ndfaTrWb1tTUrarMlyvlif
 HMB/dMlHyraNViqkiUGRW6RDXKjbRcwBM+5b0BI2hnNlmVY2il2uaWvLEF0+REmemfPZ34fR
 dPibDU/2VTSQ+Klg5La1bdZSSAUeY=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 06/25] cobalt: Address missing prototype warnings by adding includes
Date: Tue, 26 Mar 2024 07:30:45 +0100
Message-Id: <87fe6d897f35e92ea3439c907793fbf63f5a7c16.1711434664.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1711434664.git.jan.kiszka@siemens.com>
References: <cover.1711434664.git.jan.kiszka@siemens.com>
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/arch/x86/c1e.c     | 1 +
 kernel/cobalt/arch/x86/smi.c     | 1 +
 kernel/cobalt/dovetail/syscall.c | 1 +
 kernel/cobalt/posix/syscall.c    | 1 +
 kernel/cobalt/procfs.c           | 1 +
 5 files changed, 5 insertions(+)

diff --git a/kernel/cobalt/arch/x86/c1e.c b/kernel/cobalt/arch/x86/c1e.c
index 9bd4e92a6f..492ed1daeb 100644
--- a/kernel/cobalt/arch/x86/c1e.c
+++ b/kernel/cobalt/arch/x86/c1e.c
@@ -21,6 +21,7 @@
 #include <asm/processor.h>
 #include <asm/cpu_device_id.h>
 #include <asm/msr.h>
+#include <asm/xenomai/c1e.h>
 
 #define ICPU(model) \
 	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_MWAIT, 1UL }
diff --git a/kernel/cobalt/arch/x86/smi.c b/kernel/cobalt/arch/x86/smi.c
index f28af9a3b5..87a2a3c4f9 100644
--- a/kernel/cobalt/arch/x86/smi.c
+++ b/kernel/cobalt/arch/x86/smi.c
@@ -30,6 +30,7 @@
 #include <cobalt/kernel/assert.h>
 #include <asm-generic/xenomai/pci_ids.h>
 #include <asm/xenomai/machine.h>
+#include <asm/xenomai/smi.h>
 
 #define DEVFN		0xf8	/* device 31, function 0 */
 
diff --git a/kernel/cobalt/dovetail/syscall.c b/kernel/cobalt/dovetail/syscall.c
index 440c069d57..7d92ccd3a1 100644
--- a/kernel/cobalt/dovetail/syscall.c
+++ b/kernel/cobalt/dovetail/syscall.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2005 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
  */
 
+#include <linux/dovetail.h>
 #include <linux/irqstage.h>
 #include <pipeline/pipeline.h>
 #include <pipeline/kevents.h>
diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index 1d37cb279e..a26da154c4 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -21,6 +21,7 @@
 #include <linux/sched.h>
 #include <linux/kconfig.h>
 #include <linux/unistd.h>
+#include <linux/dovetail.h>
 #include <cobalt/uapi/corectl.h>
 #include <cobalt/kernel/tree.h>
 #include <cobalt/kernel/init.h>
diff --git a/kernel/cobalt/procfs.c b/kernel/cobalt/procfs.c
index 0aaf691dd8..8c0b6e6139 100644
--- a/kernel/cobalt/procfs.c
+++ b/kernel/cobalt/procfs.c
@@ -25,6 +25,7 @@
 #include <cobalt/kernel/sched.h>
 #include <xenomai/version.h>
 #include "debug.h"
+#include "procfs.h"
 
 #ifdef CONFIG_XENO_OPT_DEBUG_LOCKING
 
-- 
2.35.3

