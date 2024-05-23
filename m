Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C0C4685
	for <xenomai@lists.linux.dev>; Thu, 23 May 2024 03:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716436223; cv=none; b=boXVi345KS2375O2KWEn0H+FtWkRggezh0tUg5uLfrjt/BO4PzSKif2muiTbrVGllD5h3rmR4Sz+F6mcNmtNdly539vyL/sZNNTCmGKv0SVUzlcCeP1oNynkTh4kW6oWdkkXKAWTK7cxMEgLJGV/t4qILMXeWop+2ZiM09TDe3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716436223; c=relaxed/simple;
	bh=Sc5xYF8iTV64XLoM+duTcaeodyHCu6WdmVgvtyFxgdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=noaslxjZfp+zlcQ+4lCj+2yrchcmgIrNQZVhXIu/pLmqaiVtOhyzW0OVOcn/m7/wLZ0HV/IitqQbDzpiAES/uED/QPCucelj/WZQy3KtDibVDzF3odiNBjhyMueYxMFPkm9RMSj1yvwqJydw5XHK2UA+bYEdjyEVbKXt/9YiurQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jdU3lm1b; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jdU3lm1b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1Z0iO
	B9UV6KxtLSIE8tuPHen/HqzyE6WkEg+75JiGLQ=; b=jdU3lm1bvP1+xGhs8IyZW
	pO/FTT4mDmbElLaHVPYfo8LdGn8qOxVAGWtYvI+WZKJo6FGE55+trPQJhud80Vlb
	1pn8mEtyaK6UiwsmkEjJ0glpiY8f55WJZj/qpxE0fzJ3iG8c9IezsVjskQpTK8d0
	RyzR0YHA6OLbxzFclmyD+g=
Received: from 2956c958a175.. (unknown [106.39.130.120])
	by gzga-smtp-mta-g3-4 (Coremail) with SMTP id _____wD3n2PzvE5m9YZGBA--.55673S2;
	Thu, 23 May 2024 11:50:12 +0800 (CST)
From: JiajunDu <wonderboy512@163.com>
To: rpm@xenomai.org
Cc: wonderboy512@163.com,
	xenomai@lists.linux.dev
Subject: [PATCH] test: smp: achieve parallelism by using barriers to synchronize processes
Date: Thu, 23 May 2024 03:50:05 +0000
Message-Id: <20240523035005.2243857-1-wonderboy512@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87ed9urpex.fsf@xenomai.org>
References: <87ed9urpex.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n2PzvE5m9YZGBA--.55673S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF1fuF45ZFWfAw18KrWxWFg_yoW5uFy8pr
	W8CrW5tF48Ar9Iy3yfJ3Z3JF43tw48Wa47ZF9xC34FvF1UJw4UA3sYqFWDZFyrArs3Cr43
	tFyvyFZxKwsrJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU7rc-UUUUU=
X-CM-SenderInfo: xzrqvv5uer5kirs6il2tof0z/1tbizRjnG2V4HUdnpQAAss

https://lore.kernel.org/xenomai/87ed9urpex.fsf@xenomai.org/T/#t
Signed-off-by: JiajunDu <wonderboy512@163.com>
---
 include/evl/flag.h  | 13 +++++++++++++
 kernel/evl/init.c   | 43 +++++++++++++++++++++++++++++++++++++++++++
 kernel/evl/thread.c |  2 ++
 3 files changed, 58 insertions(+)

diff --git a/include/evl/flag.h b/include/evl/flag.h
index 230367752e48..8aaae336926c 100644
--- a/include/evl/flag.h
+++ b/include/evl/flag.h
@@ -69,6 +69,19 @@ static inline int evl_wait_flag(struct evl_flag *wf)
 	return evl_wait_flag_timeout(wf, EVL_INFINITE, EVL_REL);
 }
 
+static inline
+int evl_wait_flag_timeout_same(struct evl_flag *wf,
+			ktime_t timeout, enum evl_tmode timeout_mode)
+{
+	return evl_wait_event_timeout(&wf->wait, timeout,
+				timeout_mode, evl_peek_flag(wf));
+}
+
+static inline int evl_wait_flag_same(struct evl_flag *wf)
+{
+	return evl_wait_flag_timeout_same(wf, EVL_INFINITE, EVL_REL);
+}
+
 /* wf->wait.lock held, irqs off */
 static inline struct evl_thread *evl_wait_flag_head(struct evl_flag *wf)
 {
diff --git a/kernel/evl/init.c b/kernel/evl/init.c
index 247e79568f2d..911ae2dbf96b 100644
--- a/kernel/evl/init.c
+++ b/kernel/evl/init.c
@@ -18,6 +18,7 @@
 #include <evl/net.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/evl.h>
+#include <evl/flag.h>
 
 static char *oobcpus_arg;
 module_param_named(oobcpus, oobcpus_arg, charp, 0444);
@@ -81,6 +82,36 @@ void __init evl_warn_init(const char *fn, int level, int status)
 
 #endif
 
+DEFINE_EVL_FLAG(smp_flag);
+
+#define declare_fibo(i) static void smp_kfn##i(void *arg)					\
+{																			\
+	evl_wait_flag_same(&smp_flag);											\
+	int mod = 1000000007, first = 1, second = 1, j;							\
+	for(j = 0; j < 2000000000; j++) {										\
+		int temp = (first + second) % mod;									\
+		first = second;														\
+		second = temp;														\
+	}																		\
+	printk(EVL_INFO "[DJJ] calculation of thread %d is %d\n", i, second);	\
+}
+
+#define run_fibo(i) struct evl_kthread *thread##i; 							\
+thread##i = evl_alloc(sizeof(*thread##i));									\
+if (thread##i == NULL) {													\
+	printk(EVL_INFO "[DJJ] error%d\n", i);									\
+	return -ENOMEM;															\
+}																			\
+evl_run_kthread_on_cpu(thread##i, i, smp_kfn##i, NULL, 98, 0, "[DJJ] kfn%d", i);
+
+declare_fibo(0);
+declare_fibo(1);
+declare_fibo(2);
+declare_fibo(3);
+declare_fibo(4);
+declare_fibo(5);
+declare_fibo(6);
+
 static __init int init_core(void)
 {
 	int ret;
@@ -135,6 +166,18 @@ static __init int init_core(void)
 	if (ret)
 		goto cleanup_late_factories;
 
+	printk(EVL_INFO "[DJJ] hello world!\n");
+
+	run_fibo(0);
+	run_fibo(1);
+	run_fibo(2);
+	run_fibo(3);
+	run_fibo(4);
+	run_fibo(5);
+	run_fibo(6);
+	printk(EVL_INFO "[DJJ] raise flag\n");
+	evl_raise_flag(&smp_flag);
+
 	return 0;
 
 cleanup_late_factories:
diff --git a/kernel/evl/thread.c b/kernel/evl/thread.c
index 4d176c157743..c02fc337b113 100644
--- a/kernel/evl/thread.c
+++ b/kernel/evl/thread.c
@@ -145,6 +145,8 @@ static void pin_to_initial_cpu(struct evl_thread *thread)
 	if (!cpumask_test_cpu(cpu, &thread->affinity))
 		cpu = cpumask_first(&thread->affinity);
 
+	printk(EVL_INFO "thread name is %s, cpu is %d\n", thread->name, cpu);
+
 	set_cpus_allowed_ptr(p, cpumask_of(cpu));
 	/*
 	 * @thread is still unstarted EVL-wise, we are in the process
-- 
2.34.1

