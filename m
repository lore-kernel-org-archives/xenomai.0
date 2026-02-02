Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618812C11E1
	for <xenomai@lists.linux.dev>; Mon,  2 Feb 2026 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770018933; cv=none; b=ib0B7sTExDsAuNPD350mMXj/yrELypbkkRaYcEUbS90NKuyv63xksfxJXPfS1YCQCm93bXARVFjhDNIm/AU73zv+6/OSty0DyD/02lqpu5d4gXlkdJjACN2fpiwnfWj2AWkExYppFBFaywIpNfCRA9sYjdrkSszTLIbWRA2BXd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770018933; c=relaxed/simple;
	bh=Zi+XvICryy9RUgDrb5/V+OXV/OgqKjrenCtBCIGCLTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EY7wwtQ9P/Tz+zE1tewfKinkcu8PIpjC0dOu8v+6B9ckznb0eE7jaoT0c45fiTMVw/gMlpB5mDK3tcwt1YaDQsDY5yMkgGsBcT2VvysObsiCLuiZa6QcinbkHi0T8EB6TPv9O2kGN7uf67wQjU+uFsVZ7in5w/HbOhX1GrGBE3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=YKfGlURw; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="YKfGlURw"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260202075521fc05721bb4000207c3
        for <xenomai@lists.linux.dev>;
        Mon, 02 Feb 2026 08:55:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=EA9a7ULXQguzUn4MX0bS+vJcXmDKuAWUQtLjTh+24r4=;
 b=YKfGlURwCoe+Yuu/bsBP8OAIEedRgK+3y/J84j03KpbiGPWK6QVHiQqzsVJ4ZupdFKWyqI
 o/VVHy2DKiOacxpGl92gZFJfzOCc+sUtChcMq5ho210W8l8zO2NaZVcyuCQv2kdwzx8V6sS8
 SwB7WBFEVtWf7U0tRp5wo7W8EWYjVK1pAXEeW3qeyIV2jp6Jyg09/FnzrsYphzLqoSGs5NXd
 rD349rjV+S5CUZ6FanKwbKA/2ciU+hcbNBdnQuIvZjYMvPSzHk3qVrVGWBcAOfNYR41AgHNN
 9DFlm5xowRI6qUN41W9v4RrByxqOs7r+rwOB4DTJN4LNj5IGNWvovZqw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 02 Feb 2026 08:55:21 +0100
Subject: [PATCH Dovetail 6.18 2/3] arm64: irq_pipeline: Fix size of IPI
 statistics array
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260201-wip-flo-fixes-for-6-18-v1-2-91ea07c7eb7e@siemens.com>
References: <20260201-wip-flo-fixes-for-6-18-v1-0-91ea07c7eb7e@siemens.com>
In-Reply-To: <20260201-wip-flo-fixes-for-6-18-v1-0-91ea07c7eb7e@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

NR_IPI is not the last possible IPI, it's the last traceable IPI.
IPI_CPU_BACKTRACE and IPI_KGDB_ROUNDUP are located behind NR_IPI,
so access to those counters were out of bounds.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm64/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index e8cee27dc1132..716ba0b0c274b 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -1049,7 +1049,7 @@ static void __smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 
 static DEFINE_PER_CPU(unsigned long, ipi_messages);
 
-static DEFINE_PER_CPU(unsigned int [NR_IPI], ipi_counts);
+static DEFINE_PER_CPU(unsigned int [MAX_IPI], ipi_counts);
 
 static irqreturn_t ipi_handler(int irq, void *data)
 {

-- 
2.39.5

