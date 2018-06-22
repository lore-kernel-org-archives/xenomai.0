From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Fri, 22 Jun 2018 17:42:36 +0200
Message-Id: <dd9727ae6401dc7afc6d71cd383b89f7fa83078e.1529682156.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1529682156.git.jan.kiszka@siemens.com>
References: <cover.1529682156.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1529682156.git.jan.kiszka@siemens.com>
References: <cover.1529682156.git.jan.kiszka@siemens.com>
Subject: [Xenomai] [PATCH 4/4] cobalt/posix: Evaluate return code of
	signal_copyinfo extensions
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

They may fail as well, requiring us to return that code to the caller of
signal_wait.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/signal.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/cobalt/posix/signal.c b/kernel/cobalt/posix/signal.c
index 9d8353bbc2..7090754418 100644
--- a/kernel/cobalt/posix/signal.c
+++ b/kernel/cobalt/posix/signal.c
@@ -341,17 +341,18 @@ done:
 		ret = sys32_put_siginfo(u_si, sip, overrun);
 		if (!ret)
 			/* Allow an extended target to receive more data. */
-			cobalt_call_extension(signal_copyinfo_compat,
-					      &curr->extref, ret, u_si, sip,
-					      overrun);
+			ret = cobalt_call_extension(signal_copyinfo_compat,
+						    &curr->extref, ret, u_si,
+						    sip, overrun);
 	} else
 #endif
 	{
 		ret = signal_put_siginfo(u_si, sip, overrun);
 		if (!ret)
 			/* Allow an extended target to receive more data. */
-			cobalt_call_extension(signal_copyinfo, &curr->extref,
-					      ret, u_si, sip, overrun);
+			ret = cobalt_call_extension(signal_copyinfo,
+						    &curr->extref, ret, u_si,
+						    sip, overrun);
 	}
 
 out:
-- 
2.13.7


