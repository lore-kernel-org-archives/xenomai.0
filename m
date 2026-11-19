Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072671;
	b=34A79Elg5NKXUG2LhVHjfaB71Xkpn3ce7KICZo0a7XAurlJfix7/y1nVqYDzeUR9opcu
	 uJeylijiZOfeylwhl4SNmi3P/7RU5yuxwp1gVRBZJBmoI8I9G5xCw4dQ4UwNDKzqX/1Kx
	 6/PnJ6iP6PM4Q0tBcyjPOB9E8XVrt+Rn7vIdZvZ6w0GSyy6dF+BSKiuRZTadB1INSO2VV
	 nMkpSsbTDCg/slnl1I/FjyBYa3lKcUa07U76bB6C6QszHsEAyBSW64wm5Tf21U0VpYADE
	 30WM5TW3Fqxelgo7Kc5TMzv5PJEsY+i4TWBCGpQ8YEZ6GLoLlPSQPughQ4o2nCNuZxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072671;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iPdyqLDfQbmhIt5SHpg3OhL3U46CmIWVSUjFP9s2bFw=;
	b=1jBrRCfBimvyi16ds0u0Kg1l9XX+3Rq580hzTHHlOizgfh4u9N9XljMeo5bQEipMba+W
	 UqR6u7KVedIVp4eqfVPo6JHPjKlckBjXyYMH+1Zu29b6w4ZoU9AyGMm0lfBuaqGsl0kBv
	 W8Iefd+wDTVkel2mrpawMP8g+aWBjZCOXWADmX+wiIh6AzNH57+KQ6LvkuM4KjmQ67PhZ
	 Y0H+rOKkZPBwlCJcMfD8ax5/fgjfY5d9d1Xp7RV6jq29kYtMt/Ak94xIHFgPzPnddOQZ+
	 9+7V9qtRMhirmBmY/0d9tE95VWLLTOFYg3VFGrnszKdoxIZjnxjslAbJyG/GsktHW7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=rd+eqGy0;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384AF606A324
	for <xenomai@lists.linux.dev>; Thu, 19 Nov 2026 07:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 384AF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=rd+eqGy0
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b88bc47e23so2469370a12.2
        for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 23:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795072669; x=1795677469; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iPdyqLDfQbmhIt5SHpg3OhL3U46CmIWVSUjFP9s2bFw=;
        b=rd+eqGy0zmOgqztBjb+7sPPEOTkoaHiCVzFS0RuVbVvNjBqUGO9wdIJZG9oKvqK2Ed
         YyZmwM6L12YvYGGPk6STHkaSEqCEZOCEb5mAu4jZIuI8/q9zzsu+SMgYvgKafO3Wi1sx
         B/0o+zfu+3/Szh6v75pnoX7ddNrWmjhXrpT4SzslmzJJvrxVeFBpZGqeVYX/eqkB6AGI
         6i4QthmS+RQD3H/In6FjHmrIAssRwtygRGQwg1df2xqEklJSh0UTrSHI5f5LtYu59Uti
         NNFb3itiTWzN17k3fZkFp0RiF59OgyQ5Cg0DY3/pe1veJgHrTosx32IFr3kCECV1gq5T
         MCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072669; x=1795677469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iPdyqLDfQbmhIt5SHpg3OhL3U46CmIWVSUjFP9s2bFw=;
        b=v62kWUhp9LkZaPdgXlpfZtX4Xm23OajrW3t3Ohs5AH+Kk3vRfpFVBUaMcKHM9jSTmg
         HAWfie+U+HTMIhD1FpytNcBs5ipZ7+IZBV87NPPlherJsL6m6fkOkUBAl5L2y4HjQPdC
         LIPP1EC0QUKW+BM08JwwiR41bPggC3jzpKDo6bJWHaLebRP6G4EDg1v3KiSX6jyd5zl9
         wKPtyr5Q4a4DzFK4X5bVa+qgATQMB4hiYM1GPrMRS+CsRjwe+iaa8YP4QWJOxcxrvp//
         R6Gc4IS+DZBM91CfMbpRKmQfaTERIFRhVRwO4EhhK2s5z9U1WcPPtAuzphXAvESwYuqg
         WO+g==
X-Gm-Message-State: APuU4Z/Ds7zZizwZIHd2qwDenlepBhmXDDSviu+AqK9qSpR2NB4MD6D/
	vjm+LPESi+ESQjF5W2EQC+q3/BoEKHmod8Wj9pjK34A2oJXNZtp58Mv+6S1raA==
X-Gm-Gg: AYBFou150yYuOwiLmKti3n5RyKOpUJ9Y8/9K4g/5DtwKSNefzgoDsD2Kb+5f03HrE0A
	EvVWd9VduIe5euLVv4vGyY67UDRuTWIyR8+5LP1c7DV0oD1N5Vlauzama+i/R9Lzz0xxFMMTwC3
	oCdDMpECiGao89K3zBgA5twuNDwntDTfAEr1g6Tb/WhmjV0n8tBM31TG4jU5bGOd1egrngYryKB
	nmlfQQtihyeFhSkt5msHzSsucdw9WdD1v2crq6EEj0eDBrjT7pdgVVcIJ8ZooVD+Lys5wU+kjKO
	d0Nmh0ILpbkzpN2FWzYXjgf/PS6w7/GRSXQ2fYCNehSUmi8Ao0IMB/d7UJy1yRSrnN94hce1a+K
	dGkA2b3fdWwLG8DtQb4OYZJFUhrXVUujTZ7Nmw9mwt0yBF4uxct/mjg5E8F2JCF1vdLzVVeRIIn
	peby/10FWMazqZtbi1gUhKzTIgSvzDpobPdFDgzHIlxPuDcqJOFZJF5V8LJm3Pe3Omsyng7TJEZ
	lmk2FoSFvieYXER8LqHZXQMqrqt/3BYuf4lhIfv2nVi5huIZK20HLrUB7dfQ238dEGCTS8XRZCg
	XbBKRDqu+cGTjnzd0Nc7tIxsjl915h5E2CC5H95f2h371dFphA/tvn5494iyaiZlNE/hthr7n1Z
	cNm9xnMCLAUqWmcRdURW3phH+rfoDIw==
X-Received: by 2002:a05:6402:5cd:b0:6b8:7769:fffc with SMTP id 4fb4d7f45d1cf-6b887eb2136mr3845249a12.15.1795072669314;
        Wed, 18 Nov 2026 23:17:49 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b889a3315dsm2061733a12.10.2026.11.18.23.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 23:17:48 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH v3 3/5] testsuite/smokey/alchemytests: Add missing includes
Date: Thu, 19 Nov 2026 08:17:43 +0100
Message-Id: <20261119071745.2409665-4-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119071745.2409665-1-yegorslists@googlemail.com>
References: <20261119071745.2409665-1-yegorslists@googlemail.com>
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
index 24f6fa913..569b73375 100644
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

