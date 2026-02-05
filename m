Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B733EF0AA
	for <xenomai@lists.linux.dev>; Thu,  5 Feb 2026 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770300019; cv=none; b=fDg2vqsl2KVZCA9i3I1GgV42BjMk326BBTOq5aMaTX13A+BzH6TpTcBCo5Q9GK3EeGSAJ7jZtK3U6wVpjMbOYUGBSoq+jdcLs5EvwyglwJYCW6Twk8/Lg0i2zNeBmiEO+91elHkgLXAh8RIqmPOmTxsCPABgZXmiaMLkuCKughs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770300019; c=relaxed/simple;
	bh=tIkjQzYELCy8Zm+8N7Ms76p7pb5IwPK2khStLneDyMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XG9feNcOb+jI89CUdVy5n6/tLohQbNQuYByu4anKXPh6rfp9i1vP4YAeGJ0QdSUKkTMsc5ehISeP/gEMWzSf8LfXTc3e2ufL4yZ03gJgxyzFFSmfQEf3U0RqGOT7aFDz1gv3F6dldCZLZDrFYrZJNd9dakUuC5GJClRelghPKO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=OL2XuPCA; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="OL2XuPCA"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2026020514001483f217c34600020733
        for <xenomai@lists.linux.dev>;
        Thu, 05 Feb 2026 15:00:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=mv6K80q996iheLg/ezUe+M8UTf365keZjB27Cv1+d2M=;
 b=OL2XuPCAC4QeUYi25IVMX1jSM+T88Mmr5XHRIi35FD6otTApPQMhBDMf8IMvzeE/rfzK71
 s9cuzOxiAk1GAikGdZSWIRcCjzbPEfHcvZ63XR6KO8RnLzTFcO2kscyDPRgfbQC46uYIB8Ic
 pq/Xq8x3qeBTye/2u/HH3IcMprODfp6oGW2QbjrF4oURsou8JG1lg7cxajiMgmcSq31s3bNW
 bqQiu9/5FxNd9tJ0qkFZatu5maSqr8DvQnIY0eE8jON0xYsj9voNV8buPi0G/3Mk7DQTV6LF
 6yc5qpEmU/r9IIkt8dQwCBsX5Ng9iKH2REM5UJd7Nufsc2igzgXB9Ytg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 05 Feb 2026 15:00:12 +0100
Subject: [PATCH Dovetail 6.18 v2 1/4] arm64: irq_pipeline: Fix mapping of
 IPIs in LPI mode
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260201-wip-flo-fixes-for-6-18-v2-1-28b30dbcfdf8@siemens.com>
References: <20260201-wip-flo-fixes-for-6-18-v2-0-28b30dbcfdf8@siemens.com>
In-Reply-To: <20260201-wip-flo-fixes-for-6-18-v2-0-28b30dbcfdf8@siemens.com>
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
index 3a12956580a35..52e9d29083fc1 100644
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
2.39.5

