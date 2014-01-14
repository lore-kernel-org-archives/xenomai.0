Message-ID: <52D52D60.9030500@siemens.com>
Date: Tue, 14 Jan 2014 13:28:16 +0100
From: Gernot Hillier <gernot.hillier@siemens.com>
MIME-Version: 1.0
References: <527B5BBF.2040301@siemens.com> <527BD591.9060504@xenomai.org>
 <527C7CE6.6090603@siemens.com> <527D1E27.3030708@xenomai.org>
In-Reply-To: <527D1E27.3030708@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-forge] [PATCH v2] Silence unused_result
 warning from write()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


Some glibc versions mark write() with attribute warn_unused_result (found in
Ubuntu 12.04 / eglibc 2.15 / gcc 4.6.3), so we need to silence this warning,
especially because we're building with -Werror.

Signed-off-by: Gernot Hillier <gernot.hillier@siemens.com>
---
 lib/cobalt/init.c           | 3 ++-
 testsuite/latency/latency.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

Sorry for late self follow-up, but I was a bit offline due to parental
leave...

This is a friendly reminder to v2 of the patch (already posted on
2013-11-11), adressing your comments from 2013-11-08, Gilles. I also
rebased patch to today's master. 

The "attribute unused" style was adopted from
testsuite/latency/latency.c. We still think fixing the warning in the
source code is better than in the configure command line.

diff --git a/lib/cobalt/init.c b/lib/cobalt/init.c
index 0c2b29a..c3086a9 100644
--- a/lib/cobalt/init.c
+++ b/lib/cobalt/init.c
@@ -54,7 +54,8 @@ int __rtdm_fd_start = INT_MAX;
 static void sigill_handler(int sig)
 {
 	const char m[] = "no Xenomai support in kernel?\n";
-	write(2, m, sizeof(m) - 1);
+	ssize_t rc __attribute__ ((unused));
+	rc = write(2, m, sizeof(m) - 1);
 	exit(EXIT_FAILURE);
 }
 
diff --git a/testsuite/latency/latency.c b/testsuite/latency/latency.c
index 6325672..12b90a9 100644
--- a/testsuite/latency/latency.c
+++ b/testsuite/latency/latency.c
@@ -507,7 +507,7 @@ static void sigdebug(int sig, siginfo_t *si, void *context)
 	case SIGDEBUG_WATCHDOG:
 		n = snprintf(buffer, sizeof(buffer), "%s\n",
 			     reason_str[reason]);
-		write(STDERR_FILENO, buffer, n);
+		n = write(STDERR_FILENO, buffer, n);
 		exit(EXIT_FAILURE);
 	}
 
-- 
1.8.4


