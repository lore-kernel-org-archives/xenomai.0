Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA94423161
	for <xenomai@lists.linux.dev>; Wed,  4 Feb 2026 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770228634; cv=none; b=VuLrxZRx2MANJVSgRYgCTo2ehOSk0+SPNWSotYOPA8PPxDOGeusp/8PEeSz8BdZ83fErbXi2XCpOgXpnHy8jQ8SCXXRL/R6uHbZSOCT+D4HVz1uvLgeXqzjmN9v0Rak0AkKrl59440ysGt9UOHtuOhDe+Pn2gwgN3OAE9BlyRIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770228634; c=relaxed/simple;
	bh=98ZkRNR3Cs792CJJ3uqfsHIiBjOz1XDiDtqv7Yt8clE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J25FBVGT6bDJwcpKlhKu/EbS+/xIv+NEAsH1b5oyrZ86cuUXWstGjsmMNsxxBGhtISINM6ElYMjgxrvNsLnyk038KXJWNva+wIWsPGGCHnk2hnZr0EWZA7yzp1aA8He9NM417O5Kz9cYxfflJ4bEpQZdKrWGhD2d13ROYjFSIqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=RYQK7EH7; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="RYQK7EH7"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260204181025c4fd53963c000207fd
        for <xenomai@lists.linux.dev>;
        Wed, 04 Feb 2026 19:10:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=aMnQlU3cHfkh53/BoMc040vyAo95mOBHVd/4+R4mECE=;
 b=RYQK7EH7VN/h6cNHuDCKq3O8VXUgmw0BHdRFYE1A/U1jv1qgyVXQF7L6hSIXLI2R0gQXR/
 tJs1FhwbQSRmyw3nSW0yWC3UiB6yv/QM0/AyKKU/I27nrbcg0uLBiZtd8B2a874KuEeKb68M
 e6mZfMTs+uPRVCksmV8ajTI+0IQ1iLcajzCaKbtxLVkrvSIr6Mt3k0/3GngzYHqMdm0UT2aM
 mpkxqSELPI6l9WaWTk5UXIa69E4DJu/kIjBbZgCcHPSNDQfbODKRBEocgthJcToTSYL6f+S1
 ynZBeThbskKUGJLNnQHd2gOY2EWAkYO998Y811KsQNyw5Bs0jro+Lt4Q==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>
Subject: [PATCH 3/3] cobalt: Eliminate xnthread_host_pid wrapper
Date: Wed,  4 Feb 2026 19:10:24 +0100
Message-ID: <17c4af4566be4e6313036251e2c2973348537393.1770228624.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1770228624.git.jan.kiszka@siemens.com>
References: <cover.1770228624.git.jan.kiszka@siemens.com>
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

There is no value in this wrapper anymore, just access the new field
directly.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/thread.h    |  5 -----
 kernel/cobalt/debug.c             |  2 +-
 kernel/cobalt/dovetail/kevents.c  |  4 ++--
 kernel/cobalt/posix/event.c       |  2 +-
 kernel/cobalt/posix/process.c     |  5 ++---
 kernel/cobalt/posix/sem.c         |  2 +-
 kernel/cobalt/posix/thread.c      |  2 +-
 kernel/cobalt/posix/timer.c       |  2 +-
 kernel/cobalt/sched-quota.c       |  2 +-
 kernel/cobalt/sched-rt.c          |  2 +-
 kernel/cobalt/sched-sporadic.c    |  2 +-
 kernel/cobalt/sched-tp.c          |  2 +-
 kernel/cobalt/sched-weak.c        |  2 +-
 kernel/cobalt/sched.c             |  4 ++--
 kernel/cobalt/thread.c            |  9 ++++-----
 kernel/cobalt/trace/cobalt-core.h | 18 +++++++++---------
 16 files changed, 29 insertions(+), 36 deletions(-)

diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
index 5ff3e541d3..0bd4e29301 100644
--- a/include/cobalt/kernel/thread.h
+++ b/include/cobalt/kernel/thread.h
@@ -455,11 +455,6 @@ void xnthread_deregister(struct xnthread *thread);
 char *xnthread_format_status(unsigned long status,
 			     char *buf, int size);
 
-static inline pid_t xnthread_host_pid(struct xnthread *thread)
-{
-	return thread->host_pid;
-}
-
 int xnthread_set_clock(struct xnthread *thread,
 		       struct xnclock *newclock);
 
diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c
index 3c7696e5ad..046f28c26d 100644
--- a/kernel/cobalt/debug.c
+++ b/kernel/cobalt/debug.c
@@ -296,7 +296,7 @@ void xndebug_trace_relax(int nr, unsigned long *backtrace,
 	 */
 	spot.depth = depth;
 	spot.proghash = thread->proghash;
-	spot.pid = xnthread_host_pid(thread);
+	spot.pid = thread->host_pid;
 	spot.reason = reason;
 	strcpy(spot.thread, thread->name);
 	hash = jhash2((u32 *)&spot, sizeof(spot) / sizeof(u32), 0);
diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
index 9fa75faa1c..f31f315d19 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
@@ -70,14 +70,14 @@ void handle_oob_trap_entry(unsigned int trapnr, struct pt_regs *regs)
 		       "kernel-space at %pS (pid %d)\n", thread->name,
 		       trapnr,
 		       (void *)xnarch_fault_pc(regs),
-		       xnthread_host_pid(thread));
+		       thread->host_pid);
 	} else if (xnarch_fault_notify(trapnr)) /* Don't report debug traps */
 		printk(XENO_WARNING
 		       "switching %s to secondary mode after exception #%u from "
 		       "user-space at 0x%lx (pid %d)\n", thread->name,
 		       trapnr,
 		       xnarch_fault_pc(regs),
-		       xnthread_host_pid(thread));
+		       thread->host_pid);
 #endif
 
 	if (xnarch_fault_pf_p(trapnr))
diff --git a/kernel/cobalt/posix/event.c b/kernel/cobalt/posix/event.c
index 4e98950047..bf2dd6c7e9 100644
--- a/kernel/cobalt/posix/event.c
+++ b/kernel/cobalt/posix/event.c
@@ -372,7 +372,7 @@ COBALT_SYSCALL(event_inquire, current,
 		xnsynch_for_each_sleeper(thread, &event->synch) {
 			if (nrwait >= nrpids)
 				break;
-			t[nrwait++] = xnthread_host_pid(thread);
+			t[nrwait++] = thread->host_pid;
 		}
 	}
 
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index f7cf97c398..854e3a6657 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -656,8 +656,7 @@ int cobalt_map_user(struct xnthread *thread, __u32 __user *u_winoff)
 
 	xnthread_sync_window(thread);
 
-	xntrace_pid(xnthread_host_pid(thread),
-		    xnthread_current_priority(thread));
+	xntrace_pid(thread->host_pid, xnthread_current_priority(thread));
 
 	return 0;
 }
