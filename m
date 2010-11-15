From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTinuEh+5J4Osq895PN92VXNc1OgNF8HD526f--dA@mail.gmail.com>
References: <AANLkTinuEh+5J4Osq895PN92VXNc1OgNF8HD526f--dA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 15 Nov 2010 10:30:22 +0100
Message-ID: <1289813422.1933.79.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Debug/trace tools for xenomai applications.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ronny meeus <ronny.meeus@domain.hid>
Cc: Xenomai-help@domain.hid

On Sun, 2010-11-14 at 01:24 +0100, ronny meeus wrote:
> Hello
> 
> I'm currently fighting with a problem in the pSOS+ skin.
> This my system information:
> 
> [    2.314676] pci 0000:00:01.0: Activating ISA DMA hang workarounds
> [    2.416025] I-pipe: Domain Xenomai registered.
> [    2.418183] Xenomai: hal/i386 started.
> [    2.422780] Xenomai: scheduling class idle registered.
> [    2.424116] Xenomai: scheduling class rt registered.
> [    2.566737] Xenomai: real-time nucleus v2.5.4 (Sleep Walk) loaded.
> [    2.590628] Xenomai: starting native API services.
> [    2.604491] Xenomai: starting pSOS+ services.
> [    2.619941] HugeTLB registered 4 MB page size, pre-allocated 0
> pages
> 
> This is a piece of testcode I have created:
> 
>         check("tm_evevery",tm_evevery(4,3,&tmr_id),0);
>         check("tm_cancel",tm_cancel(tmr_id),0);
>         ev_rcvd = 0;
>         ret = ev_receive(4,EV_ANY|EV_WAIT,10,&ev_rcvd);
>         check("ev_receive",ret,ERR_TIMEOUT);
> 
> I just start a periodic timer that expires every 3 ticks and at expiry
> sends event 4 to my task.

You test rather arms a timer for sending event_list=0x3 each 4 ticks.

> I want to check the cancel of the timer, so I cancel it and I would
> expect not to receive any event.
> 
> What I observe is that this code is not working: I immediately receive
> the event after starting the timer.

Please try this test code as well:

#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/mman.h>
#include <psos+/psos.h>

void foo (u_long a0, u_long a1, u_long a2, u_long a3)
{
	u_long ret, ev = 0, tmid;

	printf("Started... (%lu, %lu, %lu, %lu)\n", a0, a1, a2, a3);
	ret = tm_evevery(4, 3, &tmid);
	printf("tm_evevery(4, 3, &tmid) => %lu\n", ret);

	ret = tm_cancel(tmid);
	printf("tm_cancel(&tmid) => %lu\n", ret);

	ret = ev_receive(4, EV_ANY|EV_WAIT, 10, &ev);
	printf("ev_receive(4, EV_ANY|EV_WAIT, 10, &ev) => %lu, ev=0x%lx\n", ret, ev);
}

int main (int ac, char **av)
{
	u_long ret, tid = 0, args[4];
	
	mlockall(MCL_CURRENT | MCL_FUTURE);

	ret = t_create("TEST", 1, 0, 0, 0, &tid);
	printf("t_create(tid=%lu) = %lu\n", tid, ret);
	args[0] = 1;
	args[1] = 2;
	args[2] = 3;
	args[3] = 4;
	ret = t_start(tid, 0, foo, args);
	printf("t_start(tid=%lu) = %lu\n", tid, ret);

	return 0;
}

> If I change the code like shown below (I added the ev_receive with the
> NO_WAIT option after starting the timer), the code works fine.
> 
>         check("tm_evevery",tm_evevery(4,3,&tmr_id),0);
>         ret = ev_receive(4,EV_ANY|EV_NOWAIT,0,&ev_rcvd);

Do you receive ERR_NOEVS as expected here?

>         check("tm_cancel",tm_cancel(tmr_id),0);
>         ev_rcvd = 0;
>         ret = ev_receive(4,EV_ANY|EV_WAIT,10,&ev_rcvd);
>         check("ev_receive",ret,ERR_TIMEOUT);
> 


> Now my question is: how do I investigate an issue like this? In other
> words, which are the best tools since this code involves both user and
> kernel space debugging.
> Are there some trace tools available that are able to generate a kind
> of sequence / trace of what is happing over time.
> 
> I also have other issues that are not consistently reproducible. For
> this kind of problems trace tools would also be useful.
> 

If you want to validate the pSOS emulation core, the best tool is the
simulator. Unfortunately, this tools still requires to be built with an
antiquated C++ toolchain, so the only sane way to enable it nowadays is
via qemu. You would need ~2 hours to set this up.

If you want to try this, I can help. Otherwise, other suggestions you
already got on this list will do.

> Thanks
> Ronny
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



