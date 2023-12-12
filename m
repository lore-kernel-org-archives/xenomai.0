Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D7059173
	for <xenomai@lists.linux.dev>; Tue, 12 Dec 2023 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="iz3WxLOa"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20231212100114d2550f828705505f92
        for <xenomai@lists.linux.dev>;
        Tue, 12 Dec 2023 11:01:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=+N5i29PTWk/PXoJ4dL33d/juAXgJpGE1/8e8LdK67+Y=;
 b=iz3WxLOazc55km8gKQODuiq9QmS3pdI/hV840F+rK3jfEtdcKb5ZWOVacMOJmKB0cOi4zT
 vkIBrLj8TDvLnb6yyJusfFacIIJRdm5u5kzqjFaK6erRXaGldVzZq5wudSIP3jGGQ+X4T6s2
 hmW2kAwqc+8qlWCkeNlpZCSc+4e1c=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 12 Dec 2023 11:01:05 +0100
Subject: [PATCH] lib/psos/task.c: Fix psos tests, incorrect error reporting
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-flo-fix-testsuite-v1-1-614eb1703e08@siemens.com>
X-B4-Tracking: v=1; b=H4sIAGAveGUC/x3NUQqDMBCE4avIPnehSUBor1L6ENOJLoRYsrEI4
 t27+PgPfMxBiiZQeg4HNfxEZa0W7jZQWmKdwfKxJn/3wXnnOZeVs+zcoV036eAw5pTc+AiIgcx
 NUcFTizUtJutWio3fBlPX0et9nn9/0U/feAAAAA==
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Fabrice Fontaine <fontaine.fabrice@gmail.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The following smokey test failure was seen on the current next branch:

 [1] at task-4.c:22
    0\"011.394| BUG in __traceobj_assert_failed(): [TASK] trace assertion failed:
               task-4.c:36 => \"ret == 0 && regval == 0xdeadbeef\"
 test psostests_task4 failed: 256

The problem was introduced in
8dceca122dbb ("lib/psos/task.c: fix build with gcc >= 12 and -Ofast"),
the second parameter of get_psos_task() was unconditionally initialized
with ERR_OBJDEL. Even if no error occurred later on, an error was
reported.

All users of get_psos_task() and get_psos_task_or_self() have to
initialize the second parameter when the care about the returned error
code afterwards. The value of the parameter will only be overwritten in
case of an error.

Fixes: 8dceca122dbb ("lib/psos/task.c: fix build with gcc >= 12 and -Ofast")
CC: Fabrice Fontaine <fontaine.fabrice@gmail.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/psos/task.c | 9 ++++-----
 lib/psos/tm.c   | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/lib/psos/task.c b/lib/psos/task.c
index 5341289df..70b5c6596 100644
--- a/lib/psos/task.c
+++ b/lib/psos/task.c
@@ -96,7 +96,6 @@ static struct psos_task *find_psos_task_or_self(u_long tid, int *err_r)
 
 struct psos_task *get_psos_task(u_long tid, int *err_r)
 {
-	*err_r = ERR_OBJDEL;
 	struct psos_task *task = find_psos_task(tid, err_r);
 
 	/*
@@ -360,7 +359,7 @@ u_long t_start(u_long tid,
 {
 	struct psos_task *task;
 	struct service svc;
-	int ret;
+	int ret = SUCCESS;
 
 	CANCEL_DEFER(svc);
 
@@ -401,7 +400,7 @@ u_long t_suspend(u_long tid)
 {
 	struct psos_task *task;
 	struct service svc;
-	int ret;
+	int ret = SUCCESS;
 
 	CANCEL_DEFER(svc);
 
@@ -424,7 +423,7 @@ u_long t_resume(u_long tid)
 {
 	struct psos_task *task;
 	struct service svc;
-	int ret;
+	int ret = SUCCESS;
 
 	CANCEL_DEFER(svc);
 
@@ -491,7 +490,7 @@ u_long t_delete(u_long tid)
 {
 	struct psos_task *task;
 	struct service svc;
-	int ret;
+	int ret = SUCCESS;
 
 	CANCEL_DEFER(svc);
 
diff --git a/lib/psos/tm.c b/lib/psos/tm.c
index 09cb47f6e..7b4c755a7 100644
--- a/lib/psos/tm.c
+++ b/lib/psos/tm.c
@@ -105,7 +105,7 @@ static u_long start_evtimer(u_long events,
 	void (*handler)(struct timerobj *tmobj);
 	struct psos_task *current;
 	struct psos_tm *tm;
-	int ret;
+	int ret = SUCCESS;
 
 	tm = pvmalloc(sizeof(*tm));
 	if (tm == NULL)

---
base-commit: cae69c97940d60956667e4c9e86d7869ae0aa2da
change-id: 20231212-flo-fix-testsuite-36fcc1693ea3

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

