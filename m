Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EAF3168EE
	for <xenomai@lists.linux.dev>; Fri, 17 Jul 2026 07:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784274322; cv=none; b=sVKfjMeLMZ7dqFGFrS3qvha5ZUO25DopVflNLogtHMs79fHx62ARq+Pt/SbXCiYMsRC01Es/dQ1x7xAGJUL8HYZx18X9/FGICehZv6GzAYgdu3EeqI9iJZ6HBE1JbABehZ0l4xxRbjuOkF1rl21DhYpLLb5gBPchhg8zWlOOeC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784274322; c=relaxed/simple;
	bh=Hn7kXSvpSkatlWBm79hreGw3qPaf52fZg5j586sXn5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hVpLiD6QPFJJCzemaqCCW6ljFRTgEVPiKKyZT9ICOLAE4HmreQMWo97sPxxEoSgUmyzbTQ7A1VOXgTzbmsAIS0iW7DoGJYMOUIjgKRwNXmcUeJI5O/WaV7Jm2dg4HJeFIy95S8bHAGRtwULVnDHs1SuQGsP6FWixGGC5mbaJ0J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=UbuVvEfm; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="UbuVvEfm"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2026071707451458023e45910002078c
        for <xenomai@lists.linux.dev>;
        Fri, 17 Jul 2026 09:45:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=qvpkcjOLvj1VZ67ynt72UG98FQ9T6S6kUueVhTuTMr0=;
 b=UbuVvEfmQc3S08CoTnf5RQLkIIqJUKjjGcwkNwi3hqaJk+zmKUDgPl1EC7x4nSyBUcytp2
 OJR7badmH6EUDBllh2GjnuZ+YYGOBd2WyPrQX8U1S+Fp9EtboJAkk+cWXyK9Yvxs5G78l/UB
 vmC7CyrUBr8KUwkSv85HsDdUEVbYR3buL24h7uK0/OC8/MFhChQcIdzd8VmunWd3PMO6KFkF
 FR587mJ/jxFrC5c2KEj5DioGofoqS1BArE/IutHgSyXqkzxogNE0aJNospVc4azo4R/mAx9t
 +LP6rZSBYDkxXHDqBItVGl2oQqYF5GBXYC+4jZrrNSIcxLrH6LyTLMOA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 17 Jul 2026 09:45:05 +0200
Subject: [PATCH v3 2/4] testsuite/smokey/sched-tp: Fix compile error seen
 with gcc 16
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-wip-flo-gcc-16-v3-2-5429c866bcca@siemens.com>
References: <20260717-wip-flo-gcc-16-v3-0-5429c866bcca@siemens.com>
In-Reply-To: <20260717-wip-flo-gcc-16-v3-0-5429c866bcca@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Fixes the following compile error:

sched-tp.c: In function ‘run_sched_tp’:
sched-tp.c:233:11: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
  233 |         s = strstr(ref_schedule, schedule);
      |           ^
cc1: all warnings being treated as errors

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/sched-tp/sched-tp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/smokey/sched-tp/sched-tp.c b/testsuite/smokey/sched-tp/sched-tp.c
index c2c3e41edff266ff9aec9a09f884ffaf3e2a9308..dc30e75a8764d61af018a9ba66648c55fe1570ba 100644
--- a/testsuite/smokey/sched-tp/sched-tp.c
+++ b/testsuite/smokey/sched-tp/sched-tp.c
@@ -122,8 +122,8 @@ static int run_sched_tp(struct smokey_test *t, int argc, char *const argv[])
 {
 	union sched_config *p;
 	int ret, n, policies;
+	const char *s;
 	size_t len;
-	char *s;
 
 	ret = cobalt_corectl(_CC_COBALT_GET_POLICIES, &policies, sizeof(policies));
 	if (ret || (policies & _CC_COBALT_SCHED_TP) == 0)

-- 
2.55.0

