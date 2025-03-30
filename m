Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517CB18A6A7
	for <xenomai@lists.linux.dev>; Sun, 30 Mar 2025 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743352198; cv=none; b=fWWrHJlQjkMJOJ/h5ynZ8Q5bh31WNMtSu8u8xNam5kRjlR2MLbcZ9P9yalBSr4imgeLdWjHVJIh1IpHhnKu+qCOZE8+lsWsg/XHPF1rmoah7PY7tgoi4oFNckxprAnKbn8/anmDAIMFnN/uB67NYkYDtPhKLjtkyAO7suoNpRpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743352198; c=relaxed/simple;
	bh=jyPLWfoBT8JNlgoni9ihlTJDg8XEU7/plEem5rwmgvA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=D1FdBsHFafF8ZiA3hpQLh9Qnyrt4GcRIHniC3HsLVLZz4veJlqQ2mzmOyBXNK25ByeQYUiB0oLSLchuaYiY3RZU4Pm+m/QCRkjIR3gFqrNaUkMOy+vNX/BbYES2HdBwiG7xfuFZjKvynjpz3eR66S2wbSKRA9DKCgVY+Q/OCs3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qDclq++L; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qDclq++L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=vDoav+8slSunjSZ1ZS
	cVU0mN1sHTyQBykvCKIxfeKq4=; b=qDclq++LoZ93h+zNIEmU8sImq2TZUajHnx
	j0wFI/EFcaicG1QM1PsNUhyKYQJZhBNzVSYefd8/HXg+By3NNyqgIq9yrSyTbz21
	9cHLbSuP3seJnfYfqAi0H3AR5YJO03vZ1qfLZJjMDTzaNitPvPKcVFpley4MkXfV
	+4+VA1B5w=
Received: from firefly.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3Bjh3celn5gM_DA--.33894S2;
	Mon, 31 Mar 2025 00:29:44 +0800 (CST)
From: Ethan <aspirestro@163.com>
To: florian.bezdeka@siemens.com,
	rpm@xenomai.org,
	jan.kiszka@siemens.com
Cc: xenomai@lists.linux.dev,
	Ethan <aspirestro@163.com>
Subject: [PATCH v2] lib/cobalt: Fix a deadlock when release_buffer() attempts to re-acquire buffer_lock
Date: Sun, 30 Mar 2025 16:29:41 +0000
Message-Id: <20250330162941.598668-1-aspirestro@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3Bjh3celn5gM_DA--.33894S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFy3ZF48WF18trWxCw4kWFg_yoW5GF1kpr
	9agr4YkrWDZw1vvFnFy3WkZFn5Za1qgF17GrZay347Aws5Gw43X39rKFyIgr45Kr97Jr4r
	Xr1UKr1rWF4DZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UMa0dUUUUU=
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/1tbiXR4gcWfpbxspgQAAsA
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
(gdb) p ((pthread_mutex_t*) &buffer_lock)->__data.__owner
$4 = 1659
(gdb) p ((pthread_mutex_t*) &buffer_lock)->__data.__lock
$5 = 2

Signed-off-by: Ethan <aspirestro@163.com>
---
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

