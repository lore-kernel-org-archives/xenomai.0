Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F17784A3E
	for <xenomai@lists.linux.dev>; Tue, 16 Apr 2024 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713258031; cv=none; b=jekISI/SIIekWJHBv89UIdSWGDy7+Qx82tYFSuwlQD3U2HYi38hP6YFJD5UN2SwgAjlzxA3nuvKyFDBciQa3DGgq6dv0sO0qyyN9VlQqCcPATmUDvMTXTy/x4LNuaMBK+ky2hNq4/g0q+asjafjUDrC3E/NDgDweAkTjJynxt2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713258031; c=relaxed/simple;
	bh=5iiq0jOolbjQW8XboZHdK95lZTDACED5N8PsoTQrwig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MVmhHTDIrqRIucYkb21gnlx/sK9NNssxi3kWcjVBOLceHSB6rVNlA6iW4BA3txJ84c85kFZDi2uTsOdTTd6PdK5qJMQNGOlrlOcqVMj7Avke7rHhk6xLnmgh0vH4wDijApBSYrZLB+brK5X9hKetjCAvLUa6a7lnBrtK6db6UUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=mxxKx7jD; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="mxxKx7jD"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2024041609002143e092853bda4f2be4
        for <xenomai@lists.linux.dev>;
        Tue, 16 Apr 2024 11:00:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=W35+mf9VCl+ySochzPPQ91R8frBtyYQt/g3ly8r7gDQ=;
 b=mxxKx7jDZMhTAyWY5N/S5IjUfKpJIiYTN/ihjc7qOVyv4S6c+LPoX5lUEcv5DLpCTPkhSO
 6QAOVNRz3npEAQDnXJRDy4Pp9WcBVrFzO5XnR2UHIWYYl1OcbhlBeGFNVZmHMbltuSq9QaMd
 dW4Bh7lwv2FrfV+uiXxO7VqgDUk8I=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH 4/5] testsuite/gpiobench: Fix calculation of maximum latency
Date: Tue, 16 Apr 2024 10:59:10 +0200
Message-Id: <20240416085911.62073-5-clara.kowalsky@siemens.com>
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

Fix typo: The maximum outer latency is calculated based on the
outer_diff.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 testsuite/gpiobench/gpiobench.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/gpiobench/gpiobench.c b/testsuite/gpiobench/gpiobench.c
index 1c525269e..3cc17eff8 100644
--- a/testsuite/gpiobench/gpiobench.c
+++ b/testsuite/gpiobench/gpiobench.c
@@ -334,7 +334,7 @@ static int rw_gpio(int value, int index)
 
 	if (outer_diff < ti.ts.outer_min)
 		ti.ts.outer_min = outer_diff;
-	if (inner_diff > ti.ts.outer_max)
+	if (outer_diff > ti.ts.outer_max)
 		ti.ts.outer_max = outer_diff;
 	ti.ts.outer_avg += (double) outer_diff;
 	if (outer_diff >= ti.max_histogram)
-- 
2.39.2

