Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642480;
	b=K3lsUAolgREhqq7YcCWQzlePGSMus+orqHGxLI9Z8ApruLwLrnYv1BJLxVI9VPX+lsWS
	 4uxnsDWj6lyLF5X10CmKON41I5Q5Fifny77+nrTZKYUGY+vmMsG4Dbaococgd7euWGrR/
	 pbET1j28oyGlVXe7sBxdzshraYJgMGD4DCiqGKV1q+J+fsy76s8VkIx4Wog2xQeztcgdk
	 siovzrJGVfkrBSxHyGweUTAfjzavdZopaThI+UUgijWq08oyof4oureNG80r2d08tbm7Y
	 02beAr/8Pvzznq1UwsPDb89TjLnmkxriFEesUFV+fCa59pM++tCIRM/YF+OZnr9e4SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642480;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JinsqdIQAO7ohB6lTjFpuOsqJdIENHGk1hAS/LQrtBI=;
	b=hUcS52E7tEelLc42V9iXog6Ugdfn73Ts7YZMM9eGcbe//YQiohRZhb5H5jf7Yy4D8V9g
	 9MEpkT9vgq0syl4Pyy9hGQQRYtguwV8SGc2UdWWmFyLSWEkpx253t23/jITxXx8Jva+Og
	 i5g+DPjDatBx8Y/riGMY6f1Gaw5PHASmqcqggWa6ip9PEuRlr/e+boZs1OSj4kKE0aBAs
	 kNzIEZ2DuJqalOPTD7D8l5UMhgvX4Re9KzbFwNc10zskX3HWQky+b54F+sJYM9y/P5HvV
	 7B3aWwo8h7YYsgJ4RRVYD7Rf0S8cpvQm5lC537UxDzU9csMsSW5CVuFsxSS8avZ3V7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NKRofxSr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AC8606A326
	for <xenomai@lists.linux.dev>; Wed, 25 Nov 2026 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NKRofxSr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F0C1F000D2;
	Wed, 25 Nov 2026 21:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642479;
	bh=JinsqdIQAO7ohB6lTjFpuOsqJdIENHGk1hAS/LQrtBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NKRofxSrVjGNsEfxIdXD6wd2C+Y24CDj1zEY5dvZTAy9v9wtOxNHW9CpE758hCTuv
	 do2UynsSgUap+X8eOXWKE90kpFdPKOff7G3U/KoJMsHVKfdcyzUNstsfgDy+XSntHs
	 xQFIVZpaZivE0xDC8TzsnkjxFOrqR290Et2Qxe31NyUpQ52+N1huONaTQ7zrM2PuvS
	 EF/GmFOQCjWqxD335KVP48/WszVp9o3AuqJYA4JTiALQnOypXU3OxRzVlhOle/bfl2
	 xaAFS6fkqQdBbsTf3Xk/m7qc0MLLzRlGENmrAS7CnpmIIMVum7pzd087G73QHSD3vL
	 x4qsJwzNrL6vQ==
From: "Richard Weinberger (sigma star gmbh)" <rw@kernel.org>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 7/7] testsuite/smokey/alchemytests: Test Alchemy services from POSIX threads
Date: Wed, 25 Nov 2026 22:34:19 +0100
Message-ID: <20261125213419.2363742-8-rw@kernel.org>
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

Check that a Cobalt POSIX thread, which is no Alchemy task, may use
mutexes, rt_task_yield() and pipes, and use queues, buffers, heaps and
events as long as it does not have to wait for a Copperplate
synchronization object.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 testsuite/smokey/alchemytests/Makefile.am    |  10 +
 testsuite/smokey/alchemytests/alchemytests.c |   2 +
 testsuite/smokey/alchemytests/mutex-3.c      | 158 +++++++++++
 testsuite/smokey/alchemytests/posix-1.c      | 259 +++++++++++++++++++
 4 files changed, 429 insertions(+)
 create mode 100644 testsuite/smokey/alchemytests/mutex-3.c
 create mode 100644 testsuite/smokey/alchemytests/posix-1.c

