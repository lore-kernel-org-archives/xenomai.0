Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BB32F2E
	for <xenomai@lists.linux.dev>; Tue,  6 Dec 2022 11:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670325769; x=1701861769;
  h=from:to:subject:date:message-id;
  bh=HgiCfxn6VDQKDGgeORFCNL5gJeHoVARoL67h/gqlaqc=;
  b=hV9B8zNQ9w78bFmDJVUyNZLpqczrjp1JwmbmAypVHK+XALuclUJ4fOgX
   buRRf7inpmAvDf5gb/UPxlrevZ8lyZHtJZHN0/Mm1fqcKeTILdBk74qqH
   /LUmFvcyxMGILyYNueyR8ayC/00ADBCSG5yrxWNkK3W3hDtQSTMIeCVwy
   DZXk2eJx2PjMr9Ly5oXere5aHpvXVzZjRdxp4RJkXhlKkKvkQaDMBzoR6
   Q2cT7VOyf9AKSZ/49sVq68amcpkshJ92Nmpl4PyRGYeUku75Ep9GOoDDe
   4mCBtf85nvvfrl/buZ/TXcwxvYfXrVO3Zv7+kilsK4Qmzyw60I2RclaYZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="402875667"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="402875667"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 03:22:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="770694512"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="770694512"
Received: from india-build.ch.intel.com ([10.34.107.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 03:22:48 -0800
From: florent pirou <florent.pirou@intel.com>
To: xenomai@lists.linux.dev
Subject: [PATCH] clock : avoid panic on xnclock_set_wallclock() call during COBALT_STATE_WARMUP
Date: Tue,  6 Dec 2022 04:37:07 -0700
Message-Id: <20221206113707.31311-1-florent.pirou@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>

The nkvdso variable should not  be unconditionally referenced in
xnclock_set_wallclock().

Call-stack:
```
IRQ stage: Linux
RIP: 0010:xnclock_set_wallclock+0xba/0x1a0
Code: 7a 01 00 4c 8b 25 e6 39 35 01 e8 31 a2 f6 ff 48 c7 c7 60 3e 4c 82 48 29 c3
 48 8b 05 70 f9 9c 01 48 89 de 48 89 1d c6 39 35 01 <48> 89 58 40 4c 29 e6 e8 fa
  fb ff ff 48 c7 c1 10 cb 01 82 ba 29 01
  RSP: 0000:ffffffff82403e70 EFLAGS: 00010012
  RAX: 0000000000000000 RBX: 172c603286674a4f RCX: 0000000000000008
  RDX: 000000000f424000 RSI: 172c603286674a4f RDI: ffffffff824c3e60
  RBP: 0000000000000000 R08: 0000000000000123 R09: ffffffff8201cb10
  R10: 00000000fffff000 R11: 3fffffffffffffff R12: 0000000000000000
  R13: 0000000000000000 R14: 0000000000000200 R15: 000000002b4448a4
  FS:  0000000000000000(0000) GS:ffff888869000000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000040 CR3: 000000000840c001 CR4: 00000000000626b0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   do_settimeofday64+0x137/0x1c0
   rth_timer_init+0x60/0x7e
   x86_late_time_init+0x12/0x2f
   start_kernel+0x4d8/0x577
   secondary_startup_64_no_verify+0xb0/0xbb
```

Kernel panic happens when the clock is set using do_settimeofday64(),
implicitly calling xnclock_set_wallclock(), during the cobalt_runstate
COBALT_STATE_WARMUP state, while nkvdso is NULL.

Yuri Zaporozhets: Crash in xnclock_set_wallclock() if time/date is set early
https://lore.kernel.org/all/CAEkURaZO-2uDFwx3ZnS=229z5XZT27WbeFs3kS5Qdq7MMPAiKw@mail.gmail.com/T/

Signed-off-by: florent pirou <florent.pirou@intel.com>
---
 kernel/cobalt/clock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cobalt/clock.c b/kernel/cobalt/clock.c
index 2b9efad4e..b1b9a3b0e 100644
--- a/kernel/cobalt/clock.c
+++ b/kernel/cobalt/clock.c
@@ -282,6 +282,11 @@ void xnclock_set_wallclock(xnticks_t epoch_ns)
 	xnsticks_t old_offset_ns, offset_ns;
 	spl_t s;
 
+	/*
+	 * Check if time/date is set earlier than cobalt_init
+	 */
+	if (!nkvdso) return;
+
 	/*
 	 * The epoch of CLOCK_REALTIME just changed. Since timeouts
 	 * are expressed as monotonic ticks, we need to apply the
-- 
2.17.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 5 208 026.16 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

