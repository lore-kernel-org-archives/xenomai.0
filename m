Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A93388379
	for <xenomai@lists.linux.dev>; Mon, 18 May 2026 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094970; cv=none; b=mcgYqnzVhKaAeunSVKr+NtrQFmgxM8stVgD4HlH9Zv+MAVGBEg9JBN6QSDTdTOigeCcS1Gip0d99MOnVEBN3SuwNllz6GRhT9eUuRhAo/+1oG34Q1NW+v9gIHPZHH/rvCqippXW9M9v90z0FEJSC2tATrs1tZxPDCUPALmaqNSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094970; c=relaxed/simple;
	bh=wnUonAx9EJp9hb5gDHE6cXUrJZ0VeWG6fFLH9LOQz+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lRyTUByiBJMS0ldMxOXJZ453xpf/SU0+MdhXadvTel7zej7/ScK8+YGJAV3BRmXhjtfKRABx5Ld6NdvZzjs+DSa52xPMcjS17MgPiCIXfLJ5jJG8C+icCEfHfd+LP14CXXgqJG1XMVW5Bbe9ayKNy7/KXEXv30+yqvNEyKdk0DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=dd3vnVVI; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="dd3vnVVI"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260518090243a7a86eef50000207ec
        for <xenomai@lists.linux.dev>;
        Mon, 18 May 2026 11:02:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=R+w1iwfCT9uoYkhaZN+APg8ZJorzawA6Z8TPT9E2T3A=;
 b=dd3vnVVIbTGyjRlwoYysxziJ30LqHNAiRcJGX1iHCBheX/FCA3GrShaEb50msLzWB3BxSi
 vHVWooPGcRDylJFC710EAAjdE403gsKCEHzzt0XfY927gMvkSeEJ8Dy/r91XvXDX/GluMUFa
 Lqgv8q+Lq85RBYhMjsOj2fOW3ZHLuDISCcJh3iUkfh6YsoGu433Jmrep3rz61gyHdy9ImEjX
 ZhXhemNOm6OSiNamAIfWLob7dUcrmv+tGK9iEWSkUDkniDj2qKXG232ztfwgJg6HKG0eRdyz
 MOFVU+08UiCtnKAvxjI0LjIs5KttBC0WVn+xgw23f+lpuoedPRSIm0Nw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 18 May 2026 11:02:42 +0200
Subject: [PATCH v2 1/4] utils/autotune: Fix compile error seen with gcc 16
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260518-wip-flo-gcc-16-v2-1-f93562624fb4@siemens.com>
References: <20260518-wip-flo-gcc-16-v2-0-f93562624fb4@siemens.com>
In-Reply-To: <20260518-wip-flo-gcc-16-v2-0-f93562624fb4@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

This fixes the following compile errror seen when using gcc 16 as
compiler:

autotune.c: In function ‘sampler_thread’:
autotune.c:95:34: error: variable ‘n’ set but not used [-Werror=unused-but-set-variable=]
   95 |         int fd = (long)arg, ret, n = 0;
      |                                  ^
cc1: all warnings being treated as errors

The variable n was write-only. Removing the variable entirely as it
never contributed to the test.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 utils/autotune/autotune.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/utils/autotune/autotune.c b/utils/autotune/autotune.c
index f52733b7ae1d5a920fc7ad79c7288001dfeb8f21..2e25daef964beb96a8744e50f5ae9c62c04b64b2 100644
--- a/utils/autotune/autotune.c
+++ b/utils/autotune/autotune.c
@@ -92,7 +92,7 @@ static const struct option base_options[] = {
 
 static void *sampler_thread(void *arg)
 {
-	int fd = (long)arg, ret, n = 0;
+	int fd = (long)arg, ret;
 	__u64 timestamp = 0;
 	struct timespec now;
 
@@ -102,9 +102,7 @@ static void *sampler_thread(void *arg)
 			if (errno != EPIPE)
 				error(1, errno, "pulse failed");
 			timestamp = 0; /* Next tuning period. */
-			n = 0;
 		} else {
-			n++;
 			clock_gettime(CLOCK_MONOTONIC, &now);
 			timestamp = (__u64)now.tv_sec * 1000000000 + now.tv_nsec;
 		}

-- 
2.54.0

