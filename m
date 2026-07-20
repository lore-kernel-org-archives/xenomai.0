Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD58449B01
	for <xenomai@lists.linux.dev>; Mon, 20 Jul 2026 21:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784582918; cv=none; b=a//bXdFMic8+148Vrg1a4QH639HQYqsaGdFhDj74r4nqvNHMSsauQsVYoRXIT4UV3jLa3biKa2XEcsg/4EkBrsTl4pK/HjzNWPBCc9SAYVov4ehlmVH1Y/zene6cUbU05yp5ZjHCUEajCUcIU/tuJXqRdsgrK6BcmhL7waRYvyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784582918; c=relaxed/simple;
	bh=SHEeVXL+vo7YW9W+3VCAX7GpybJwD+ZLXxH5UTLK3jo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eGrlqq3bep5cUz+/5CbaKUkNGjsrS5nqYDNXdwOwFzIJepX/JvQqy4Emx483vxwDi7Nd16Y6yjqP8v2E2CCyuVkknmpgMbJV0ExxVCfhpl6Rb6a8z+cNTZ98Qz8WdI4dNywSCbm2pXRmdYJvq2xVnGIQnb/RLYjUAdu8DR2HKqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Fq56tGE3; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Fq56tGE3"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260720212826573371429e00020724
        for <xenomai@lists.linux.dev>;
        Mon, 20 Jul 2026 23:28:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=mZFRDrzs/bH1QvDC2HYPDVoI269JRXs9AGTSzSRBYcw=;
 b=Fq56tGE3s627ieo+0oGYORDxx6Mmj6kI2CDkmNo1RsJ67PE92B9KXTPe4kyt9II2GlRRtC
 8EYbnV8BkbLJyelaSFgfKBOtN7xTP3k1pnLBhhRgPNDO2WFIgd6/lzsO53wKBdLQVQfAvUZ3
 WFrlHjtAOQNOkHYa1zuo+sCnFm8cgnwrEZsv+UH1vjcutkgW4Hz1CnFx1tb7fkcc73iE7S2D
 sWBdrF08XChXE6jmZ2odKCrqenlHlLemglRxa+cqWcencDpEXlzaFRUY4eU8pH0PK4cBN5bw
 A0CK+HipP9Ft7OXFYF+S/vJ29MHFZe5yj8ZLkT57nZmWrHah5wLlzC6A==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v4 0/3] Add support for gcc 16
Date: Mon, 20 Jul 2026 23:28:24 +0200
Message-Id: <20260720-wip-flo-gcc-16-v4-0-f281a1f0cbd4@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPiSXmoC/2XM0QrCIBiG4VsZHveH/nNudtR9RAfTdBPaHBpWj
 N17bgQRO3w/+J6ZRBOcieRUzCSY5KLzYw5+KIju27Ez4G65CVIUtKINPN0E9u6h0xqYAIGSWSV
 rJVtG8mkKxrrXBl6uuXsXHz68Nz/hun4ptqMSAgUry0qgQG4VP0dnBjPGo/YDWbFU/oCa1Tugz
 EDFUepGCKV1+w8sy/IBvhUKrO8AAAA=
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

Changes in v4:
- Patch 1: Removed. Already applied
- Patch 2: Removed. Already applied 
- Patch 1: Previously Patch 3: taskDelay() -> threadobj_spin()
- Patch 2: Previously Patch 4: Update changelog, factor out test
           activation
- Patch 3: New. Test activation as separate patch
- Link to v3: https://lore.kernel.org/r/20260717-wip-flo-gcc-16-v3-0-5429c866bcca@siemens.com

Changes in v3:
- Rebased on current next
- Patch 4: Enable psos test at smokey level
- Patch 4: Increase busy waiting interval to 2ms
- Link to v2: https://lore.kernel.org/r/20260518-wip-flo-gcc-16-v2-0-f93562624fb4@siemens.com

Changes in v2:
  - Reworked patches 3 and 4, removed / migrated busy loops

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (3):
      testsuite/smokey/vxworktests: Fix compile error seen with gcc 16
      testsuite/smokey/psostests: Fix compile error seen with gcc 16
      testsuite/smokey/psostests: Enable psostests_task2 test

 testsuite/smokey/psostests/psostests.c | 4 +---
 testsuite/smokey/psostests/rn-1.c      | 7 +++----
 testsuite/smokey/psostests/task-2.c    | 5 ++---
 testsuite/smokey/vxworkstests/task-2.c | 5 ++---
 4 files changed, 8 insertions(+), 13 deletions(-)
---
base-commit: 8109051556b438cd4c280e75c2a45ae3b43d7f7e
change-id: 20260508-wip-flo-gcc-16-6291fb97b9a1

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

