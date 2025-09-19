Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A2A277C95
	for <xenomai@lists.linux.dev>; Fri, 19 Sep 2025 06:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264923; cv=none; b=s/vWBjL5s+jXEI3szHI6XwsYmrzUduso1nTPDUDoVc25Q3TG1ujUgPKhi7QN+/5fpoHqukdexRR+XXwQtwbWctcqIEK+Yupt4A+p3kxUMFp45yGwVJGIiZDNlJ1cWURZPM6rghpKIrtuPAr80AUnGGD7LIoRYN7QPV+qNxcn1uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264923; c=relaxed/simple;
	bh=ev8boYFBVUXihDzckZYeIx2W0HEb4vvNusQ6b9G++d8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUu7eaIzgEj6MBxn2F4K8+qHcgH0UjtQNQHXMI9LO2i29uNUA8ISGSEBHP1AXsC6xmulyf2JNnUdyoWhtjbuDEyqhmkyKERvyJ0c7VXr6tdPD5Qs2nHc2NltQ10HOyHYzrcPH3DaczOSPvwxEO+6xwrfOiMZwvgaNGK2gZcvElY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=EGEGyplg; arc=none smtp.client-ip=217.70.178.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="EGEGyplg"
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id B0B7D4373A
	for <xenomai@lists.linux.dev>; Fri, 19 Sep 2025 06:55:19 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	by spool.mail.gandi.net (Postfix) with ESMTPS id D60BF74003E
	for <xenomai@xenomai.org>; Fri, 19 Sep 2025 06:55:18 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20250919065512f20a7cc82b00020798
        for <xenomai@xenomai.org>;
        Fri, 19 Sep 2025 08:55:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=+M+YqWa/+tZMc9fow/Rkxc0RSNyH9h3kJlvYIcRxCZE=;
 b=EGEGyplg3Ew/67Hx6X67sTBCib/y3ut49VRnRkYgwBp2IcblLNdrh4db553xk+tOk3o9AE
 HmZ0VqzGrN2y+sbsth1/Nqymce/YHo6STTicp6+16tV8yvIbAvYIZuS50du3KKz6Af2nWxNH
 x4i8WVtywL52cY1ErraUQaWF7oMsOX3ZBEVHjaT00PQ/QDllJoTR7UiJpHIxWdMIED7S/AjW
 mfntt9iIxKtfYCue2gVvR4BNgWZK7ig+QVAqkyBEQg2HnyWRG8vcxn7Ev5ZWoL37poKj9YDo
 pKGrujloJvmhPgUTvGLO6AQlqiKOAlwqW4CtRwhft9MqcszQT1RhCGAQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>,
	xenomai@xenomai.org
Subject: [dovetail 6.1.y-cip][PATCH 2/3] arm64: fpsimd: dovetail: drop redundant hard irqs disabling
Date: Fri, 19 Sep 2025 08:55:03 +0200
Message-ID: <69e5ff8590d101d24ace2e6708196af7a2ead2f8.1758264904.git.jan.kiszka@siemens.com>
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
	dkim=pass header.d=siemens.com header.s=fm1 header.b=EGEGyplg;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-20250919065512f20a7cc82b00020798-y4fFhu@rts-flowmailer.siemens.com designates 185.136.64.227 as permitted sender) smtp.mailfrom=fm-294854-20250919065512f20a7cc82b00020798-y4fFhu@rts-flowmailer.siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegkeehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkjghfggfgsedtkeertddttddtnecuhfhrohhmpeflrghnucfmihhsiihkrgcuoehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomheqnecuggftrfgrthhtvghrnhepheegheduiefgtdfgtdfhkeelkedvvdejudduffdvgeffheelieelgfevkeehvdeunecukfhppedvudejrdejtddrudejkedrvdduuddpudekhedrudefiedrieegrddvvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvuddupdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomhepfhhmqddvleegkeehgedqvddtvdehtdeludeltdeiheehuddvfhdvtdgrjegttgekvdgstddttddvtdejleekqdihgehfhfhhuhesrhhtshdqfhhlohifmhgrihhlvghrrdhsihgvmhgvnhhsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

From: Jan Kiszka <jan.kiszka@siemens.com>

fpsimd_save_and_flush_cpu_state() itself does take care of this.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/kernel/fpsimd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index ba804fcdfdb3f..f915706332191 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -2148,13 +2148,9 @@ void __efi_fpsimd_end(void)
 static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
 				  unsigned long cmd, void *v)
 {
-	unsigned long flags;
-
 	switch (cmd) {
 	case CPU_PM_ENTER:
-		flags = hard_cond_local_irq_save();
 		fpsimd_save_and_flush_cpu_state();
-		hard_cond_local_irq_restore(flags);
 		break;
 	case CPU_PM_EXIT:
 		break;
-- 
2.51.0

