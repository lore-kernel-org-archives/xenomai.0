Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490F31103
	for <xenomai@lists.linux.dev>; Fri,  5 May 2023 07:21:04 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2023050507210287d891e8ff14f572a8
        for <xenomai@lists.linux.dev>;
        Fri, 05 May 2023 09:21:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=lrb+W/FGoTLX+7vpoBmH7YIPnuU5x2+sOra/rs+h7eM=;
 b=A1trM9vv2iXbrezhVVArIsYIqbNFaWjwZ1FPrbyvdjzohkcgApxEjAfLXSyEBqLLdH5H1B
 2npQC9Iv3usLXzxNNmjPfJY8NepqoDiIJFXvpbQHtJZwHkroxdJ7ETajLwGlzrEvo8xFyXSI
 oXMz09lpQTIlIU01qxRzBVHtiY2i4=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 05 May 2023 09:21:03 +0200
Subject: [PATCH 08/17] y2038: cobalt: posix/mqueue: Remove compat syscall
 for mq_timedsend64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230428-florian-y2038-part-one-v1-8-64a972ff2189@siemens.com>
References: <20230428-florian-y2038-part-one-v1-0-64a972ff2189@siemens.com>
In-Reply-To: <20230428-florian-y2038-part-one-v1-0-64a972ff2189@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

There is no difference between the native and the compat entry point,
so let's keep it simple. The native entrypoint is already linked into
the syscall table at the right offset.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/posix/mqueue.c    | 10 ++--------
 kernel/cobalt/posix/mqueue.h    |  3 ---
 kernel/cobalt/posix/syscall32.c |  8 --------
 kernel/cobalt/posix/syscall32.h |  5 -----
 4 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/kernel/cobalt/posix/mqueue.c b/kernel/cobalt/posix/mqueue.c
index 3514ba1b0..4487e23de 100644
--- a/kernel/cobalt/posix/mqueue.c
+++ b/kernel/cobalt/posix/mqueue.c
@@ -974,13 +974,6 @@ out:
 	return ret;
 }
 
-int __cobalt_mq_timedsend64(mqd_t uqd, const void __user *u_buf, size_t len,
-			    unsigned int prio, const void __user *u_ts)
-{
-	return __cobalt_mq_timedsend(uqd, u_buf, len, prio, u_ts,
-				     u_ts ? mq_fetch_timeout64 : NULL);
-}
-
 COBALT_SYSCALL(mq_timedsend, primary,
 	       (mqd_t uqd, const void __user *u_buf, size_t len,
 		unsigned int prio, const struct __user_old_timespec __user *u_ts))
@@ -993,7 +986,8 @@ COBALT_SYSCALL(mq_timedsend64, primary,
 	       (mqd_t uqd, const void __user *u_buf, size_t len,
 		unsigned int prio, const struct __kernel_timespec __user *u_ts))
 {
-	return __cobalt_mq_timedsend64(uqd, u_buf, len, prio, u_ts);
+	return __cobalt_mq_timedsend(uqd, u_buf, len, prio, u_ts,
+				     u_ts ? mq_fetch_timeout64 : NULL);
 }
 
 int __cobalt_mq_timedreceive(mqd_t uqd, void __user *u_buf,
diff --git a/kernel/cobalt/posix/mqueue.h b/kernel/cobalt/posix/mqueue.h
index d9223866a..755623f47 100644
--- a/kernel/cobalt/posix/mqueue.h
+++ b/kernel/cobalt/posix/mqueue.h
@@ -40,9 +40,6 @@ int __cobalt_mq_timedsend(mqd_t uqd, const void __user *u_buf, size_t len,
 			  int (*fetch_timeout)(struct timespec64 *ts,
 					       const void __user *u_ts));
 
-int __cobalt_mq_timedsend64(mqd_t uqd, const void __user *u_buf, size_t len,
-			    unsigned int prio, const void __user *u_ts);
-
 int __cobalt_mq_timedreceive(mqd_t uqd, void __user *u_buf,
 			     ssize_t *lenp,
 			     unsigned int __user *u_prio,
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index d3cc79878..0197c749b 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -285,14 +285,6 @@ COBALT_SYSCALL32emu(mq_timedsend, primary,
 				     u_ts, u_ts ? sys32_fetch_timeout : NULL);
 }
 
-COBALT_SYSCALL32emu(mq_timedsend64, primary,
-		    (mqd_t uqd, const void __user *u_buf, size_t len,
-		     unsigned int prio,
-		     const struct __kernel_timespec __user *u_ts))
-{
-	return __cobalt_mq_timedsend64(uqd, u_buf, len, prio, u_ts);
-}
-
 COBALT_SYSCALL32emu(mq_timedreceive, primary,
 		    (mqd_t uqd, void __user *u_buf,
 		     compat_ssize_t __user *u_len,
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index ab7dbb945..5569af7d8 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -102,11 +102,6 @@ COBALT_SYSCALL32emu_DECL(mq_timedsend,
 			  unsigned int prio,
 			  const struct old_timespec32 __user *u_ts));
 
-COBALT_SYSCALL32emu_DECL(mq_timedsend64,
-			 (mqd_t uqd, const void __user *u_buf, size_t len,
-			  unsigned int prio,
-			  const struct __kernel_timespec __user *u_ts));
-
 COBALT_SYSCALL32emu_DECL(mq_timedreceive,
 			 (mqd_t uqd, void __user *u_buf,
 			  compat_ssize_t __user *u_len,

-- 
2.39.2

