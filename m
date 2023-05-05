Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B754C85
	for <xenomai@lists.linux.dev>; Fri,  5 May 2023 07:21:07 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2023050507210386394c7d1172cefbc3
        for <xenomai@lists.linux.dev>;
        Fri, 05 May 2023 09:21:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=SIj5YIrJen3KJyRsweQTMFgVGxGpfUQfemEtEsBHEwI=;
 b=P0SqBKQuzQef6kyevnAKEVX8cwIgaGdhBIyGhi4HeUigJvrDuBpIkaUM1LCZNsutmej484
 V+3Xq04MyJxIPj4epswF6XZcU8ijcE5dOKdbJALS4Hr5trXWIgHevBtQDhSr30sug9921A0t
 xiV2N9frSDXMVnep8UfBdl3jnB6s4=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 05 May 2023 09:21:05 +0200
Subject: [PATCH 10/17] y2038: cobalt: posix/event: Remove compat syscall
 for event_wait64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230428-florian-y2038-part-one-v1-10-64a972ff2189@siemens.com>
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
 kernel/cobalt/posix/event.c     | 26 +++++++++-----------------
 kernel/cobalt/posix/event.h     |  5 -----
 kernel/cobalt/posix/syscall32.c |  9 ---------
 kernel/cobalt/posix/syscall32.h |  7 -------
 4 files changed, 9 insertions(+), 38 deletions(-)

diff --git a/kernel/cobalt/posix/event.c b/kernel/cobalt/posix/event.c
index 052c68605..a5fa45db8 100644
--- a/kernel/cobalt/posix/event.c
+++ b/kernel/cobalt/posix/event.c
@@ -190,17 +190,18 @@ out:
 	return ret;
 }
 
-int __cobalt_event_wait64(struct cobalt_event_shadow __user *u_event,
-			  unsigned int bits,
-			  unsigned int __user *u_bits_r,
-			  int mode, const struct __kernel_timespec __user *u_ts)
+COBALT_SYSCALL(event_wait, primary,
+	       (struct cobalt_event_shadow __user *u_event,
+		unsigned int bits,
+		unsigned int __user *u_bits_r,
+		int mode, const struct __user_old_timespec __user *u_ts))
 {
 	struct timespec64 ts, *tsp = NULL;
 	int ret;
 
 	if (u_ts) {
 		tsp = &ts;
-		ret = cobalt_get_timespec64(&ts, u_ts);
+		ret = cobalt_get_u_timespec(&ts, u_ts);
 		if (ret)
 			return ret;
 	}
@@ -208,18 +209,18 @@ int __cobalt_event_wait64(struct cobalt_event_shadow __user *u_event,
 	return __cobalt_event_wait(u_event, bits, u_bits_r, mode, tsp);
 }
 
-COBALT_SYSCALL(event_wait, primary,
+COBALT_SYSCALL(event_wait64, primary,
 	       (struct cobalt_event_shadow __user *u_event,
 		unsigned int bits,
 		unsigned int __user *u_bits_r,
-		int mode, const struct __user_old_timespec __user *u_ts))
+		int mode, const struct __kernel_timespec __user *u_ts))
 {
 	struct timespec64 ts, *tsp = NULL;
 	int ret;
 
 	if (u_ts) {
 		tsp = &ts;
-		ret = cobalt_get_u_timespec(&ts, u_ts);
+		ret = cobalt_get_timespec64(&ts, u_ts);
 		if (ret)
 			return ret;
 	}
@@ -227,15 +228,6 @@ COBALT_SYSCALL(event_wait, primary,
 	return __cobalt_event_wait(u_event, bits, u_bits_r, mode, tsp);
 }
 
-COBALT_SYSCALL(event_wait64, primary,
-	       (struct cobalt_event_shadow __user *u_event,
-		unsigned int bits,
-		unsigned int __user *u_bits_r,
-		int mode, const struct __kernel_timespec __user *u_ts))
-{
-	return __cobalt_event_wait64(u_event, bits, u_bits_r, mode, u_ts);
-}
-
 COBALT_SYSCALL(event_sync, current,
 	       (struct cobalt_event_shadow __user *u_event))
 {
diff --git a/kernel/cobalt/posix/event.h b/kernel/cobalt/posix/event.h
index 919774c9a..a67141f2b 100644
--- a/kernel/cobalt/posix/event.h
+++ b/kernel/cobalt/posix/event.h
@@ -41,11 +41,6 @@ int __cobalt_event_wait(struct cobalt_event_shadow __user *u_event,
 			unsigned int __user *u_bits_r,
 			int mode, const struct timespec64 *ts);
 
-int __cobalt_event_wait64(struct cobalt_event_shadow __user *u_event,
-			  unsigned int bits, unsigned int __user *u_bits_r,
-			  int mode,
-			  const struct __kernel_timespec __user *u_ts);
-
 COBALT_SYSCALL_DECL(event_init,
 		    (struct cobalt_event_shadow __user *u_evtsh,
 		     unsigned int value,
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index dfa4d31ec..97981bda9 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -752,15 +752,6 @@ COBALT_SYSCALL32emu(event_wait, primary,
 	return __cobalt_event_wait(u_event, bits, u_bits_r, mode, tsp);
 }
 
-COBALT_SYSCALL32emu(event_wait64, primary,
-		    (struct cobalt_event_shadow __user *u_event,
-		     unsigned int bits,
-		     unsigned int __user *u_bits_r,
-		     int mode, const struct __kernel_timespec __user *u_ts))
-{
-	return __cobalt_event_wait64(u_event, bits, u_bits_r, mode, u_ts);
-}
-
 COBALT_SYSCALL32emu(select, primary,
 		    (int nfds,
 		     compat_fd_set __user *u_rfds,
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 973a0befc..c96fa1379 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -201,13 +201,6 @@ COBALT_SYSCALL32emu_DECL(event_wait,
 			  unsigned int __user *u_bits_r,
 			  int mode, const struct old_timespec32 __user *u_ts));
 
-COBALT_SYSCALL32emu_DECL(event_wait64,
-			 (struct cobalt_event_shadow __user *u_event,
-			  unsigned int bits,
-			  unsigned int __user *u_bits_r,
-			  int mode,
-			  const struct __kernel_timespec __user *u_ts));
-
 COBALT_SYSCALL32emu_DECL(select,
 			 (int nfds,
 			  compat_fd_set __user *u_rfds,

-- 
2.39.2