@@ -809,7 +808,7 @@ void cobalt_adjust_affinity(struct task_struct *task) /* nklocked, IRQs off */
 		 * Whine and cancel that thread.
 		 */
 		printk(XENO_WARNING "thread %s[%d] switched to non-rt CPU%d, aborted.\n",
-		       thread->name, xnthread_host_pid(thread), cpu);
+		       thread->name, thread->host_pid, cpu);
 		/*
 		 * Can't call xnthread_cancel() from a migration
 		 * point, that would break. Since we are on the wakeup
diff --git a/kernel/cobalt/posix/sem.c b/kernel/cobalt/posix/sem.c
index e53bcad9b3..44aeb26dd0 100644
--- a/kernel/cobalt/posix/sem.c
+++ b/kernel/cobalt/posix/sem.c
@@ -629,7 +629,7 @@ COBALT_SYSCALL(sem_inquire, current,
 		xnsynch_for_each_sleeper(thread, &sem->synchbase) {
 			if (nrwait >= nrpids)
 				break;
-			t[nrwait++] = xnthread_host_pid(thread);
+			t[nrwait++] = thread->host_pid;
 		}
 	}
 
diff --git a/kernel/cobalt/posix/thread.c b/kernel/cobalt/posix/thread.c
index 46c3f47976..989b948c02 100644
--- a/kernel/cobalt/posix/thread.c
+++ b/kernel/cobalt/posix/thread.c
@@ -820,7 +820,7 @@ COBALT_SYSCALL(thread_getpid, current, (unsigned long pth))
 	if (thread == NULL)
 		pid = -ESRCH;
 	else
-		pid = xnthread_host_pid(&thread->threadbase);
+		pid = thread->threadbase.host_pid;
 
 	xnlock_put_irqrestore(&nklock, s);
 
diff --git a/kernel/cobalt/posix/timer.c b/kernel/cobalt/posix/timer.c
index 3107698ca6..b284fa809f 100644
--- a/kernel/cobalt/posix/timer.c
+++ b/kernel/cobalt/posix/timer.c
@@ -184,7 +184,7 @@ static int cobalt_timer_create_internal(clockid_t clockid,
 		goto fail;
 	}
 
-	timer->target = xnthread_host_pid(&target->threadbase);
+	timer->target = target->threadbase.host_pid;
 	cc->timers[timer_id] = timer;
 
 	xnlock_put_irqrestore(&nklock, s);
diff --git a/kernel/cobalt/sched-quota.c b/kernel/cobalt/sched-quota.c
index 4c3383b5f6..f821f54bdb 100644
--- a/kernel/cobalt/sched-quota.c
+++ b/kernel/cobalt/sched-quota.c
@@ -749,7 +749,7 @@ static int vfile_sched_quota_next(struct xnvfile_snapshot_iterator *it,
 		return VFILE_SEQ_SKIP;
 
 	p->cpu = xnsched_cpu(thread->sched);
-	p->pid = xnthread_host_pid(thread);
+	p->pid = thread->host_pid;
 	memcpy(p->name, thread->name, sizeof(p->name));
 	p->tgid = thread->quota->tgid;
 	p->prio = thread->cprio;
diff --git a/kernel/cobalt/sched-rt.c b/kernel/cobalt/sched-rt.c
index 24570322a0..a8e836fb1a 100644
--- a/kernel/cobalt/sched-rt.c
+++ b/kernel/cobalt/sched-rt.c
@@ -173,7 +173,7 @@ static int vfile_sched_rt_next(struct xnvfile_snapshot_iterator *it,
 		return VFILE_SEQ_SKIP;
 
 	p->cpu = xnsched_cpu(thread->sched);
-	p->pid = xnthread_host_pid(thread);
+	p->pid = thread->host_pid;
 	memcpy(p->name, thread->name, sizeof(p->name));
 	p->cprio = thread->cprio;
 	p->period = xnthread_get_period(thread);
diff --git a/kernel/cobalt/sched-sporadic.c b/kernel/cobalt/sched-sporadic.c
index 77f1d00fd8..bec8dcb533 100644
--- a/kernel/cobalt/sched-sporadic.c
+++ b/kernel/cobalt/sched-sporadic.c
@@ -458,7 +458,7 @@ static int vfile_sched_sporadic_next(struct xnvfile_snapshot_iterator *it,
 		return VFILE_SEQ_SKIP;
 
 	p->cpu = xnsched_cpu(thread->sched);
-	p->pid = xnthread_host_pid(thread);
+	p->pid = thread->host_pid;
 	memcpy(p->name, thread->name, sizeof(p->name));
 	p->current_prio = thread->cprio;
 	p->low_prio = thread->pss->param.low_prio;
diff --git a/kernel/cobalt/sched-tp.c b/kernel/cobalt/sched-tp.c
index ccff374284..1bfa3ac984 100644
--- a/kernel/cobalt/sched-tp.c
+++ b/kernel/cobalt/sched-tp.c
@@ -382,7 +382,7 @@ static int vfile_sched_tp_next(struct xnvfile_snapshot_iterator *it,
 		return VFILE_SEQ_SKIP;
 
 	p->cpu = xnsched_cpu(thread->sched);
-	p->pid = xnthread_host_pid(thread);
+	p->pid = thread->host_pid;
 	memcpy(p->name, thread->name, sizeof(p->name));
 	p->ptid = thread->tps - thread->sched->tp.partitions;
 	p->prio = thread->cprio;
diff --git a/kernel/cobalt/sched-weak.c b/kernel/cobalt/sched-weak.c
index dd6a78e636..b49c882111 100644
--- a/kernel/cobalt/sched-weak.c
+++ b/kernel/cobalt/sched-weak.c
@@ -143,7 +143,7 @@ static int vfile_sched_weak_next(struct xnvfile_snapshot_iterator *it,
 		return VFILE_SEQ_SKIP;
 
 	p->cpu = xnsched_cpu(thread->sched);
-	p->pid = xnthread_host_pid(thread);
+	p->pid = thread->host_pid;
 	memcpy(p->name, thread->name, sizeof(p->name));
 	p->cprio = thread->cprio;
 
diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
index f1c799bbaa..ed99ddd0a2 100644
--- a/kernel/cobalt/sched.c
+++ b/kernel/cobalt/sched.c
@@ -1037,7 +1037,7 @@ static int vfile_schedlist_next(struct xnvfile_snapshot_iterator *it,
 		priv->curr = list_next_entry(thread, glink);
 
 	p->cpu = xnsched_cpu(thread->sched);
-	p->pid = xnthread_host_pid(thread);
+	p->pid = thread->host_pid;
 	memcpy(p->name, thread->name, sizeof(p->name));
 	p->cprio = thread->cprio;
 	p->state = xnthread_get_state(thread);
@@ -1197,7 +1197,7 @@ static int vfile_schedstat_next(struct xnvfile_snapshot_iterator *it,
 
 	sched = thread->sched;
 	p->cpu = xnsched_cpu(sched);
-	p->pid = xnthread_host_pid(thread);
+	p->pid = thread->host_pid;
 	memcpy(p->name, thread->name, sizeof(p->name));
 	p->state = xnthread_get_state(thread);
 	if (thread->lock_count > 0)
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 441d36a15d..60a7112844 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -167,8 +167,7 @@ static int map_kthread(struct xnthread *thread, struct kthread_arg *ka)
 
 	xnthread_test_cancel();
 
-	xntrace_pid(xnthread_host_pid(thread),
-		    xnthread_current_priority(thread));
+	xntrace_pid(thread->host_pid, xnthread_current_priority(thread));
 
 	return ret;
 }
@@ -1092,7 +1091,7 @@ void xnthread_resume(struct xnthread *thread, int mask)
 
 	trace_cobalt_thread_resume(thread, mask);
 
-	xntrace_pid(xnthread_host_pid(thread), xnthread_current_priority(thread));
+	xntrace_pid(thread->host_pid, xnthread_current_priority(thread));
 
 	sched = thread->sched;
 	oldstate = thread->state;
@@ -2066,7 +2065,7 @@ void xnthread_relax(int notify, int reason)
 	 */
 	XENO_WARN(COBALT, is_primary_domain(),
 		  "xnthread_relax() failed for thread %s[%d]",
-		  thread->name, xnthread_host_pid(thread));
+		  thread->name, thread->host_pid);
 
 	pipeline_leave_oob_finish();
 
