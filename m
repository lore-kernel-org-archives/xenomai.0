Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B678737107E
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 06:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221402; cv=none; b=Trt56bzuIgOY77uiOd9m5wzmHQqBGYdmg9TxTQLt0VCCsTUzDy5eqCpu3Wo/xY6AnGitMtkGyazny65wUIx9/SlnCeIt1w15F0x8yafoHlZMpqaSuTbF/wO6RMyk1Lk8SgXA464IjZfg7eRmiX3yIKqln2RE1sIP7ns6E/rUWrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221402; c=relaxed/simple;
	bh=v40WTb/BNPKpFxnzGkFNCK05OoSYpsw9z3b4So+Mj14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jIxCi0EZIJ1y9p55dIQmpaKMXBCXH9EIckIzeacpk/Skp7budmilBYHIYKuldrzIIY1oFza64eD/gOYniIvEVRznPHADvzz190kACusN/pSBILyZ4+S0z6U9VF99TcEAmsiPuon8MBNi8AgUALInmLWr5x3NZ0AldEZtdwFozfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=eRaiGoS1; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="eRaiGoS1"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260508062302191df8bc4200020723
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 08:23:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=T1HD7Yclxw0GYOdBu51N3OJwOoUoJWdAXn+3UjWchvg=;
 b=eRaiGoS1AhiOy8YT3vIFXX7qy2Qs52PwEqlnbY1+OQx2BlYh29JO/DLEJZ4siVtVRTApT3
 QSi1FPzsuQ84aZ1eXkVlr5hwrUsAwk0jfHuyGJGCp0gCQgziypiP5vWqo8m0raC7kDYv3WDR
 zAjHCLZgV/X3Nwlcp2s+B1QsWoMJX0fFqsXCbau8ELlcbakzuBCaDsLnWtgAojwsLr2tAJlA
 qHO2euBRwCXy+ml+xOeNrIjVwRQSnkSGrtK7iAQsQ0LmvZGH/2CGpaEO/i2JY7EPkR8fhjVA
 osx2KFDC59KdIyKh7OmLSv9SUUjfV9U5iPE9H5mzr7e6keLWLjbY1BCg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 08 May 2026 08:22:58 +0200
Subject: [PATCH 25/32] demo/alchemy: Rearrange includes
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-wip-flo-refactor-includes-v1-25-e449f2bd4fc2@siemens.com>
References: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
In-Reply-To: <20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Moving from "local to global" should help us to keep headers
self-contained.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 demo/alchemy/altency.c           | 15 ++++-----------
 demo/alchemy/cobalt/cross-link.c |  3 ---
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/demo/alchemy/altency.c b/demo/alchemy/altency.c
index 43ce8ea4a890ef0446dde1a02e9208af00d7fe6a..7775d6a0976bc376cd894b0bebd0e86ac59ee45e 100644
--- a/demo/alchemy/altency.c
+++ b/demo/alchemy/altency.c
@@ -4,21 +4,14 @@
  * Licensed under the LGPL v2.1.
  */
 
-#include <stdlib.h>
-#include <math.h>
-#include <stdio.h>
-#include <string.h>
-#include <errno.h>
-#include <sched.h>
-#include <time.h>
-#include <unistd.h>
-#include <signal.h>
-#include <alchemy/task.h>
 #include <alchemy/sem.h>
-#include <rtdm/testing.h>
+#include <alchemy/task.h>
 #include <boilerplate/trace.h>
+#include <rtdm/testing.h>
 #include <xenomai/init.h>
 
+#include <math.h>
+
 RT_TASK latency_task, display_task;
 
 RT_SEM display_sem;
diff --git a/demo/alchemy/cobalt/cross-link.c b/demo/alchemy/cobalt/cross-link.c
index 0a62c074fa94740e3b9e5f6540f1542eadfba2a7..464b91d46ee566ce40ab89540f7616d13edf4c3c 100644
--- a/demo/alchemy/cobalt/cross-link.c
+++ b/demo/alchemy/cobalt/cross-link.c
@@ -21,9 +21,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <stdio.h>
-#include <signal.h>
-#include <unistd.h>
 #include <alchemy/task.h>
 #include <rtdm/serial.h>
 

-- 
2.54.0

