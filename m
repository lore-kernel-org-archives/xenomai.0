Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529011;
	b=pIDZ/VRiwdDNnlXiSO9klyJec+AGK9fEihnhiwyJPhfgqdlggYzi9pLff/+iN28+FCUS
	 Y1Ier2AQGDG38f5UBeglnlPn2XFUZkdlK0K/ZU8tC80UqLt7JDd4eUd2SjTbsTw0tq2cS
	 JvA29eHzq1OhE3Q3qXnRXoCP/zusciCMmnZMpBR9RMHoORPWdjSqiPV+Xgz8OHkUd/lq1
	 tcx/fxEkC5JAkwbIu7yxJ+7k+pXfZJRw0HG/YeAf5UjPYPP3LNtKSBTM3vf1Q1QjIp+Cp
	 YzsrcUgJvvA/bzZKWKm07Vdq9uO2nxNPT177d9+iZS/aZqXVpTzw2yTq3KrbFlgOWKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529011;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oJz6UWpTg2/4oMzxjOLdO1zmhjWw6o515qJi3CEiH6E=;
	b=ARkSAvcG32sJx78esk1W/YLNVjmXXNSWiYOjOSsOVIn4X85G9s8j+O1GBTJTBMS25Jgk
	 bJwxK2eAW47Q/9H2wugtKUharJgFu4xEa8+U+lTmzXAXX/T8AK6hKz+QI95Ma6qwjV6gv
	 XLMr659ssySYyEiasbL1Hxk7pB1vtFrMFmPu8f3ABwqFOEP/L4QeyEjd8OEhPmX34V6za
	 fBu4Ll05nVI14Yl1TlgkfxlwP+k5Q+381PhOfns0bsv7tU4ywjrQMkki93tJlvEEy06zb
	 aKuYUHbCSUXeYr9aJeYLK26IdKPd8tyRsDuciK3FD1RYF2M2Ob16JCLg2XLgDl2Bsbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=kHUqF0+Q;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F031606A31E
	for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 14:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F031606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=kHUqF0+Q
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c5126505cb3so584147866b.0
        for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 06:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795529009; x=1796133809; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oJz6UWpTg2/4oMzxjOLdO1zmhjWw6o515qJi3CEiH6E=;
        b=kHUqF0+QQfNAyHCS/r2boCaKV+dhC6u42m7rg6lxLAZg1p7LPbLAWgM5PgD/EjFSl2
         Mlie6h663pMn7SkUhnnOrfF76C2g5gzAVbuMRFjJkZwjmvb6fzW3pquMvo/inQ/2uKa7
         8jhD9XnudTrF8ivTfFnkpSc8fHGrlLoNFe+S7ECCEHhspi+rSxsehPQKK21swbl6EmP1
         rVR01tcYZWhDyunn1mQn6sTmi3+NjWL9/BkB2v7MJDFmPAJQSQdGAeviZVudpYhwJqSb
         1LmSyOdp+2NZOsM5fgyX2OS7UA9sZnYafylprg9Fug6kie+5IBcuzetXa20eVuH0pqpE
         a2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795529009; x=1796133809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oJz6UWpTg2/4oMzxjOLdO1zmhjWw6o515qJi3CEiH6E=;
        b=bNpAHSwz7oLqkszVERln5oGoZ3mEv0gIJkYikpHPqjLwSb1JSIx5RatOTvkBHiEDrb
         IXi0/dlVihkeuCqmBqcGX+c/sQTCpYZV9szT34hJrbHWqOpU0JXs78mgamvtFRu3SjKC
         ZtrZknReCEkmam+3QQFBJumE+syyATUqqyRY5on+qsyWCz63FXlIu+CadpdwOn0O/AMs
         2VPODqpt6cQyfex452EzIUlt+HZ62mIOZ59coIo1CZEHrILB4v8nJ2/O/FTiMbAG49RN
         ympw4GPVOauF3os7O112knacsROxWPQMIpZIsl7NQYgSDgennlUQthg4RpMIw4W4bEwl
         BNsg==
