References: <55ED7A9E.1080209@gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55ED8875.10504@xenomai.org>
Date: Mon, 7 Sep 2015 14:52:05 +0200
MIME-Version: 1.0
In-Reply-To: <55ED7A9E.1080209@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] timer_create( ) example in Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Konstantinos Chalas <konchalas@gmail.com>, Xenomai <xenomai@xenomai.org>

On 09/07/2015 01:53 PM, Konstantinos Chalas wrote:
> Hello everyone,
> 
> Does any of you have a working implementation of timer_create( ) in
> Xenomai-3?
> 
> According to the documentation /only thread-directed notification is
> supported (evp->sigev_notify set to//SIGEV_THREAD_ID//). The thing is
> that the use of //SIG/EV_THREAD_ID is not common, therefore it is hard
> to find any help.../
>

evp->sigev_notify_thread_id must be set with your recipient thread ID.
There is nothing special otherwise.

> /By the way, the example provided at the end of
> http://www.softprayog.in/tutorials/alarm-sleep-and-high-resolution-timers,
> crashes my system. I understand that it doesn't comply with Xenomai
> documentation, but should it crash the whole system?
> 

You've just proved Murphy's law article #27 is right, "If you perceive
that there are four possible ways a procedure can go wrong, and you
circumvent these, then a fifth way, unprepared for, will promptly develop".

diff --git a/kernel/cobalt/posix/timer.c b/kernel/cobalt/posix/timer.c
index e5551b3..8c4d2da 100644
--- a/kernel/cobalt/posix/timer.c
+++ b/kernel/cobalt/posix/timer.c
@@ -67,8 +67,10 @@ timer_init(struct cobalt_timer *timer,
 	    timer->clockid != CLOCK_REALTIME)
 		return ERR_PTR(-EINVAL);

-	if (evp == NULL || evp->sigev_notify == SIGEV_NONE)
-		return owner;	/* Assume SIGEV_THREAD_ID. */
+	if (evp == NULL || evp->sigev_notify == SIGEV_NONE) {
+		target = owner;	/* Assume SIGEV_THREAD_ID. */
+		goto init;
+	}

 	if (evp->sigev_notify != SIGEV_THREAD_ID)
 		return ERR_PTR(-EINVAL);
@@ -80,7 +82,7 @@ timer_init(struct cobalt_timer *timer,
 	target = cobalt_thread_find_local(evp->sigev_notify_thread_id);
 	if (target == NULL)
 		return ERR_PTR(-EINVAL);
-
+init:
 	/*
 	 * All standard clocks are based on the core clock, and we
 	 * want to deliver a signal when a timer elapses.
-- 
Philippe.

