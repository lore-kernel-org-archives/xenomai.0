Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A1C1BCA1E
	for <xenomai@lists.linux.dev>; Thu, 10 Oct 2024 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728599453; cv=none; b=PDtUnT6nsvxXrNN4fo82gj+DvZM7d5WuHkwpS1nji5BLKj8o+k1jqJZkAwo/x2ocmRbtXdLDckOO6NFOgFFzLo+Ru6+zz16S5403bOF86RO4sAukPS7DpHvu1FpvzFndRhcTtJqVuWLdGWEJWQuW7Ah65lkrLMpkFcvbwkveWcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728599453; c=relaxed/simple;
	bh=Cf3BTx0/HBgTm6P9K66BZA6Z+XoR2hQnQhZQGApkEjE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o9o3Q1My9Bk+VwV5tsI4kFmjiFonoyHq0370UNxfxhYIN/s1XZCCuuFOdWzIZjGI61ZFA2jaQevAAph1S1cbKmlNWouB9sVBZ2+LQA5oG2tyTFPqhJFymrxoVVp/sXfB3nwXkIdOmVxVe9VdtYTi4M9JbEXv0JkBTqcaT4yXQso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=fATvJJVo; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="fATvJJVo"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20241010223045006bfced7f90fd81c8
        for <xenomai@lists.linux.dev>;
        Fri, 11 Oct 2024 00:30:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=G3uojXQ0z3EKWJAfRIZ8HyQrDAY9lIfib4FhyYvgxrk=;
 b=fATvJJVoJXwfTz2dzpTeEzM9Jwl3+b9kb5kXWzUpaIkwWNBzNj0HoN1u5b7vVt5LasYLwq
 2LHiS9uhJT2XVOAdZwaI4V3YGxmCq8TdxrTTBsI9gmu5i9Q76knh1/Xwp8iMva5pyuqx9L/o
 QaYX81Y5Xn89vVRMdJR8GCyFotefR0PgVGch8u1Vkq+8az9dkwQ/zUUKslk9l/sEg6cdHxQC
 zt0w9isbqa98HA+EqBfTc5y7ZEJAZ8iRLzWD8MKSZ2Q4BnkQC5Ee040GS41iT3EmQxNhkF96
 ags9haViWl2hZlu6srpQt11Pjs7XYb1XvTaKlOBCzRNlWsylStEcU9nQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 0/4] Preparations for Debian 13 / Trixie
Date: Fri, 11 Oct 2024 00:30:44 +0200
Message-Id: <20241011-flo-cleanup-y2038-v2-0-0ef0d52cf9c1@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJRVCGcC/32NQQ6CMBAAv2J6ds22IBBP/sNwaOtWNiktaYVIC
 H+38gCPM8lkNpEpMWVxO20i0cKZYyigzidhBx1eBPwsLBSqWqKU4HwE60mHeYJVYdVBQ1XlWqs
 bbLQondGZwCQd7FDKMHtf5JTI8ecYPfrCA+d3TOvxXeTP/lssEhBqczWIbefK6Z6ZRgr5YuMo+
 n3fvz3wuaHJAAAA
To: xenomai@lists.linux.dev
Cc: Jan Kisza <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

as we are already in the preparation phase for a new release I took the
task to clarify that the upcoming release is in a good shape regarding
the upcoming Debian 13 next year.

As it turned out a couple of minor issues had to be addressed to make
the upcoming release ready for glibc and compilers shipped by Debian 13.

The y2038 implementation needs a couple of fixes due to changes made in
glibc. For some reason they decided to change __USE_TIME_BITS64 macro.
The commit that introduced the change is linked in the following
patches.

Testing on Debian 13 was done manually so far, Debian 12 was covered by
internal CI runs.

Best regards,
Florian

Cc: Jan Kisza <jan.kiszka@siemens.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Changes in v2:
- Seems it's too late for configuring b4 correctly... Lost one patch...
- Link to v1: https://lore.kernel.org/r/20241011-flo-cleanup-y2038-v1-0-4b5b0078fa60@siemens.com

---
Florian Bezdeka (4):
      y2038: lib/cobalt: select: Fix compile failure observed on Debian 13
      y2038: lib/cobalt: Fix link failure observed on Debian 13
      y2038: lib/cobalt: vdso: Fix runtime error detected on Debian 13
      y2038: testsuite/clocktest: Fix link compile error observed on Debian 13

 configure.ac                                   | 3 ++-
 include/cobalt/wrappers.h                      | 3 ++-
 lib/cobalt/arch/x86/include/asm/xenomai/time.h | 2 +-
 lib/cobalt/select.c                            | 7 ++++++-
 testsuite/clocktest/clocktest.c                | 2 +-
 5 files changed, 12 insertions(+), 5 deletions(-)
---
base-commit: 86c4592bee073d6bcd21b16dbd13b0d60af202dc
change-id: 20241011-flo-cleanup-y2038-6e33f7ca606a

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

