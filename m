Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD90712C54E
	for <xenomai@lists.linux.dev>; Mon, 26 Feb 2024 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964967; cv=none; b=W0BnXn2VXcC0gY2QwGgmGVpSUzWZEngvfkGel1CXB0O9qnrDCi04IpkwNyah1/Hxs3PDNt2adjn2jAFvlCdphTO9wIcYrCv6K6NMxNtVio5Ed5btV0xEG+tpyGJNtdYucMAQqoPcM0Hl92fSTFFu3xY3+e6GPxuAh7M/77s2nOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964967; c=relaxed/simple;
	bh=V3LXHyQwCNACS4TzkmuEQT8qOyx5pyaLD77vyM+i36k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NNAEYdFOMqDfpyzA95/0USs9TOCYnPFNjKROz+vqR20bke2FyA0NcgzzCLBF0F/OSb0qwY2lK7j0yO3sNxDK0iEXZyYqK+pns+bxDW2VIJuwbCD0PqeMgxTLZN7Bn34Fi0izSQu4qykBAbMw6VmXpyAlKyjCy5UcND9GvA7CdLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=l2EuRYOp; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="l2EuRYOp"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202402261629143eb5653725239eaf18
        for <xenomai@lists.linux.dev>;
        Mon, 26 Feb 2024 17:29:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=3IS+JnkPP0+xxLdEfVs0bScLywaYeG7a1pbjqIWGB5Q=;
 b=l2EuRYOpKrIuxYyOmGM5KOoDhuV6AQ+j8OyWG38/XVA0m0Cv472KYagTsjg45qWzu03VQp
 OXKq6+gQu4YRH2CbnK2xV0EcNAZoWAZeFM7GzOLYCWF2PejwcKrgA/63Z8XFwHfEUiNMDm72
 p6KpSv+Ew8JDNfMK2OhkntdashdoY=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH dovetail 6.7-6.1 0/2] dovetail: x86: Fix handling of prctl
 based compat syscalls
Date: Mon, 26 Feb 2024 17:29:12 +0100
Message-Id: <20240226-v6-7-dovetail-rebase-v1-0-2962213b5e9c@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFi83GUC/zWNQQqDMBBFrxJm3ZE4aCy9SukixmkdCLFMbBDEu
 xuELt+D9/8OmVU4w8PsoFwky5IqtDcDYfbpwyhTZSBLnSVyWBwOOC2FVy8RlUefGdkT9X3n7D1
 YqOklR/UpzDVOvxir/Cq/Zbu+nvBfMK4Z0DUtvI7jBL+qDeuNAAAA
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi Philippe, Hi Jan, Hi all,

while switching to prctl based syscalls on Xenomai 3 I found some issues
in dovetail. Seems the compt support for x86 is not fully tested here.

The patches apply to the 6.7, 6.6 and 6.1 branches. 5.10 will need some
backporting. I think I can provide backports once this series was applied.

Best regards,
Florian

CC: Jan Kiszka <jan.kiszka@siemens.com>
CC: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (2):
      dovetail: x86: Fix detection of prctl based compat syscalls
      dovetail: x86: Fix fetching of the first syscall argument from compat tasks

 arch/arm/include/asm/syscall.h   |  3 ++-
 arch/arm64/include/asm/syscall.h |  3 ++-
 arch/x86/include/asm/dovetail.h  |  9 +++++++++
 arch/x86/include/asm/syscall.h   | 10 ++++++++--
 kernel/dovetail.c                |  5 ++++-
 5 files changed, 25 insertions(+), 5 deletions(-)
---
base-commit: 2e3ed248f02a47dba4e5077031d285ff5c397372
change-id: 20240226-v6-7-dovetail-rebase-ea22554608c0

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

