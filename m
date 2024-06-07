Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC793194C8C
	for <xenomai@lists.linux.dev>; Fri,  7 Jun 2024 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767973; cv=none; b=AjQj+XSfK2Vu0hloy7QtIdHJHMWtnEkkqHJaC+bq2RiFYQ31ZyTeybRhRmxJIwHsCxwwFyG8ifz5GVUuuW2XxecaIv5qsAtpxfdFX/rJmrqqzauFaGEOOYnCFnM7Wh2uR3Ts4w4uI+MkozxTpVkinL3aItyxpKRNKN6vNk2z8gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767973; c=relaxed/simple;
	bh=V/rTOftrVubPQdgxuaS5r4zAgX9arDYamOm9Q6GlvBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bZZ/iJmUgPB0dTJ2R2lsRK8EMMuEVPkEc5TfQiVoKpqJrMhKxrpeevy1UAVVDZmeFIH70MEjUVTYZ0hNoCCnrBOHcSE50gsPNb5PdJrFOkTaRqort+UJvCMZcKTL5VCW/NiAJpM3VCaQB7Tzb2dCuHGCMc1M5HPugtyFQKrRGGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=AcgF/jc9; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="AcgF/jc9"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202406071346076b85a7170ff9d64d59
        for <xenomai@lists.linux.dev>;
        Fri, 07 Jun 2024 15:46:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/yTX+c8qKODjuEcow4DDL7bspadTC3bWaKOsb7ctMWE=;
 b=AcgF/jc9My54a8Jb0963F6RTL78sTFm3Ope2/nG8Z7pND5p4rSGKGfNRPXMtQZSqxXKSg3
 Vnt1ZD83/u8Quhw2fLdefX3w9ODXkmKW1sH2prtJ1OM6iNSbNgOwBjFxhLD7CDG73YkAi76h
 vGj91aFYhF+3JKUzWjdtXQ2VU1e/U=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH v2 2/3] testsuite/gpiobench: Fix output pin in react mode
Date: Fri,  7 Jun 2024 15:45:50 +0200
Message-Id: <20240607134551.3450170-3-clara.kowalsky@siemens.com>
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

The gpiobench was tested with one device in loopback mode and another
device in react mode. The former sends an asynchronous event to the
react device by toggling its output pin. In this test state, however,
the react device always responds with a high signal on its output pin.
Yet the input pin of the loopback device is set to edge-triggered, which
is why the test hangs in read() on both sides after one loop.

For the test to work, the output pin of the react device must toggle
between high and low in order for the loopback device to successfully
read a change on the input pin.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 testsuite/gpiobench/gpiobench.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testsuite/gpiobench/gpiobench.c b/testsuite/gpiobench/gpiobench.c
index 86b2c32ce..79a2dee29 100644
--- a/testsuite/gpiobench/gpiobench.c
+++ b/testsuite/gpiobench/gpiobench.c
@@ -424,7 +424,11 @@ static void *run_gpiobench_react(void *cookie)
 		 * latency box will measure the time elapsed
 		 * between the two events
 		 */
-		value = GPIO_HIGH;
+		if (!(i & 1))
+			value = GPIO_HIGH;
+		else
+			value = GPIO_LOW;
+
 		ret = write(ti.fd_dev_out, &value, sizeof(value));
 		if (ret < 0) {
 			printf("RW GPIO write, failed\n");
-- 
2.39.2

