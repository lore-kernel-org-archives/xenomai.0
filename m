Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F7E3E16BA
	for <xenomai@lists.linux.dev>; Mon, 18 May 2026 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094970; cv=none; b=J79a2g5RcdU4Y3Vgj0HIqho8ccaf4acJeGkfzat3+njH99rgRAoTifZu0UrIiu5D56tQm0/HN7xCvJyqRxuBawoJ82sCt3yc5NQapUuZRPgellxQQN6iKKRbRQNAK64OxIa6+FmilQeymJQIvbTOLmkz2KRzOfOO1ngdwPEZniA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094970; c=relaxed/simple;
	bh=lGBIDf9l8fm2aP5Df8Nek1fFSD2KPAPUEl+V0funnJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kDvUIbJ9ZGY/12cUk9Mv2N8NjDpYEyd6kkSy80ZhNgaldcTtvd1pmYKkbfLHd/XG2QiBOTu3lYy39k0Ci1FrY3+zjkEyimx27OjYoDyih60V9A10xtJC/ZTrOG9iiWXDnZvyIVsyW2h67ux8ZnJUg5tdDj9Onw9irDSF2moBziY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=B+Y4YFwd; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="B+Y4YFwd"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260518090243748957ee2b000207b5
        for <xenomai@lists.linux.dev>;
        Mon, 18 May 2026 11:02:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ha08xYRShFgU6hzg0xpgkeafG2rIoH6AD5zwgTub8J0=;
 b=B+Y4YFwdywmgMmUfEBUVUAxYrW83TPNVRw+Qi+I5lKq/DfVd94rSw9vWk+on6bgoo9WBOv
 jWAyXJpWGDeoDYOKMRG4TkJxeC9kCx89CP+zc1m/QlKsLugsD+SdDMJ/+GlH28JJv2avM6k7
 uVt/yC/pvrH0a9AkoTpB5sVouBkc5tcus4DHbIoO9zpMyRGpux4lP3T5Nu4qCXewZ+fn7kiS
 j1f3lvMQz8eDnMNJf212c6miA21nZCgNEV4XMpTjuwpQI+E5ZiQhMjoakSQaHhgL+VZ279aJ
 mwqqCp3dgnVyx2GJXVhVpKc9cMf18TM7lAl1AyofQw6uBmr8bIYNywpQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 18 May 2026 11:02:43 +0200
Subject: [PATCH v2 2/4] testsuite/smokey/sched-tp: Fix compile error seen
 with gcc 16
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260518-wip-flo-gcc-16-v2-2-f93562624fb4@siemens.com>
References: <20260518-wip-flo-gcc-16-v2-0-f93562624fb4@siemens.com>
In-Reply-To: <20260518-wip-flo-gcc-16-v2-0-f93562624fb4@siemens.com>
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