@@ -2447,7 +2446,7 @@ int xnthread_killall(int grace, int mask)
 
 		if (XENO_DEBUG(COBALT))
 			printk(XENO_INFO "terminating %s[%d]\n",
-			       t->name, xnthread_host_pid(t));
+			       t->name, t->host_pid);
 		nrkilled++;
 		xnthread_cancel(t);
 	}
diff --git a/kernel/cobalt/trace/cobalt-core.h b/kernel/cobalt/trace/cobalt-core.h
index 645d3e3ad4..f534121cb3 100644
--- a/kernel/cobalt/trace/cobalt-core.h
+++ b/kernel/cobalt/trace/cobalt-core.h
@@ -49,7 +49,7 @@ DECLARE_EVENT_CLASS(thread_event,
 	TP_fast_assign(
 		__entry->state = thread->state;
 		__entry->info = thread->info;
-		__entry->pid = xnthread_host_pid(thread);
+		__entry->pid = thread->host_pid;
 	),
 
 	TP_printk("pid=%d state=0x%lx info=0x%lx",
@@ -216,12 +216,12 @@ TRACE_EVENT(cobalt_switch_context,
 	TP_fast_assign(
 		__entry->prev = prev;
 		__wrap_assign_str(prev_name, prev->name);
-		__entry->prev_pid = xnthread_host_pid(prev);
+		__entry->prev_pid = prev->host_pid;
 		__entry->prev_prio = xnthread_current_priority(prev);
 		__entry->prev_state = prev->state;
 		__entry->next = next;
 		__wrap_assign_str(next_name, next->name);
-		__entry->next_pid = xnthread_host_pid(next);
+		__entry->next_pid = next->host_pid;
 		__entry->next_prio = xnthread_current_priority(next);
 	),
 
@@ -310,7 +310,7 @@ DECLARE_EVENT_CLASS(schedquota_thread_event,
 	TP_fast_assign(
 		__entry->tgid = tg->tgid;
 		__entry->thread = thread;
-		__entry->pid = xnthread_host_pid(thread);
+		__entry->pid = thread->host_pid;
 	),
 
 	TP_printk("tgid=%d thread=%p pid=%d",
@@ -372,7 +372,7 @@ TRACE_EVENT(cobalt_thread_suspend,
 	),
 
 	TP_fast_assign(
-		__entry->pid = xnthread_host_pid(thread);
+		__entry->pid = thread->host_pid;
 		__entry->mask = mask;
 		__entry->timeout = timeout;
 		__entry->timeout_mode = timeout_mode;
@@ -396,7 +396,7 @@ TRACE_EVENT(cobalt_thread_resume,
 
 	TP_fast_assign(
 		__wrap_assign_str(name, thread->name);
-		__entry->pid = xnthread_host_pid(thread);
+		__entry->pid = thread->host_pid;
 		__entry->mask = mask;
 	),
 
@@ -434,7 +434,7 @@ TRACE_EVENT(cobalt_thread_set_current_prio,
 
 	TP_fast_assign(
 		__entry->thread = thread;
-		__entry->pid = xnthread_host_pid(thread);
+		__entry->pid = thread->host_pid;
 		__entry->cprio = xnthread_current_priority(thread);
 	),
 
@@ -504,7 +504,7 @@ TRACE_EVENT(cobalt_thread_migrate_passive,
 
 	TP_fast_assign(
 		__entry->thread = thread;
-		__entry->pid = xnthread_host_pid(thread);
+		__entry->pid = thread->host_pid;
 		__entry->cpu = cpu;
 	),
 
@@ -571,7 +571,7 @@ TRACE_EVENT(cobalt_shadow_map,
 
 	TP_fast_assign(
 		__entry->thread = thread;
-		__entry->pid = xnthread_host_pid(thread);
+		__entry->pid = thread->host_pid;
 		__entry->prio = xnthread_base_priority(thread);
 	),
 
-- 
2.51.0

