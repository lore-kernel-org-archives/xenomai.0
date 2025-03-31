Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0AE20297E
	for <xenomai@lists.linux.dev>; Mon, 31 Mar 2025 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743424984; cv=none; b=A87DCcWnM/O6pTqtBjy+hZp5s1aDYYX1OMMulpckWJM18grV4vAVNDXRur0U7xhHPumaL3Ke9w9tAALNE/IqRNC6pVzToz1AQZSyamj4cH/p6syhiueMLr9IPN2Gi2auFZPZbAs72X6bDGW/rFneyw6BzHYRh3c1+jLWtbz2BZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743424984; c=relaxed/simple;
	bh=oRnx1/Iwk5zdwpcAtwZDpUs7Eqtiu5WqTx3VWc8M9kA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CQ7o4RxgB9h4OH502NmS7dG2TQ+0L0UCRGpcvkOKicd94ptU1lwuJ9kaVkkOtLsVol95YdB+0Sb2Qp/3IZa0Kf3Ogbk8N52Pwp//6e2MeXVwZhpFzvhrivM2uT9ppaxHt/UdhaYCYhBiKcCVv8TkMGi4IudwEuvNyrYLNitYl1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QukscC6q; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QukscC6q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=T2kM2NuJRfV3hs/d7z
	FLAOPV3ylwdzcuIxOYziwZ7xk=; b=QukscC6qcBFSjvRjYD/70eeEKQyfvIoU3t
	mBI1Nh0/PJtlNdzgrhH2Ya0ztap2ztZS0qTSU59cUDf7YFVQX/RbWYMqaYxuaemM
	2KCiurtvkEn54v5QdpSAU2bOXk8/9XGCZz96bXC0u5wDpNuKZ1mRCbO3580RKKVG
	JpMa4WxZ8=
Received: from firefly.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wBn_RfPjepnfVUuBA--.3176S2;
	Mon, 31 Mar 2025 20:42:55 +0800 (CST)
From: Haiyang He <aspirestro@163.com>
To: florian.bezdeka@siemens.com,
	rpm@xenomai.org,
	jan.kiszka@siemens.com
Cc: xenomai@lists.linux.dev,
	Haiyang He <aspirestro@163.com>
Subject: [PATCH v3] lib/cobalt: Fix a deadlock when release_buffer() attempts to re-acquire buffer_lock
Date: Mon, 31 Mar 2025 12:42:53 +0000
Message-Id: <20250331124253.598842-1-aspirestro@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wBn_RfPjepnfVUuBA--.3176S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFy3ZF48WF18trWxCw4kWFg_yoW5tF47pr
	9agr45CrWkC34vvFsrt3WkZF10va1j9FW7GrZayw17Aws8Gw43X3yUKFyI9r45Kr93Ar4r
	Xr1jgr1vgrsrZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U_hLnUUUUU=
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/1tbiXQ8hcWfqhr+PiQAAsw
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

This patch uses the pthread_setcancelstate() function to set the thread state
to PTHREAD_CANCEL_DISABLE, ensuring that the thread does not respond to
cancellation requests while holding the buffer_lock.

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
#0  __lll_lock_wait (futex=futex@entry=0x7ff7fcaed8 <buffer_lock>, private=0) at lowlevellock.c:52
#1  0x0000007ff7f43cd8 in __GI___pthread_mutex_lock (mutex=0x7ff7fcaed8 <buffer_lock>) at pthread_mutex_lock.c:80
#2  0x0000007ff7fa3038 in release_buffer () from /usr/xenomai/lib/libcobalt.so.2
#3  0x0000007ff7f413c0 in __nptl_deallocate_tsd () at pthread_create.c:301
#4  0x0000007ff7f4156c in start_thread (arg=0x7ff7fa7430 <cobalt_thread_trampoline>) at pthread_create.c:488
#5  0x0000007ff7bcc49c in thread_start () at ../sysdeps/unix/sysv/linux/aarch64/clone.S:78
(gdb) p ((pthread_mutex_t*) &buffer_lock)->__data.__owner
$4 = 1659
(gdb) p ((pthread_mutex_t*) &buffer_lock)->__data.__lock
$5 = 2
(gdb) p ((pthread_mutex_t*) &buffer_lock)->__data.__count
$6 = 0

Signed-off-by: Haiyang He <aspirestro@163.com>
---

Patch v2:
 - Use the pthread_setcancelstate() function to set the thread state
to PTHREAD_CANCEL_DISABLE.

Patch v3:
 - Add backtrace output in gdb.

 lib/cobalt/printf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/cobalt/printf.c b/lib/cobalt/printf.c
index 0aa5940c6..bd2d7de56 100644
--- a/lib/cobalt/printf.c
+++ b/lib/cobalt/printf.c
@@ -482,10 +482,17 @@ const char *rt_print_buffer_name(void)
 /* *** Deferred Output Management *** */
 void rt_print_flush_buffers(void)
 {
+	int old_state;
+
 	cobalt_thread_relax();
+
+	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &old_state);
+
 	pthread_mutex_lock(&buffer_lock);
 	print_buffers();
 	pthread_mutex_unlock(&buffer_lock);
+
+	pthread_setcancelstate(old_state, NULL);
 }
 
 static void release_buffer(struct print_buffer *buffer)
-- 
2.17.1

