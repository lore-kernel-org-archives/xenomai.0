Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010797;
	b=p7r+PdB54cJN9IUHtmkCh9w2d/GSI9d7CW+95yBt69rELYGyno50qrZaN1No4bf07sIE
	 0xhC2pkKKfBtUmO9wvT/Ul7ayRkcHsHQxiiE/uP21VMamB21gVZwUk1Rujug5qfRKArwn
	 5O25UIE4eE+ofvZ7LHHhZ4giNT0YkC2Glu102sjRxnpSPKoQnjT8BQ0EOE5GYNnmpMEXo
	 pejzGgQB+M35nTw53Aw0U76JX3Ii65AgCsjwkI16ZnV9VvklmG9DEbCsmEIBmrzAxhzCK
	 CAUsU0HehRwPCRV+cyRI5DzsNCgZKwxkhbFcKCN2R5b0NzitP8Ba9QJHxsVAIkDWTWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010797;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Hb3XpmOZj5FjtzEo1uLAvpkuJKFQup9BKqZyEbR+p2k=;
	b=t7ESk3+6N62f9svbVO+r3xUQeq95syz8LMyJfkGIOlfXWWezSqFBDXFtynucW231k6Ce
	 Ker/uusKC8BUKyLdSxBk0NAFXbmB6RvMy0ToRppDEzVxYeqSABcx6BbSu/J1blKTZZrD2
	 CXX+SYjsYnlIChu0IImWBMIY2c56s/I1g7XheBnhJusMnBjXSuZp2UtQVYTfuaebMifuv
	 ip4RtIWrUiS1tzRNNvOj3MwCVo8JJTtAn6vZgSZDSTE6oMhPC0juhu2XDM058ZsZFMsmk
	 mudDpq/T8lN6bVu0l9aU1SpR988NCJ7SFKqAwv4oKYDLvw6p3kmMA9sJFriW1LB4x+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b="xMGt/n0A";
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20843606A32F
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 14:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20843606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=xMGt/n0A
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4cac7a7d3cso129000566b.3
        for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 06:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795010795; x=1795615595; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hb3XpmOZj5FjtzEo1uLAvpkuJKFQup9BKqZyEbR+p2k=;
        b=xMGt/n0AdZAs/g2hBhE2RuWOlXJvmc7n4+RLvNWiTQOzTAZEd7nxkGqttDuWEhwKIX
         zkokgQETKNRtmJIPfOnrwUFrjkrcgcP6RPiwH6yj2y1pQoYC4Va0+/nkDu7I/OG1izgh
         EDpZyq+xBh0ho6KJWStET9lS3vynWijyhxu1S6rcNwB5M1WLBoEZGXE0+jMtVsW3VZqA
         e9Dna8Wi0MxQhAcZurPHz+PeziUxWl7vabGlrFfRevEUY7eBdi2XFs7tZ01xYc67pXJM
         +iTwpFest6Quvs4SwpUxk8mPn+NTf/uJ39n/1DaCJWUS+4saFiCRSMCFrP0Jfz5QSBSe
         6QBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010795; x=1795615595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hb3XpmOZj5FjtzEo1uLAvpkuJKFQup9BKqZyEbR+p2k=;
        b=HKaJ1Q4UehMOtToBp/oJEkkuyL+tHCmlSnVSd4virwiNkbRi9kG83WgIEC1JRneR8d
         LVVLU74qAPRPwvQosZcIl+Yt+WI3Ssome/Y5ZQVagekOh3HVReGLwnwnRvejmobgmDAp
         ziJDSF57SjaXUpBPA3RknWp6RrQ5DHsKL1WKrvThIeNr4nvAwD8E38VM0UjXjRDg8Gmy
         ncPoEdgpcad079sScUhTEQefheLZx3ZElQO6UqM0rcyehDbVk9FI3VG5hC3wZf3xXYbs
         dHXVBusQK0Jp9QHpm4wWMlqpNri4uFdZFHVdnMB67gPqJr1TCcnauYODBUItGCT82cjw
         AXMw==
X-Gm-Message-State: APuU4Z+xWvsZ8Zkm7bK8xXT/pjM+2EcH8D1einS/Sfol56fv+iE626X9
	2Qof2k4G3orOtrAs/nZ5ewVornOHKeUkiAJ+3uERi0Zp6f4IhjccQexPFpLGeQ==
X-Gm-Gg: AYBFou0B08kvtO4C0YJgCUmiXzT/UGRnGq5iCIOXtvsjW2H44RQLTRS8c6PKik1s06l
	z9kTyfGkHexpW38On9+A6JFFFd2umZ5C9G4IH94CIISI8HDe1ZV7VCq5zkW4VnWOQjU+SXmtxoN
	fMGlO8G5+UOFsYjxf2iDyEMsuOUCgZeNFCOY11+E45SD8bRAzMa5RuMMH4zE86x52TcUPImahib
	/U+DNLkQ9kbtmXL7rHDOdIh0GshUsV4UtigS3L9BlIRiDKEM+4pG3nJYswLpdFj7pD/SK1b8eGB
	yPToMo6Ajcqu8RIHSweZlv6bVqDl0NptloTzvDmY+kEGCYGt1+XBBxF1fOTak3U2dFRZ90fQxPS
	mPORvrN7o1fkQvJy2KtSZl7T1VFUMeW9r22KlVWA5s6NHbW+6uc5sZQVfZBMUpb6Kn7NiQcqJgh
	yABf+3kiFROgXpp4h+YKlDfBA7UTxSh5VhmZwmpTvj8x2hnn1IIpFiu44iVgea3pT74ywMyiNsV
	wdYRsx1Uxx5pMdB4UxkGqFpVonA86zyxIRw1Iwi22XFqfeFPB+pnL3YI36JsBAKHzX57bToKELj
	TRmfjpTwmpg2hQDwj5QfUN35ZQs4eV7NIxv0D6QW8TInAs3noFmr9KdsyL+x24hl3UIjo+kSwG6
	GW2BWCfSB
X-Received: by 2002:a17:907:3f93:b0:c50:c04d:cbb3 with SMTP id a640c23a62f3a-c510dc7e0a2mr235799266b.0.1795010795287;
        Wed, 18 Nov 2026 06:06:35 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c512346c84esm1024966b.56.2026.11.18.06.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:06:34 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH v2 2/4] testsuite/smokey/alchemytests: Add missing includes
Date: Wed, 18 Nov 2026 15:06:30 +0100
Message-Id: <20261118140632.1080213-3-yegorslists@googlemail.com>
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
index d0180bfac..b2db20ab3 100644
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

