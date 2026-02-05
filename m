Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811BF3EF0B1
	for <xenomai@lists.linux.dev>; Thu,  5 Feb 2026 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770300020; cv=none; b=Q1tdb/Ilpk3vrmtpj0LCh6Ph3giTPu7DgCJUhkr0H/N8pBAC6uIrAY5iXQ9ExzHHgDrBePp2kUAYoHx88f2zUQ3wi6hPdAVxqRL/KsHgbiBXJjF6vTwGxou53Kt19samkyZMofnPro0vqr0ONiYpirO1JXNZPu1pAfsSfnZkzM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770300020; c=relaxed/simple;
	bh=eKQo/TWu1uiDKqkSG9mjCoG4fD/1ZGhnkOAA7nHExkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rxw6MziJekzE0kUC4BRYgU9LUetTcM7KOs3b/5AJhnk2HoXb2yx3BqOn3BrHZpToxF/ZGwcxCUzDFRD7wUC20fJYiidZgWTchMqy7aXI7yx0YxOyarWVOqsxWmd9OqJTxXElgmZkzLlsaPZJGkd9QhAhfqz6BXflDIo34i+osmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=TrnAQn78; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="TrnAQn78"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026020514001453c406f5a5000207a2
        for <xenomai@lists.linux.dev>;
        Thu, 05 Feb 2026 15:00:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Fyo1uA75GuTDcBY42MnNMDGsIBav6MqAaRQPyvB/Ups=;
 b=TrnAQn78hRcxhOgTZqeMtzYQAl9lvxxE2V9u1+X6nKBIf+V6h8CvoS80tofcWzslSmeb5f
 BXvpacnB5aDdS9NSpLKXhRvmBz2cIqFWkgLAfaK4RjmiwM2zC5iIpYC02TLms6z0027Iq+5C
 Y77rl03DVHmpoObEK3EHkmORtwtPIIwsIwo7tl3/bb+xKUBGGk0lmfVEAZ7rV0EV3x7KiO85
 m/LdHYPA2a/EYv84oMOTnkQWry9ADMKe4SeA+VVj4+70WlqaqPKYtK2mY32g+PMj8oL5w8f/
 DRnmAVPs+JI8/L7Q48AardppOM/FQ4/DX7aIpIw8ETVaxipORZtyIUEg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 05 Feb 2026 15:00:13 +0100
Subject: [PATCH Dovetail 6.18 v2 2/4] arm64: irq_pipeline: Fix size of IPI
 statistics array
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260201-wip-flo-fixes-for-6-18-v2-2-28b30dbcfdf8@siemens.com>
References: <20260201-wip-flo-fixes-for-6-18-v2-0-28b30dbcfdf8@siemens.com>
In-Reply-To: <20260201-wip-flo-fixes-for-6-18-v2-0-28b30dbcfdf8@siemens.com>
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
index 52e9d29083fc1..8d3791ed39e69 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -1054,7 +1054,7 @@ static void __smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 
 static DEFINE_PER_CPU(unsigned long, ipi_messages);
 
-static DEFINE_PER_CPU(unsigned int [NR_IPI], ipi_counts);
+static DEFINE_PER_CPU(unsigned int [MAX_IPI], ipi_counts);
 
 static irqreturn_t ipi_handler(int irq, void *data)
 {

-- 
2.39.5

