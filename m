Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642472;
	b=mIT0uuy1q7C2Hqr64khQAAaLe02GAy8/Y3lXFRQrJUuvhsL5gq8tiRauAsJ5L6qyIq8p
	 YJD9BjDMbrb1lnt2rj7sjzrgLQEehsaqjun4qxkc9YVn4CuH+Zc2/aMUk+ky1fSOkBGbZ
	 nk+phKeNyQLScXzmLlA+kfcZqdCuYHph2wpldVxlHnc8o8hxkZZl2wWUBs3ZB1NOGqRiX
	 qelEAp7T0FoTF2O2/kCD5636/feuNsdGL1pMCYN2eiDtnoXFQ9D7o/26DztBW6VlUArg0
	 mywIvDF/p7SwYoPD/j89HW2a1IJFrN5tAVMsRzK1kleRAKGUuV1KFiRkbbr7oIMs4Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642472;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Pb88kE+kGeuoFDj/6pGOnlcvEJgVncNsp0VKmCqGSiU=;
	b=XAMhtrA4RS5Ac5gV2biD91yu26U7K4jketwqddmEWc+eWSRReyX4EeddBZ23tipOpt5r
	 LglGOvgDWS0zD5rY3dBvjNfhPRFR2kRSd75Jy+JXIkQjTW6DXKm9hNPEBHW1asU6bitUW
	 HyzO1eI5By7QdJwKgVnhYJ9qvaxtsfFKlxy5PSpMFgUkH3bk70ebhryTNFiBD4sO0Fnjt
	 4d3A2VwR76IvuIduH7XQ4RhRORAmS6aivSgzAE2Hq1SB2alc4jO6vuaCvWcC6Fz/8Vz83
	 oIAVHOwFuF6JSQJk++bDewXEua5tp2slSJq8ZiTFyFVzr5zX+JCoVE1+K1dfQSDvUxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0aOylF5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51234606A32D
	for <xenomai@lists.linux.dev>; Wed, 25 Nov 2026 21:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0aOylF5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A411F000D3;
	Wed, 25 Nov 2026 21:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642471;
	bh=Pb88kE+kGeuoFDj/6pGOnlcvEJgVncNsp0VKmCqGSiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K0aOylF5gNkaOF+o6oy36CFPNcA43TwgOin38ACCadgSw/Bqgo5ZuLbEil+Ijn9SA
	 eDtigIKu9WKY0/ZPj+5tSqpVNtRnb4uoxBlnsm9MS7h+5eIEW8Fk782ZyCE+aWCqgo
	 bhL3ebfjw4aNGfm/ShmeaL4F7F4/R3RfEwbOn2syJL4SsugB5sd3ypPatkmrse3gga
	 0iK0uPTJAFpyWIAd9DzYnPnHIUlxKsnoXVfqrdSe6dhEuSwDYPcSUFCpbLeamA9jJQ
	 huwkW5Hj89RM+sZht45fdgt8Vgi2jkiTLC7iaK0s5Gb78IpUob82YgpQlujM+Ep8dO
	 6Ea1CUkp2rEpg==
From: "Richard Weinberger (sigma star gmbh)" <rw@kernel.org>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 3/7] lib/alchemy: Document the actual calling context requirements
Date: Wed, 25 Nov 2026 22:34:15 +0100
Message-ID: <20261125213419.2363742-4-rw@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125213419.2363742-1-rw@kernel.org>
References: <20261125213419.2363742-1-rw@kernel.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Weinberger <richard@nod.at>

Many services document -EPERM for callers which are not "Xenomai
threads", but actually require a Copperplate TCB (Alchemy, pSOS or
VxWorks task, or the main thread), or even an Alchemy task. Cobalt
POSIX threads are Xenomai threads, yet refused.

Introduce the term "Xenomai task" in the glossary and document the
requirement which is actually enforced. Also fix a few wrong errno
values, API tags and copy&paste errors along the way.

