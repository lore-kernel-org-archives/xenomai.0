Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659485A4E0
	for <xenomai@lists.linux.dev>; Thu, 14 Mar 2024 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710424048; cv=none; b=Wq1YCrmpDG68oR66JWEjiCcqVe3u6upNeUl85qQMbxtFj/FaLqDkjmIqPZvEWJ3Z13HxluonCrVdDAwVAmlm2pmaPuG42foIM+Pm4DdptK45Mz0nfLHgHvq7yFlqK1o+Mx1u1y0dN/aWQ9N9LattnTLiEIa9HQVgWhoJqnDcdNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710424048; c=relaxed/simple;
	bh=wnwRZaRXfSUmj+ZyAupqowVgY/6BZPlW40L8yuab/AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=asXktntvFdMHYDW75i8+OdRcBig5mbLvP/SnEqmJJQtCocdVhfGORLAlgffVj/4vy9IJBOLJRP0FxzJ91DSknMXXMbSNpUNc8OsR2Cs90XQYAleMEgK87Ip2uyjCKTPVgWsITfuS5YjkJI1iCrOxOgQfH5ucScclNVvFkfwn05E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=Fabian.Scheler@siemens.com header.b=Efl34r9d; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=Fabian.Scheler@siemens.com header.b="Efl34r9d"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202403141347121d8aa3691774e92210
        for <xenomai@lists.linux.dev>;
        Thu, 14 Mar 2024 14:47:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Fabian.Scheler@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=5JXc6MjxT3hy7baNC6Z0f8BeZGtzgk9rKGx4DGeTZFU=;
 b=Efl34r9d+FtxeYdXRDU+JhcXV+Y0deJziDtYEz623QblV188L/wg5/KXTh0wpGhhyI/zCs
 znCDDwSDlX1bjsIm+gAKZYLO8bBebcv/Q6leOeDn8R4aAlnhrKA8klHwN2pk3/fL5hTgat32
 tW49IYWvgS/NcIpguvJuAaRq8G8+Y=;
From: Fabian Scheler <Fabian.Scheler@siemens.com>
To: xenomai@lists.linux.dev
Cc: Fabian Scheler <Fabian.Scheler@siemens.com>
Subject: [PATCH v2] testsuite/smokey/gdb: Fix race-condition
Date: Thu, 14 Mar 2024 14:44:12 +0100
Message-ID: <20240314134411.28121-2-Fabian.Scheler@siemens.com>
In-Reply-To: <55c1a08a-6b1a-4d75-8a1b-2df85bebcbe1@siemens.com>
References: <55c1a08a-6b1a-4d75-8a1b-2df85bebcbe1@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1325281:519-21489:flowmailer

When quitting gdb by sending the quit-command, gdb may actually finish before
the father-process calls pause. In that case the father-process would wait
endlessly.

The fix now uses waitpid instead of pause to explicitly wait for the
child-process, in contrast to pause waitpid also handles child-processes that
already have been terminated.

Signed-off-by: Fabian Scheler <Fabian.Scheler@siemens.com>
---
 testsuite/smokey/gdb/gdb.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/testsuite/smokey/gdb/gdb.c b/testsuite/smokey/gdb/gdb.c
index b09b78b4e..1daa7ee4c 100644
--- a/testsuite/smokey/gdb/gdb.c
+++ b/testsuite/smokey/gdb/gdb.c
@@ -78,7 +78,7 @@ static void handle_sigchld(int signum)
 	if (WEXITSTATUS(status) == ESRCH)
 		smokey_note("gdb: skipped (gdb not available)");
 	else
-		check("gdb execution", WEXITSTATUS(status), 0);
+		check("gdb terminated unexpectedly", 0, 1);
 	child_terminated = 1;
 	close(pipe_out[0]);
 }
@@ -202,6 +202,8 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
 	pthread_attr_t attr;
 	char run_param[32];
 	cpu_set_t cpu_set;
+	pid_t childpid;
+	int status;
 	int err;
 
 	smokey_parse_args(t, argc, argv);
@@ -257,7 +259,8 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
 		err = pipe(pipe_out);
 		check_no_error("pipe_out", err);
 
-		switch (do_fork()) {
+		childpid = do_fork();
+		switch (childpid) {
 		case -1:
 			error(1, errno, "fork/vfork");
 
@@ -283,8 +286,14 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
 
 		default:
 			wait_for_pattern("(gdb) ");
+
+			/* the signal handler only is used to skip the test if
+			   gdb is missing */
 			if (child_terminated)
 				break;
+			else
+				signal(SIGCHLD, SIG_DFL);
+
 			send_command("b breakpoint_target\n", 1);
 			send_command("r\n", 1);
 
@@ -301,13 +310,11 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
 			eval_expression("thread_loops==expected_loops", "1");
 
 			send_command("q\n", 0);
-			pause();
 
-			if (!child_terminated) {
-				fprintf(stderr,
-					"FAILURE: gdb still running?!\n");
-				exit(1);
-			}
+			err = waitpid(childpid, &status, 0);
+			check("waitpid", err, childpid);
+			check("gdb execution", WEXITSTATUS(status), 0);
+			close(pipe_out[0]);
 		}
 
 		signal(SIGCHLD, SIG_DFL);
-- 
2.44.0

