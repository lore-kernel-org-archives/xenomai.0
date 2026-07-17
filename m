Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5833AA4F1
	for <xenomai@lists.linux.dev>; Fri, 17 Jul 2026 07:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784274928; cv=none; b=Gqmj4wL0lrk01Uv6BCHqNE6Jjbm1KqypOiC1yj70vV2huRSaT/BYCA4L/5f48PzzYEk4/NfEH7KLHlbW8TByH0XIoFLM3F7bz/bqxRPci00jUE0+NhRJ6xXpXOcXepEJavb6lhr7z/UUhTISnYpA+ixAPRrFftD5vaco1Pfnh6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784274928; c=relaxed/simple;
	bh=FLeJfVFZnAOkk41dtIqpisgYRbsV4yi80MJQvYabRqE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gK6HhbwfqDtlqxly9T6fkIQeidW0CvByFPcnLzuITsml3hVkaHkGXVC7Gz4/nwwGkZdO3up0BFR0OUzRmKl3WCl8u4NCeV8fpLdzd5KmQ+zXAjZgeOMMmagzU0x2GIhXh1AAYuei0Q5qTa63Eqcn7cPvt4KOtgNm5Vzvfg5wwYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=TH8g5MQP; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="TH8g5MQP"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026071707451351b0f25b8200020728
        for <xenomai@lists.linux.dev>;
        Fri, 17 Jul 2026 09:45:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=xOAAU4RIrcJRx4MCmVKoJTOGO72md2E5ffl5bJWZxzk=;
 b=TH8g5MQPLlN0DzXQ8tBFukhzl8E30/8TgomQmv9gydUSYvD8d/Uyfd1y7+1rAUOKXGLwY7
 p7b9rvNyzQD8T4bihAQeGw1OTFD1xGlyg++O/PEi0EVeOv9+xtKt861tHXJe93/QpFsx3E3f
 56LXXJgIGjYtZKP+49+lX4nSZtObKmqaNe2hukVQG9y6oGmAUkUmSkYSFONIRNuKdBOBW2xc
 KUJYmC9y2OchQ32gG5Ivixuv2fa2ezv3kfBFTFeXfLiojCkCdMlJn1uk6PGJK8MrX+ZkVTwt
 oadeSkVFsVVWRT1tpijOhLLsd5yaBGEpr8lnq6OOe30nHkAXsn9fucGg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v3 0/4] Add support for gcc 16
Date: Fri, 17 Jul 2026 09:45:03 +0200
Message-Id: <20260717-wip-flo-gcc-16-v3-0-5429c866bcca@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH/dWWoC/2XMQQ6CMBCF4auQWTumHaBaV97DsJA6hUmEktagh
 nB3K3Hn8n/J+xZIHIUTnIoFIs+SJIw5yl0Brr+OHaPccgMpMqpWR3zKhP4esHMOtUFDVvvWHlp
 71ZBPU2Qvrw28NLl7SY8Q35s/03f9UfqPmgkVelvWhgxVvq3OSXjgMe1dGKBZ1/UDuxxrZa4AA
 AA=
X-Change-ID: 20260508-wip-flo-gcc-16-6291fb97b9a1
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

Trying to compile the codebase with gcc 16 revealed some minor issues /
compile failures. Fixing them up was quite easy, so here we go.

gcc 16 is the default compiler on Fefora 44 and available as package
for Debian 14 (forky).

Cc: Jan Kiszka <jan.kiszka@siemens.com>

Changes in v3:
- Rebased on current next
- Patch 4: Enable psos test at smokey level
- Patch 4: Increase busy waiting interval to 2ms
- Link to v2: https://lore.kernel.org/r/20260518-wip-flo-gcc-16-v2-0-f93562624fb4@siemens.com

Changes in v2:
  - Reworked patches 3 and 4, removed / migrated busy loops

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (4):
      utils/autotune: Fix compile error seen with gcc 16
      testsuite/smokey/sched-tp: Fix compile error seen with gcc 16
      testsuite/smokey/vxworktests: Fix compile error seen with gcc 16
      testsuite/smokey/psostests: Fix compile error seen with gcc 16

 testsuite/smokey/psostests/psostests.c | 4 +---
 testsuite/smokey/psostests/rn-1.c      | 7 +++----
 testsuite/smokey/psostests/task-2.c    | 5 ++---
 testsuite/smokey/sched-tp/sched-tp.c   | 2 +-
 testsuite/smokey/vxworkstests/task-2.c | 4 +---
 utils/autotune/autotune.c              | 4 +---
 6 files changed, 9 insertions(+), 17 deletions(-)
---
base-commit: 48934c3fed790f8603eaaf0d4fa1ce92d27552f4
change-id: 20260508-wip-flo-gcc-16-6291fb97b9a1

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

