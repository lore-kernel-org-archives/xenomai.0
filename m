Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F4F199952
	for <xenomai@lists.linux.dev>; Fri, 30 Aug 2024 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016427; cv=none; b=DnUgdKLYqrk+yrkshvFvPOdzER1ayhi+ZGHcDAqCAxqcsTyoNlWQHElhKcoOh79dWCDdQaWgJ/G6Jn2YszhxwdxXYFYeAHSdZ6mZ/BSo7GorPerC6bRpU219bIZL3c8e5TxLHK2i896dc2jQxD4nK2L0o6r1WHd5Bg21wu9f9oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016427; c=relaxed/simple;
	bh=k05q4kkWfrooC8lCNgSNl3TV8NVBmgcCcdFZZ2crTJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m9DfVw6LJZZGAPa8qJIRrGTJrTKZNV4nNQW7AKPzPfMUVhE/Z+dOvo2HagiwRgDu7mhqaEenG6boTaPobqYI4YjM6bignxlIdXIn95N9AqCUdnMiTI6eLOarFUWe6qe8/xy9++I4k2YkZ0mTRB9xLOfpv/eCQyrrou1WwmDcna4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Dddq+1hA; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Dddq+1hA"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2024083011133429cc02d9a6d63057bc
        for <xenomai@lists.linux.dev>;
        Fri, 30 Aug 2024 13:13:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=q2T74tcYJBVxa+GD+S2Hu7IHkhCsI/0mDH2MEZuqLP0=;
 b=Dddq+1hAP880OCN+KJM67QJTwDSy1jnBmT3KQB9mjFbpcFgkbg1s4ZvizQJHdsfLjJtIbr
 BiP13ycdplmKi4NjVd34VWHQOoYocrE4ZDNHi/4OO5iRyBmnc6BEsRN9xdwtnFxRnAGGsTjB
 fpYhGOWJb07Pv8WAe4Qt+SjPyi/5QVsj6kqhiteuPgw3t2zfblkDCOIYRrbeC6iLkRpJUgqA
 +czBH6YIgnaxlwS5P5djKb2pkljRug1j31UJ7AEENaEb394gqAlRkmJwfHrMDsn4eLcWlDI2
 0D3DhkKB+KsmIPrq3cBrexCrShR106p8P7rqS/QEnNLXOLU1drT2UC0w==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: JerryJun <jerryjun123@163.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/3] Fix races in thread relaxation
Date: Fri, 30 Aug 2024 13:13:30 +0200
Message-ID: <cover.1725016413.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

This should resolve the issue reported in [1] and also clean up a bit
more of our now obsolete pipeline abstraction. Test case is planned for
later.

Jan

[1] https://lore.kernel.org/xenomai/770b1e4bc42cfa1ba5f4f37cc854956f3e78bb60.camel@siemens.com/T/#t

Jan Kiszka (3):
  cobalt: Move relax related lostage_wakeup work from stack to thread
  cobalt: Drop obsolete pipeline_inband_work abstraction
  cobalt/posix/process: Sync on thread-hosted irq_work items before
    exiting

 .../kernel/dovetail/pipeline/inband_work.h    | 28 ----------------
 include/cobalt/kernel/rtdm/driver.h           |  9 +++--
 include/cobalt/kernel/thread.h                | 10 ++++--
 kernel/cobalt/posix/process.c                 |  5 +++
 kernel/cobalt/rtdm/drvlib.c                   | 15 +++------
 kernel/cobalt/rtdm/fd.c                       | 13 +++-----
 kernel/cobalt/thread.c                        | 33 +++++++------------
 kernel/drivers/udd/udd.c                      | 12 +++----
 8 files changed, 45 insertions(+), 80 deletions(-)
 delete mode 100644 include/cobalt/kernel/dovetail/pipeline/inband_work.h

-- 
2.43.0

