Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891A21A2C11
	for <xenomai@lists.linux.dev>; Sun, 12 Jan 2025 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736678923; cv=none; b=EEWzrowROI5LWZFKS2xPcEsvjY3boEWBj600itpVG0YlEZhUf57y6dK23O7lFeKpoG6f6VIqVErmW1NDWIzbKgBjcvwLs7BbcMHB1sxGVKS84X/pTM3iSOPoT9FjJR0yTyLblaX4Dqfh24Tq469yChYn5KtUCkpUALcpAy3FoqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736678923; c=relaxed/simple;
	bh=7LZ2GppABVkzL+GJGB/AhchnSoA77QuEYNoVlljkOAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fxN9M6jx2YT87tGA1Chyk4J2aOKGDUTwRemaYZx+cgr80fzuH0T7hZPAV/NaxtcC8W+MEJduEC1MxR4sQFAFRVLtq2Tw5oIkEQuk0SwXFYzrtpIBD+zmgqNnabO0ftWXuNvXtzEnOipsuiS0lV/DKZGfo6a5VZ3vNxA9qkOkBp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Jd0Lv75Y; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Jd0Lv75Y"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2025011210482928dc5d099016af15d8
        for <xenomai@lists.linux.dev>;
        Sun, 12 Jan 2025 11:48:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=0DOa45/MyquN51mPQYD6e+fXYf3tkUK9vpAhAGSPFhI=;
 b=Jd0Lv75YTkaqnDb5HjbLntTcdObB1eEM+KRuItnvJotpQ85uYMZ3O2JOdLTnaN8moPgFTl
 nakqTR/b8WrMK12msPoyYYvtfLlYOBbKiCbuysdD8Tk86KqXve7w2tcXbO330y4GehQ7bxxU
 LkglWHt9RfM/LUKfxMjtlRc2vlGTVaxJDnOz9m89RGOLT4hFpSdxZ+Qa5RaJSvRO2mepMIEw
 Yzis9nIsA1dg+rkvE+La4Ee6cnbc81SMBc+9rk6EWvujY6HvnpGorbf6lUACE9p1i+E5uhXZ
 7qNGP6+fUwRpSqZr8U5o6zWIPontvONKIXm4lr9OXJGOqDgzQ4AH15GQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
	Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 0/3] cobalt: always check userspace read/write validity
Date: Sun, 12 Jan 2025 11:48:26 +0100
Message-ID: <cover.1736678909.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

This adds a few missing access_ok and get/put_user return code
evaluations. Along that, the register corruption seen since kernel 6.11
is avoided.

Jan

Jan Kiszka (3):
  testsuite/smokey/y2038: Always present valid u_ret to monitor_wait64
  cobalt: Add missing access_ok checks
  cobalt: Add missing evaluations of __xn_get/put_user return codes

 kernel/cobalt/posix/cond.c             | 9 ++++++---
 kernel/cobalt/posix/io.c               | 2 ++
 kernel/cobalt/posix/monitor.c          | 3 ++-
 kernel/cobalt/posix/mqueue.c           | 3 ++-
 kernel/cobalt/posix/process.c          | 5 ++++-
 kernel/cobalt/posix/syscall32.c        | 2 ++
 testsuite/smokey/y2038/syscall-tests.c | 6 +++---
 7 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.43.0