No functional change.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 lib/alchemy/alarm.c    |  9 -----
 lib/alchemy/buffer.c   | 11 +++---
 lib/alchemy/cond.c     |  3 +-
 lib/alchemy/event.c    |  9 +++--
 lib/alchemy/heap.c     |  7 ++--
 lib/alchemy/mutex.c    |  3 +-
 lib/alchemy/pipe.c     | 11 +++---
 lib/alchemy/queue.c    | 11 +++---
 lib/alchemy/sem.c      |  3 +-
 lib/alchemy/task.c     | 78 ++++++++++++++++++++++--------------------
 lib/copperplate/init.c | 10 ++++++
 11 files changed, 85 insertions(+), 70 deletions(-)

diff --git a/lib/alchemy/alarm.c b/lib/alchemy/alarm.c
index 14cb4e248..9d5171175 100644
--- a/lib/alchemy/alarm.c
+++ b/lib/alchemy/alarm.c
@@ -155,9 +155,6 @@ static void alarm_handler(struct timerobj *tmobj)
  * - -EEXIST is returned if the @a name is conflicting with an already
  * registered alarm.
  *
- * - -EPERM is returned if this service was called from an
- * asynchronous context.
- *
  * @apitags{mode-unrestricted, switch-secondary}
  *
  * @note Alarms are process-private objects and thus cannot be shared
@@ -237,9 +234,6 @@ out:
  *
  * - -EINVAL is returned if @a alarm is not a valid alarm descriptor.
  *
- * - -EPERM is returned if this service was called from an
- * asynchronous context.
- *
  * @apitags{mode-unrestricted, switch-secondary}
  */
 #ifndef DOXYGEN_CPP
@@ -298,9 +292,6 @@ out:
  *
  * - -EINVAL is returned if @a alarm is not a valid alarm descriptor.
  *
- * - -EPERM is returned if this service was called from an invalid
- * context.
- *
  * @apitags{xthread-only, switch-primary}
  *
  * @note Each of the initial @a value and @a interval is interpreted
diff --git a/lib/alchemy/buffer.c b/lib/alchemy/buffer.c
index b9526304d..4f826fb27 100644
--- a/lib/alchemy/buffer.c
+++ b/lib/alchemy/buffer.c
@@ -424,8 +424,8 @@ out:
  * waiting for data. In such event, @a bf is no more valid upon return
  * of this service.
  *
- * - -EPERM is returned if this service should block, but was not
- * called from a Xenomai thread.
+ * - -EPERM is returned if this service was not called from a Xenomai
+ * task, unless @a abs_timeout is { .tv_sec = 0, .tv_nsec = 0 }.
  *
  * @note A short read (i.e. fewer bytes returned than requested by @a
  * len) may happen whenever a pathological use of the buffer is
@@ -664,8 +664,8 @@ out:
  * waiting for buffer space. In such event, @a bf is no more valid
  * upon return of this service.
  *
- * - -EPERM is returned if this service should block, but was not
- * called from a Xenomai thread.
+ * - -EPERM is returned if this service was not called from a Xenomai
+ * task, unless @a abs_timeout is { .tv_sec = 0, .tv_nsec = 0 }.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
@@ -914,7 +914,8 @@ out:
  * the specified amount of time.
  *
  * - -EPERM is returned if this service should block, but was not
- * called from a Xenomai thread.
+ * called from a Xenomai task. Over Cobalt, this error is also returned
+ * if the caller is not a Xenomai thread, even if it should not block.
  *
  * @apitags{xthread-nowait, switch-primary}
  *
diff --git a/lib/alchemy/cond.c b/lib/alchemy/cond.c
index 4409e3f5b..1a4ccacc3 100644
--- a/lib/alchemy/cond.c
+++ b/lib/alchemy/cond.c
@@ -458,7 +458,8 @@ int rt_cond_inquire(RT_COND *cond, RT_COND_INFO *info)
  * the specified amount of time.
  *
  * - -EPERM is returned if this service should block, but was not
- * called from a Xenomai thread.
+ * called from a Xenomai task. Over Cobalt, this error is also returned
+ * if the caller is not a Xenomai thread, even if it should not block.
  *
  * @apitags{xthread-nowait, switch-primary}
  *
