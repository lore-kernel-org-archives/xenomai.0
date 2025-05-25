Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8E813DDAA
	for <xenomai@lists.linux.dev>; Sun, 25 May 2025 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748162007; cv=none; b=mA2ySqbrCbkJU+SSte6NK7RY4UzYBDxWQ2o7h3Qbbuaf2hOKv6aW9aMIIQKEFz5EBGxcCLIn3LFaOJss9pehAnYPHhmWlHDBVDotPyLYkr0kXlaDd2Lj0aox/Rx4IOXM1Ek3+0Hf5jUmZHMa8xYvrNEAAtRKKb+ItJIPgYXO2Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748162007; c=relaxed/simple;
	bh=LIvMU0JKU/jdtY3f3rbkrAStu2/gYxFKJecpyJZh+WE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mugjao9LHFdNjGMVYwz6cUrnvor68v+04WZZXf4ew5WqQpJmg3miE9nGYuq8rfSDgHTI62b9R45Kd9y17uZX8acCJhIZxMNT8Uu+LEWfsgda4Mdar4eDURBXcvOvs/8gLg8e8mmZrtrcJReQTxfCZ2dY1lX8doBJ2d2fJp2HZRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=II7KnHUb; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="II7KnHUb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=qU
	mPRAHBZZY8T/FaZ/Dt17z5hd7Uw3OtnO0wPYBjUmE=; b=II7KnHUbaDttgevGyR
	SIaPXC45B4yV79zo9Q9bc1YoNebDGwRH+mtgfxH7qhw50Jq7CQrSx1h2zEFvkM13
	bQs7ZDgPNtbYw/2IIrqJdTSA1MIFq2il7Dv5zAGRlqotxO8TFpqGFG3ykEm6RNti
	2d4hHG9IMRwGDpqDqokVFsHPo=
Received: from u2204.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCXVnvP1TJoPIEADw--.44100S2;
	Sun, 25 May 2025 16:33:19 +0800 (CST)
From: Haiyang He <aspirestro@163.com>
To: jan.kiszka@siemens.com
Cc: xenomai@lists.linux.dev,
	Haiyang He <aspirestro@163.com>
Subject: [PATCH] testsuite/latency: Remove unused include of syscall.h
Date: Sun, 25 May 2025 16:33:17 +0800
Message-Id: <20250525083317.394765-1-aspirestro@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXVnvP1TJoPIEADw--.44100S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrWF4kGF4Duw43XFykAry5Jwb_yoWxXwcEkw
	13Aan2kF1jkrn5Kr4vgw4Iyry2kr1kXr1IqFyIqF4rAF40qryUGrZ5ZryDGr17W3ZxCFy3
	tFs8tayUAr9FgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUUKItUUUUU==
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/1tbiXBRYcWgy0wk1FQAAsB

No functional change intended.

Signed-off-by: Haiyang He <aspirestro@163.com>
---
 testsuite/latency/latency.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/testsuite/latency/latency.c b/testsuite/latency/latency.c
index fe688b9b8..0b6964bb9 100644
--- a/testsuite/latency/latency.c
+++ b/testsuite/latency/latency.c
@@ -556,8 +556,6 @@ static void faulthand(int sig)
 
 #ifdef CONFIG_XENO_COBALT
 
-#include <cobalt/uapi/syscall.h>
-
 static const char *reason_str[] = {
 	[SIGDEBUG_UNDEFINED] = "received SIGDEBUG for unknown reason",
 	[SIGDEBUG_MIGRATE_SIGNAL] = "received signal",
-- 
2.34.1

