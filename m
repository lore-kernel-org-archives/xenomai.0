Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAAC20E6E1
	for <xenomai@lists.linux.dev>; Thu, 25 Sep 2025 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805561; cv=none; b=IKgReOn5/ROxSnC7uJ9QGu+Qe6xnTdVRzdhnTT7hyI00KStlBLjLIlUvMdcjlgMp5aX44q8qtUDP9gJI3J2yUHPiQI9k/XfxI54mnCD+3W4t9DE8WSOJ4udLjmUdyyes3SncHpBSxCdksHL+CgvbhwslawswmRxqFO+Q9pwtD6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805561; c=relaxed/simple;
	bh=Hvpqa7xPuEsM/Mczxvjc6whi6z1ZX7dFKELiPGapUf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bj0haq/GYjh5Ua6teXyhY20xIuUjCLFzG2P9DYlEH8lbmjgM8JVQle9cWR+vOB+dHFfW5W90xVUqtiwRAqvS7MvNfsZie/4FATg6hK7JHNwd7YoMwTNguFgh2UrZIcwzI5iB8WINa2IcXhTQfuhUFEfylxc1j1ttjFbuNoX7fhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=tjX9GIfu; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="tjX9GIfu"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250925130550ec0d6a87740002071b
        for <xenomai@lists.linux.dev>;
        Thu, 25 Sep 2025 15:05:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=KE+LNE+pheAHicfUQOBvqRlp+XSV+9DtCcGdRNPF4Io=;
 b=tjX9GIfuz1RyYMfRH8H0j5zl6guF/TaTbuInLiGsl8JEEAA+e++dSusCoJw8t+bEwHYEOv
 IMM88xYM6I117r4HexBbkmxZn98g1dHwKvQWwNMCnpbh/FNa9z0wFqW4PktZEGCxi5B07MH+
 N/6tyQ1hxFFq61x0JCawmV2khHH/9XVuSR0f1902NbpOiJzSpLdkZ/MkSBPCGhFp/bWptQ66
 V1pOFfKm2tNTc5+MnQ7x34RNvfubBO8NUfu5IAZotJ3jT2VNbA0jONaZddn1ydFwa6o2EZY8
 CP/daHfrINoUTC7BesaqbSx0tK5v82UaEZYuk1x22VMG87ygntDzJWSA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 25 Sep 2025 15:05:50 +0200
Subject: [PATCH RFC Dovetail 6.16 4/5] kernel/irq/chip: Simplify
 should_feed_pipeline()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-wip-flo-cleanups-based-on-6-16-v1-4-8c4ac7b52cd8@siemens.com>
References: <20250925-wip-flo-cleanups-based-on-6-16-v1-0-8c4ac7b52cd8@siemens.com>
In-Reply-To: <20250925-wip-flo-cleanups-based-on-6-16-v1-0-8c4ac7b52cd8@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

No functional change.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/irq/chip.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 8593cdfb6e2ca..f18f513e20c7d 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -628,15 +628,13 @@ static inline bool should_feed_pipeline(struct irq_desc *desc, int state)
 	switch (state) {
 	case IRQ_FLOW_REPLAY:	/* Deferred to in-band. */
 		irq_clear_deferral(desc);
-		break;
+		return false;
 	case IRQ_FLOW_FORWARD:	/* Handled oob, forwarded in-band. */
 		irq_clear_forward(desc);
-		break;
+		return false;
 	default:
 		return true;
 	}
-
-	return false;
 }
 
 #ifdef CONFIG_IRQ_PIPELINE

-- 
2.39.5

