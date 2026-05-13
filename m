Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13A239EF0F
	for <xenomai@lists.linux.dev>; Wed, 13 May 2026 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676620; cv=none; b=X7UIxMQSZ8Sm05nmZtpwbHSaa5oICWcn+fLeNjyfMzIMmD2zH3rz8XeQjQkmdoJhJzjcY+1/2xZgTw5cygysoyYA+3HA5rYrqz1ThIT2uNZYCZ2q4/H1Eze46PFMID1Rh8SZmd0+b3GnQ/Y9BNK/5r2Juv+p/RhuI5p3cbCVcyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676620; c=relaxed/simple;
	bh=lGBIDf9l8fm2aP5Df8Nek1fFSD2KPAPUEl+V0funnJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lyLeN0D0Ro9IEg16VfWPE1zhtXqmM+VaABVcC+DjHbqqX8ThcS5Gazeyw9/xc2N9fy11qzQwm6arvYW8yW2+6RvnnzAToZNbOb/Hgv0/1S3JmDjMojnZ68TtN/GbevBpfiY06D9tLVQHXqRn5pAuUO/O/Iqx8JHrpKeeVZcQ1nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=EsaaRj7G; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="EsaaRj7G"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260513125013b373843dca000207d7
        for <xenomai@lists.linux.dev>;
        Wed, 13 May 2026 14:50:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ha08xYRShFgU6hzg0xpgkeafG2rIoH6AD5zwgTub8J0=;
 b=EsaaRj7Gh3otE50SjHW0K0aZ79NPQrGWTrcdrjsY+G1dd0qjQz1cjdVuC/Xmc0kdyucv/c
 0xrmgewnupiwhF3/5/A3QjPHZQhz5g4MTAefIQXSCNxyyVquv+oFNYiTnx8gdFNqdvUY8ZC+
 bp+ffdpIsckmhqSaDvUXKKmZMxnfL02T0wlVT3gCKY6IRfUhLv9cYCX2DgItha1NZvXGYT3m
 +BFmj+2+sPyHxgys+0kiH65Q4NO7tkAtwD2j+qEIJ7GOw/P3mlu+8ki2z23QeHXMuMa6Bn3a
 kqhyAv9YDxvCRFGwYYP9iNq/uybepJ6Q/Y4n/CMPYvmTO1BADnjPxb1g==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 13 May 2026 14:50:09 +0200
Subject: [PATCH 2/5] testsuite/smokey/sched-tp: Fix compile error seen with
 gcc 16
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260513-wip-flo-gcc-16-v1-2-120ae1287401@siemens.com>
References: <20260513-wip-flo-gcc-16-v1-0-120ae1287401@siemens.com>
In-Reply-To: <20260513-wip-flo-gcc-16-v1-0-120ae1287401@siemens.com>
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
2.54.0