X-Gm-Message-State: APuU4Z93D2szFTURpe3cYORvMopWV5Ci13b0RTocHtF4IJ9b0kIdF41P
	uKCcpZkhZMwToi64oVbgT1bzfGhMyvAdw2mXGvaXQG2p+DENq2SLBGAfJvhh6Q==
X-Gm-Gg: AZFdTZe39oloNEwTpS9DFM9xU7GiHCkyDjM93CbbJ7zPXTATjhEO+mK/tSGh5iAMk6c
	YWerMfjpxGrkEpMe0HvMMi7mneedr4ooqBtkJK2jJBWAdO/RJacy2rBYaBm9BTTgspdx8jy1w8K
	L7gqGswrfQXYhW5ofoUTf4kSKX3XkylGJ72Cd3/XllOPuDJ5bhzbw9HlktoUxVLe8XBjBTqouyQ
	D4VNIWl4y4zZ/SJuM6MVMTCcFKS5sYpTe+eWikeEbJd1Of8oiqWxpaAZbnHxlKI6ILggO36fePv
	PWd0+xLZkHrSxrAA9Jp6/5MN4/7dQr5ZFMAp4NA5J32UhwYqbpxXwsCboVZKsqIceAmVCEvwZDw
	Gp2hoHhoFzXm/2j0hvObjL8d0hXf3FVOQc+K4lcrBg3bOS/LlaUnDWTTcaWI5Egf0RTmD6MTBvt
	8kVry7uvojHpUQRlJzpambtnAlPrDAtmICqOHWTjthPVNl76wfNKB6Nn3bD3FiLhhFGaet7pl6R
	H/rUmPExVfu1pBO3qE0oy6y+mRb6mYPRU1M/2giaBrw8bSZgX+Tuj7sLFkY+mLGIKJR6i++EyHW
	jzINUaMY4+CbGe6olXAX4qeiasJ5xZQFD8FwEeO/hmEs5r5VSMOWnw+15wVCYFlV9uJAROT5phe
	cTNdZu6wS
X-Received: by 2002:a17:907:1b09:b0:c45:b99:f282 with SMTP id a640c23a62f3a-c513a4b0c5emr1183816866b.7.1795529007934;
        Tue, 24 Nov 2026 06:03:27 -0800 (PST)
Received: from development2.visionsystems.local (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513a8678cdsm510486566b.0.2026.11.24.06.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:03:24 -0800 (PST)
From: Yegor Yefremov <yegorslists@googlemail.com>
To: xenomai@lists.linux.dev
Cc: Yegor Yefremov <yegorslists@googlemail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 4/4] testsuite/smokey/y2038: Define ADJ_SETOFFSET if missing
Date: Tue, 24 Nov 2026 15:03:03 +0100
Message-Id: <20261124140303.3336015-5-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124140303.3336015-1-yegorslists@googlemail.com>
References: <20261124140303.3336015-1-yegorslists@googlemail.com>
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

uClibc-ng's <sys/timex.h> lacks ADJ_SETOFFSET, so the y2038 test fails
to build:

  syscall-tests.c:412:22: error: 'ADJ_SETOFFSET' undeclared (first use in this function)

Fall back to the value from the kernel UAPI, as the test already does
for the time64 data types.

Fixes: fa89ca44e33d ("y2038: testsuite/smokey/y2038: testcase for adjtime64")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 4318712cc..7c7035f15 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -17,6 +17,11 @@
 #include <sched.h>
 #include <rtdm/ipc.h>
 
+/* not provided by all C libraries, e.g. uClibc-ng */
+#ifndef ADJ_SETOFFSET
+#define ADJ_SETOFFSET 0x0100
+#endif
+
 smokey_test_plugin(y2038, SMOKEY_NOARGS, "Validate correct y2038 support");
 
 /*
-- 
2.34.1

