Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CECB1F19A
	for <xenomai@lists.linux.dev>; Tue, 16 Apr 2024 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713258029; cv=none; b=rQDKR/74/jOelisqRbAo+dkuo/w5sqJ4VY2/D3PFmSS0DxIteJZurcei7Qjui7fEeyr7Vopj5zkFkm99G6vjDQo9soWjy2b3hT3LosCb/W19x22n6f76iIwjb7P/PiDrUqttfj5XR4hinnQeQmaCVtoemMDrIC3B8uCI710bUAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713258029; c=relaxed/simple;
	bh=KtDz4Tx/Visomh1uocP8k8Og6g9NaRi53+7ifs6lI60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q99qdQHaQsjHbhb0BSyoyXyWehy5Fd8UVjOFcZzH1aifPGVTPSe1rF04hwWWGu1nmBFCNmW1Rzqwoq2JzG560lpZ+wj2w6iZ1tnC61pOe8fdFUu/XUBWBAQAkLdoixzxE8+wJXf8n+qdRVtnK0mQaQno/Ypc8QR48ND+rIgTI6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=XTRSrXT1; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="XTRSrXT1"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240416090016df8d5d817a2ff6e542
        for <xenomai@lists.linux.dev>;
        Tue, 16 Apr 2024 11:00:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=0l246zdjL0ShzINasICL9tLHJEMpG5dyqMla5OnMXQk=;
 b=XTRSrXT1LbHL8zhplIGhtxaAWtGY4nc7aBE6hUvG1UwtXUfLv7C1h1jmsm/4/UuYcrM8hU
 xJGPz5OPN4vrC3YXQcFfv+B43sydGBCglPhMeXWF+G1vd0GWbXos+iYjl0efd6aZqG2Uybsy
 PShwxKASrnxE9Ry14iTG2NfbzZBmQ=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH 3/5] testsuite/gpiobench: Synchronize index of loopback mode and react mode
Date: Tue, 16 Apr 2024 10:59:09 +0200
Message-Id: <20240416085911.62073-4-clara.kowalsky@siemens.com>
In-Reply-To: <20240416085911.62073-1-clara.kowalsky@siemens.com>
References: <20240416085911.62073-1-clara.kowalsky@siemens.com>
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
 testsuite/gpiobench/gpiobench.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/testsuite/gpiobench/gpiobench.c b/testsuite/gpiobench/gpiobench.c
index 707f35ae9..1c525269e 100644
--- a/testsuite/gpiobench/gpiobench.c
+++ b/testsuite/gpiobench/gpiobench.c
@@ -374,6 +374,7 @@ static void *run_gpiobench_loop(void *cookie)
 		/*take a break, nanosleep here will not jeopardize the latency*/
 		thread_msleep(10);
 
+		ti.total_cycles = i += 1;
 		ret = rw_gpio(GPIO_LOW, i);
 		/* send a low level pulse from gpio output pin and
 		 * receive an interrupt from the other gpio pin,
@@ -392,8 +393,8 @@ static void *run_gpiobench_loop(void *cookie)
 		thread_msleep(10);
 	}
 
-	ti.ts.inner_avg /= (ti.total_cycles * 2);
-	ti.ts.outer_avg /= (ti.total_cycles * 2);
+	ti.ts.inner_avg /= ti.total_cycles;
+	ti.ts.outer_avg /= ti.total_cycles;
 
 	return NULL;
 }
@@ -506,8 +507,8 @@ static void print_hist(void)
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

