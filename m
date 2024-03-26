Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A1480BE1
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448992; cv=none; b=P0WmD66+fnJpLtXtWAR87MuqtjCs5MieC16kuTdKYFZh8pY2Pxcg8acbhuDoFGyErngyxZM7zwwyELuHnb6irV5VKc2L6Y1iuRHSflajTU5g39fOS0frgogNbmKmf4CO+n1DLHHPCGMeY1m2zHTa/Fzvqm8Mo15jqixdZzwHjtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448992; c=relaxed/simple;
	bh=1kf8a+LQPxJP/ixBRsLvGG+nvfG4wCQDfDeDrJxMfFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ebu878OrRSspNgBoEMrvivxXuMpIby07s9VzDNpJiQ2fODFQrBVj2Ck60cQ7+h2yGgt/S8Zw8K09vCgf6t5FCFZRcyGk54rpLHm731KI8U/x5Lc8gYYCzxYECCOaJzE/mUKQpy7xQoMD76j2K1LTee4ouVhd0bKj7gpQhzBLFrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9B0B66450973
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 11:29:46 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id AMr4DdjUCo3V; Tue, 26 Mar 2024 11:29:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id EF7AC6343B21;
	Tue, 26 Mar 2024 11:29:45 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id s9frVob8LxMS; Tue, 26 Mar 2024 11:29:45 +0100 (CET)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id C5EE56450960;
	Tue, 26 Mar 2024 11:29:45 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/2] alchemytests: Add test case for RT_MUTEX and -EINTR
Date: Tue, 26 Mar 2024 11:29:34 +0100
Message-Id: <20240326102934.15109-2-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240326102934.15109-1-richard@nod.at>
References: <20240326102934.15109-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make sure rt_task_unblock() can unblock a mutex waiter.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 testsuite/smokey/alchemytests/Makefile.am |   5 +
 testsuite/smokey/alchemytests/mutex-2.c   | 111 ++++++++++++++++++++++
 2 files changed, 116 insertions(+)
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
2.34.1

