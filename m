Message-ID: <527B5BBF.2040301@siemens.com>
Date: Thu, 07 Nov 2013 10:22:07 +0100
From: Gernot Hillier <gernot.hillier@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [Xenomai-forge] [PATCH] Silence unused_result warning
	from write()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Some glibc versions mark write() with attribute warn_unused_result (found in
Ubuntu 12.04 / eglibc 2.15 / gcc 4.6.3), so we need to silence this warning,
especially when building with -Werror.

Signed-off-by: Gernot Hillier <gernot.hillier@siemens.com>
---
 lib/cobalt/init.c           | 4 +++-
 testsuite/latency/latency.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/cobalt/init.c b/lib/cobalt/init.c
index 101a2bd..568f9d0 100644
--- a/lib/cobalt/init.c
+++ b/lib/cobalt/init.c
@@ -53,7 +53,9 @@ int __rtdm_fd_start = INT_MAX;
 static void sigill_handler(int sig)
 {
 	const char m[] = "no Xenomai support in kernel?\n";
-	write(2, m, sizeof(m) - 1);
+	if (write(2, m, sizeof(m) - 1) < 1) {
+		/* Silence unused_result warning. No handling in error case, though. */
+	}
 	exit(EXIT_FAILURE);
 }
 
diff --git a/testsuite/latency/latency.c b/testsuite/latency/latency.c
index 7c5099b..b9e1f00 100644
--- a/testsuite/latency/latency.c
+++ b/testsuite/latency/latency.c
@@ -507,7 +507,9 @@ static void sigdebug(int sig, siginfo_t *si, void *context)
 	case SIGDEBUG_WATCHDOG:
 		n = snprintf(buffer, sizeof(buffer), "%s\n",
 			     reason_str[reason]);
-		write(STDERR_FILENO, buffer, n);
+		if (write(STDERR_FILENO, buffer, n) < 1) {
+			/* Silence unused_result warning. No handling in error case, though. */
+		}
 		exit(EXIT_FAILURE);
 	}
 
-- 
1.8.1.2

-- 
Regards,

Gernot Hillier
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

