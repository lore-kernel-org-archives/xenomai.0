Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E12A22332A
	for <xenomai@lists.linux.dev>; Wed, 26 Feb 2025 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579692; cv=none; b=noH2hdnklEJKInIObLYL64WjIr4YIuZMDcXam88j2ct5L19JCVIqZ/eQKTJcvvPlMu5WnWK56iXFHfULM/XgCV1xEmNSCWaWartkXejWyXWkh0oPZXMrMjqFbQ/dPcPDqUJvxZVFgwdpiDto92DGFQWPUqhPIPN+YX2ThtufwBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579692; c=relaxed/simple;
	bh=9vyogZxkf4x8buYUnVSSMo1H0SCzLFgZiQlSuRRDsMM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K1C/49k/J7uUzpkve3lAmq48AzykrJhzEsgMHv7Ad6DmTgmnBKdQpNFmpLSGLFCjcZdoqdEvtj30NchTZZZsYkibCyQnVT0KK3zkkkRfcN+SRp8BoUUhueD+4E0S1Cagbb/Ll7RnaCAaJTNR5MitIfwjlV6sxYSzNfOfLakUmZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=bCKk+fh+; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="bCKk+fh+"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202502261421199cefd6a6610899d5bf
        for <xenomai@lists.linux.dev>;
        Wed, 26 Feb 2025 15:21:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=/pY0NjBr0BIb4QrHVzrVQCh1IxvWL/glq8QXJfMh0rE=;
 b=bCKk+fh+tPUbq983asnbT41aBhlOmukcu7WHAhqJLB1BYXpOKoIicBWYwDvq2SxBtj1cL6
 jj5/p2awhd3Mt0DbBS1f3zfxTEx+YWBdTXleEqN4rvdBU+ERgzLtE1s++sPd+WbLpXySN8kB
 13Jq7G/Vzv50pDvgn9GVdRt5JVH3AR03jYe/Rvz7YgbH9YBYuAe3Pjgc3LOOQLapRSdTdnGA
 yVaj06mGdVxiAUno6qswpkR5yVsiYhb7Pbl3jiHouvvPQQkgOx8et/cVKoqqexwzegfCylvl
 iShKqB2mXpdzXybeD7H4TPxEe0P/m1AGLXpxQ4p3PeGKKCPveUGh8B1Q==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH] cobalt/tracing: Fix cobalt_tick_shot trace point
Date: Wed, 26 Feb 2025 15:21:17 +0100
Message-Id: <20250226142117.4057013-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

It's not allowed to call div_s64() from the TP_printk() part.
Fix the tracepoint by moving the call to the TP_fast_assign() section.

The trace buffer looked like that:
[UNABLE TO PARSE] secs=%d nsec=%d delta=%d

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/trace/cobalt-core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/trace/cobalt-core.h b/kernel/cobalt/trace/cobalt-core.h
index 22e4adda2..645d3e3ad 100644
--- a/kernel/cobalt/trace/cobalt-core.h
+++ b/kernel/cobalt/trace/cobalt-core.h
@@ -822,14 +822,14 @@ TRACE_EVENT(cobalt_tick_shot,
 	),
 
 	TP_fast_assign(
-		__entry->delta = delta;
+		__entry->delta = div_s64(delta, 1000);
 		__entry->secs = div_u64_rem(trace_clock_local() + delta,
 					    NSEC_PER_SEC, &__entry->nsecs);
 	),
 
 	TP_printk("next tick at %Lu.%06u (delay: %Ld us)",
 		  (unsigned long long)__entry->secs,
-		  __entry->nsecs / 1000, div_s64(__entry->delta, 1000))
+		  __entry->nsecs / 1000, __entry->delta)
 );
 
 TRACE_EVENT(cobalt_trace,
-- 
2.39.5

