Message-ID: <521364EF.8050006@siemens.com>
Date: Tue, 20 Aug 2013 14:45:35 +0200
From: Gernot Hillier <gernot.hillier@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] xeno-regression-test returns SUCCESS when Xenomai not
	available
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi there!

I'm currently working on an automatic test environment for Xenomai
kernels. Sometimes, Xenomai integration into my kernel fails completely 
and I expected this to be detected in a xeno-regression-test run - however:

root@localhost:~# xeno-regression-test && echo Worked.
Started child 28231: /bin/bash 
/usr/lib/xenomai/testsuite/xeno-test-run-wrapper 
/usr/bin/xeno-regression-test
++ echo 0
/usr/bin/xeno-regression-test: line 38: /proc/xenomai/latency: No such 
file or directory
++ :
++ /usr/lib/xenomai/testsuite/arith
Xenomai: /dev/rtheap is missing
(chardev, major=10 minor=254)
Worked.

Looking into xeno-test-run.c, I see that a dead script child is not
causing an error exit of xeno-test-run in handle_script_child().

Is there any special reason for that behaviour or could we just add a
comparable EXIT_FAILURE branch as in handle_checked_child(), something
like

--- src/testsuite/xeno-test/xeno-test-run.c.orig        2013-08-20 
10:10:04.452067093 +0200
+++ src/testsuite/xeno-test/xeno-test-run.c     2013-08-20 
13:10:12.739924212 +0200
@@ -420,7 +418,14 @@ void handle_script_child(struct child *c
         int rc;

         if (child->dead) {
+               int status = child->exit_status;
                 child_cleanup(child);
+               if (WIFEXITED(status)) {
+                       fail_fprintf(stderr,
+                                  "child %d exited with status %d\n",
+                                  child->pid, WEXITSTATUS(status));
+                       exit(EXIT_FAILURE);
+               }
                 return;
         }

However, as I didn't really get the concept yet how script and checked
clients work together, I'm not sure whether this is the right way to 
fix(?) that behaviour.

-- 
With kind regards,
Gernot Hillier

Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

