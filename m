Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A307C2DE6E1
	for <xenomai@lists.linux.dev>; Thu, 16 Oct 2025 06:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760596354; cv=none; b=I4cmErdLqMVMKg+D7CDv8yjCZILg2uE25SbkB6CQnqZRBWDzeYwAudHD+Lu4EY0qKU5Acsnh2dXQtj2JYde66MZV/ONCaHV6L1w883xlTYNv8E+zJPkW/Rr2Efr4QL+LuLWadlajisMKvXS9kWQhuZXNsgMqIxJWmxIGWMvoRpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760596354; c=relaxed/simple;
	bh=QSCq39KNhgjBgE2jT8/cYz4PrOiIpY4H+XdMnKttkW4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMzw/Y+YAZxMchSLEfLlzvK/+Hglut1tQ6LAhc6bbDm9gkJBo8Yx9jyVCNUPmClyXGb/btzMcgk2KwlC1NJ15RPTElqMsxm5cZwH0PlXV/YAtK/QiAO0a/5420bfuSXeubuTQ9q7qSWofW69/wye1DoSntnC6zQ4Xxp5YTF6F8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=C1hB4hDB; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="C1hB4hDB"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20251016063226bc7698742c0002075a
        for <xenomai@lists.linux.dev>;
        Thu, 16 Oct 2025 08:32:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=uT1wZHEje8jYVUXfIO55BC8os4YL/xvwkwLHGLCh3aE=;
 b=C1hB4hDBWRpe4GrrUSTdqm8w/2Odpe/Q05Lh5l3iof7eJtlDqF904IFhlh9X5Q028LZeU9
 dHouUDUn08U8Vq7HGCABqzAUKVmKAbVI8SzsT9toxGz3pULYK0ou7O6vnRaoDaT7Q3RiuMeb
 1CFfj43WdyNgZ1hbKUNOqh4TJ1/gEmoHJ8ca+A3bnRnjdd4ZMxByC023pFuRSIaiTzMqKeQH
 PkNMXFI/h/aJzw9VLbXziHO20CAIlpCf2Aii9aqSqkJrFmdHZZo1NTszBfv/ubexKNuTJAwH
 9a7qI2ukwTccLeDrus4fHyPuR1pAJOtOPXBljHKrHrjXzCijQAgSK8gA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH v2 7/7] testsuite/smokey/sched-quota: Make workload more predictable
Date: Thu, 16 Oct 2025 08:32:24 +0200
Message-ID: <2c177a0216d4d58e3d261a06075847a1551a11ee.1760596344.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1760596344.git.jan.kiszka@siemens.com>
References: <cover.1760596344.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Adding some time-based busy-waiting makes the workload way more
predictable for the calibration and later on evaluation. This fixes
rather frequent failures of this test on real hardware, since the update
to a Debian 13 toolchain specifically on RPi4.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/sched-quota/sched-quota.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testsuite/smokey/sched-quota/sched-quota.c b/testsuite/smokey/sched-quota/sched-quota.c
index 5abe75d27e..f9e64e37f1 100644
--- a/testsuite/smokey/sched-quota/sched-quota.c
+++ b/testsuite/smokey/sched-quota/sched-quota.c
@@ -17,6 +17,7 @@
 #include <sys/cobalt.h>
 #include <boilerplate/time.h>
 #include <boilerplate/ancillaries.h>
+#include <copperplate/threadobj.h>
 #include <smokey/smokey.h>
 
 smokey_test_plugin(sched_quota,
@@ -63,6 +64,7 @@ static volatile int throttle;
 static unsigned long __attribute__(( noinline ))
 __do_work(unsigned long count)
 {
+	threadobj_spin(1000);
 	return count + 1;
 }
 
-- 
2.51.0

