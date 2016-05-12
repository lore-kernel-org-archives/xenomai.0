References: <573204D1.4060202@siemens.com>
 <20160510160837.GA29741@hermes.click-hack.org> <57320A7D.1060105@siemens.com>
 <20160511060545.GH13285@hermes.click-hack.org> <5732DCA4.8020404@xenomai.org>
 <5732DE63.1070003@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5734E29F.9080109@siemens.com>
Date: Thu, 12 May 2016 22:07:59 +0200
MIME-Version: 1.0
In-Reply-To: <5732DE63.1070003@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Resuming nanosleep & Co. after ignored signals
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2016-05-11 09:25, Jan Kiszka wrote:
> On 2016-05-11 09:17, Philippe Gerum wrote:
>> On 05/11/2016 08:05 AM, Gilles Chanteperdrix wrote:
>>> Since we will return from the xenomai syscall in secondary mode, we
>>> could conceivably go through the plain Linux syscall epilogue with
>>> the restart block, using a specific restart block which piggy backs
>>> into xenomai kernel. I wonder if xenomai syscall returning in
>>> secondary mode do not go through the plain Linux syscall epilogue
>>> already, actually.
>>>
>>
>> Correct, it does.
>>
> 
> I was thinking along these lines already, but it is not straightforward.
> The problems that we cannot directly use the restart mechanism. It would
> make userspace issue the restart syscall, a Linux one, but we need to
> migrate in that syscall to primary mode again. That, to my
> understanding, can only be done from within the syscall hook because
> only then we ensure running the correct syscall return path.
> 
> But we may reuse at least Linux' mechanism to decide if the syscall
> should be restarted or not by initializing and then evaluating
> restart_block.fn in our nanosleep syscall. I will play with that today.
> 

Here is the outcome which seems to work but is a bit hacky by relying on
Linux to set restart_block.fn to do_no_restart_syscall if it delivered a
signal (and by reusing the nanosleep.expires field). Feedback welcome
if / how this could be turned into an upstream feature.

Jan

diff --git a/include/cobalt/uapi/kernel/thread.h b/include/cobalt/uapi/kernel/thread.h
index 8d26f16..409e75d 100644
--- a/include/cobalt/uapi/kernel/thread.h
+++ b/include/cobalt/uapi/kernel/thread.h
@@ -77,6 +77,7 @@
 
 #define XNMOVED   0x00000001 /**< CPU migration in primary mode occurred */
 #define XNLBALERT 0x00000002 /**< Scheduler lock break alert (SIGDEBUG sent) */
+#define XNRESTART 0x00000004
 
 /** @} */
 
diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index b51cb4c..a54a516 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -237,7 +237,7 @@ int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
 			     struct timespec *rmt)
 {
 	struct xnthread *cur;
-	xnsticks_t rem;
+	xnsticks_t timeout, rem;
 	int ret = 0;
 	spl_t s;
 
@@ -261,10 +261,37 @@ int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
 
 	xnlock_get_irqsave(&nklock, s);
 
-	xnthread_suspend(cur, XNDELAY, ts2ns(rqt) + 1,
+	if (xnthread_test_localinfo(cur, XNLBALERT)) {
+		xnthread_clear_localinfo(cur, XNLBALERT);
+
+		if (current->restart_block.fn != NULL) {
+			xnlock_put_irqrestore(&nklock, s);
+
+			if (rmt)
+				ns2ts(rmt, rem > 1 ? rem : 0);
+			return -EINTR;
+		}
+
+		timeout = current->restart_block.nanosleep.expires;
+	} else
+		timeout = ts2ns(rqt);
+
+	xnthread_suspend(cur, XNDELAY, timeout + 1,
 			 clock_flag(flags, clock_id), NULL);
 
 	if (xnthread_test_info(cur, XNBREAK)) {
+		if (flags == 0 && signal_pending(current)) {
+			xnthread_set_localinfo(cur, XNLBALERT);
+
+			current->restart_block.fn = NULL;
+			current->restart_block.nanosleep.expires =
+				xntimer_get_timeout_stopped(&cur->rtimer);
+
+			xnlock_put_irqrestore(&nklock, s);
+
+			return -ERESTARTSYS;
+		}
+
 		if (flags == 0 && rmt) {
 			rem = xntimer_get_timeout_stopped(&cur->rtimer);
 			xnlock_put_irqrestore(&nklock, s);
@@ -280,7 +307,7 @@ int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
 	return ret;
 }
 
-COBALT_SYSCALL(clock_nanosleep, nonrestartable,
+COBALT_SYSCALL(clock_nanosleep, primary,
 	       (clockid_t clock_id, int flags,
 		const struct timespec __user *u_rqt,
 		struct timespec __user *u_rmt))


-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

