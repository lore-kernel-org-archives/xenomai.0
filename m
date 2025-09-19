Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D8234BA52
	for <xenomai@lists.linux.dev>; Fri, 19 Sep 2025 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264922; cv=none; b=ivmtGobAx751EGqayVvd3Up8EuDWwqB0FDdaECp9lI+czBKwJ8z7y+LirQRNLFz7ndnngBmm0jGqoJn+hHNCdsyXcc98LeC/A5zhQ93hGXabqensRHZNoeQEsN2efFaizOkx9ZsMSvG+zaurTEYcJFHNamJzCvt5cFY5TX7ukpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264922; c=relaxed/simple;
	bh=ddU9RYX27qGBak+CDIOaKlCMquxW7ITWczgZ03b6Sj4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/p9v5tkDL767FLzpqt+6su85UR2kV6XEBcXQO429kHp6ghEb4wOMJk5ImRPyR7lkpQreOrkq0yT5k0Gs56EYeX/+fic5AbihHVio90chlsCdmj1qY9WW1yxtrNy+xtHtOHsfTsvvp05TmhhZZCHtA1rDgB82u5zJHl8fx5zOfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=iJ/GhZLQ; arc=none smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="iJ/GhZLQ"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 7705D43AC8
	for <xenomai@lists.linux.dev>; Fri, 19 Sep 2025 06:55:16 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 7CAB5941041
	for <xenomai@xenomai.org>; Fri, 19 Sep 2025 06:55:15 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202509190655124716427b8600020777
        for <xenomai@xenomai.org>;
        Fri, 19 Sep 2025 08:55:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=yOtYOK3ez0xCu5/IaNOHSJRU3X0ez0TXM4ODnwqjzB4=;
 b=iJ/GhZLQfem3cqBNCgH9FCkieknQEbkkO/3zn4mp9ME0WZkgwVGkIgz30mjkXGQTBEfSZe
 6P3Ampmeb1DlP5N0H6dHcQmml3KMBYSa/VLT1d3GXJ2PWmIDEPy1KDJrP+samWJweqbMjhaJ
 rWBCYrE3634rpCGBnPo2AjzL17eZAEDAu+7eedc8pPOMJLTTVz/zwX3jjV4o+M5r6nrxJCpr
 zpE8uGv2lG6DCFoGUxcmTLmLuwGDdoht3K/kU3bEixcKbjWnGYseMU+dSnR6XQ4MBRbmNXnO
 dvxEb2ZQvz7M0YUMjA9cCwelQHe5IAMKTJWhFuzw2QZ0zkVdBN9pcToQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>,
	xenomai@xenomai.org
Subject: [dovetail 6.1.y-cip][PATCH 1/3] arm64: fpsimd: dovetail: Hard-disable interrupts inside fpsimd_save_and_flush_cpu_state
Date: Fri, 19 Sep 2025 08:55:02 +0200
Message-ID: <b9ecf3458a5c8850edc16b46a8ef67152bd0d197.1758264904.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1758264904.git.jan.kiszka@siemens.com>
References: <cover.1758264904.git.jan.kiszka@siemens.com>
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
	dkim=pass header.d=siemens.com header.s=fm1 header.b="iJ/GhZLQ";
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-202509190655124716427b8600020777-2Itnsa@rts-flowmailer.siemens.com designates 185.136.64.228 as permitted sender) smtp.mailfrom=fm-294854-202509190655124716427b8600020777-2Itnsa@rts-flowmailer.siemens.com
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegkeehhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkjghfggfgsedtkeertddttddtnecuhfhrohhmpeflrghnucfmihhsiihkrgcuoehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomheqnecuggftrfgrthhtvghrnhepheegheduiefgtdfgtdfhkeelkedvvdejudduffdvgeffheelieelgfevkeehvdeunecukfhppedvudejrdejtddrudejkedrvddutddpudekhedrudefiedrieegrddvvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvuddtpdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomhepfhhmqddvleegkeehgedqvddtvdehtdeludeltdeiheehuddvgeejudeigedvjegskeeitddttddvtdejjeejqddvkfhtnhhsrgesrhhtshdqfhhlohifmhgrihhlvghrrdhsihgvmhgvnhhsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

From: Jan Kiszka <jan.kiszka@siemens.com>

Not all callers of this function do that themselves.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/kernel/fpsimd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 83b8492984982..ba804fcdfdb3f 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1951,10 +1951,10 @@ void fpsimd_save_and_flush_cpu_state(void)
 	if (!system_supports_fpsimd())
 		return;
 	WARN_ON(!hard_irqs_disabled() && preemptible());
-	__get_cpu_fpsimd_context();
+	get_cpu_fpsimd_context();
 	__fpsimd_save();
 	fpsimd_flush_cpu_state();
-	__put_cpu_fpsimd_context();
+	put_cpu_fpsimd_context();
 }
 
 #ifdef CONFIG_KERNEL_MODE_NEON
-- 
2.51.0

