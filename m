From: Dmitriy Cherkasov <dmitriy@oss-tech.org>
Date: Thu, 18 Jan 2018 01:33:19 +0000
Message-Id: <1516239201-24251-2-git-send-email-dmitriy@oss-tech.org>
In-Reply-To: <1516239201-24251-1-git-send-email-dmitriy@oss-tech.org>
References: <1516239201-24251-1-git-send-email-dmitriy@oss-tech.org>
Subject: [Xenomai] [PATCH 1/3] cobalt/kernel: make signal code handling
	compatible with 4.14
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Linux does away with __SI_MASK in 4.14 (see cc731525f26af).
Update cobalt to reflect this change.

Signed-off-by: Dmitriy Cherkasov <dmitriy@oss-tech.org>
---
 kernel/cobalt/posix/signal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/posix/signal.c b/kernel/cobalt/posix/signal.c
index dc23a8e16..3d62f943e 100644
--- a/kernel/cobalt/posix/signal.c
+++ b/kernel/cobalt/posix/signal.c
@@ -341,10 +341,12 @@ static int signal_put_siginfo(void __user *u_si, const struct siginfo *si,
 	struct siginfo __user *u_p = u_si;
 	int code, ret;
 
-	/* Translate kernel codes for userland. */
 	code = si->si_code;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 14, 0)
+	/* Translate kernel codes for userland. */
 	if (code & __SI_MASK)
 		code |= __SI_MASK;
+#endif
 
 	ret = __xn_put_user(si->si_signo, &u_p->si_signo);
 	ret |= __xn_put_user(si->si_errno, &u_p->si_errno);
-- 
2.14.3


