Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DD41E00A0
	for <xenomai@lists.linux.dev>; Thu, 24 Apr 2025 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745493341; cv=none; b=jdOgNPkePE83QUJmYcGnwleuBC+JyavJhdYviGdx+vqYYms3fWFpb9Z62+EkG4vHEYRWDtwH8QMWNR3/Kdh7qgT43Qo3AwDsWiB/UoI6+zcQfxzGme9O7BkqrbUczxFOhO/BzQik+25+w5w8EtOYm4jJ8OeITtklzCxUhTCPjKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745493341; c=relaxed/simple;
	bh=aZx770WABLgmN0F4U2tQjOpTIh/CBL4yPaRuap4XENw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sJrg12+p1M3vn2Rf9jC8TtH1uYkDPZjARITaC6RsSCGycIY3H+XaP3FSiPXnug6amN1oMz5wAvs6y8JSSCO1wUJ0tGmns9bjdgzEW7o+9DrjwnNn2o0lLMwjBsHtrgNkYsI/dcufWlEJ33h02mMHt7y8me8tP0j7OYHtWYkTIm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oAWlr5oq; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oAWlr5oq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Mm7BC
	CKZAprIXR5NElW3oj6+uQBwkUR/zeSO5zSW20k=; b=oAWlr5oqRlDI8OMB9NuUW
	9eFyl+JmRuEF17Ij9EQXXHWEwTrLrL/bFvcrjj0Mui0SZTopgbldNqQtIX4NNDUd
	zNC8WzKGQ3dDrGWtRPS+v86v94bCZ5X8A8Uv/+klH/BBhcm6t2RlSXgIyZ3U//7j
	MzU3G292gbHzaLcpMAh5Sk=
Received: from u2204.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3Z6BOHQpo8seXCA--.2853S2;
	Thu, 24 Apr 2025 19:15:28 +0800 (CST)
From: Haiyang He <aspirestro@163.com>
To: jan.kiszka@siemens.com
Cc: xenomai@lists.linux.dev,
	Haiyang He <aspirestro@163.com>
Subject: [PATCH] Doc: Add supported_cpus param for Cobalt kernel
Date: Thu, 24 Apr 2025 19:15:21 +0800
Message-Id: <20250424111521.2344714-1-aspirestro@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Z6BOHQpo8seXCA--.2853S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw4fWw13ZFy8Jr4UGw4rKrg_yoWDZFX_Kw
	1fXFs7W3yjqryUGFyrJrs3CrWjyF95Xr17GrWrGr18Cr9xAw1jy3Z8Za9rZFyrur9F9F1D
	W34jqry7Cr429jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRGjgx7UUUUU==
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/1tbiXAM5cWgKGQFh5AAAso

Add table entry for the xenomai.supported_cpus parameter, defined in
kernel/cobalt/init.c.

Signed-off-by: Haiyang He <aspirestro@163.com>
---
 doc/asciidoc/README.INSTALL.adoc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/asciidoc/README.INSTALL.adoc b/doc/asciidoc/README.INSTALL.adoc
index 04c102822..508e9b43d 100644
--- a/doc/asciidoc/README.INSTALL.adoc
+++ b/doc/asciidoc/README.INSTALL.adoc
@@ -126,6 +126,10 @@ should be passed on the kernel command line by the boot loader.
 |============================================================================
 ^|NAME              ^|DESCRIPTION                    ^|DEFAULT
 
+|xenomai.supported_cpus=<mask> | *SMP only*: Bitmask of CPUs allowed
+to run real-time tasks. Each bit represents a CPU logical core
+(bit 0=CPU0). | -1 (all CPUs)
+
 |xenomai.allowed_group=<gid> | Enable non-root access to Xenomai
 services from user-space.  <gid> is the ID of the Linux user group
 whose members should be allowed such access by the Cobalt core. | None
-- 
2.34.1

