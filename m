Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA4A5386
	for <xenomai@lists.linux.dev>; Fri,  5 May 2023 07:31:13 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202305050721029aef1919696da74199
        for <xenomai@lists.linux.dev>;
        Fri, 05 May 2023 09:21:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=9X4U9RIFBeNiUA3gNHP03qcq+WnhH0d6jXbmQeYOk4Q=;
 b=n3MzMBibdQx0y1imUB7m631+VIJB552Mh0zUzG9XTgvZSHTw4ErvwcaeMMrRRqpy7OBcFL
 r2QAFv09JTRHTVilzHNUMcN9H65Ltvw8YFqetclWRXcXMs2KRrSAUyQqZ8T2OfN+oD7PvEhw
 NC98vPWfxFQ9Dun++wxg/bdjiu+WA=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 05 May 2023 09:21:04 +0200
Subject: [PATCH 09/17] y2038: cobalt: posix/monitor: Remove compat syscall
 for monitor_wait64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230428-florian-y2038-part-one-v1-9-64a972ff2189@siemens.com>
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
 kernel/cobalt/posix/monitor.c   | 26 +++++++++-----------------
 kernel/cobalt/posix/monitor.h   |  5 -----
 kernel/cobalt/posix/syscall32.c |  8 --------
 kernel/cobalt/posix/syscall32.h |  6 ------
 4 files changed, 9 insertions(+), 36 deletions(-)

diff --git a/kernel/cobalt/posix/monitor.c b/kernel/cobalt/posix/monitor.c
index 1e7128352..c266b8b3b 100644
--- a/kernel/cobalt/posix/monitor.c
+++ b/kernel/cobalt/posix/monitor.c
@@ -294,17 +294,17 @@ out:
 	return ret;
 }
 
-int __cobalt_monitor_wait64(struct cobalt_monitor_shadow __user *u_mon,
-			    int event,
-			    const struct __kernel_timespec __user *u_ts,
-			    int __user *u_ret)
+COBALT_SYSCALL(monitor_wait, nonrestartable,
+	       (struct cobalt_monitor_shadow __user *u_mon,
+	       int event, const struct __user_old_timespec __user *u_ts,
+	       int __user *u_ret))
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
@@ -312,17 +312,16 @@ int __cobalt_monitor_wait64(struct cobalt_monitor_shadow __user *u_mon,
 	return __cobalt_monitor_wait(u_mon, event, tsp, u_ret);
 }
 
-COBALT_SYSCALL(monitor_wait, nonrestartable,
-	       (struct cobalt_monitor_shadow __user *u_mon,
-	       int event, const struct __user_old_timespec __user *u_ts,
-	       int __user *u_ret))
+COBALT_SYSCALL(monitor_wait64, nonrestartable,
+	       (struct cobalt_monitor_shadow __user *u_mon, int event,
+		const struct __kernel_timespec __user *u_ts, int __user *u_ret))
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
@@ -330,13 +329,6 @@ COBALT_SYSCALL(monitor_wait, nonrestartable,
 	return __cobalt_monitor_wait(u_mon, event, tsp, u_ret);
 }
 
-COBALT_SYSCALL(monitor_wait64, nonrestartable,
-	       (struct cobalt_monitor_shadow __user *u_mon, int event,
-		const struct __kernel_timespec __user *u_ts, int __user *u_ret))
-{
-	return __cobalt_monitor_wait64(u_mon, event, u_ts, u_ret);
-}
-
 COBALT_SYSCALL(monitor_sync, nonrestartable,
 	       (struct cobalt_monitor_shadow __user *u_mon))
 {
diff --git a/kernel/cobalt/posix/monitor.h b/kernel/cobalt/posix/monitor.h
index bf8794e36..3c76a036b 100644
--- a/kernel/cobalt/posix/monitor.h
+++ b/kernel/cobalt/posix/monitor.h
@@ -42,11 +42,6 @@ int __cobalt_monitor_wait(struct cobalt_monitor_shadow __user *u_mon,
 			  int event, const struct timespec64 *ts,
 			  int __user *u_ret);
 
-int __cobalt_monitor_wait64(struct cobalt_monitor_shadow __user *u_mon,
-			    int event,
-			    const struct __kernel_timespec __user *u_ts,
-			    int __user *u_ret);
-
 COBALT_SYSCALL_DECL(monitor_init,
 		    (struct cobalt_monitor_shadow __user *u_monsh,
 		     clockid_t clk_id,
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 0197c749b..dfa4d31ec 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -733,14 +733,6 @@ COBALT_SYSCALL32emu(monitor_wait, nonrestartable,
 	return __cobalt_monitor_wait(u_mon, event, tsp, u_ret);
 }
 
-COBALT_SYSCALL32emu(monitor_wait64, nonrestartable,
-		    (struct cobalt_monitor_shadow __user *u_mon, int event,
-		     const struct __kernel_timespec __user *u_ts,
-		     int __user *u_ret))
-{
-	return __cobalt_monitor_wait64(u_mon, event, u_ts, u_ret);
-}
-
 COBALT_SYSCALL32emu(event_wait, primary,
 		    (struct cobalt_event_shadow __user *u_event,
 		     unsigned int bits,
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index 5569af7d8..973a0befc 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -195,12 +195,6 @@ COBALT_SYSCALL32emu_DECL(monitor_wait,
 			  int event, const struct old_timespec32 __user *u_ts,
 			  int __user *u_ret));
 
-COBALT_SYSCALL32emu_DECL(monitor_wait64,
-			 (struct cobalt_monitor_shadow __user *u_mon,
-			  int event,
-			  const struct __kernel_timespec __user *u_ts,
-			  int __user *u_ret));
-
 COBALT_SYSCALL32emu_DECL(event_wait,
 			 (struct cobalt_event_shadow __user *u_event,
 			  unsigned int bits,

-- 
2.39.2

