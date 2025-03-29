Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A07149C55
	for <xenomai@lists.linux.dev>; Sat, 29 Mar 2025 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743264421; cv=none; b=TQjhomxYQwqBxwQ9Xr32WVx4o9/6bkzJ6tajanSxpGu18wz+6RRU3Dp1yU2FbpJJZoDk6QmG0Nddk7DBbfpMvg/lGChMHehlC0wi0wEKG1FRZHPevZRaffeCjcfTw1LXna3GidQ6Z2DYZL+ObovFBi0j0Y1XkJA21yaxkaSI/l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743264421; c=relaxed/simple;
	bh=ms3JsM9BZ7WbvYYl7/s9mRPSIHy5MogDbYsXhJMEo+A=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LmlWV5JObf+o3TQZiE7kdf2TbaL77ID2Qvsr5SBpvQG0ibZpUanIaqO/e8m3n0h8QMKkzUHDK5GRzOHtXuRJ2tgvyCjDTEr+a9talkUZhD0ipY01w8NAKG2MVaOiVKD9BNxDC7/oseJ4786k+v6IcGHiKGEmvJtsjPwYTy5F/Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jDS6lWe8; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jDS6lWe8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=TxHSpAtrMumzHyEOaH
	Ry2Stw3U4liL3mjesjxmWi+vg=; b=jDS6lWe8M8SlQ6jGQZWGPA10bYXlXuralm
	CZXW024U43g5e4H3es2Hd2CBDezhSLZyOObMHjUue+80CXqxQHOmliMpiMhYVqMv
	PwsgeNwd5s7ONhi/OSYWjMoM7cG8QR/tlz/II2EfplkZjuTSxf6XfQDaGN8hvWbF
	HSJlrvXhk=
Received: from firefly.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wB3RzeYGuhn4KK9Cg--.29835S2;
	Sun, 30 Mar 2025 00:06:48 +0800 (CST)
From: Ethan <aspirestro@163.com>
To: florian.bezdeka@siemens.com,
	rpm@xenomai.org,
	jan.kiszka@siemens.com
Cc: xenomai@lists.linux.dev,
	Ethan <aspirestro@163.com>
Subject: [PATCH] lib/cobalt: Fix a deadlock when release_buffer() attempts to re-acquire buffer_lock
Date: Sat, 29 Mar 2025 16:06:46 +0000
Message-Id: <20250329160646.527363-1-aspirestro@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wB3RzeYGuhn4KK9Cg--.29835S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFy3ZF48WF18trWxKF4xXrb_yoWrGw1kpr
	ZIgr4UGrs7Zrs2vF12y3WDXF1Fyw4vgF47GrZavw17Aan8CrsIq34UKFW29F40kr97Jrs8
	Xr4jgF1kWF4DZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UvLv_UUUUU=
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/xtbBYxkfcWfoFYdiFAAAs-
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>

The release_buffer() function is the destructor function for the thread-specific
data (TSD) associated with buffer_key. If the current thread is executing
rt_print_flush_buffers() and has already acquired buffer_lock, and is then
requested to exit via pthread_cancel(), the release_buffer() function will be
invoked. A deadlock can occur when release_buffer() attempts to re-acquire
buffer_lock.

This patch changes the buffer_lock from PTHREAD_MUTEX_DEFAULT to
PTHREAD_MUTEX_ERRORCHECK type, as it supports deadlock detection. If the lock is
successfully acquired, it will return 0. If the same thread attempts to re-lock
a mutex that it has already locked, it will return EDEADLK. This approach
prevents the deadlock issue.

The deadlock can be observed as gdb shown. The thread "slave" will block when
calling pthread_mutex_lock() in release_buffer() while attempting to re-acquire
buffer_lock again. This also causes cobalt_print to remain waiting indefinitely
for buffer_lock.

(gdb) info thread
  Id   Target Id                                        Frame
* 1    Thread 0x7ff7ff4010 (LWP 1654) "hello"           0x0000007ff7bb6398 in sched_yield () at ../sysdeps/unix/syscall-template.S:78
  2    Thread 0x7ff7a7a1c0 (LWP 1657) "cobalt_printf"   __lll_lock_wait (futex=futex@entry=0x7ff7fcaed8 <buffer_lock>, private=0)
    at lowlevellock.c:52
  3    Thread 0x7ff72791c0 (LWP 1658) "master"          0x0000007ff7b6d314 in __GI__IO_default_xsputn (n=<optimized out>, data=<optimized out>,
    f=<optimized out>) at genops.c:393
  4    Thread 0x7ff72581c0 (LWP 1659) "slave" (Exiting) __lll_lock_wait (futex=futex@entry=0x7ff7fcaed8 <buffer_lock>, private=0)
    at lowlevellock.c:52
(gdb) thread 4
[Switching to thread 4 (Thread 0x7ff72581c0 (LWP 1659))]
52      lowlevellock.c: No such file or directory.
(gdb) bt
(gdb) p ((pthread_mutex_t*) &buffer_lock)->__data.__owner
$4 = 1659
(gdb) p ((pthread_mutex_t*) &buffer_lock)->__data.__lock
$5 = 2

Signed-off-by: Ethan <aspirestro@163.com>
---
 lib/cobalt/printf.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/lib/cobalt/printf.c b/lib/cobalt/printf.c
index 0aa5940c6..87ed989f4 100644
--- a/lib/cobalt/printf.c
+++ b/lib/cobalt/printf.c
@@ -82,6 +82,7 @@ static struct timespec syncdelay;
 static pthread_mutex_t buffer_lock;
 static pthread_cond_t printer_wakeup;
 static pthread_key_t buffer_key;
+static pthread_mutexattr_t attr;
 static pthread_key_t cleanup_key;
 static pthread_t printer_thread;
 static atomic_long_t *pool_bitmap;
@@ -498,6 +499,12 @@ static void release_buffer(struct print_buffer *buffer)
 
 	pthread_setspecific(buffer_key, NULL);
 
+	/* The type of buffer_lock is PTHREAD_MUTEX_ERRORCHECK, which supports
+	 * deadlock detection. If the lock is successfully acquired, it will return
+	 * 0; If the same thread attempts to re-lock a mutex that it has already
+	 * locked, it will return EDEADLK. This approach prevents the deadlock
+	 * issue.
+	 */
 	pthread_mutex_lock(&buffer_lock);
 
 	print_buffers();
@@ -666,7 +673,7 @@ void cobalt_print_init_atfork(void)
 	}
 
 	/* re-init to avoid finding it locked by some parent thread */
-	pthread_mutex_init(&buffer_lock, NULL);
+	pthread_mutex_init(&buffer_lock, &attr);
 
 	while (*pbuffer) {
 		if (*pbuffer == my_buffer)
@@ -723,7 +730,9 @@ void cobalt_print_init(void)
 		rt_print_init_inner(buffer, __cobalt_print_bufsz);
 	}
 done:
-	pthread_mutex_init(&buffer_lock, NULL);
+	pthread_mutexattr_init(&attr);
+	pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_ERRORCHECK);
+	pthread_mutex_init(&buffer_lock, &attr);
 	pthread_key_create(&buffer_key, (void (*)(void*))release_buffer);
 	pthread_key_create(&cleanup_key, do_cleanup);
 	pthread_cond_init(&printer_wakeup, NULL);
-- 
2.34.1

