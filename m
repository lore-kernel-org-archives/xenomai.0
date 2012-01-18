From: Neri Marschik <n.marschik@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 18 Jan 2012 13:33:09 +0100
Message-ID: <1326889989.3822.8.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] __xnpod_schedule not getting called
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi there Xenomai community,

I am implementing a new scheduler for some project and came up with a
question. Maybe it's a beginners question based on a misunderstanding.

If I don't have a periodic task my "pick" function is not getting
called.

I put some prints into the code to see what happens:

VirtualBox kernel: [ 1052.038250] __xnpod_schedule
VirtualBox kernel: [ 1052.038252] xnsched_pick_next
VirtualBox kernel: [ 1052.038253] __xnsched_anytime_exception_pick()
VirtualBox kernel: [ 1052.038255] __xnsched_anytime_main_pick()
VirtualBox kernel: [ 1052.038257] __xnsched_idle_pick()
VirtualBox kernel: [ 1052.038690] __xnpod_schedule

This is normal behavior which repeats forever as long as there is some
periodic task running. 
If I stop this periodic task my non-periodic tasks which should be run
only once are never run because the pick() function is not called
again. 

I noticed that __xnpod_schedule doesn't get called because of this:

	if (testbits(sched->status,
		     XNKCOUT|XNINIRQ|XNSWLOCK|XNRESCHED) != XNRESCHED)
		return;

in: pod.h static inline void xnpod_schedule(void)

I'd appreciate if anyone has an idea about that.

Btw. running version 2.5.5.2


Best regards







