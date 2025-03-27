Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDF8205AC8
	for <xenomai@lists.linux.dev>; Thu, 27 Mar 2025 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743063929; cv=none; b=bEk984RFNEumwxf25lDYqK1XdwsrYGFH939pKdvI/q+RgHE84tkaBhYy0Bw9LOQrM7df3F8Kmf9o6g6jIoRaGY7S/CI4HwyefflaFo8km97uCg2fW8QfymUDXK33q5T3SIF4iZDOxbQGNwd+xXeqUAg1VnudlM1Zvro37oltNsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743063929; c=relaxed/simple;
	bh=BikgY4TKrIUFvYiznBfPSmnI6lsGVDC6nnZAv08V9hU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nK+ChJlhX/BC5nGkw4j0KXzpoQdzoDgJGtwZz5bmZLe7FnyjRwP6HexHmm3fT6nMHPDMRb+8xET7Uz1tUgqADBPL18atTC4om2mNcTWiR8WRe5+1YfNY2KA0TFtCVGPTo0A7+wpQtO9a9l5p+Uw52npVA4Kyn0bEcmmmnX2obrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PIWr/TyO; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PIWr/TyO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=S/BugNaL7g7nOezSPf48EmtTqcq0DkCQlRtyU+asQlw=;
	b=PIWr/TyOlKV24LJyoEAW6IklQCOAjSUNa6dabXcokasQ1ywNAhku9AiwEVD4b/
	DyPPLjYkLKRuuQ/e0CEbPjIHgUndNjLPad+NtUI8vku4pq+2Diqw8kEmqtj8R4WB
	JThLzTCJiisRciKWsh/n9mk8NK8zG2NOVJYVWW0KM7DbM=
Received: from firefly.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBHq+9tC+Vnya0aCQ--.3375S2;
	Thu, 27 Mar 2025 16:25:18 +0800 (CST)
From: Ethan <aspirestro@163.com>
To: florian.bezdeka@siemens.com,
	rpm@xenomai.org,
	jan.kiszka@siemens.com
Cc: xenomai@lists.linux.dev,
	Ethan <aspirestro@163.com>
Subject: [PATCH v2] testsuite/smokey/y2038: replace gettid() function with a wrapper of __NR_gettid system call
Date: Thu, 27 Mar 2025 08:24:52 +0000
Message-Id: <20250327082452.383145-1-aspirestro@163.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHq+9tC+Vnya0aCQ--.3375S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF1fXr4kXrW7Xw43Aw48Crg_yoW8ZF4Upa
	y5Ca48K3ykAa48A3ZxCF1xA3s8J3ykAa4UXryxKw1Fkay7Kr1Utr40gFy5XF13CFZ8Xry7
	Xw4fXr1Svw4jvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UVGQkUUUUU=
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/1tbiXR0dcWflBRaYWgABs+

It fails to build testsuite/smokey/y2038 because there is no gettid() function
in earlier glibc than 2.30. The commit that added gettid() function to glibc
can be found at [1].

The following build failure is detected when using glibc 2.27 on Ubuntu
18.04.6 LTS (Bionic Beaver):

syscall-tests.c: In function ‘test_sc_cobalt_timer_settime64’:
syscall-tests.c:1211:31: error: implicit declaration of function ‘gettid’; did you mean ‘getgid’? [-Werror=implicit-function-declaration]
  sev.sigev_notify_thread_id = gettid();
                               ^~~~~~
                               getgid

[1] https://sourceware.org/git/?p=glibc.git;a=commit;h=1d0fc213824eaa2a8f8c4385daaa698ee8fb7c92

Signed-off-by: Ethan <aspirestro@163.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 29e9c66c0..bb1bf0686 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -12,6 +12,7 @@
 #include <smokey/smokey.h>
 #include <sys/timerfd.h>
 #include <sys/utsname.h>
+#include <sys/syscall.h> /* For __NR_gettid definitions */
 #include <mqueue.h>
 #include <rtdm/ipc.h>
 
@@ -1208,7 +1209,7 @@ static int test_sc_cobalt_timer_settime64(void)
 
 	sev.sigev_signo = sig;
 	sev.sigev_notify = SIGEV_THREAD_ID | SIGEV_SIGNAL;
-	sev.sigev_notify_thread_id = gettid();
+	sev.sigev_notify_thread_id = syscall(__NR_gettid);
 
 	ret = smokey_check_errno(timer_create(CLOCK_REALTIME, &sev, &t));
 	if (ret)
@@ -1271,7 +1272,7 @@ static int test_sc_cobalt_timer_gettime64(void)
 
 	sev.sigev_signo = sig;
 	sev.sigev_notify = SIGEV_THREAD_ID | SIGEV_SIGNAL;
-	sev.sigev_notify_thread_id = gettid();
+	sev.sigev_notify_thread_id = syscall(__NR_gettid);
 
 	ret = smokey_check_errno(timer_create(CLOCK_REALTIME, &sev, &t));
 	if (ret)
-- 
2.17.1

