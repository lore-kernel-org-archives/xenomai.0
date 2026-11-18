Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795002560;
	b=ep9AJ/mpskirnVVWaCuWYqik7h1uf4/goo2b5goqSeysSAeL4Yb4wUcymQd4eyYO0yr2
	 ZR9BvAV6c0ZrIeFWLR7k3M9ETzJEtoKFeQX/fdHdlkfTz1E2AX7gs+NAIYzRJFGJ2gxRb
	 gPuTj0tai7dv4p0P2gDu7H2DPgVIHSLF81WAyFba6iFA9CsqV0wqXzuFKcnfmvhZeFKah
	 Vpq3VEM2A1pM7F9T601nibKMQMUoRsDVUsKRCPMT4qNEYRq/MI2pnlxxDPTKF/eb8CtCQ
	 OXJY5cBW1GTTUtaqN7gGAGERsBW+OjDV9szZcfdXAlUaCL5pRxzdnbOKnRzGOJEJTvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002560;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xpY7TNarCsh/Ar12crUpnMy/5kxXErx3+WnLASvs7MA=;
	b=dKldiLQjCn6iYZtZqi5vNpDWTcL1Jc7GJM4Nlu4dYhL4yINjx+W+NkO6pXzkwpdJRMhf
	 IbY9zni4J2vEn/gDru0CJxaz9bQFr4DoNiIGWI5LZDtjkMdK7BXk7XAsOGWf4Lfb6SzHr
	 jXIUjYTibP6vGDTpUPYmM4bQyGzE/bBg3iCZUI2MwnbFsESwqmdJ9R4b8b7cqV3BSXHFe
	 Q8T29JCjF3POYnrMrzSugKmbJ3s9lAYP+FqYX4CacFFt6dsKATXcHZcTjg5tKDan6qDwz
	 s2au4/h3ACz6GFyIoL3yaHwB7To0DDsCw3VPEU/7oA+YEJSZWl+J96fhQ4mpDPcaCxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=y2jEnbYp;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9880606A31C
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 11:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9880606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=y2jEnbYp
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b8a52db5f9so393836a12.3
        for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 03:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795002558; x=1795607358; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xpY7TNarCsh/Ar12crUpnMy/5kxXErx3+WnLASvs7MA=;
        b=y2jEnbYpr0BKFjlSIWMxJjfq2eTnRHBSncc9DDE/qHtYdTE3Bxq6WXAnGcGpvb8xJ7
         bejdS6vxW9ZH0CY8S7/moXtma7s6rG/7X5srAHCPTsbIW7BLyGWcEfgYYkEjMO0e6yeG
         5akVsB9Gc7E3v8uS9pj8QseoANK9b3njzkAgiFToAhx6/l5OYvLloiGACwAVA9ZZnu8E
         BQgG+wfuXM0MXrYqE//SP1JkdLo4p9bd27VFqh8U4IXSSp+dY6LrI6CwdEBflI4e1x2D
         U/xILwrfK5H/tQqMzVBtjw+kUG2hhQuWd8X96Zz5ix6TVCTupuODKCo9A+/+rIk2eSX0
         jAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795002558; x=1795607358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xpY7TNarCsh/Ar12crUpnMy/5kxXErx3+WnLASvs7MA=;
        b=TeKVOTBs0lDtpqwI7zIGOR/gAmCJz3EhIXP2+11YbfeEOcab7LLAMuCxsKFSVhQgCG
         fhbDqVJOtGlHXFArmJ94xq7oeUF7s5rxtmHyagdMcNkrqZ00nzIw9dclm4cABmZYXXsT
         xhM75b4Re+ib9xicWRsmIVXii6cTv2CkBFjCDjKTQQtWlPt2GSzI1idrgb+4djdjPYVm
         wLqOrNBnduLm07J2KDNUNM3HsqFJFLANebUrXHBkwAM/w8/YKryQqnBj4+MDKPsQ4TAM
         bzXGzABM05YXjujZuaE6+/bD2ym3w8EA705b0WyohO9Y4ubte90FO4dcK1BopWhEuo9/
         YyVg==