diff --git a/lib/alchemy/event.c b/lib/alchemy/event.c
index 8ba76f333..8428db539 100644
--- a/lib/alchemy/event.c
+++ b/lib/alchemy/event.c
@@ -378,8 +378,10 @@ out:
  * sleeping on it. In such a case, @a event is no more valid upon
  * return of this service.
  *
- * - -EPERM is returned if this service should block, but was not
- * called from a Xenomai thread.
+ * - -EPERM is returned if this service was not called from a Xenomai
+ * task, unless @a abs_timeout is { .tv_sec = 0, .tv_nsec = 0 }. Over
+ * Cobalt, this error is also returned if the caller is not a Xenomai
+ * thread.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
@@ -583,7 +585,8 @@ out:
  * the specified amount of time.
  *
  * - -EPERM is returned if this service should block, but was not
- * called from a Xenomai thread.
+ * called from a Xenomai task. Over Cobalt, this error is also returned
+ * if the caller is not a Xenomai thread, even if it should not block.
  *
  * @apitags{xthread-nowait, switch-primary}
  *
diff --git a/lib/alchemy/heap.c b/lib/alchemy/heap.c
index 140fdc656..fb3424f5f 100644
--- a/lib/alchemy/heap.c
+++ b/lib/alchemy/heap.c
@@ -408,8 +408,8 @@ out:
  * waiting for a block. In such event, @a heap is no more valid upon
  * return of this service.
  *
- * - -EPERM is returned if this service should block, but was not
- * called from a Xenomai thread.
+ * - -EPERM is returned if this service was not called from a Xenomai
+ * task, unless @a abs_timeout is { .tv_sec = 0, .tv_nsec = 0 }.
  *
  * @apitags{xthread-nowait, switch-primary}
  *
@@ -639,7 +639,8 @@ out:
  * the specified amount of time.
  *
  * - -EPERM is returned if this service should block, but was not
- * called from a Xenomai thread.
+ * called from a Xenomai task. Over Cobalt, this error is also returned
+ * if the caller is not a Xenomai thread, even if it should not block.
  *
  * @apitags{xthread-nowait, switch-primary}
  *
diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
index 9609f1fa5..75d7ff3d3 100644
--- a/lib/alchemy/mutex.c
+++ b/lib/alchemy/mutex.c
@@ -499,7 +499,8 @@ out:
  * the specified amount of time.
  *
  * - -EPERM is returned if this service should block, but was not
- * called from a Xenomai thread.
+ * called from a Xenomai task. Over Cobalt, this error is also returned
+ * if the caller is not a Xenomai thread, even if it should not block.
  *
  * @apitags{xthread-nowait, switch-primary}
  *
diff --git a/lib/alchemy/pipe.c b/lib/alchemy/pipe.c
index a266a380f..b5ada2c7d 100644
--- a/lib/alchemy/pipe.c
+++ b/lib/alchemy/pipe.c
@@ -289,7 +289,7 @@ out:
  * @fn ssize_t rt_pipe_read(RT_PIPE *pipe, void *buf, size_t size, RTIME timeout)
  * @brief Read from a pipe (with relative scalar timeout).
  *
- * This routine is a variant of rt_queue_read_timed() accepting a
+ * This routine is a variant of rt_pipe_read_timed() accepting a
  * relative timeout specification expressed as a scalar value.
  *
  * @param pipe The pipe descriptor.
