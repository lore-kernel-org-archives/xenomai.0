Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D454F71B4B
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434679; cv=none; b=YSHN7GpYKqdVH4BMu44RehbBZ5podLcifIoTSE2YsSG5hrrTV4gU/ETI3LyrEGjauRc+w8bU3Vh1+6xTYWv6yNYLieVVYVcD44EulBVD4ndDt+7t5nRy/+NafzcM42xTd2JWwzuHFQZ8PYMtlxP0uZ9aAvsCdOBSXISgJAnlDIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434679; c=relaxed/simple;
	bh=HPL0dzH+c5sNz2VlNMHJ18cwRz9fWba6QwrG5ZCjoZs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bVtcpVdaXk7mAoUd1f2dxPKF6Q7fZzkRttUAVdRzwrFsocAGJVi65RGwQ4hn9hzp2YDUatTRdLZRoOQ7KjqRlIkB2dlEvLXcJfAAj6OtNm8YPLaMeYhrORvfCFbAtgSPnDwp4+2B8/Pane8muxZyRldkH3DovScMTSuYTBGyO8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=TmJy6IgA; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="TmJy6IgA"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240326063107d2e895c520dc6d0b46
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=di9d/CRSrZ2DOzcxhT0DGTnJZq9LtXlAwHd73Ewewwk=;
 b=TmJy6IgAEa2Mxp7r2A8mgNt5hL/Xi7citZf0z1fZQEMqnEOg3YRasFXJbk4AcE0UHTIk8S
 6FZi/McdRBrc2jkQkn73IEFy6H60bvazLteR1jzV7P5VFinTMBu+WmewiSugDPfYx/x5lhzu
 YtChntjm4JYdxEQfqVuzADMASpy3g=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 07/25] cobalt: Make private functions static
Date: Tue, 26 Mar 2024 07:30:46 +0100
Message-Id: <ef5f9fc57094a73040b114f036f67270d7871ea9.1711434664.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1711434664.git.jan.kiszka@siemens.com>
References: <cover.1711434664.git.jan.kiszka@siemens.com>
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

Addresses missing prototype warnings with kernel 6.8.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/clock.c            | 8 ++++----
 kernel/cobalt/dovetail/kevents.c | 2 +-
 kernel/cobalt/posix/mqueue.c     | 2 +-
 kernel/cobalt/timer.c            | 2 +-
 kernel/cobalt/vfile.c            | 8 ++++----
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/cobalt/clock.c b/kernel/cobalt/clock.c
index fbb7ddbe95..adbfc65125 100644
--- a/kernel/cobalt/clock.c
+++ b/kernel/cobalt/clock.c
@@ -419,12 +419,12 @@ static void cleanup_timerlist_proc(struct xnclock *clock)
 	xnvfile_destroy_snapshot(&clock->timer_vfile);
 }
 
-void init_timerlist_root(void)
+static void init_timerlist_root(void)
 {
 	xnvfile_init_dir("timer", &timerlist_vfroot, &cobalt_vfroot);
 }
 
-void cleanup_timerlist_root(void)
+static void cleanup_timerlist_root(void)
 {
 	xnvfile_destroy_dir(&timerlist_vfroot);
 }
@@ -445,8 +445,8 @@ static inline void cleanup_timerlist_proc(struct xnclock *clock) { }
 
 static struct xnvfile_directory clock_vfroot;
 
-void print_core_clock_status(struct xnclock *clock,
-			     struct xnvfile_regular_iterator *it)
+static void print_core_clock_status(struct xnclock *clock,
+				    struct xnvfile_regular_iterator *it)
 {
 	const char *wd_status = "off";
 
diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
index f78abbdc79..0f70dbc27f 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
@@ -169,7 +169,7 @@ void pipeline_cleanup_process(void)
 	dovetail_stop_altsched();
 }
 
-int handle_ptrace_resume(struct task_struct *tracee)
+static int handle_ptrace_resume(struct task_struct *tracee)
 {
 	struct xnthread *thread;
 	spl_t s;
diff --git a/kernel/cobalt/posix/mqueue.c b/kernel/cobalt/posix/mqueue.c
index 5d072eb7fd..853aa6cad8 100644
--- a/kernel/cobalt/posix/mqueue.c
+++ b/kernel/cobalt/posix/mqueue.c
@@ -237,7 +237,7 @@ static void mqd_close(struct rtdm_fd *fd)
 	mq_unref(mq);
 }
 
-int
+static int
 mqd_select(struct rtdm_fd *fd, struct xnselector *selector,
 	   unsigned type, unsigned index)
 {
diff --git a/kernel/cobalt/timer.c b/kernel/cobalt/timer.c
index 4b9cea4a97..09f93f7173 100644
--- a/kernel/cobalt/timer.c
+++ b/kernel/cobalt/timer.c
@@ -62,7 +62,7 @@ int xntimer_heading_p(struct xntimer *timer)
 	return 0;
 }
 
-void xntimer_enqueue_and_program(struct xntimer *timer, xntimerq_t *q)
+static void xntimer_enqueue_and_program(struct xntimer *timer, xntimerq_t *q)
 {
 	struct xnsched *sched = xntimer_sched(timer);
 
diff --git a/kernel/cobalt/vfile.c b/kernel/cobalt/vfile.c
index 05fa48a091..e2c0f0a965 100644
--- a/kernel/cobalt/vfile.c
+++ b/kernel/cobalt/vfile.c
@@ -314,8 +314,8 @@ static int vfile_snapshot_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-ssize_t vfile_snapshot_write(struct file *file, const char __user *buf,
-			     size_t size, loff_t *ppos)
+static ssize_t vfile_snapshot_write(struct file *file, const char __user *buf,
+				    size_t size, loff_t *ppos)
 {
 	struct xnvfile_snapshot *vfile =
 		pde_data(file->f_path.dentry->d_inode);
@@ -562,8 +562,8 @@ static int vfile_regular_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-ssize_t vfile_regular_write(struct file *file, const char __user *buf,
-			    size_t size, loff_t *ppos)
+static ssize_t vfile_regular_write(struct file *file, const char __user *buf,
+				   size_t size, loff_t *ppos)
 {
 	struct xnvfile_regular *vfile =
 		pde_data(file->f_path.dentry->d_inode);
-- 
2.35.3