X-Gm-Message-State: APuU4Z9iNc+YD1gNyCEiaK1TsvwsEHbRVAxlIB7gfYkb9/fVCgga6nO9
	8AYSLoLujgKx70gFLyG6pcaTGrtARospCZsX0qzqwU6PlHrfBRc5cAB10mJ75A==
X-Gm-Gg: AYBFou00dbRoz7pm1VCyKyLxnI3skfKjaxQXbPoFWU+pPUc7g2AuRlA98iuX+m5+T2Y
	ENDp2xUmfE3JYreuaz1Nut+Tk/LiymAo5KmUd9YhmyPsILpYzcocilQhUo09qekIiQVK/TwPYGn
	6YUUyuiSHF3HqZcqc5rB890BwOoJWPuIFrI17RvWKiASy2VtB1VYnqH/adwlQ+zUM7hE4U9nS9Q
	MX8nYWNwRDsjolyX0eYBuRnx2s59EhJsgLayFzeL/J7plb/ETLMwqBgzggA7dpoQ0xIUHy5jlMI
	5q42Wb/FsYE0LHl4pP2mn2mnVWNBiUtyZI8YTGMwEjP4yZwzgWrcI1N+7SHmz13GbWEUapY7dSv
	3gnZurB9xPh+T1/7jjEHt0wKxcHxXMAnOvzBbWCXRJI5CFH+vqpBgTyh7PCqpfZUZ8fi1BGk5QO
	JNQfav6MFw5p3UCJRt1HuuZiqw/4B3cbUBBYMwehEosr7SbqZTz05hRm8rQMKaqejR+Yp/oVXN6
	fwUmixvqBZfp/pLM5yFfu4xIu1rO4Wez32KzMl6bv9eZjVgnK+2SvUl06wPngFiIEpmrtPgVSeJ
	jZhVCrbOgHVY1uWcOprXGDPIA7p1/7XX1zovLfPF7Zqve9GO3bTH4dukmVRY5VhBmFYZFBaGz3L
	56y6LERqC
X-Received: by 2002:aa7:d1d9:0:b0:6b6:f5b0:889a with SMTP id 4fb4d7f45d1cf-6b887ec0972mr1353132a12.35.1795002557980;
        Wed, 18 Nov 2026 03:49:17 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b888ef94a5sm917931a12.4.2026.11.18.03.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:49:14 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH 4/5] testsuite/smokey/alchemytests: Add missing includes
Date: Wed, 18 Nov 2026 12:49:08 +0100
Message-Id: <20261118114909.3030884-5-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118114909.3030884-1-yegorslists@googlemail.com>
References: <20261118114909.3030884-1-yegorslists@googlemail.com>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the Mercury core, the alchemy tests fail to build, as some
declarations are only pulled in indirectly by the Cobalt headers:

  alchemytests.c:43:17: error: implicit declaration of function 'fprintf' [-Wimplicit-function-declaration]
  alchemytests.c:43:25: error: 'stderr' undeclared (first use in this function)
  task-2.c:34:17: error: implicit declaration of function 'compiler_barrier' [-Wimplicit-function-declaration]

Include <stdio.h> and <boilerplate/atomic.h>.

Fixes: 61fc9ff4b721 ("alchemytests: Set cpu-affinity by env var")
Fixes: 10d898c40e26 ("alchemytests: Fix task-2")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 testsuite/smokey/alchemytests/alchemytests.c | 1 +
 testsuite/smokey/alchemytests/task-2.c       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
index b596a1e17..bd01fe227 100644
--- a/testsuite/smokey/alchemytests/alchemytests.c
+++ b/testsuite/smokey/alchemytests/alchemytests.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
 #include <smokey/smokey.h>
diff --git a/testsuite/smokey/alchemytests/task-2.c b/testsuite/smokey/alchemytests/task-2.c
index ca2225ad7..80ad90bc7 100644
--- a/testsuite/smokey/alchemytests/task-2.c
+++ b/testsuite/smokey/alchemytests/task-2.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
+#include <boilerplate/atomic.h>
 #include <copperplate/traceobj.h>
 #include <alchemy/task.h>
 #include <alchemy/sem.h>
-- 
2.34.1

