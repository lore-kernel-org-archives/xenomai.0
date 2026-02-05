Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77663EDADF
	for <xenomai@lists.linux.dev>; Thu,  5 Feb 2026 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770300019; cv=none; b=OIR8FfEkZSeOBeXq/Ow5qOCdMZ0Ili8XE3XQAawsYSyiQq+z15N+4KxyKw2AAnJhb0TLfUpZlxXcQs51UDEFVPHbVkoFcaQem/EmkEU6SfVV8oDzymx5qX7uD6xfe94PVj2Kb+NNWrNSHCttvzIiUpcK8AD3ExRM68rXQMxlu+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770300019; c=relaxed/simple;
	bh=x0I4Ylcs4gqhhNyi9eomWapplAfNdsy/vpFRtkheSQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qc2ohmk9xYNFVER1vel/zTDK2uZfjJfnvXbRKoUFlQQLO+TfU9SsifKVgAaU/pnnz2Io1g7m9AGO5GMWf3nFEIguj4wVuPVY6tgOgv/BIT57T2aTyGdWxUqu/b3c8GEy/ru90ApjG7LSQk1+EqUQ6q3uwVYKxzQTnRoh+FtYAkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=AkwP3s3h; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="AkwP3s3h"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260205140015b4c1555bfd000207f2
        for <xenomai@lists.linux.dev>;
        Thu, 05 Feb 2026 15:00:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=S7mt6sCW680jbaG2Sh+Q29GQ4UTT2GX/G1OxhqCPNQE=;
 b=AkwP3s3hLQ6awVxHqF2dLf+0OCVj00PvkcJT6lroXpcOwM7ly1tlCGMEROo2BR7O+frXJv
 TMGQpmNs9ojtq4GDsddeN+q5xh2NUKXtmnGhUejJ7lPRW+Jprt7xbsFPGiEHKhHqt6dFdwxm
 5Vl0M5FH93w0aCh49WTILfJ0P3J/9EhYU6CuzepmNei73HUjtPfJvE4n+3Ks3R9dSSbcmcTw
 6fSh6HjWs12VOpe1WvO04mIRTgvGu+w+KBd08N0xK8yD7iTufrSqxA8US87Pw+LmXVOz+qVM
 5Zd1jVf6Sor1jCipTGEFv2lNGvLtpaARIDOtYW7+Bng9pWxPzM4ydp1g==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 05 Feb 2026 15:00:15 +0100
Subject: [PATCH Dovetail 6.18 v2 4/4] arm64: irq_pipeline: Fix tracepoint
 for multiplexed IPIs
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260201-wip-flo-fixes-for-6-18-v2-4-28b30dbcfdf8@siemens.com>
References: <20260201-wip-flo-fixes-for-6-18-v2-0-28b30dbcfdf8@siemens.com>
In-Reply-To: <20260201-wip-flo-fixes-for-6-18-v2-0-28b30dbcfdf8@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

When IRQ pipelining is enabled the reason for an IPI was always set
to IPI_RESCHEDULE as this is the IPI used for multiplexing all the
inband IPIs via a single SGI/LPI.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm64/kernel/smp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 53ec370235f93..39499b9797923 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -1069,9 +1069,10 @@ static void ipi_setup_oob_lpi(int ncpus)
 		map_oob_ipis(cpu, nr_ipi);
 }
 
-static void __smp_cross_call(const struct cpumask *target, unsigned int ipinr)
+static void __smp_cross_call(const struct cpumask *target, unsigned int ipinr,
+			     unsigned int msg)
 {
-	trace_ipi_raise(target, ipi_types[ipinr]);
+	trace_ipi_raise(target, ipi_types[msg]);
 	arm64_send_ipi(target, ipinr);
 }
 
@@ -1102,7 +1103,7 @@ static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 {
 	/* regular in-band IPI (multiplexed over SGI0). */
 	set_ipi_message(target, ipinr);
-	__smp_cross_call(target, 0);
+	__smp_cross_call(target, 0, ipinr);
 }
 
 static unsigned int get_ipi_count(int ipi, unsigned int cpu)
@@ -1120,7 +1121,7 @@ void irq_send_oob_ipi(unsigned int irq, const struct cpumask *cpumask)
 		return;
 
 	/* Out-of-band IPI (SGI1-3). */
-	__smp_cross_call(cpumask, sgi);
+	__smp_cross_call(cpumask, sgi, sgi);
 }
 EXPORT_SYMBOL_GPL(irq_send_oob_ipi);
 

-- 
2.39.5

