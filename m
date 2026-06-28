Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F36F13A244
	for <xenomai@lists.linux.dev>; Sun, 28 Jun 2026 04:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782622284; cv=none; b=glhtlgNI7E1jSMkcFIwqpT02rtDnn7aCyrCt3GFwbF4C+ceDiSorrq7GRYVk26Ozeia3DwLbMo/i4NsOoXFe+CVEfwmbOj7Uk6In19CXM0TP8s9ueX4pr4nWtJBh0OYdKx7NDkhLBeyRsVEuQ7PeFkrVNzOtniw0I8t8ud2a9Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782622284; c=relaxed/simple;
	bh=obme3kyCmFmh25QH8FVoxGL0YBmGoAwGtQsYItIU7xk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RdR80NBrSAHdrOJgJzT6nwZzLKKzKg5WFFVV8eS6APvUakrTwHCwIqrvAoqN2USGnJhWM1VmgyKGiYOtFSo4a3xxieTgTHWSBJei4CXHh7d1cw+VtbgyJlwAdaClENKnkzuyhar+aRps1rOrUtiNpVq2iBUkSD4v5MIJsCzGXvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=R7o1KS93; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="R7o1KS93"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Jv
	NcA7DyjedwT+uSDJKXwfb9xD0uiQ8116j80/OtrFg=; b=R7o1KS93v4KvXNBB0k
	T/q6mM/aI+ZUHpCquaEBDz+p5LzvOwbYb2aS+r0pJk6DKwlQzekQ6soKpzK08+M8
	M+CMVAalgpFX313sl8P/ktpJGRkHEBsxOojE6WM3cX913l5eS8x73ua8hbKaPLek
	lNlWPmfRyw+pWjZzdS6FO/Rb4=
Received: from wang-Xenomai.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wCXYGc2qEBqjBkzGA--.59914S6;
	Sun, 28 Jun 2026 12:51:17 +0800 (CST)
From: guang_feng_wang@163.com
To: jan.kiszka@siemens.com,
	rpm@xenomai.org,
	florian.bezdeka@siemens.com
Cc: xenomai@lists.linux.dev,
	guang feng wang <guang_feng_wang@163.com>
Subject: [PATCH website v1 4/5] doc: generalize ARM64 Cobalt build notes
Date: Sun, 28 Jun 2026 12:50:58 +0800
Message-Id: <0c703a2af3314782cc2374194cf55577002fde1f.1782585785.git.guang_feng_wang@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782585785.git.guang_feng_wang@163.com>
References: <cover.1782585785.git.guang_feng_wang@163.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXYGc2qEBqjBkzGA--.59914S6
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrWxtryUZr1DCr1xJw4rGrg_yoWkCFb_X3
	WxtF4kZr1Fyrs3tw1I9F1fXry09w4kJryrWFn2vFnrAwsrJFn8A398Ja4UAFyUGF4a9rs3
	ur90yw40kFs7ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRKSoGDUUUUU==
X-CM-SenderInfo: xjxd0wxbih0wxbzd0wi6rwjhhfrp/xtbC+QXlX2pAqEUCPgAA39

From: guang feng wang <guang_feng_wang@163.com>

The ARM64 Cobalt kernel build example still refers to a Raspberry Pi 3
and Cortex-A53 setup, and mentions a Linaro toolchain explicitly.

Generalize the wording to describe a typical AArch64 cross build while
keeping aarch64-linux-gnu- as the example toolchain prefix.

Signed-off-by: guang feng wang <guang_feng_wang@163.com>
---
 content/installation/_index.md | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/content/installation/_index.md b/content/installation/_index.md
index 4eaafcb..12cf726 100644
--- a/content/installation/_index.md
+++ b/content/installation/_index.md
@@ -280,9 +280,8 @@ location
 
 #### Building Cobalt/arm64 kernel {#x3-build-cobalt-arm64}
 
-Using Linaro toolchain with the prefix aarch64-linux-gnu- and compiling
-for the raspberry pi 3 board (cortex-a53), cross compiling is as
-follows:
+Using an AArch64 cross toolchain with the prefix `aarch64-linux-gnu-`,
+a typical ARM64 cross build is as follows:
 
     $ cd $linux_tree
     $ $xenomai_root/scripts/prepare-kernel.sh --arch=arm64 \
-- 
2.34.1