@@ -354,7 +354,7 @@ ssize_t rt_pipe_read(RT_PIPE *pipe,
  * @fn ssize_t rt_pipe_read_until(RT_PIPE *pipe, void *buf, size_t size, RTIME abs_timeout)
  * @brief Read from a pipe (with absolute scalar timeout).
  *
- * This routine is a variant of rt_queue_read_timed() accepting an
+ * This routine is a variant of rt_pipe_read_timed() accepting an
  * absolute timeout specification expressed as a scalar value.
  *
  * @param pipe The pipe descriptor.
@@ -420,8 +420,8 @@ ssize_t rt_pipe_read(RT_PIPE *pipe,
  * waiting for a message. In such event, @a pipe is no more valid upon
  * return of this service.
  *
- * - -EPERM is returned if this service should block, but was not
- * called from a Xenomai thread.
+ * - -EPERM is returned if this service was not called from a Xenomai
+ * task, unless @a abs_timeout is { .tv_sec = 0, .tv_nsec = 0 }.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
@@ -637,7 +637,8 @@ ssize_t rt_pipe_stream(RT_PIPE *pipe,
  * the specified amount of time.
  *
  * - -EPERM is returned if this service should block, but was not
- * called from a Xenomai thread.
+ * called from a Xenomai task. Over Cobalt, this error is also returned
+ * if the caller is not a Xenomai thread, even if it should not block.
  *
  * @apitags{xthread-nowait}
  *
diff --git a/lib/alchemy/queue.c b/lib/alchemy/queue.c
index 0dba63f2b..e91973920 100644
--- a/lib/alchemy/queue.c
+++ b/lib/alchemy/queue.c
@@ -792,8 +792,8 @@ out:
  * waiting for a message. In such event, @a q is no more valid upon
  * return of this service.
  *
- * - -EPERM is returned if this service should block, but was not
- * called from a Xenomai thread.
+ * - -EPERM is returned if this service was not called from a Xenomai
+ * task, unless @a abs_timeout is { .tv_sec = 0, .tv_nsec = 0 }.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
@@ -952,8 +952,8 @@ out:
  * waiting for a message. In such event, @a q is no more valid upon
  * return of this service.
  *
- * - -EPERM is returned if this service should block, but was not
- * called from a Xenomai thread.
+ * - -EPERM is returned if this service was not called from a Xenomai
+ * task, unless @a abs_timeout is { .tv_sec = 0, .tv_nsec = 0 }.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
@@ -1159,7 +1159,8 @@ out:
  * the specified amount of time.
  *
  * - -EPERM is returned if this service should block, but was not
- * called from a Xenomai thread.
+ * called from a Xenomai task. Over Cobalt, this error is also returned
+ * if the caller is not a Xenomai thread, even if it should not block.
  *
  * @apitags{xthread-nowait, switch-primary}
  *
diff --git a/lib/alchemy/sem.c b/lib/alchemy/sem.c
index e88c6e4d6..6a561574c 100644
--- a/lib/alchemy/sem.c
+++ b/lib/alchemy/sem.c
@@ -536,7 +536,8 @@ out:
  * the specified amount of time.
  *
  * - -EPERM is returned if this service should block, but was not
- * called from a Xenomai thread.
+ * called from a Xenomai task. Over Cobalt, this error is also returned
+ * if the caller is not a Xenomai thread, even if it should not block.
  *
  * @apitags{xthread-nowait, switch-primary}
  *
diff --git a/lib/alchemy/task.c b/lib/alchemy/task.c
index dcb3de42c..2f61c8580 100644
--- a/lib/alchemy/task.c
+++ b/lib/alchemy/task.c
@@ -473,8 +473,8 @@ out:
  *
  * - -EINVAL is returned if @a task is not a valid task descriptor.
  *
- * - -EPERM is returned if @a task is NULL and this service was called
- * from an invalid context. In addition, this error is always raised
+ * - -EPERM is returned if @a task is NULL but the caller is not an
+ * Alchemy task. In addition, this error is always raised
  * when this service is called from asynchronous context, such as a
  * timer/alarm handler.
  *
@@ -562,10 +562,12 @@ int rt_task_join(RT_TASK *task)
  *
  * @return Zero is returned upon success. Otherwise:
  *
- * - -EINVAL is returned if @a task is NULL but the caller is not a
- * Xenomai task, or if @a task is non-NULL but not a valid task
+ * - -EINVAL is returned if @a task is non-NULL but not a valid task
  * descriptor.
  *
+ * - -EPERM is returned if @a task is NULL but the caller is not an
+ * Alchemy task.
+ *
  * - -EINVAL is returned if @a cpus contains no processors that are
  * currently physically on the system and permitted to the process
  * according to any restrictions that may be imposed by the "cpuset"
@@ -707,12 +709,13 @@ out:
  * - -EEXIST is returned if the @a name is conflicting with an already
  * registered task.
  *
- * - -EBUSY is returned if the caller is not a regular POSIX thread.
+ * - -EBUSY is returned if the caller already is an Alchemy, pSOS or
+ * VxWorks task.
  *
  * - -EPERM is returned if this service was called from an invalid
  * context, e.g. interrupt handler.
  *
- * @apitags{pthread-only, switch-secondary, switch-primary}
+ * @apitags{thread-unrestricted, switch-secondary, switch-primary}
  *
  * @sideeffect Over Cobalt, if the caller is a plain POSIX thread, it
  * is turned into a Xenomai _shadow_ thread, with full access to all
@@ -809,10 +812,12 @@ undo:
  *
  * @return Zero is returned upon success. Otherwise:
  *
- * - -EINVAL is returned if @a task is NULL but the caller is not a
- * Xenomai task, or if @a task is non-NULL but not a valid task
+ * - -EINVAL is returned if @a task is non-NULL but not a valid task
  * descriptor.
  *
+ * - -EPERM is returned if @a task is NULL but the caller is not an
+ * Alchemy task.
+ *
  * - -ETIMEDOUT is returned if @a idate is different from TM_INFINITE
  * and represents a date in the past.
  *
@@ -919,8 +924,8 @@ out:
  * task. If @a overruns_r is non-NULL, the count of pending overruns
  * is written to the pointed memory location.
  *
- * - -EPERM is returned if this service was called from an invalid
- * context.
+ * - -EPERM is returned if this service was not called from a Xenomai
+ * task.
  *
  * @apitags{xthread-only, switch-primary}
  *
@@ -957,13 +962,11 @@ int rt_task_wait_period(unsigned long *overruns_r)
  *
  * - -ETIMEDOUT is returned if @a date has already elapsed.
  *
- * - -EPERM is returned if this service was called from an invalid
- * context.
+ * - -EPERM is returned if this service was not called from a Xenomai
+ * task.
  *
  * @apitags{xthread-only, switch-primary}
  *
- * @note The caller must be an Alchemy task if @a task is NULL.
- *
  * @note The @a date value is interpreted as a multiple of the Alchemy
  * clock resolution (see --alchemy-clock-resolution option, defaults
  * to 1 nanosecond).
@@ -1058,7 +1061,7 @@ int rt_task_sleep(RTIME delay)
  *
  * @return See rt_task_create().
  *
- * @apitags{mode-unrestricted, switch-secondary}
+ * @apitags{xthread-only, mode-unrestricted, switch-secondary}
  *
  * @sideeffect see rt_task_create().
  */
@@ -1126,12 +1129,11 @@ int rt_task_same(RT_TASK *task1, RT_TASK *task2)
  *
  * @return Zero is returned upon success. Otherwise:
  *
- * - -EINVAL is returned if @a task is NULL but the caller is not a
- * Xenomai task, or if @a task is non-NULL but not a valid task
+ * - -EINVAL is returned if @a task is non-NULL but not a valid task
  * descriptor.
  *
- * - -EPERM is returned if @a task is NULL and this service was called
- * from an invalid context.
+ * - -EPERM is returned if @a task is NULL but the caller is not an
+ * Alchemy task.
  *
  * @apitags{mode-unrestricted, switch-primary}
  *
@@ -1256,8 +1258,8 @@ RT_TASK *rt_task_self(void)
  * - -EINVAL is returned if @a task is not a valid task descriptor, or
  * if @a prio is invalid.
  *
- * - -EPERM is returned if @a task is NULL and this service was called
- * from an invalid context.
+ * - -EPERM is returned if @a task is NULL but the caller is not an
+ * Alchemy task.
  *
  * @apitags{mode-unrestricted, switch-primary, switch-secondary}
  *
@@ -1389,8 +1391,8 @@ out:
  * - -EINVAL is returned if @a task is not a valid task descriptor, or
  * if @a prio is invalid.
  *
- * - -EPERM is returned if @a task is NULL and this service was called
- * from an invalid context.
+ * - -EPERM is returned if @a task is NULL but the caller is not an
+ * Alchemy task.
  *
  * @apitags{mode-unrestricted, switch-primary}
  *
@@ -1483,11 +1485,12 @@ out:
  *
  * @return Zero is returned upon success. Otherwise:
  *
- * - -EINVAL is returned if @a task is not a valid task descriptor, or
- * if any bit from @a clrmask or @a setmask is invalid.
-
- * - -EPERM is returned if this service was called from an invalid
- * context.
+ * - -EINVAL is returned if any bit from @a clrmask or @a setmask is
+ * invalid.
+ *
+ * - -EPERM is returned if this service was not called from an Alchemy
+ * task, or if it was called from an asynchronous context with bits
+ * other than T_LOCK in @a clrmask or @a setmask.
  *
  * @apitags{xthread-only, switch-primary}
  *
@@ -1549,8 +1552,8 @@ out:
  * - -EINVAL is returned if @a task is not a valid task descriptor, or
  * if @a prio is invalid.
  *
- * - -EPERM is returned if @a task is NULL and this service was called
- * from an invalid context.
+ * - -EPERM is returned if @a task is NULL but the caller is not an
+ * Alchemy task.
  *
  * @apitags{mode-unrestricted, switch-primary}
  *
@@ -1699,8 +1702,8 @@ out:
  *
  * - -EINVAL is returned if @a task is not a valid task descriptor.
  *
- * - -EPERM is returned if this service was called from an invalid
- * context.
+ * - -EPERM is returned if this service was not called from a Xenomai
+ * task.
  *
  * - -ENOBUFS is returned if @a mcb_r does not point at a message area
  * large enough to collect the remote task's reply. This includes the
@@ -1906,8 +1909,8 @@ out:
  * token should be passed to rt_task_reply(), in order to send back a
  * reply to and unblock the remote task appropriately. Otherwise:
  *
- * - -EPERM is returned if this service was called from an invalid
- * context.
+ * - -EPERM is returned if this service was not called from an Alchemy
+ * task.
  *
  * - -EINTR is returned if rt_task_unblock() was called for the
  * current task before a message was received.
@@ -2038,8 +2041,8 @@ out:
 *  calling rt_task_send(). In such a case, the remote task also
 *  receives -ENOBUFS on return from rt_task_send().
  *
- * - -EPERM is returned if this service was called from an invalid
- * context.
+ * - -EPERM is returned if this service was not called from an Alchemy
+ * task.
  *
  * @apitags{xthread-only, switch-primary}
  */
@@ -2147,7 +2150,8 @@ out:
  * the specified amount of time.
  *
  * - -EPERM is returned if this service should block, but was not
- * called from a Xenomai thread.
+ * called from a Xenomai task. Over Cobalt, this error is also returned
+ * if the caller is not a Xenomai thread, even if it should not block.
  *
  * @apitags{xthread-nowait, switch-primary}
  *
diff --git a/lib/copperplate/init.c b/lib/copperplate/init.c
index 01969cfea..3eea6b51f 100644
--- a/lib/copperplate/init.c
+++ b/lib/copperplate/init.c
@@ -337,6 +337,16 @@ copperplate_setup_call(copperplate_interface);
  * excluding such threads which have been promoted to the real-time
  * domain afterwards (aka "shadowed") over Cobalt.
  *
+ * @attention By Xenomai task, we mean the subset of Xenomai threads
+ * which have a Copperplate thread control block: tasks created or
+ * shadowed by one of the RTOS APIs based on Copperplate (Alchemy,
+ * pSOS, VxWorks), and the thread which initialized the Xenomai
+ * libraries (i.e. normally main()). Cobalt/POSIX threads created by
+ * the POSIX API are Xenomai threads, but not Xenomai tasks. Some
+ * services further require the caller to be a task of a particular
+ * API, e.g. an Alchemy task created by rt_task_create() or
+ * rt_task_shadow().
+ *
  * @par
  * <b>Context tags</b>
  * <TABLE>
-- 
2.55.0

