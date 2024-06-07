Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937F0194C9D
	for <xenomai@lists.linux.dev>; Fri,  7 Jun 2024 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767976; cv=none; b=hmuYaymiMJLFCseY0NJR1xFRAoh4Leo8JoOTQ2ttyPHvK+KWFaPsBsHoF/fvORsoCnJPT2/DAvGLSuHoFuqL8pAHckww/7rsbrCFjXDvjiOQzebwgUM1gqJ2SDzidWsqnVFgMBzxHq2p5UKlH+6VIuqkDE6hlcbY9yAAk4HgwLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767976; c=relaxed/simple;
	bh=7xA+Wa7tIRS2Ye32UEGdSrVCJ2/oe2/Rq+pFzRrZBiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H4bBjcqjjlMq9qb3KMGjmrtQfL7gm7N5aJuzJ/rCeKVFkOk7Gv5CduqF7ZQ5vU5gpA+YRfBISa7zC0i/k77yuhTQZ0CID4Bv7XjOekS6V+40TqC8jeDRINXTh0PyoPsxottMtN6vbg+n9EUrY44Qb2qqolI+xDFN1BZwB8AbdY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=k4bf3bDg; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="k4bf3bDg"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240607134611ecc869587cf37a192b
        for <xenomai@lists.linux.dev>;
        Fri, 07 Jun 2024 15:46:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=FDpdrXBKM4DMRZZYeU/w5SjCuQMyca4vppQPK7kzoAg=;
 b=k4bf3bDgLPUOTMrnrYsrVoJ9m6hxeun1XGJ0tiFx2gVO5SSn0ue2Kcq6xmPK7eXZMVxvVL
 vlV2kUj0LKxo2bzZUGeNp8amTkEmzBEe/iCqKu0drFwQKuZyR5olZtWoi9HxeMxdp4tkO3r+
 YllsmmcQ9/jvd6fB6VaGYfyUOI/K8=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH v2 3/3] testsuite/gpiobench: Synchronize index of loopback mode and react mode
Date: Fri,  7 Jun 2024 15:45:51 +0200
Message-Id: <20240607134551.3450170-4-clara.kowalsky@siemens.com>
In-Reply-To: <20240607134551.3450170-1-clara.kowalsky@siemens.com>
References: <20240607134551.3450170-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

While the index of the react device is incremented on every round (read,
write, increment), the index of the loopback is only increased on every
2nd round (write, read, sleep, repeat last steps, increment). This
results in the unintuitive behavior that half the number of loops would
have to be passed as a parameter for the loopback device in order for
both devices to stop at the same time.

To simplify this, the index of the loopback device is increased for each
loop. The calculation of the average latency is adjusted.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 testsuite/gpiobench/gpiobench.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/testsuite/gpiobench/gpiobench.c b/testsuite/gpiobench/gpiobench.c
index 79a2dee29..dfd936c0e 100644
--- a/testsuite/gpiobench/gpiobench.c
+++ b/testsuite/gpiobench/gpiobench.c
@@ -374,6 +374,8 @@ static void *run_gpiobench_loop(void *cookie)
 		/*take a break, nanosleep here will not jeopardize the latency*/
 		thread_msleep(10);
 
+		i += 1;
+		ti.total_cycles = i;
 		ret = rw_gpio(GPIO_LOW, i);
 		/* send a low level pulse from gpio output pin and
 		 * receive an interrupt from the other gpio pin,
@@ -392,8 +394,8 @@ static void *run_gpiobench_loop(void *cookie)
 		thread_msleep(10);
 	}
 
-	ti.ts.inner_avg /= (ti.total_cycles * 2);
-	ti.ts.outer_avg /= (ti.total_cycles * 2);
+	ti.ts.inner_avg /= ti.total_cycles;
+	ti.ts.outer_avg /= ti.total_cycles;
 
 	return NULL;
 }
@@ -506,8 +508,8 @@ static void print_hist(void)
 		printf("\nTest is interrupted and exit exceptionally\n");
 		printf("Please run again till it exit normally\n");
 
-		ti.ts.inner_avg /= (ti.total_cycles * 2);
-		ti.ts.outer_avg /= (ti.total_cycles * 2);
+		ti.ts.inner_avg /= ti.total_cycles;
+		ti.ts.outer_avg /= ti.total_cycles;
 
 	}
 	printf("\n");
-- 
2.39.2

