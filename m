Message-ID: <4F187F23.6090006@domain.hid>
Date: Thu, 19 Jan 2012 21:37:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1326889989.3822.8.camel@domain.hid>
In-Reply-To: <1326889989.3822.8.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] __xnpod_schedule not getting called
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Neri Marschik <n.marschik@domain.hid>
Cc: xenomai@xenomai.org

On 01/18/2012 01:33 PM, Neri Marschik wrote:
> Hi there Xenomai community,
> 
> I am implementing a new scheduler for some project and came up with a
> question. Maybe it's a beginners question based on a misunderstanding.
> 
> If I don't have a periodic task my "pick" function is not getting
> called.
> 
> I put some prints into the code to see what happens:
> 
> VirtualBox kernel: [ 1052.038250] __xnpod_schedule
> VirtualBox kernel: [ 1052.038252] xnsched_pick_next
> VirtualBox kernel: [ 1052.038253] __xnsched_anytime_exception_pick()
> VirtualBox kernel: [ 1052.038255] __xnsched_anytime_main_pick()
> VirtualBox kernel: [ 1052.038257] __xnsched_idle_pick()
> VirtualBox kernel: [ 1052.038690] __xnpod_schedule
> 
> This is normal behavior which repeats forever as long as there is some
> periodic task running. 
> If I stop this periodic task my non-periodic tasks which should be run
> only once are never run because the pick() function is not called
> again. 
> 
> I noticed that __xnpod_schedule doesn't get called because of this:
> 
> 	if (testbits(sched->status,
> 		     XNKCOUT|XNINIRQ|XNSWLOCK|XNRESCHED) != XNRESCHED)
> 		return;
> 
> in: pod.h static inline void xnpod_schedule(void)
> 
> I'd appreciate if anyone has an idea about that.
> 
> Btw. running version 2.5.5.2

Do you reproduce the same behaviour with xenomai 2.5.6?

-- 
                                                                Gilles.

