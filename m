Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBEE253958
	for <xenomai@lists.linux.dev>; Fri, 19 Sep 2025 06:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264923; cv=none; b=YLxK7Dgxfhc2CG6MhCsLHt54yoSY6p5qiVA6CfnYfb0qSoZX+KZXkFD6Sn/gq00h4z4W73fD4byAK7FpJxmmrVaHVae6FuGPI1iGAwZgiqFbVy52xUONVguno3jBoaH/OFrzTg0hdy5BI0dcAHij9CQ7NI2f7f+BNkZjoSwcg6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264923; c=relaxed/simple;
	bh=57ABjb2OY0ZP4mx6+tpgOSMrBt+aubwX5ZJR9jgKROQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ouh/ORtY/vt77/xVsql41VmFpEbnFBfn+vCVRQkXuV88bqVPfVW1q33Cvui2pknAqTrf6uwL0juraz3Q+kxQYSdhA1/XOByoRpVliHzRZ9h7h65KPIweXV/CbmHdVp+PCWjnSDhNJCDcp5hNkS4ZHn2AohZ9dccEESaCoElxl/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Mygah9ig; arc=none smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Mygah9ig"
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 645AB43BED
	for <xenomai@lists.linux.dev>; Fri, 19 Sep 2025 06:55:19 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 8A467AC0237
	for <xenomai@xenomai.org>; Fri, 19 Sep 2025 06:55:18 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202509190655121056e57c2e000207f9
        for <xenomai@xenomai.org>;
        Fri, 19 Sep 2025 08:55:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=v0eczpcL3OIN2hnmsW/zYNaWwgaqKtr32EXyYdzE9Rc=;
 b=Mygah9igu78s7YyVVQxJnQIeLNMS3oPMXcgdL8jXGes67SfmIB3wwVvBdHRK186XuJT2nu
 lnVdO2VhibJvukwdN/ibQnGQYSnUwH4MrLM792vhF8Zx7+tuFWhjcEExb+1PcxLOuP0vK3QC
 jC0QcGVJjf4FchJM99usW0jReP08wNvNvWIdYEcZcCDOCkK/rgJ2rash+3n6grSPykVzIn92
 Mg3P2DD8OW28dvF9PtAKUT/4LdHuyEU6U5sr6XUO/bXVdI8L2i6OCkpREXkthk+fYIL4gSyS
 lprSRhzyzFdql2j4bRd0+MPkM15rKT+ChVHQ0BBO+IL2s2MnkpTnNaFg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>,
	xenomai@xenomai.org
Subject: [dovetail 6.1.y-cip][PATCH 0/3] fpsimd fixes and cleanups
Date: Fri, 19 Sep 2025 08:55:01 +0200
Message-ID: <cover.1758264904.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=Mygah9ig;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-202509190655121056e57c2e000207f9-dqBrCc@rts-flowmailer.siemens.com designates 185.136.64.225 as permitted sender) smtp.mailfrom=fm-294854-202509190655121056e57c2e000207f9-dqBrCc@rts-flowmailer.siemens.com
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegkeehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkggfgsedtkeertddttddtnecuhfhrohhmpeflrghnucfmihhsiihkrgcuoehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomheqnecuggftrfgrthhtvghrnhepleffgeeltddugfefvdfhjefguefhgfehvdegjeetgeehvdekleeigfevgeefteehnecukfhppedvudejrdejtddrudejkedrvdduvddpudekhedrudefiedrieegrddvvdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvuddvpdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomhepfhhmqddvleegkeehgedqvddtvdehtdeludeltdeiheehuddvuddtheeivgehjegtvdgvtddttddvtdejfhelqdguqheurhevtgesrhhtshdqfhhlohifmhgrihhlvghrrdhsihgvmhgvnhhsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

See patches.

Jan

Jan Kiszka (3):
  arm64: fpsimd: dovetail: Hard-disable interrupts inside
    fpsimd_save_and_flush_cpu_state
  arm64: fpsimd: dovetail: drop redundant hard irqs disabling
  arm64: fpsimd: dovetail: Drop extra condition from WARN_ON

 arch/arm64/kernel/fpsimd.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

-- 
2.51.0

