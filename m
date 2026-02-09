Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9303324B3C
	for <xenomai@lists.linux.dev>; Mon,  9 Feb 2026 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629636; cv=none; b=VjRFXhb39Yg5SwluKthSrUH1HGYc40rY7ncIZlojK4qoHGbOKbW6moA3kc+EwIuSHoGxxrRFJL4ZnS2TUbrrHbm0T2DnL9gvdRmA4Kyi1pg7Nhw98Zt1RUx4ig76kw5D99/oevMQpLvlrkxFhc0JmACejDTZoy3xNnQAP1TYdc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629636; c=relaxed/simple;
	bh=WgszFE8i6LECCt/SvSf/Lmz2YCVIY3PQ1iOKjOz3o2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ssvDsZrQcS6QHqHcX1OtE4Bs5BmBXWSrYPjLtVc+84aAEJL1/HPcZ7+N8AVe974AzMjyOXBMzvoaHeXmiZ+XzRFAhuVeLHUMT/4KqQ37NegrIZ5DtqaA/uFIwBaB+UalrkjM8ekSZ2tjskziDEJAz5Dx5+CD5jPUOO1juNvBVEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=F7xxfUkb; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="F7xxfUkb"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202602090933477f1b72124e00020739
        for <xenomai@lists.linux.dev>;
        Mon, 09 Feb 2026 10:33:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=dew3bt76ZFIvnitYr5ROdw28w8/IZX3qJbTb51zWkpY=;
 b=F7xxfUkbu6Idy48jVRkM3XBbuvoCaaTkNgei71Jjd7CArhYFZ+LZ2dLwmoC1FKxxjhLKYk
 M8mPEeCVk2GSACa46ZKU2EVMBEx3huIdBIU6OdcLBgmOb89T0BKlmr5/HVPgK9+vbNKwNdx7
 LBNJRoSwRdz7nZ9eztZoue6tliz0w4fMfocj5qa0oMhWmGadCsmJX1sd2ZYJFY2t9XvCi6Vi
 jdN/JV7QqatsTB31IL84nzeiuo5b8L39xRBJEX9fASSJ8jMQoBbFFL7QIjqbY7tUCfmPqGUO
 5qmXUTYfJt24AwMhWu8V4oeuDuk7hNMGCJB3R17b0PSGHbK62EzGFa7g==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 09 Feb 2026 10:33:36 +0100
Subject: [PATCH Dovetail 6.18 v3 2/3] arm64: irq_pipeline: Fix size of IPI
 statistics array
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-wip-flo-fixes-for-6-18-v3-2-4f980378bbde@siemens.com>
References: <20260209-wip-flo-fixes-for-6-18-v3-0-4f980378bbde@siemens.com>
In-Reply-To: <20260209-wip-flo-fixes-for-6-18-v3-0-4f980378bbde@siemens.com>
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
index 52e9d29083fc1d9c2828b3262e5c5db4d2f854ba..8d3791ed39e6935a63ba351038e4b685e07c05d3 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -1054,7 +1054,7 @@ static void __smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 
 static DEFINE_PER_CPU(unsigned long, ipi_messages);
 
-static DEFINE_PER_CPU(unsigned int [NR_IPI], ipi_counts);
+static DEFINE_PER_CPU(unsigned int [MAX_IPI], ipi_counts);
 
 static irqreturn_t ipi_handler(int irq, void *data)
 {

-- 
2.53.0

