Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C7D43AAF
	for <xenomai@lists.linux.dev>; Tue, 12 Mar 2024 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710225585; cv=none; b=Fh8700UEq+DR0Du/pmBbXQcfW70tPDiKY8ULk7HQIN2hyXr8nwsnuKQ5cmWIUvlEZLH+g7J7DYnKvKwZ9RhLAxDW1pehFzJmwUjPDVaIHMm5nP9X38YGLaVA/5O3FgDVUabfB7P0rKu3SzK66putqxKUQqfKjbWImBE7rudxBiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710225585; c=relaxed/simple;
	bh=kI6lr4pwF4xxwcdR7B0lqJ87cJIrdX9m6A+Gcaj1YCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dE21QNP02pb9nDLkT2sPygDfGUHNaOepbtvf7ySMBEZNvCThfPxe5xJ56c2ttyiFrOouBS+iCcXBF96aP61YLjKl1baOsHaFStcOl5hjyMOdcvqupWBTruvG5Cz1pv7wmUe287+6SU+swU8ZWn5ThP/CXPvrNfiaGVE4d9Hya+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=Fabian.Scheler@siemens.com header.b=UsEYMMKm; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=Fabian.Scheler@siemens.com header.b="UsEYMMKm"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240312063931db87e203fe8f02817d
        for <xenomai@lists.linux.dev>;
        Tue, 12 Mar 2024 07:39:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Fabian.Scheler@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=xykH+ZXoBWq0AhncTZRAvEhv0ILUKPhH87G6QBgXhDk=;
 b=UsEYMMKmaIjypmKkym8VKZ7FrCxB+PKhVwVMyy4JsI8svXkVXj3R+/WwbeMKfmWujsgFZ8
 Tj4dyG6tpW7pwA3robT1xBtcV+xJ84960kQhmLGA1dkFZ7AC0jaS/DhXmMq7XM51aUKHAoTn
 X99kggM2UMeKjacsXIjWa4Js5KHR0=;
From: Fabian Scheler <Fabian.Scheler@siemens.com>
To: xenomai@lists.linux.dev
Cc: Fabian Scheler <Fabian.Scheler@siemens.com>
Subject: [PATCH] testsuite/smokey/gdb: Fix race-condition
Date: Tue, 12 Mar 2024 07:38:13 +0100
Message-ID: <20240312063813.27021-1-Fabian.Scheler@siemens.com>
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
 testsuite/smokey/gdb/gdb.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/testsuite/smokey/gdb/gdb.c b/testsuite/smokey/gdb/gdb.c
index b09b78b4e..5e9e9d101 100644
--- a/testsuite/smokey/gdb/gdb.c
+++ b/testsuite/smokey/gdb/gdb.c
@@ -77,8 +77,7 @@ static void handle_sigchld(int signum)
 	wait(&status);
 	if (WEXITSTATUS(status) == ESRCH)
 		smokey_note("gdb: skipped (gdb not available)");
-	else
-		check("gdb execution", WEXITSTATUS(status), 0);
+
 	child_terminated = 1;
 	close(pipe_out[0]);
 }
@@ -202,6 +201,8 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
 	pthread_attr_t attr;
 	char run_param[32];
 	cpu_set_t cpu_set;
+	pid_t childpid;
+	int status;
 	int err;
 
 	smokey_parse_args(t, argc, argv);
@@ -257,7 +258,8 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
 		err = pipe(pipe_out);
 		check_no_error("pipe_out", err);
 
-		switch (do_fork()) {
+		childpid = do_fork();
+		switch (childpid) {
 		case -1:
 			error(1, errno, "fork/vfork");
 
@@ -283,8 +285,14 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
 
 		default:
 			wait_for_pattern("(gdb) ");
+
+			/* the signal handler only is used to skip the test if
+			   gdb is missing */
 			if (child_terminated)
 				break;
+                        else
+				signal(SIGCHLD, SIG_DFL);
+
 			send_command("b breakpoint_target\n", 1);
 			send_command("r\n", 1);
 
@@ -301,13 +309,11 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
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