diff --git a/testsuite/smokey/alchemytests/Makefile.am b/testsuite/smokey/alchemytests/Makefile.am
index fd9e909de..4ee2ab486 100644
--- a/testsuite/smokey/alchemytests/Makefile.am
+++ b/testsuite/smokey/alchemytests/Makefile.am
@@ -21,6 +21,8 @@ test_PROGRAMS =				\
 		alchemytests_mq3	\
 		alchemytests_mutex1	\
 		alchemytests_mutex2	\
+		alchemytests_mutex3	\
+		alchemytests_posix1	\
 		alchemytests_sem1	\
 		alchemytests_sem2	\
 		alchemytests_task1	\
@@ -79,6 +81,14 @@ alchemytests_mutex2_SOURCES = mutex-2.c
 alchemytests_mutex2_CPPFLAGS = $(alchemycppflags)
 alchemytests_mutex2_LDADD = $(alchemyldadd)
 alchemytests_mutex2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_mutex3_SOURCES = mutex-3.c
+alchemytests_mutex3_CPPFLAGS = $(alchemycppflags)
+alchemytests_mutex3_LDADD = $(alchemyldadd)
+alchemytests_mutex3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_posix1_SOURCES = posix-1.c
+alchemytests_posix1_CPPFLAGS = $(alchemycppflags)
+alchemytests_posix1_LDADD = $(alchemyldadd)
+alchemytests_posix1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
 alchemytests_mq1_SOURCES = mq-1.c
 alchemytests_mq1_CPPFLAGS = $(alchemycppflags)
 alchemytests_mq1_LDADD = $(alchemyldadd)
diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
index 569b73375..85019c35d 100644
--- a/testsuite/smokey/alchemytests/alchemytests.c
+++ b/testsuite/smokey/alchemytests/alchemytests.c
@@ -15,6 +15,8 @@ static const char * const tests[] = {
 	"alchemytests_mq3",
 	"alchemytests_mutex1",
 	"alchemytests_mutex2",
+	"alchemytests_mutex3",
+	"alchemytests_posix1",
 #ifdef CONFIG_XENO_COBALT
 	"alchemytests_pipe1",
 #endif
diff --git a/testsuite/smokey/alchemytests/mutex-3.c b/testsuite/smokey/alchemytests/mutex-3.c
new file mode 100644
index 000000000..f3c2b0f43
--- /dev/null
+++ b/testsuite/smokey/alchemytests/mutex-3.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Check that Alchemy mutexes may be acquired by any Xenomai thread,
+ * not only by Alchemy tasks, and that the owner reported by
+ * rt_mutex_inquire() is only an Alchemy task.
+ *
+ * __RT() is required since the Alchemy tests are not linked with the
+ * POSIX symbol wrappers, but we want a Cobalt thread here.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <pthread.h>
+#include <semaphore.h>
+#include <copperplate/traceobj.h>
+#include <alchemy/task.h>
+#include <alchemy/mutex.h>
+
+static struct traceobj trobj;
+
+static int tseq[] = {
+	1, 2, 3, 4, 5, 6, 7, 8, 9,
+};
+
+static RT_TASK t_a;
+
+static RT_MUTEX mutex;
+
+static sem_t held, done;
+
+static void *posix_thread(void *arg)
+{
+	int ret;
+
+	traceobj_enter(&trobj);
+
+	/* Used to fail with -EPERM for non-Alchemy callers. */
+	ret = rt_mutex_acquire(&mutex, TM_NONBLOCK);
+	traceobj_check(&trobj, ret, 0);
+
+	/* Alchemy mutexes are recursive. */
+	ret = rt_mutex_acquire(&mutex, TM_INFINITE);
+	traceobj_check(&trobj, ret, 0);
+
+	ret = rt_task_yield();
+	traceobj_check(&trobj, ret, 0);
+
+	traceobj_mark(&trobj, 2);
+
+	__RT(sem_post(&held));
+	__RT(sem_wait(&done));
+
+	traceobj_mark(&trobj, 4);
+
+	ret = rt_mutex_release(&mutex);
+	traceobj_check(&trobj, ret, 0);
+
+	ret = rt_mutex_release(&mutex);
+	traceobj_check(&trobj, ret, 0);
+
+	traceobj_exit(&trobj);
+
+	return NULL;
+}
+
+static void task_a(void *arg)
+{
+	int ret;
+
+	traceobj_enter(&trobj);
+
+	ret = rt_mutex_acquire(&mutex, TM_INFINITE);
+	traceobj_check(&trobj, ret, 0);
+
+	traceobj_mark(&trobj, 6);
+
+	__RT(sem_post(&held));
+	__RT(sem_wait(&done));
+
+	ret = rt_mutex_release(&mutex);
+	traceobj_check(&trobj, ret, 0);
+
+	traceobj_mark(&trobj, 8);
+
+	traceobj_exit(&trobj);
+}
+
+int main(int argc, char *const argv[])
+{
+	struct sched_param param = { .sched_priority = 10 };
+	RT_MUTEX_INFO info;
+	pthread_attr_t attr;
+	pthread_t tid;
+	int ret;
+
+	traceobj_init(&trobj, argv[0], sizeof(tseq) / sizeof(int));
+
+	__RT(sem_init(&held, 0, 0));
+	__RT(sem_init(&done, 0, 0));
+
+	ret = rt_mutex_create(&mutex, "MUTEX");
+	traceobj_check(&trobj, ret, 0);
+
+	traceobj_mark(&trobj, 1);
+
+	pthread_attr_init(&attr);
+	pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
+	pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
+	pthread_attr_setschedparam(&attr, &param);
+	ret = __RT(pthread_create(&tid, &attr, posix_thread, NULL));
+	traceobj_check(&trobj, ret, 0);
+	pthread_attr_destroy(&attr);
+
+	__RT(sem_wait(&held));
+
+	traceobj_mark(&trobj, 3);
+
+	/* We are not an Alchemy task either: must not get -EPERM. */
+	ret = rt_mutex_acquire(&mutex, TM_NONBLOCK);
+	traceobj_check(&trobj, ret, -EWOULDBLOCK);
+
+	ret = rt_mutex_inquire(&mutex, &info);
+	traceobj_check(&trobj, ret, 0);
+	traceobj_assert(&trobj, info.owner.handle == NO_ALCHEMY_TASK.handle);
+
+	__RT(sem_post(&done));
+
+	ret = __RT(pthread_join(tid, NULL));
+	traceobj_check(&trobj, ret, 0);
+
+	traceobj_mark(&trobj, 5);
+
+	ret = rt_task_create(&t_a, "taskA", 0, 20, 0);
+	traceobj_check(&trobj, ret, 0);
+
+	ret = rt_task_start(&t_a, task_a, NULL);
+	traceobj_check(&trobj, ret, 0);
+
+	__RT(sem_wait(&held));
+
+	traceobj_mark(&trobj, 7);
+
+	ret = rt_mutex_inquire(&mutex, &info);
+	traceobj_check(&trobj, ret, 0);
+	traceobj_assert(&trobj, info.owner.handle == t_a.handle);
+
+	__RT(sem_post(&done));
+
+	traceobj_join(&trobj);
+
+	traceobj_mark(&trobj, 9);
+
+	ret = rt_mutex_delete(&mutex);
+	traceobj_check(&trobj, ret, 0);
+
+	traceobj_verify(&trobj, tseq, sizeof(tseq) / sizeof(int));
+
+	exit(0);
+}
diff --git a/testsuite/smokey/alchemytests/posix-1.c b/testsuite/smokey/alchemytests/posix-1.c
new file mode 100644
index 000000000..faed2829a
--- /dev/null
+++ b/testsuite/smokey/alchemytests/posix-1.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Call Alchemy services from a POSIX thread, which is no Xenomai
+ * task. -EPERM is only expected when the caller would have to wait
+ * on a Copperplate synchronization object.
+ *
+ * __RT() is required since the Alchemy tests are not linked with the
+ * POSIX symbol wrappers, but we want a Cobalt thread here.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <pthread.h>
+#include <semaphore.h>
+#include <copperplate/traceobj.h>
+#include <alchemy/task.h>
+#include <alchemy/timer.h>
+#include <alchemy/event.h>
+#include <alchemy/queue.h>
+#include <alchemy/buffer.h>
+#include <alchemy/heap.h>
+#ifdef CONFIG_XENO_COBALT
+#include <alchemy/pipe.h>
+#endif
+#include <smokey/smokey.h>
+
+static struct traceobj trobj;
+
+static RT_EVENT event;
+
+static RT_QUEUE queue;
+
+static RT_BUFFER buffer;
+
+static RT_HEAP heap;
+
+static RTIME short_delay;
+
+static const char msg[] = "hello";
+
+#ifdef CONFIG_XENO_COBALT
+
+static RT_PIPE mpipe;
+
+static int pipe_minor = -1;
+
+static sem_t pipe_ready;
+
+static void test_pipe(void)
+{
+	char buf[sizeof(msg)];
+	ssize_t ret;
+
+	if (pipe_minor < 0)
+		return;
+
+	ret = rt_pipe_read(&mpipe, buf, sizeof(buf), short_delay);
+	traceobj_check(&trobj, ret, -ETIMEDOUT);
+
+	__RT(sem_post(&pipe_ready));
+
+	ret = rt_pipe_read(&mpipe, buf, sizeof(buf), TM_INFINITE);
+	traceobj_check(&trobj, ret, sizeof(msg));
+	traceobj_assert(&trobj, strcmp(buf, msg) == 0);
+}
+
+static void feed_pipe(void)
+{
+	char *rtp;
+	int fd;
+
+	if (pipe_minor < 0)
+		return;
+
+	__RT(sem_wait(&pipe_ready));
+
+	traceobj_assert(&trobj, asprintf(&rtp, "/dev/rtp%d", pipe_minor) > 0);
+	fd = open(rtp, O_WRONLY);
+	free(rtp);
+	traceobj_assert(&trobj, fd >= 0);
+	traceobj_assert(&trobj, write(fd, msg, sizeof(msg)) == sizeof(msg));
+	close(fd);
+}
+
+static void create_pipe(void)
+{
+	pipe_minor = rt_pipe_create(&mpipe, "pipe", P_MINOR_AUTO, 0);
+	if (pipe_minor < 0) {
+		notice("pipe test skipped (no kernel support)");
+		return;
+	}
+
+	__RT(sem_init(&pipe_ready, 0, 0));
+}
+
+static void delete_pipe(void)
+{
+	if (pipe_minor >= 0)
+		traceobj_check(&trobj, rt_pipe_delete(&mpipe), 0);
+}
+
+#else
+
+static inline void test_pipe(void) { }
+static inline void feed_pipe(void) { }
+static inline void create_pipe(void) { }
+static inline void delete_pipe(void) { }
+
+#endif
+
+static void test_event(void)
+{
+	unsigned int mask;
+	int ret;
+
+	ret = rt_event_wait(&event, 0x1, &mask, EV_ANY, TM_INFINITE);
+	traceobj_check(&trobj, ret, 0);
+	traceobj_assert(&trobj, mask == 0x1);
+
+	ret = rt_event_wait(&event, 0x2, &mask, EV_ANY, short_delay);
+#ifdef CONFIG_XENO_COBALT
+	traceobj_check(&trobj, ret, -ETIMEDOUT);
+#else
+	traceobj_check(&trobj, ret, -EPERM);
+#endif
+}
+
+static void test_queue(void)
+{
+	char buf[sizeof(msg)];
+	ssize_t ret;
+	void *p;
+
+	ret = rt_queue_read(&queue, buf, sizeof(buf), TM_INFINITE);
+	traceobj_check(&trobj, ret, sizeof(msg));
+	traceobj_assert(&trobj, strcmp(buf, msg) == 0);
+
+	ret = rt_queue_receive(&queue, &p, TM_INFINITE);
+	traceobj_check(&trobj, ret, sizeof(msg));
+	traceobj_assert(&trobj, strcmp(p, msg) == 0);
+	traceobj_check(&trobj, rt_queue_free(&queue, p), 0);
+
+	ret = rt_queue_read(&queue, buf, sizeof(buf), TM_NONBLOCK);
+	traceobj_check(&trobj, ret, -EWOULDBLOCK);
+
+	ret = rt_queue_read(&queue, buf, sizeof(buf), short_delay);
+	traceobj_check(&trobj, ret, -EPERM);
+
+	ret = rt_queue_receive(&queue, &p, TM_INFINITE);
+	traceobj_check(&trobj, ret, -EPERM);
+}
+
+static void test_buffer(void)
+{
+	char buf[64];
+	ssize_t ret;
+
+	memset(buf, 0, sizeof(buf));
+
+	ret = rt_buffer_write(&buffer, buf, 16, TM_INFINITE);
+	traceobj_check(&trobj, ret, 16);
+
+	ret = rt_buffer_read(&buffer, buf, 16, TM_INFINITE);
+	traceobj_check(&trobj, ret, 16);
+
+	ret = rt_buffer_read(&buffer, buf, 16, short_delay);
+	traceobj_check(&trobj, ret, -EPERM);
+
+	ret = rt_buffer_write(&buffer, buf, sizeof(buf), TM_INFINITE);
+	traceobj_check(&trobj, ret, sizeof(buf));
+
+	ret = rt_buffer_write(&buffer, buf, 1, short_delay);
+	traceobj_check(&trobj, ret, -EPERM);
+
+	ret = rt_buffer_read(&buffer, buf, sizeof(buf), TM_NONBLOCK);
+	traceobj_check(&trobj, ret, sizeof(buf));
+}
+
+static void test_heap(void)
+{
+	void *p1, *p2, *p3;
+	int ret;
+
+	ret = rt_heap_alloc(&heap, 8192, TM_INFINITE, &p1);
+	traceobj_check(&trobj, ret, 0);
+
+	ret = rt_heap_alloc(&heap, 8192, TM_INFINITE, &p2);
+	traceobj_check(&trobj, ret, 0);
+
+	ret = rt_heap_alloc(&heap, 8192, short_delay, &p3);
+	traceobj_check(&trobj, ret, -EPERM);
+
+	traceobj_check(&trobj, rt_heap_free(&heap, p1), 0);
+	traceobj_check(&trobj, rt_heap_free(&heap, p2), 0);
+}
+
+static void *posix_thread(void *arg)
+{
+	test_event();
+	test_queue();
+	test_buffer();
+	test_heap();
+	test_pipe();
+
+	return NULL;
+}
+
+int main(int argc, char *const argv[])
+{
+	struct sched_param param = { .sched_priority = 10 };
+	pthread_attr_t attr;
+	pthread_t tid;
+	int ret;
+
+	traceobj_init(&trobj, argv[0], 0);
+
+	short_delay = rt_timer_ns2ticks(1000000);
+
+	ret = rt_event_create(&event, "event", 0x1, EV_PRIO);
+	traceobj_check(&trobj, ret, 0);
+
+	ret = rt_queue_create(&queue, "queue", 4096, Q_UNLIMITED, Q_FIFO);
+	traceobj_check(&trobj, ret, 0);
+	ret = rt_queue_write(&queue, msg, sizeof(msg), Q_NORMAL);
+	traceobj_check(&trobj, ret, 0);
+	ret = rt_queue_write(&queue, msg, sizeof(msg), Q_NORMAL);
+	traceobj_check(&trobj, ret, 0);
+
+	ret = rt_buffer_create(&buffer, "buffer", 64, B_FIFO);
+	traceobj_check(&trobj, ret, 0);
+
+	ret = rt_heap_create(&heap, "heap", 16384, H_PRIO);
+	traceobj_check(&trobj, ret, 0);
+
+	create_pipe();
+
+	pthread_attr_init(&attr);
+	pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
+	pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
+	pthread_attr_setschedparam(&attr, &param);
+	ret = __RT(pthread_create(&tid, &attr, posix_thread, NULL));
+	traceobj_check(&trobj, ret, 0);
+	pthread_attr_destroy(&attr);
+
+	feed_pipe();
+
+	ret = __RT(pthread_join(tid, NULL));
+	traceobj_check(&trobj, ret, 0);
+
+	delete_pipe();
+	traceobj_check(&trobj, rt_heap_delete(&heap), 0);
+	traceobj_check(&trobj, rt_buffer_delete(&buffer), 0);
+	traceobj_check(&trobj, rt_queue_delete(&queue), 0);
+	traceobj_check(&trobj, rt_event_delete(&event), 0);
+
+	exit(0);
+}
-- 
2.55.0

