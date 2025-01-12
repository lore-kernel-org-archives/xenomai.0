Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C311A4AAA
	for <xenomai@lists.linux.dev>; Sun, 12 Jan 2025 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736678922; cv=none; b=ulDRYA5stNwaOIOpm4bjztuzVwARpz55oL6EOLeKDbPG7O1Qs5exh8N81PnHhPhtg1qpoADCKphT+lvegO7+yw5noaIiMmTMfRvFPtcKRCzMaRhuPpSbA7akIosyhawETFq8gdPm2i0uWhYA0f5Bhp+DsQSRv5fpK7Nd+kHyAQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736678922; c=relaxed/simple;
	bh=z+tk0c6OgLrowDGF5CV+EzI81yj72YsYvwTMFgVTfAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXxZafeQuUw9IF8uqmKQGWevpSHsCQE07/xNLFBiiWrkGD0u/d/duceBRpTmhg/lbi/+9lvmisC9WTKWrkGrfnISmFJfBp5zgzSjcdnycL4iv+vMElBQEbuSCTusLD0DR0nRjSNEQc7S8DoaHgLbhfn66OEDcvpJjGnXlxv/fqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=uFPSMFEJ; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="uFPSMFEJ"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250112104830db5cf8183d3380c3ee
        for <xenomai@lists.linux.dev>;
        Sun, 12 Jan 2025 11:48:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=KH6Hjf9Oqvus5DWmNfOxHQGlozjFY1rigYxu3+NbxLM=;
 b=uFPSMFEJ9x0JuAh6jecYR/O8T8lr6Gc27rzzOqDqOmDexA5FfQKkmjQbjg50fsFMt0yHCJ
 TAMM0Waj3i25VjRkOdSjZeXVMZLyA2SE+tt4mFED5IK10EJGGaUzX0smrOY4NQ3x+LMHD3lE
 u0QKZgjnb0jTaW0eBIHCa6rdKselrmqdtjUEMQHi7yoI+8xjGw6wjy3k7I5bGU6RnouNS558
 niJiO77ZjhcG+4698YvLYM5d4qpflM196I0DamAS8lZUlRmyeo4/9U80AorRFxY/q6jp69dI
 VwrwFD5q9eYBvuAuGwU0r+uLx9ETbJcqEiF+Kum6svysh2tDAljs85+Q==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
	Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 2/3] cobalt: Add missing access_ok checks
Date: Sun, 12 Jan 2025 11:48:28 +0100
Message-ID: <eaa1b565f740f337b62cb18ea2217e0b8c2cb69b.1736678909.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1736678909.git.jan.kiszka@siemens.com>
References: <cover.1736678909.git.jan.kiszka@siemens.com>
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

These ensure that we are not using an invalid address range, possibly
writing to kernel space.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/io.c        | 2 ++
 kernel/cobalt/posix/mqueue.c    | 3 ++-
 kernel/cobalt/posix/syscall32.c | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
index e581ec6db8..722f1ce20c 100644
--- a/kernel/cobalt/posix/io.c
+++ b/kernel/cobalt/posix/io.c
@@ -146,6 +146,8 @@ static int put_mmsglen(void __user **u_mmsg_p, const struct mmsghdr *mmsg)
 	struct mmsghdr __user **p = (struct mmsghdr **)u_mmsg_p,
 		*q __user = (*p)++;
 
+	if (!access_ok(&q->msg_len, sizeof(q->msg_len)))
+		return -EFAULT;
 	return __xn_put_user(mmsg->msg_len, &q->msg_len);
 }
 
diff --git a/kernel/cobalt/posix/mqueue.c b/kernel/cobalt/posix/mqueue.c
index 853aa6cad8..34776fe6cd 100644
--- a/kernel/cobalt/posix/mqueue.c
+++ b/kernel/cobalt/posix/mqueue.c
@@ -1031,7 +1031,8 @@ int __cobalt_mq_timedreceive(mqd_t uqd, void __user *u_buf,
 
 	cobalt_mqd_put(mqd);
 
-	if (u_prio && __xn_put_user(prio, u_prio))
+	if (u_prio && (!access_ok(u_prio, sizeof(*u_prio)) ||
+		       __xn_put_user(prio, u_prio)))
 		return -EFAULT;
 
 	return 0;
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 793bde1388..484f059844 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -605,6 +605,8 @@ static int put_mmsglen32(void __user **u_mmsg_p, const struct mmsghdr *mmsg)
 	struct compat_mmsghdr __user **p = (struct compat_mmsghdr **)u_mmsg_p,
 		*q __user = (*p)++;
 
+	if (!access_ok(&q->msg_len, sizeof(q->msg_len)))
+		return -EFAULT;
 	return __xn_put_user(mmsg->msg_len, &q->msg_len);
 }
 
-- 
2.43.0

