Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E371A128376
	for <xenomai@lists.linux.dev>; Fri, 24 May 2024 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716539852; cv=none; b=uLLdBXbjgrlt/gwi9xVxfO3H16DnXFMCYDMNn6PczwWVD2KEWl3XclVOD0jhWm9xUfwUdUE7IP97Ohwa/0O2aLRm5NP9ikEutx1/cpcFiqW4yAMHb9D0InoR9frXoZ+wgt30XJ77oFnUR0AsjizY5IBI8ubplgNRZGBTmPyQqfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716539852; c=relaxed/simple;
	bh=3D0bSQTzsPgUhgFy/Ed5ja+aOiREL7d6oA8nZ1yKZMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=shbJrLIZ8Renwf0NjVCzyDnSxsXe4IyjFpp3yVqA/SXdjq/6fDTJP4CFk4Wa7Ukz36calm+GrzEuYs7uWRXsfroE0IiGO3wJsgAzzff5vCy8N7DDG+tJQ1l3wbtVGWn4j+/ci1NFZkFWULsMdbnebO322mMWOSikBeVy9hrCNwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 43C1462348A5;
	Fri, 24 May 2024 10:37:19 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id BM0ouHe2GAvM; Fri, 24 May 2024 10:37:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id BCA306340E17;
	Fri, 24 May 2024 10:37:18 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7J8LFcU-6zPu; Fri, 24 May 2024 10:37:18 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 7D3F26195FCF;
	Fri, 24 May 2024 10:37:18 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: lorenz@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH v2 2/2] alchemytests: Add test case for RT_MUTEX and -EINTR
Date: Fri, 24 May 2024 10:36:42 +0200
Message-Id: <20240524083642.19434-3-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240524083642.19434-1-richard@nod.at>
References: <20240524083642.19434-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make sure rt_task_unblock() can unblock a mutex waiter.

Co-developed-by: Lorenz Kofler <lorenz@sigma-star.at>
Signed-off-by: Lorenz Kofler <lorenz@sigma-star.at>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 testsuite/smokey/alchemytests/Makefile.am    |   5 +
 testsuite/smokey/alchemytests/alchemytests.c |   1 +
 testsuite/smokey/alchemytests/mutex-2.c      | 111 +++++++++++++++++++
 3 files changed, 117 insertions(+)
 create mode 100644 testsuite/smokey/alchemytests/mutex-2.c

diff --git a/testsuite/smokey/alchemytests/Makefile.am b/testsuite/smokey=
/alchemytests/Makefile.am
index 3525dfa09..eba82f8ec 100644
--- a/testsuite/smokey/alchemytests/Makefile.am
+++ b/testsuite/smokey/alchemytests/Makefile.am
@@ -20,6 +20,7 @@ test_PROGRAMS =3D				\
 		alchemytests_mq2	\
 		alchemytests_mq3	\
 		alchemytests_mutex1	\
+		alchemytests_mutex2	\
 		alchemytests_pipe1	\
 		alchemytests_sem1	\
 		alchemytests_sem2	\
@@ -69,6 +70,10 @@ alchemytests_mutex1_SOURCES =3D mutex-1.c
 alchemytests_mutex1_CPPFLAGS =3D $(alchemycppflags)
 alchemytests_mutex1_LDADD =3D $(alchemyldadd)
 alchemytests_mutex1_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
+alchemytests_mutex2_SOURCES =3D mutex-2.c
+alchemytests_mutex2_CPPFLAGS =3D $(alchemycppflags)
+alchemytests_mutex2_LDADD =3D $(alchemyldadd)
+alchemytests_mutex2_LDFLAGS =3D @XENO_AUTOINIT_LDFLAGS@
 alchemytests_pipe1_SOURCES =3D pipe-1.c
 alchemytests_pipe1_CPPFLAGS =3D $(alchemycppflags)
 alchemytests_pipe1_LDADD =3D $(alchemyldadd)
diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smo=
key/alchemytests/alchemytests.c
index 9a937f3a0..947fa37b9 100644
--- a/testsuite/smokey/alchemytests/alchemytests.c
+++ b/testsuite/smokey/alchemytests/alchemytests.c
@@ -12,6 +12,7 @@ static const char * const tests[] =3D {
 	"alchemytests_mq2",
 	"alchemytests_mq3",
 	"alchemytests_mutex1",
+	"alchemytests_mutex2",
 	"alchemytests_pipe1",
 	"alchemytests_sem1",
 	"alchemytests_sem2",
diff --git a/testsuite/smokey/alchemytests/mutex-2.c b/testsuite/smokey/a=
lchemytests/mutex-2.c
new file mode 100644
index 000000000..cb2c2710f
--- /dev/null
+++ b/testsuite/smokey/alchemytests/mutex-2.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <copperplate/traceobj.h>
+#include <alchemy/task.h>
+#include <alchemy/mutex.h>
+
+static struct traceobj trobj;
+
+static int tseq[] =3D {
+	1, 2, 3, 4, 5, 6, 7, 8, 9,
+};
+
+static RT_TASK t_a, t_b, t_c;
+
+static RT_MUTEX mutex;
+
+static void task_a(void *arg)
+{
+	int ret;
+
+	traceobj_enter(&trobj);
+
+	traceobj_mark(&trobj, 3);
+
+	ret =3D rt_mutex_acquire(&mutex, 1000000000ULL);
+	traceobj_check(&trobj, ret, -EINTR);
+
+	traceobj_mark(&trobj, 6);
+
+	traceobj_exit(&trobj);
+}
+
+static void task_c(void *arg)
+{
+	int ret;
+
+	traceobj_enter(&trobj);
+
+	traceobj_mark(&trobj, 4);
+
+	ret =3D rt_mutex_acquire(&mutex, TM_INFINITE);
+	traceobj_check(&trobj, ret, -EINTR);
+
+	traceobj_mark(&trobj, 8);
+
+	traceobj_exit(&trobj);
+}
+
+static void task_b(void *arg)
+{
+	int ret;
+
+	traceobj_enter(&trobj);
+
+	ret =3D rt_mutex_create(&mutex, "MUTEX");
+	traceobj_check(&trobj, ret, 0);
+
+	traceobj_mark(&trobj, 1);
+
+	ret =3D rt_mutex_acquire(&mutex, TM_INFINITE);
+	traceobj_check(&trobj, ret, 0);
+
+	traceobj_mark(&trobj, 2);
+
+	traceobj_exit(&trobj);
+	rt_task_suspend(rt_task_self());
+}
+
+int main(int argc, char *const argv[])
+{
+	int ret;
+
+	traceobj_init(&trobj, argv[0], sizeof(tseq) / sizeof(int));
+
+	ret =3D rt_task_create(&t_b, "taskB", 0, 21, 0);
+	traceobj_check(&trobj, ret, 0);
+
+	ret =3D rt_task_start(&t_b, task_b, NULL);
+	traceobj_check(&trobj, ret, 0);
+
+	ret =3D rt_task_create(&t_a, "taskA", 0, 20, 0);
+	traceobj_check(&trobj, ret, 0);
+
+	ret =3D rt_task_start(&t_a, task_a, NULL);
+	traceobj_check(&trobj, ret, 0);
+
+	ret =3D rt_task_create(&t_c, "taskC", 0, 20, 0);
+	traceobj_check(&trobj, ret, 0);
+
+	ret =3D rt_task_start(&t_c, task_c, NULL);
+	traceobj_check(&trobj, ret, 0);
+
+	traceobj_mark(&trobj, 5);
+
+	ret =3D rt_task_unblock(&t_a);
+	traceobj_check(&trobj, ret, 0);
+
+	traceobj_mark(&trobj, 7);
+
+	ret =3D rt_task_unblock(&t_c);
+	traceobj_check(&trobj, ret, 0);
+
+	traceobj_mark(&trobj, 9);
+
+	traceobj_join(&trobj);
+
+	traceobj_verify(&trobj, tseq, sizeof(tseq) / sizeof(int));
+
+	exit(0);
+}
--=20
2.35.3

