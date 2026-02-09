Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EDF3446BC
	for <xenomai@lists.linux.dev>; Mon,  9 Feb 2026 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629637; cv=none; b=cH4IF/XhSUrVTje2IvXgBGdwhZt9adajJ/HV08XtUutZh3KfvEw+yE+YiFqcXdH69N1mUVBXRiZaPVDM1j8+afF5vy0iBWetFM5m9SzuCG6/ymNdr1oO7Gw8hxk37j2I9zbJnjsb114vB04GBWIdcpcgl4n0bgyRKwBxqJe0Crg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629637; c=relaxed/simple;
	bh=Fx/6wuy+VdeIaI7p27mEljXPi+sRJ3Pm0NUuzA0saxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DVZFcD4FgG47tAcc15x6WuZztHHpN1kdtI9AowNHGMjEBcVJhCJXK9e8/mDj90vCo2MjptdvLXR9em3dDNzOGBcKLh+dtTJHOcdUrM0OjLgaziiPb/yd4r4uQJlWkRWmLbeVN05Be+q1XNUmIGsdcSZZuR4sEjYWjlebAXRoJ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=XwsP64YM; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="XwsP64YM"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202602090933476702e52f1000020700
        for <xenomai@lists.linux.dev>;
        Mon, 09 Feb 2026 10:33:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=5N8ozPR8EfOZiqcl2DcUsY+qC9Gt1FdurKh3hXBAmO0=;
 b=XwsP64YMBzfWK60oipa4ZC3D3G+ClO9xo3ekSyjsZP7VtTt4Etbn1FsJKA5okQwUDR3tvM
 k9/9KvOEY+UnNQ+YLYyvcyI/86vK/YLMplIWoRWjFCtoMgAoHrxXL3IyKUfSLNuXUHXJzyy0
 jA9DiXcCGVKfdZfD6hq2ivnli8FCDk7wbi++H9N76DdxrTVwdw5yhGcutn372GOVZL6xGWuW
 zuKMrnD6ZHk+U9wmCgFGYXbQKkgRs3hcohjxxa6apAIWMXxFJVCpbwTnvXpSEu7xaQIOCVoA
 adDnHQAaLcpu/zkw/xnla0pDcSYdnbitdIde/Enj0aZn+SZtf0IjXcbw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 09 Feb 2026 10:33:35 +0100
Subject: [PATCH Dovetail 6.18 v3 1/3] arm64: irq_pipeline: Fix mapping of
 IPIs in LPI mode
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-wip-flo-fixes-for-6-18-v3-1-4f980378bbde@siemens.com>
References: <20260209-wip-flo-fixes-for-6-18-v3-0-4f980378bbde@siemens.com>
In-Reply-To: <20260209-wip-flo-fixes-for-6-18-v3-0-4f980378bbde@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

In LPI mode everything was mapped to the IRQ descriptor of CPU 0,
which is wrong. Each CPU has its own IRQ/LPI used for multiplexing
inband IPIs.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm64/kernel/smp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 3a12956580a35b9e31f34c34a3200ad907078df0..52e9d29083fc1d9c2828b3262e5c5db4d2f854ba 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -1020,12 +1020,14 @@ static void do_handle_IPI(int ipinr)
 
 #ifdef CONFIG_IRQ_PIPELINE
 
-static inline void map_oob_ipis(int cpu)
+static inline void map_oob_ipis(int cpu, int ipi_offset)
 {
 	int ipi;
 
+	ipi_offset = ipi_irq_base + (cpu * ipi_offset);
+
 	for (ipi = OOB_IPI_OFFSET; ipi < OOB_NR_IPI + OOB_IPI_OFFSET; ipi++)
-		get_ipi_desc(cpu, ipi) = irq_to_desc(ipi_irq_base + ipi);
+		get_ipi_desc(cpu, ipi) = irq_to_desc(ipi_offset + ipi);
 }
 
 static void ipi_setup_oob_sgi(void)
@@ -1033,7 +1035,7 @@ static void ipi_setup_oob_sgi(void)
 	int cpu;
 
 	for_each_possible_cpu(cpu)
-		map_oob_ipis(cpu);
+		map_oob_ipis(cpu, 0);
 }
 
 static void ipi_setup_oob_lpi(int ncpus)
@@ -1041,7 +1043,7 @@ static void ipi_setup_oob_lpi(int ncpus)
 	int cpu;
 
 	for (cpu = 0; cpu < ncpus; cpu++)
-		map_oob_ipis(cpu);
+		map_oob_ipis(cpu, nr_ipi);
 }
 
 static void __smp_cross_call(const struct cpumask *target, unsigned int ipinr)

-- 
2.53.0

