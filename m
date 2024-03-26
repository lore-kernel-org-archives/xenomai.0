Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD2054BFF
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434678; cv=none; b=ag5hPp1NsYMe4D/+F9eNYYgqAAEjyWkP4Kf5zaNO1FD+WToCLTeVwkuf/cbPFCSSLEFTRTJosPPo82O08+IVTY6FHvez4sw+mwPWArcHItILj5JjvGp1JIULC6JOaDa/u9a/Pwpxet4AhrrxghQNkhKNQ4ilfkea4UI8r8CnHQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434678; c=relaxed/simple;
	bh=f6W6hoZaNukmOsjynum+KA5H38PmrtSNJisdyEKKezw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aeBms6K6rSKCMBDlac+8bWk/AqFA5Y03GZNRTaYjlD7/sOFlLPg5WtPvBnLf+SsLboJvDmn9usLok0lokClKxlGv1iNcbBUHGbs+55J49U0d0fIEhRcRMb4B7mhVIoEVXfYCPanMBlFOSYCjhIw4Xeq0Blwnx62yHhMGnqbIxKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=BBZoTJoZ; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="BBZoTJoZ"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2024032606310626f7626847e92b54b4
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=+RsMgXivezp6koTqnNZhUKDx5Ytvvar0+hXG7szUlZU=;
 b=BBZoTJoZ8TrPyRlold7+GTn42YBRXCSGK40+bAkFGvs/+AnKNO3vHactkdVaeLXuv6+wIs
 nE3L3r1V31Zfj9qjlG/1O6yyPM8skLsVQg1ejojgEdXqJXb799f/jbXKR2WniBj4Me3sfpzJ
 0Jel++AXLpRCnHtyKHrMh50w7c0yg=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 01/25] Account for renaming of MAX_ORDER in kernel 6.8
Date: Tue, 26 Mar 2024 07:30:40 +0100
Message-Id: <149b639286499790a2cc311d07bb72f7083f3f88.1711434664.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1711434664.git.jan.kiszka@siemens.com>
References: <cover.1711434664.git.jan.kiszka@siemens.com>
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 4 ++++
 kernel/cobalt/posix/mqueue.c                         | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index c86ab16029..abf58c589c 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -65,4 +65,8 @@
 #define pde_data(i)	PDE_DATA(i)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,8,0)
+#define MAX_PAGE_ORDER	MAX_ORDER
+#endif
+
 #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */
diff --git a/kernel/cobalt/posix/mqueue.c b/kernel/cobalt/posix/mqueue.c
index 878fb521b4..5d072eb7fd 100644
--- a/kernel/cobalt/posix/mqueue.c
+++ b/kernel/cobalt/posix/mqueue.c
@@ -158,7 +158,7 @@ static inline int mq_init(struct cobalt_mq *mq, const struct mq_attr *attr)
 
 	memsize = msgsize * attr->mq_maxmsg;
 	memsize = PAGE_ALIGN(memsize);
-	if (get_order(memsize) > MAX_ORDER)
+	if (get_order(memsize) > MAX_PAGE_ORDER)
 		return -ENOSPC;
 
 	mem = xnheap_vmalloc(memsize);
-- 
2.35.3

