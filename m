Message-ID: <49809064.9050807@domain.hid>
Date: Wed, 28 Jan 2009 18:05:40 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <498085C2.7090604@domain.hid>
In-Reply-To: <498085C2.7090604@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] trunk: xnsched_set_policy seems to set only cprio
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> unfortunately I'm forced to switch to other bugs, but I found out a bit
> more about the issue that pthread_getschedparam doesn't return the
> correct policy&prio under trunk - at least when called from threads
> created via pthread_create as SCHED_FIFO:
> 
> Such threads start with SCHED_OTHER, but then the propagation via
> do_setsched_event and finally xnsched_set_policy only seems to affect
> thread.cprio, not bprio. Will see if I can continue debugging this
> later, but maybe /someone/ already knows what goes wrong...
> 

With the new scheduler infrastructure, ->bprio tends to be used solely as a
priority backup area when dealing with PIP; but at the same time, some skins
still consider it as an always up-to-date location where to find the nominal
priority of a thread, so this hunk should help in keeping things compatible with
2.4.x:

diff --git a/ksrc/nucleus/sched.c b/ksrc/nucleus/sched.c
index 8d50a6b..3b95fbb 100644
--- a/ksrc/nucleus/sched.c
+++ b/ksrc/nucleus/sched.c
@@ -395,6 +395,7 @@ int xnsched_set_policy(struct xnthread *thread,
 	thread->sched_class = sched_class;
 	thread->base_class = sched_class;
 	xnsched_setparam(thread, p);
+	thread->bprio = thread->cprio;

 	if (xnthread_test_state(thread, XNREADY))
 		xnsched_enqueue(thread);

> Thanks,
> Jan
> 


-- 
Philippe.

