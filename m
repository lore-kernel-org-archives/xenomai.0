Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FC3199953
	for <xenomai@lists.linux.dev>; Fri, 30 Aug 2024 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016427; cv=none; b=MxndzJpm0g4Dm3XAz5rUGrBf2/ARug8gsV8rxBcvXfl63WZ49Kd9KyylN7hHbXjfSc9/L40CaLrqrQhY3GZrK+AI0x1f5b8aEIPRAEGcU2ZDkh3pvPXGiLxkk17pxVx5XqzgSY7g1h4nCylNhQeX/3SRZ5pBAhTYCqG6yb6tEjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016427; c=relaxed/simple;
	bh=RIH7NcQZcGaz8Wo7zQh0wH1qXxOK9jSRtJm6e1LN16I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3UCzGbkItxpBKjnanv3d7RTqeJxL3tEwZ2UhXKTLCfAM1OnRp9G5oih7WcX+3ZFQoHNFr08MgdfdBeGg9dupRwXye3KKTdEosFeyW8oja0WJtECMg5S0Zv7CTSOrs/uLJsbYUysvELRqW79M0cA+H3wi05ChQB0DphWYJqo7mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=gZFn3j2m; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="gZFn3j2m"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202408301113343f8422c5551b179ed3
        for <xenomai@lists.linux.dev>;
        Fri, 30 Aug 2024 13:13:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=g1WwFjNw5jOtTCDEyLc4ccefWJlG8hIxBJ4AjWAVVAM=;
 b=gZFn3j2mSnnLJxZS4dlzTMJZ3c5KEexuX6O1Fr4Qy3sDE9GQG2UW0U9W7FXsgXwG299Vf0
 a88NwgzQSQ4eF/QHLAJ5/ADS10Nw6wkhna+lqLVVKDY6EjtupRhvOTyaH+6IiDk7Kk96mitx
 qN5oA+Kum/u6Pb7lIDACwte3m4bZ/PtX4xs533W8IQzeugwQN7EXAt4ppj4QnMjrrs9g31D2
 7JFUWqOVz9O5n61k4WvuXmSp2KbJa7Tlqe0i8nk5zPrx4kQFZytjjL16MT9yja5uHBYje8ek
 qQDnu4didAY+JJ2ZWT9e5ezWyGd7s/57OJiqkOyd6/MMuYKREPbOGjCg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: JerryJun <jerryjun123@163.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 3/3] cobalt/posix/process: Sync on thread-hosted irq_work items before exiting
Date: Fri, 30 Aug 2024 13:13:33 +0200
Message-ID: <a1029bef54ff78bc01795032aee5bdec7c86fe41.1725016413.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1725016413.git.jan.kiszka@siemens.com>
References: <cover.1725016413.git.jan.kiszka@siemens.com>
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

Better safe than sorry: Due to migrations, there could theoretically
still be signal or relaxation work pending on different CPU. To avoid
reaping the carpet underneath of them, sync on all per-thread work_irq
items when a former RT thread is terminating.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/process.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 7cfaa723e6..8b4efcab40 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -838,6 +838,7 @@ static void __handle_taskexit_event(struct task_struct *p)
 {
 	struct cobalt_ppd *sys_ppd;
 	struct xnthread *thread;
+	unsigned int n;
 	spl_t s;
 
 	/*
@@ -861,6 +862,10 @@ static void __handle_taskexit_event(struct task_struct *p)
 
 	xnthread_run_handler_stack(thread, exit_thread);
 
+	for (n = 0; n < XNTHREAD_MAX_SIGNALS; n++)
+		irq_work_sync(&thread->sigarray[n].inband_work);
+	irq_work_sync(&thread->relax_work.inband_work);
+
 	if (xnthread_test_state(thread, XNUSER)) {
 		cobalt_umm_free(&cobalt_kernel_ppd.umm, thread->u_window);
 		thread->u_window = NULL;
-- 
2.43.0

