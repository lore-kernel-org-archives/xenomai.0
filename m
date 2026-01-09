Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2965D33290B
	for <xenomai@lists.linux.dev>; Fri,  9 Jan 2026 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767958852; cv=none; b=GwloMWNzHlunbbsImuOT4KOaL5dNF7SiJ9rwFZlsqeIf8nWdUx5vVxOanzjX2VgoaOEsRQ0r1et8PBwb/OLpsCes06OtaMxjrtt1thReGE2L7XRFnoN54fqbUHrwc1BM8wegwIo7Cbt2Vjxvo98S+DgtnmSSting2OS5dnXnc+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767958852; c=relaxed/simple;
	bh=8aUPU8V4Ml+YCXSr/VkUk7kCBvF5rFulplhKKee83uE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b2nKq9xJw9/7th1GrKpVoStVh6zMACqAtSvXvUOVavNtLDN9TL0Xvl0XTUW0c+TB3HgoSNoCdzyXf6IzH9q3hJrtSUBRBb0HQPumDcw/dQipP9hsAAWdEogJm7VWlRlp8nvhE33o4S8ySHElWyVimB/3KwtLvDqmFxX4TDE/Yao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=YkJx28kM; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="YkJx28kM"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260109114039f9bfea71680002070b
        for <xenomai@lists.linux.dev>;
        Fri, 09 Jan 2026 12:40:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ZtXFdmWfYVeUapQEDjjJzIEcOZLEGCiyOEw9foXNJG0=;
 b=YkJx28kMvVGYxw2V5n8HxtJbUW9IWsJKmPiQvsyQuowdyFSSLEy2Vx/FTiKrJmvcM1qA0Q
 8uJqjyp62DEW6MTizOqvV7aokjj+op+QW9s2I8pVgp0o0JWf46Wo5nNYv9KEXQrODDJECjBE
 Ki/gsblRQ4rcGUavoZhNEs5lTYsA7yHrZrovfoEzEGbLMMlVsNytvqA5zRJhFmQBVDKnojqg
 EFBF/d2WGRgPTO7zghXRe1+hYcI8vUM+ogb2myLfF7sdzePBfY7epAA5eUNQDxEYTUw7XeyN
 Qwa+FBSgl1whoJfobkwHJOJ5Lt4/RLUjtkcLYEJLThXLAycS/eApIT4A==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH Dovetail 6.17] arm64: irq_pipeline: fix IPI mapping
Date: Fri,  9 Jan 2026 12:40:34 +0100
Message-Id: <20260109114034.1094081-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

While the commit mentioned below touched ipi_setup_sgi(), ipi_setup_lgi()
was forgotten.

Fixes: 7e7b969ce82f ("arm64: irq_pipeline: fix IPI mapping")

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm64/kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

With that one applied 6.17 seems to be in a stable state again.

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 8ceb41ff0253c..d89b659231614 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -1219,8 +1219,8 @@ static void ipi_setup_lpi(int ipi, int ncpus)
 		 * be mapped, so that arm64_send_ipi() can read any IPI desc.
 		 */
 		if (irqs_pipelined())
-			for (i = ipi + 1; i < nr_ipi; i++)
-				get_ipi_desc(cpu, i) = irq_to_desc(irq);
+			for (i = OOB_IPI_OFFSET; i < OOB_NR_IPI + OOB_IPI_OFFSET; i++)
+				get_ipi_desc(cpu, i) = irq_to_desc(irq + i);
 	}
 }
 
-- 
2.39.5

