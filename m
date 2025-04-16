Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414A220A5D3
	for <xenomai@lists.linux.dev>; Wed, 16 Apr 2025 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811528; cv=none; b=UQTPPpu2D0GHAXo0fxRFHMojdCbUYL1cu836ARHJRzMKHN9lDhsfbVVrAZ2yBU+NRTQ0NYE4EMCm6TCdpWXw1lCf5P2yVVGkFupt72KOt9q/UjMZFk4homvoJETQNzdh0QbhSlvnUzeq60qucEX56kDee9IhMLsUznrWKF1L8nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811528; c=relaxed/simple;
	bh=zDN78BDmLMGoUA2eVE7Q6cn1wm/w9e2Cc7oMbyux+8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e9kAq/qLB/VkaLEwChz/RBuJxq4sLdE2676b4skV5ADRg1ZLL8kqr+JFfJxbiX+zRCHSHUA4AuR0YnHxfUtFVKYq9AfvMsdFQLBYeKuhJEuenQ0jiNeaOJbsBBciA+vLlvAQzKmREVVJK5/4DLvFe6fgDM1PDk8ZQ9ApkCFV8EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=An4u6biI; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="An4u6biI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=4BbEx
	1jp+veHwoJkel76MUN+WW+lGKv8biF2aCGmwq0=; b=An4u6biI33Phjid2jHz8R
	IpVhCivWpPUx/2K9iLBFTcwQYIxpRLHLPbq9KsMgXkX0nlIMndhWHBsJ/C+do+6S
	DEMI49/J3KSg9NeBXx6Yhg/twpHgLyC6JaBFMBvLwXq12+32UU0FI/O6Qn4aGR1a
	YFNkdTMaVWfMfXZeNGYj0Y=
Received: from u2204.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBnpCD9tf9nSmvwAQ--.40674S2;
	Wed, 16 Apr 2025 21:51:58 +0800 (CST)
From: Haiyang He <aspirestro@163.com>
To: jan.kiszka@siemens.com
Cc: xenomai@lists.linux.dev,
	Haiyang He <aspirestro@163.com>
Subject: [PATCH] doc: Correct the default value of xenomai.sysheap_size
Date: Wed, 16 Apr 2025 21:51:48 +0800
Message-Id: <20250416135148.1943000-1-aspirestro@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnpCD9tf9nSmvwAQ--.40674S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr1kXr4rCFWDJr18Cr1xXwb_yoWkZFc_KF
	13Jws7Wrs8tFyjgF1Fyr4xZr1FvFyUXr1xJr1fKr18A3sIya1ay39YqFs3ZFyfuwsFvF15
	Z3yqvF13Ar1q9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMDGYDUUUUU==
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/xtbBYxoxcWf-sMOIEQAAsL

By default, the sysheap_size_arg equals to
CONFIG_XENO_OPT_SYS_HEAPSZ. Ref to kernel/cobalt/Kconfig, the default
size of system heap (Kb) is 4096.

config XENO_OPT_SYS_HEAPSZ
	int "Size of system heap (Kb)"
	default 4096
	help
	  The system heap is used for various internal allocations by
	  the Cobalt kernel. The size is expressed in Kilobytes.

Signed-off-by: Haiyang He <aspirestro@163.com>
---
 doc/asciidoc/README.INSTALL.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/asciidoc/README.INSTALL.adoc b/doc/asciidoc/README.INSTALL.adoc
index 60f1f9149..04c102822 100644
--- a/doc/asciidoc/README.INSTALL.adoc
+++ b/doc/asciidoc/README.INSTALL.adoc
@@ -132,7 +132,7 @@ whose members should be allowed such access by the Cobalt core. | None
 
 |xenomai.sysheap_size=<kbytes> | Set the size of the memory heap used
 internally by the Cobalt core to allocate runtime objects.  This value
-is expressed in kilo-bytes. | 256
+is expressed in kilo-bytes. | 4096
 		
 |xenomai.state=<state> | Set the initial state of the Cobalt core at
 boot up, which may be _enabled_, _stopped_ or _disabled_. See the
-- 
2.34.1

