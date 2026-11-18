Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010798;
	b=epyTKbae3U3SWQihiCKJYvo/kO5pz24XpXu17VA1kQCd6vODQ9hVyJt6R1DZ2omJCyz7
	 qHyljXkWbtLn1B0teXGn0tTMw6gwrQuZRIRHL9sER16UNtqR1xaCh1Gny0/opQtPQh1SX
	 RibvpXIuDoixyLs2Hfvpw1bvRKDhUptUcLKOS+s9pxrARqOBVqWc1CmcCukLf5ndC9tOv
	 5BpsMeZ4R+mvQaRzuHrhvXdXMLZSEKSM60ENtPpOX458OyRbgOiajNWbMIfNN92NYM6tJ
	 xVz3QfZttG7YM+au96paBi2TeKfke0yEriEMJV6ysYjHU+Zl2BOfeaCBouE9U6OSDpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TrC+ufZTaHbhC/Np3pDTO6GLHaBQDQ5l/mmo1pMHHuI=;
	b=EBKt9NdCtkUQAr7Aplz8hL9v7RaHQVVQXNAcOdU9Hc/N4+IfA7R65Cva7Co8vP9aI+ab
	 yw+exnoSrb8NvOHPQ84cVCwvjCcp+TOn8q8ZnDjsnUc+66H2JtRuQ8hjKmYRaXTMgBJBP
	 +iUtN1L4XqqgbKRVzX31YkUg4VLubSJdzlLrdeFdzw607XyWUQ5ZI0LqsvADQrYaZiOJv
	 ae6GnttsxIBJeH33Wh8lvrQ22GVXUaWEycVlZZ5neQOH6DuKLgOfYvYunAbptc5taUQW3
	 0y2KnuHY67pdwO7qksCLuar+XUbvV64P0Q636c4DOcM5RcZPPaQI+lrE7+ANAjUfoJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=JAuVrAlZ;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DFA606A31C
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 14:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5DFA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=JAuVrAlZ
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c5067a2411bso139281566b.2
        for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 06:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795010796; x=1795615596; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TrC+ufZTaHbhC/Np3pDTO6GLHaBQDQ5l/mmo1pMHHuI=;
        b=JAuVrAlZ6+CGQGpubqmRET5YKtFisp9CNzysY9wclpcZAp4GBVQK/9xFDMonjqT/OW
         GjkG3fHdU0Sn3p6UMl/BQmYSRaAsctFKqDSyANiGF1hif8expDy8ZR3szX+Jx+Sxyo2T
         bWQ55VknI58uZNXeQp5XSRBrkdUIJjG8LJqm7wycWi/l+D2wV3uruJXjvwz7sCH5ozww
         auo1aXdO4FVOjgiAbRAG6hPlci+ZFvlEuQjKVtOa+FZEsBNJ+2x9EWl3mx1moIJ2Olif
         wM0uKWnPfENGBdTH4KVZ7+jCPgxMSRrlG1EHJGBe7Q7eVvJYKLuFMyjitUIxRUsXDlyJ
         MhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010796; x=1795615596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TrC+ufZTaHbhC/Np3pDTO6GLHaBQDQ5l/mmo1pMHHuI=;
        b=2smFkhn8yapalBSdbV6TUDhi3GPfg+d0ANe9W1d6L5AbNOCwSYN8Ji1Qam+QW5ZlYl
         /oypkvyulMvwp7oqnggUxRlJZ1go8JfGb6zBz6l7lZhXHiIGyZRz+QvNwkKpUHZ2g7bP
         wNbhIdv885zFT1EMM3g9A8JwfZoSinziLpFHuSR83qRdQxpKqiAiatVGRYhmxHAwya3p
         rbLAtnyX7/PBBqtCopEsAhbk0Ii8nSkocyYYlSQdAcAhWD5bYvMBP6lpmP4fKk6n3LlB
         cN6qnRbQnAmn5VbxOUDj2ZolbanfzIT0G91fEKh6XH5QztoNbvO4zi6YYzKTzoecrOC1
         IIWQ==
X-Gm-Message-State: APuU4Z+IwfrBfbDKLRlpqw/Ju73M3CE9CxrLo8zy058fNuKoy9gkGAZO
	4o1ANHJSiOkwqYAnDOpiFqTYPZO/bcjWzSjNaD1IvAzmAQLB9iGAvAZHN3VdXw==
X-Gm-Gg: AYBFou1S/PipxB66O+hb5YThaEoGnqassynVVZ0Qe4NuPw9AZxGak0S//S431WJv13A
	eUL+lvc+Zq2UfR5YqiWhzNmIhZ8GGNXNCUlg3VsKGUmsc+J4IV8qsSTmjXX7FySXYunTWOVwW8O
	1BFgftP48F3sPjQCgBA8HoSUguAT2Rx5ucLFmNWx3T/zJ5d8P/eA0flfyYqnDbfm9i4MOIsWJf5
	+357HtUZaVyti8TMU0expQPSLpHfxwiz7MufBpZuFWQbe8p6dDWtPj9Bqpcq/iRhK+r1/D17/eZ
	HrgYYEmcrjPeFNPo9ypde1Z+6XHQHBcgTI33dF1SKs28MgzAnXFoyv6Vo3zCXkjUbumhB8XH8Pi
	dkMvbsIHzcOHX+zPmmsfugR0Q4NzsLchnqhs2dDYlJR/hi84Uv4OL92rLKg2udX+S7148+4AS4r
	WXI6LX5BN3z/JE7SzBpF/BL0Q4v9gdod12RQjPxOaivyBDAWqQZOGepIsHlU3spHd39oY38Fxyu
	dIVTv0TAsu8l5BQKZbMd+6qj6NMDW+AZQb6bfjXrNf2qklRVatrO0MSFXJyInRirzpe0JLFhlb7
	m9CHzl8ScUvaMQPAKwFlaHgFmtATemwuzMr3GwXpIBy6raQN+Erjo2HaDO+vuAYFNs5Xr6FUMI0
	gTAq2v0AB
