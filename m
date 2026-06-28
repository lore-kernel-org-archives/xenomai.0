Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F302110E
	for <xenomai@lists.linux.dev>; Sun, 28 Jun 2026 04:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782622283; cv=none; b=Kx94LEB5cp32EAxi8enQCVmAd4xtrngp9EOKos4UP6P1tUaC5slhZCO+oYxp0QAe1EX+kKQQcoD03rsITljtHtPRCSnxIaSTyoSIrtpG1RXWDIze++yQlkliEOUyLmJrNx7u2+agbh6wcTHAxCXuLJMQFujJzP36o6NgGF/RtQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782622283; c=relaxed/simple;
	bh=uwIHuhn3hOmevFd4sJEbNwyQVRUhg4fNvkrNaUAGwpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t0TzyTc1xy2YzEbkHfoSxgcYpwL8NqoWtU9AjVM7/t1Zaq/3/KMbaC9r6evgg9zVe+OtdYRWjBSjf2qmydKa4JvDayfm+Cq0CIPo49QEo8qXK+fj0SjTzXgOGiDMviWFIWMylF32ZVheVQ8cKR00p2i4LR9qT4F7Yhjjlxr8o6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=f0CVmCT+; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="f0CVmCT+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=wX
	SHxpHp8HyHdlZE07rIUNDBp7aOi+E2G1v6EmTPPl4=; b=f0CVmCT+3EmeeDLYfU
	JclMrxVipPKqvDD+DUFpUIQDm5d0ZxEnwJOLSvwd3ykQhZFxqFnDHUzzHB7cRITf
	Kbr9FskBE6y/nYNCn9bU0ub9u/5Plt8Rh00Q+zGZZqBJpOYoI86/U96oYoyfP8Xx
	cwu5gfRUcBELBxhwKokXFsfIs=
Received: from wang-Xenomai.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wCXYGc2qEBqjBkzGA--.59914S4;
	Sun, 28 Jun 2026 12:51:15 +0800 (CST)
From: guang_feng_wang@163.com
To: jan.kiszka@siemens.com,
	rpm@xenomai.org,
	florian.bezdeka@siemens.com
Cc: xenomai@lists.linux.dev,
	guang feng wang <guang_feng_wang@163.com>
Subject: [PATCH website v1 2/5] doc: update stale Cobalt kernel preparation example
Date: Sun, 28 Jun 2026 12:50:56 +0800
Message-Id: <433757b3a9242de476c946075be857abb9601a12.1782585785.git.guang_feng_wang@163.com>
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
X-CM-TRANSID:_____wCXYGc2qEBqjBkzGA--.59914S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7urWrZF1fGr4rXFWrtw48tFb_yoW8GFW3pr
	yDuw1rKFyrGr1ay3WDXayxZr1rWa93KryUWrWDCa42ya4qyrs2qF9Ivrn09Fy5XFs7Aa1Y
	vryYqr9rCa18AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zErWFUUUUUU=
X-CM-SenderInfo: xjxd0wxbih0wxbzd0wi6rwjhhfrp/xtbC+QPkXmpAqEMCJQAA3m

From: guang feng wang <guang_feng_wang@163.com>

The Cobalt kernel preparation example still refers to a linux-3.10-ipipe
tree. This is stale for the current Dovetail-based Cobalt setup path.

Update the example to use a generic Dovetail-enabled Linux tree instead.

Signed-off-by: guang feng wang <guang_feng_wang@163.com>
---
 content/installation/_index.md | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/content/installation/_index.md b/content/installation/_index.md
index 673b51b..265cb5a 100644
--- a/content/installation/_index.md
+++ b/content/installation/_index.md
@@ -59,11 +59,12 @@ if so.
 tells the script about the target architecture. If unspecified, the
 build host architecture suggested as a reasonable default.
 
-For instance, the following command would prepare the Linux tree located
-at `/home/me/linux-3.10-ipipe` in order to patch the Xenomai support in:
+For instance, the following command would prepare a Dovetail-enabled
+Linux tree located at `/home/me/linux-dovetail` in order to patch
+the Xenomai support in:
 
     $ cd xenomai-3
-    $ scripts/prepare-kernel.sh --linux=/home/me/linux-3.10
+    $ scripts/prepare-kernel.sh --linux=/home/me/linux-dovetail
 
 Note: The script will infer the location of the Xenomai kernel code from
 its own location within the Xenomai source tree. For instance, if
-- 
2.34.1

