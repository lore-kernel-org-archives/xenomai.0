Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053A62D9492
	for <xenomai@lists.linux.dev>; Mon, 19 Jan 2026 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768818857; cv=none; b=ijboxdY5vFfWgEu7gZBWS+SIxExwVLde9IBS+BfvwKD8xutxrOSOS/rRx+89IbXyDzwjmhRUmINjgL4ib18yEgfsWYZK31j80/Zl53m9tZCkrxZSxAIC99v6W2bISMTnRSrYHZjUpwv2YqcrYm9u1dDkAI92HQ5vVR7OzcO3gQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768818857; c=relaxed/simple;
	bh=dc87b6J/Qp2t0XRL9JUEwiMrbaMQIbvmGikYjWcHGKA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MbooNLQT+GxJlSGkp527pg/6ROXTIanHHigljwIxFAW7H9GikcIg3K7EqYgyroMjoHsde8xtSxZ9wsXt6KQNO8U4o6HIy67wUMVO/hOU6ck5jH6ssgUy1JPx5VpQJo1w4nLDLYCKSLCcXvvITDDo13X4DL/qMKpFIuubAcaEjrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ekB73Ict; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ekB73Ict"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2026011910340660d3204731000207b9
        for <xenomai@lists.linux.dev>;
        Mon, 19 Jan 2026 11:34:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=CPlLXVrLfXINp0U32qfik08Lgwc5I37ym68WYbYTgX4=;
 b=ekB73IctoLau4XoQmWGSZ4nfaZRL1Z/SOEIu1HEz1VVylN7vc9/6hWhJqR/89SDZmggm73
 yvTtqOiaUag90vmy2iZHdTjZyK2p0G+k6ckv4VicMxj05sPsef7iD5OX1Xz2J2TP4VMp0Iee
 0fhJ9ejyx+aSK3U1/Rodf68FxW6a8g8/W7ZhW71wIL09UT5A2313GjIoPcny6W/63vAPxe/a
 b0G3VwGSY0iI6uXr4ctBspZ9i97bnOLo1xnlJ++U4CU105E4Zy2faXVAvi2tf2KGHn0E5pfv
 Qohf5+JFQy2F8pl8BGzBebeOKrwiXuC5WgyCz/3MUgxPGBiniM+6xAiw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/3] Testing: Minor improvements to switchtest and smokey
 gdb test
Date: Mon, 19 Jan 2026 11:34:03 +0100
Message-Id: <20251006-wip-flo-test-improvements-v1-0-b70e8726ec0b@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJsIbmkC/x2N0QrCMBAEf6XcswdJxAr+iviQxq09SJOQi1Uo/
 XeDj7MwOzspqkDpNuxUsYlKTh3saaCw+PQCy7MzOeMu1piRP1J4jpkbtLGspeYNK1JTdmMwgDX
 Xs3fU/ckreKo+haU/pHeMfSwVs3z/wfvjOH4uyc6kgAAAAA==
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

These are some testing related patches that pilled up over the last
weeks/months. Mainly to increase test coverage (fpsimd on arm64) and
some minor improvements to the gdb tests.

Note: All affected kernel versions should have been updated, so that
Dovetail on arm64 is able to deal with in-kernel FPU preemption. The
necessary FPU context switching machinery has been backported to
Dovetail 6.1, lower releases have been skipped for now.

There remains one known Dovetail issue open: FPU preemption on PREEMPT_RT
inside softirqs. This corner case is not yet stressed by CI. Can't tell
yet which architectures are affected. At least arm64 is confirmed.

Cc: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (3):
      testsuite/smokey/gdb: Remove unused include
      testsuite/smokey/gdb: Improve error reporting from gdb
      cobalt/arm64: switchtest: Enable fpsimd testing

 .../cobalt/arch/arm64/include/asm/xenomai/fptest.h |  7 ++++--
 testsuite/smokey/gdb/gdb.c                         | 25 +++++++++++++++++-----
 2 files changed, 25 insertions(+), 7 deletions(-)
---
base-commit: 40b2479bcaddf767a779f72a3c707348204bea1c
change-id: 20251006-wip-flo-test-improvements-26c0ee1073a2

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

