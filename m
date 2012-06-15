Message-ID: <4FDBA50D.6060605@xenomai.org>
Date: Fri, 15 Jun 2012 23:11:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4FDB96AE.4090008@antcom.de>
In-Reply-To: <4FDB96AE.4090008@antcom.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Debian bug report #677633: Xenomai posix skin : bug
 with nanosleep function
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roland Stigge <stigge@antcom.de>
Cc: 677633@bugs.debian.org, Xenomai@xenomai.org

On 06/15/2012 10:10 PM, Roland Stigge wrote:
> 
> Hi,
> 
> The nanosleep_test.c code shows a malfunction of the nanosleep function
> when a timer periodically triggering a signal.
> When nanosleep is interrupted the variable holding the rest of the time
> to sleep is immediately zero.
> 
> 
> 
> However, no bug is reported without the xenomai's posix skin.

The following patch should fix the bug:
diff --git a/ksrc/skins/posix/clock.c b/ksrc/skins/posix/clock.c
index 024260d..107ebb0 100644
--- a/ksrc/skins/posix/clock.c
+++ b/ksrc/skins/posix/clock.c
@@ -336,15 +336,12 @@ int clock_nanosleep(clockid_t clock_id,
        if (xnthread_test_info(cur, XNBREAK)) {

                if (flags == 0 && rmtp) {
-                       xnticks_t now, expiry;
                        xnsticks_t rem;

-                       now = clock_get_ticks(clock_id);
-                       expiry = xntimer_get_date(&cur->rtimer);
+                       rem = xntimer_get_timeout_stopped(&cur->rtimer);
                        xnlock_put_irqrestore(&nklock, s);
-                       rem = expiry - now;

-                       ticks2ts(rmtp, rem > 0 ? rem : 0);
+                       ticks2ts(rmtp, rem > 1 ? rem : 0);
                } else
                        xnlock_put_irqrestore(&nklock, s);

Note however that with xenomai, a signal received during nanosleep will
trigger a switch to secondary mode. So, this usage is only possible for
a real-time thread in exceptional conditions (to handle an error for
instance), not when latency matters.

-- 
                                                                Gilles.

