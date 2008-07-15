Message-ID: <487C42CB.5080405@domain.hid>
Date: Tue, 15 Jul 2008 08:25:15 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <487B8B3E.8020805@domain.hid> <487B91F6.3070909@domain.hid>
	<487BA305.6040401@domain.hid> <487BB89B.6010604@domain.hid>
	<487BF171.2090902@domain.hid>
In-Reply-To: <487BF171.2090902@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_bind() and timeout values
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

Stefan Kisdaroczi wrote:
> Hi Philippe,
> 
> the attached patch fixed the problem for me.

Good spot. Now it's official, since four years that feature exists or so, nobody
actually used registry timeouts... Oh, well...

> However, i think that in the "break case" still EACCES is returned.
> Can the break be replaced with a "return ETIMEDOUT" ?
>

Yes, normally we should do that along with your patch. Actually, the most
appropriate fix would be to use an absolute timeout value internally, since the
nucleus allows it.

--- ksrc/nucleus/registry.c	(revision 4044)
+++ ksrc/nucleus/registry.c	(working copy)
@@ -711,7 +711,6 @@
 	xnobject_t *object;
 	xnthread_t *thread;
 	xntbase_t *tbase;
-	xnticks_t stime;
 	int err = 0;
 	spl_t s;

@@ -723,7 +722,8 @@

 	xnlock_get_irqsave(&nklock, s);

-	stime = xntbase_get_time(tbase);
+	if (timeout != TM_NONBLOCK && timeout != TM_INFINITE)
+		timeout += xntbase_get_time(tbase);

 	for (;;) {
 		object = registry_hash_find(key);
@@ -738,18 +738,8 @@
 			goto unlock_and_exit;
 		}

-		if (timeout != XN_INFINITE) {
-			xnticks_t now = xntbase_get_time(tbase);
-
-			if (stime + timeout >= now)
-				break;
-
-			timeout -= (now - stime);
-			stime = now;
-		}
-
 		thread->registry.waitkey = key;
-		xnsynch_sleep_on(&registry_hash_synch, timeout, XN_RELATIVE);
+		xnsynch_sleep_on(&registry_hash_synch, timeout, XN_ABSOLUTE);

 		if (xnthread_test_info(thread, XNTIMEO)) {
 			err = -ETIMEDOUT;
 --
Philippe.


