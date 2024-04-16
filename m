Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED5984A37
	for <xenomai@lists.linux.dev>; Tue, 16 Apr 2024 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713258016; cv=none; b=f4wUneJjQWItxqdhCUBoPz4poSu3YVpo+SXEFdU8jMD1wf/K7uVRgid8HZDGcN5Caw+H5NdEoxVxjDWlg9Iejn2cg47ss5BLwZpDC+emS1k+r7RIeRwkQGCrJRXmBHXvxbYnBRLL5hy0lJVOHs2ode4G+4SCltkUI0BmwAGeOSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713258016; c=relaxed/simple;
	bh=EOKFsaEbYHnS1CAYytWKmgNvL390XYwjrxLc8CM5YCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fyde05MFBEpNRfwzAwrBtuVF8d+JlYo5Y9HiNa/Jx5nKtIuBEzUHZarj+N/wgTNppmTVKkfnKoklGkPJSA46lNiYtdnoTfcH6RWx0RSp+V0DG6tjPQl7WlNyuaEiYl3NBpswxR6r0X7QWVcfBH/6CcCTxc6kkNrGUFTu8FzglB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=ftQ/W4lc; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="ftQ/W4lc"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2024041609001064c32e630fff9289d5
        for <xenomai@lists.linux.dev>;
        Tue, 16 Apr 2024 11:00:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=pD4SJKtSO205QChBFRTIuwXTdTYEEgZiKk6F/gNv4jw=;
 b=ftQ/W4lcUc9VneJz4OQJokgYW6z2aqv/gMtXPzr36mCW3fu8niOYoRLk/spUOq9OLjNcGo
 heZQw7LUQYk6C/hbtQswhJVk/ZjPKRyNNz+116qsWiS+winQPxsnM5F/CoSRuqDUerq5F8g6
 xXN/1ynLJI57nMbcYYK7pEDev+NmE=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH 2/5] testsuite/gpiobench: Toggle output pin in react mode
Date: Tue, 16 Apr 2024 10:59:08 +0200
Message-Id: <20240416085911.62073-3-clara.kowalsky@siemens.com>
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
index 04c694639..707f35ae9 100644
--- a/testsuite/gpiobench/gpiobench.c
+++ b/testsuite/gpiobench/gpiobench.c
@@ -424,7 +424,11 @@ static void *run_gpiobench_react(void *cookie)
 		 * latency box will measure the time elapsed
 		 * between the two events
 		 */
-		value = GPIO_HIGH;
+		if((i & 1) == 0)
+			value = GPIO_HIGH;
+		else
+			value = GPIO_LOW;
+
 		ret = write(ti.fd_dev_out, &value, sizeof(value));
 		if (ret < 0) {
 			printf("RW GPIO write, failed\n");
-- 
2.39.2

