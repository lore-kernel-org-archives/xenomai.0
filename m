From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <97d8ea3a-e038-af23-7032-a6522de81ab7@siemens.com>
Date: Mon, 3 Sep 2018 19:07:07 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] Revert "cobalt/posix: Evaluate return code of
 signal_copyinfo extensions"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

This reverts commit e2520f8143c816b90d1531e36a405879fb640459.

The change was simply wrong, the return code was already passed, but
that is hidden in the parameter list of cobalt_call_extension. The
latter return 1 if a callback was invoked.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/signal.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/cobalt/posix/signal.c b/kernel/cobalt/posix/signal.c
index 8e4d920b2d..cea67cd435 100644
--- a/kernel/cobalt/posix/signal.c
+++ b/kernel/cobalt/posix/signal.c
@@ -349,18 +349,17 @@ done:
 		ret = sys32_put_siginfo(u_si, sip, overrun);
 		if (!ret)
 			/* Allow an extended target to receive more data. */
-			ret = cobalt_call_extension(signal_copyinfo_compat,
-						    &curr->extref, ret, u_si,
-						    sip, overrun);
+			cobalt_call_extension(signal_copyinfo_compat,
+					      &curr->extref, ret, u_si, sip,
+					      overrun);
 	} else
 #endif
 	{
 		ret = signal_put_siginfo(u_si, sip, overrun);
 		if (!ret)
 			/* Allow an extended target to receive more data. */
-			ret = cobalt_call_extension(signal_copyinfo,
-						    &curr->extref, ret, u_si,
-						    sip, overrun);
+			cobalt_call_extension(signal_copyinfo, &curr->extref,
+					      ret, u_si, sip, overrun);
 	}
 
 out:
-- 
2.16.4