X-Received: by 2002:a17:907:968b:b0:c50:9149:48e4 with SMTP id a640c23a62f3a-c510e16e51cmr249781866b.11.1795010796248;
        Wed, 18 Nov 2026 06:06:36 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c512346c84esm1024966b.56.2026.11.18.06.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:06:35 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH v2 3/4] testsuite/smokey: Include stdbool.h where needed
Date: Wed, 18 Nov 2026 15:06:31 +0100
Message-Id: <20261118140632.1080213-4-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118140632.1080213-1-yegorslists@googlemail.com>
References: <20261118140632.1080213-1-yegorslists@googlemail.com>
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

Several Alchemy, pSOS and VxWorks tests use bool without including
<stdbool.h>. With the Cobalt core, the header is pulled in indirectly,
and GCC 15 and later default to C23 where bool is a keyword, but
building the Mercury core with an older compiler fails:

  event-1.c:14:8: error: unknown type name 'bool'
  mq-2.c:10:8: error: unknown type name 'bool'
  task-11.c:64:2: error: unknown type name 'bool'
  task-2.c:17:8: error: unknown type name 'bool'

Include <stdbool.h> in the affected tests.

Fixes: e7cfe856c498 ("testsuite: smokey - new testcase alchemy/task-11")
Fixes: eef4a9cd9327 ("testsuite/smokey/alchemytests: Account for race condition inside QEMU")
Fixes: 54e9c5098634 ("testsuite/smokey/alchemytests: Relax mq-2 test over VM")
Fixes: 79df634b5b23 ("testsuite: smokey: Raise some delays in skin tests when running in VM")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 testsuite/smokey/alchemytests/event-1.c | 1 +
 testsuite/smokey/alchemytests/mq-2.c    | 1 +
 testsuite/smokey/alchemytests/task-11.c | 1 +
 testsuite/smokey/alchemytests/task-2.c  | 1 +
 testsuite/smokey/psostests/task-2.c     | 1 +
 testsuite/smokey/vxworkstests/task-2.c  | 1 +
 6 files changed, 6 insertions(+)

diff --git a/testsuite/smokey/alchemytests/event-1.c b/testsuite/smokey/alchemytests/event-1.c
index d691192ec..9d13c4d7a 100644
--- a/testsuite/smokey/alchemytests/event-1.c
+++ b/testsuite/smokey/alchemytests/event-1.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <copperplate/traceobj.h>
 #include <alchemy/task.h>
 #include <alchemy/event.h>
diff --git a/testsuite/smokey/alchemytests/mq-2.c b/testsuite/smokey/alchemytests/mq-2.c
index 09b26b213..f3c3f9ce7 100644
--- a/testsuite/smokey/alchemytests/mq-2.c
+++ b/testsuite/smokey/alchemytests/mq-2.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <boilerplate/ancillaries.h>
 #include <copperplate/traceobj.h>
 #include <alchemy/task.h>
diff --git a/testsuite/smokey/alchemytests/task-11.c b/testsuite/smokey/alchemytests/task-11.c
index 6d07e0270..cdf4cd476 100644
--- a/testsuite/smokey/alchemytests/task-11.c
+++ b/testsuite/smokey/alchemytests/task-11.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <copperplate/traceobj.h>
 #include <alchemy/task.h>
 
diff --git a/testsuite/smokey/alchemytests/task-2.c b/testsuite/smokey/alchemytests/task-2.c
index b2db20ab3..216a3cd87 100644
--- a/testsuite/smokey/alchemytests/task-2.c
+++ b/testsuite/smokey/alchemytests/task-2.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <boilerplate/atomic.h>
 #include <copperplate/traceobj.h>
 #include <alchemy/task.h>
diff --git a/testsuite/smokey/psostests/task-2.c b/testsuite/smokey/psostests/task-2.c
index af0c0ff98..1b8f09f2f 100644
--- a/testsuite/smokey/psostests/task-2.c
+++ b/testsuite/smokey/psostests/task-2.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <copperplate/traceobj.h>
 #include <copperplate/threadobj.h>
 #include <psos/psos.h>
diff --git a/testsuite/smokey/vxworkstests/task-2.c b/testsuite/smokey/vxworkstests/task-2.c
index bf2613143..14f4dbac9 100644
--- a/testsuite/smokey/vxworkstests/task-2.c
+++ b/testsuite/smokey/vxworkstests/task-2.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdlib.h>
+#include <stdbool.h>
 #include <unistd.h>
 #include <copperplate/threadobj.h>
 #include <copperplate/traceobj.h>
-- 
2.34.1

