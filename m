Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62589274FEF
	for <xenomai@lists.linux.dev>; Fri, 19 Sep 2025 06:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264923; cv=none; b=hUV7dMbn0HPxDCSdMvcFx2+iKrbs0qZsmmdK++c+dFGN8KrGdoBIj9Y5sGTodS7dcYMb1mPxVrMypVlU4/J28mvNLpm8NhYtlrxi4SY+fuEkt3D1+V4v2H5Q1AIgz4/5517bb3gNBkC4zpEKfHuseTIaFYAStc9qxeRw1wn/zGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264923; c=relaxed/simple;
	bh=BRceDS2sw/qNXSaAQdeOcFYJDDlcriG6Qa3QYjPtlCM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QO7ZbPQXoJmBX2mHhUquVXScumClpfqCt7a8a/FPtxIgBL93Lm73kzsS4/gHeQMCm7a0o3nQgAFp6MiOn2SlZerQS8GjIUWmmPhxAH8sZbpwDIgnM555mpgsRYRHcyJbaRw8kNRMKj/bX1GeokNz5q8lp6fjJXMiFOhf9ePEYqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=VXoioi1Y; arc=none smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="VXoioi1Y"
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id AFD3443ABD
	for <xenomai@lists.linux.dev>; Fri, 19 Sep 2025 06:55:19 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 4688FAC09A6
	for <xenomai@xenomai.org>; Fri, 19 Sep 2025 06:55:19 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250919065513c6a30590c70002072d
        for <xenomai@xenomai.org>;
        Fri, 19 Sep 2025 08:55:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=VXWbbcRTsf155bmalB3luea9mgvMh3gSrHMB9iJNSkQ=;
 b=VXoioi1YcZLreRPy4mkjg90MevSF2ECHKc6bv2yJDAH2JUtFNzXXI45huY+w5RDtkLYp3U
 0G+f7ukTNTL/Kggyv8q+GOXI+QhTY47CkuVLk98loyuXS4DoS2FRvTBuqGNTqjgDvZE3GWJt
 EqjyPZgMY0DceJ2/AFM7+3bqyeoQGJiMoeZgCiNL6nVv7FLojO53yfnPkgJ40SKKes5Ur+qI
 F9h/e2XRA2KsznFkpX0KBF4lrLavPbldcp0A16OV6OcjVfBdzJiFzShk7ExWl6QHr+LtVvu2
 bgt5dTbHPFXXludb1jPPbIKhrLi98fzxR1W7RZ1P/OHqb4msfKJSZJGw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>,
	xenomai@xenomai.org
Subject: [dovetail 6.1.y-cip][PATCH 3/3] arm64: fpsimd: dovetail: Drop extra condition from WARN_ON
Date: Fri, 19 Sep 2025 08:55:04 +0200
Message-ID: <f53cbf9e9098b3c54a8986aab50c5325be5fda1a.1758264904.git.jan.kiszka@siemens.com>
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
	dkim=pass header.d=siemens.com header.s=fm1 header.b=VXoioi1Y;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-20250919065513c6a30590c70002072d-mKjOQq@rts-flowmailer.siemens.com designates 185.136.65.226 as permitted sender) smtp.mailfrom=fm-294854-20250919065513c6a30590c70002072d-mKjOQq@rts-flowmailer.siemens.com
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegkeehhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkjghfggfgsedtkeertddttddtnecuhfhrohhmpeflrghnucfmihhsiihkrgcuoehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomheqnecuggftrfgrthhtvghrnhepheegheduiefgtdfgtdfhkeelkedvvdejudduffdvgeffheelieelgfevkeehvdeunecukfhppedvudejrdejtddrudejkedrvdduvddpudekhedrudefiedrieehrddvvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvuddvpdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomhepfhhmqddvleegkeehgedqvddtvdehtdeludeltdeiheehudeftgeirgeftdehledttgejtddttddvtdejvdguqdhmmfhjqffsqhesrhhtshdqfhhlohifmhgrihhlvghrrdhsihgvmhgvnhhsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

From: Jan Kiszka <jan.kiszka@siemens.com>

There is no indication that this function is called over oob context as
well, and newer dovetail versions do not carry this extra condition
anymore.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/kernel/fpsimd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index f915706332191..ed269edea7907 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1950,7 +1950,7 @@ void fpsimd_save_and_flush_cpu_state(void)
 {
 	if (!system_supports_fpsimd())
 		return;
-	WARN_ON(!hard_irqs_disabled() && preemptible());
+	WARN_ON(preemptible());
 	get_cpu_fpsimd_context();
 	__fpsimd_save();
 	fpsimd_flush_cpu_state();
-- 
2.51.0

