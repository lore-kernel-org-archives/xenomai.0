Message-ID: <43BBFCB6.9080601@domain.hid>
Date: Wed, 04 Jan 2006 17:49:58 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RTDM timerbench problems
References: <1136391676.5443.57.camel@domain.hid>
In-Reply-To: <1136391676.5443.57.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6B6C7F75AE74A9657301E9DF"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stelian Pop <stelian.pop@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6B6C7F75AE74A9657301E9DF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Stelian Pop wrote:
> Hi,
> 
> I'm trying to use the xeno_timerbench as a replacement to the old 2.0
> klatency module and I encounter some problems.
> 
> This is on my in-progress ARM Xenomai port. User space latency and old
> klatency work great (my board has some hardware latency problems though
> - latencies can be as high as 500 us..). This in on a 2.6.14.5 kernel
> using the latest ipipe patch and the latest SVN trunk xenomai.
> 
> Note that I never used the RTDM skin until now, so the problem could be
> as well in the core RTDM code.

Almost impossible - there are no bugs! ;)

> 
> 1) When compiled statically into the kernel, it does not work at all:
> 	# /usr/xenomai/testsuite/latency/latency -p 10000 -t 1
> 	== Sampling period: 10000 us
> 	== Test mode: in-kernel periodic task
> 	latency: failed to open benchmark device, code -19
> 	(modprobe xeno_timerbench?)
> 
> 2) When loaded as a module, it does work in -t 2 mode (kernel timer
> handler):
> 	# /usr/xenomai/testsuite/latency/latency -p 10000 -t 2
> 	== Sampling period: 10000 us
> 	== Test mode: in-kernel timer handler
> 	warming up...
> 	RTT|  00:00:01  (in-kernel timer handler, 10000 us period)
> 	RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
> 	RTD|        6000|       14640|       72000|       0|        6000|       72000
> 	RTD|        7000|       15060|       65000|       0|        6000|       72000
> 	RTD|        7000|       15470|       72000|       0|        6000|       72000
> 	---|------------|------------|------------|--------|-------------------------
> 	RTS|        6000|       15056|       72000|       0|    00:00:03/00:00:03
> 
> But in -t 1 mode (kernel periodic task) it hangs hard just after the warming period:
> 
> 	# /usr/xenomai/testsuite/latency/latency -p 10000 -t 1
> 	== Sampling period: 10000 us
> 	== Test mode: in-kernel periodic task
> 	warming up...
> 
> Before hanging, sometimes it just prints:
> 	Unable to handle kernel NULL pointer dereference at virtual address 0000004d
> 
> Sometimes the oops is more complete (note that sometimes it also hangs in the middle of
> the printout):
> 	Unable to handle kernel NULL pointer dereference at virtual address 0000004d
> 	pgd = c0004000
> 	[0000004d] *pgd=00000000
> 	Internal error: Oops: 817 [#1]
> 	Modules linked in: xeno_timerbench
> 	CPU: 0
> 	PC is at xnpod_schedule+0x6b4/0x7f0
> 	LR is at xnpod_schedule+0x54c/0x7f0
> 	pc : [<c0056cc4>]    lr : [<c0056b5c>]    Not tainted
> 	sp : c7d41830  ip : c79e8044  fp : c7d41860
> 	r10: c0283c2c  r9 : c0282
> 
> Does this rings a bell to someone ? 

Well, seriously, I don't believe it's a RTDM-related issue as the
invocation of the timer-handler and the kernel-task tests are quite
similar. The former works, the latter fails inside the scheduler, this
rather indicates some issue in the arch-specific part of the scheduler
(the timer test runs in IRQ-context).

Did you test some RTDM or native kernel-only timed-task before? With
RTDM this can be as trivial as this one:


#include <rtdm/rtdm_driver.h>

rtdm_task_t heartbeat_task;
int         end = 0;

#define HEARTBEAT_PERIOD    100000000   /* 100 ms */

void heartbeat(void *cookie)

{
    while (!end) {
        rtdm_task_wait_period();

        rtdm_printk("I'm alive.");
    }
}

int init_module(void)
{
    return rtdm_task_init(&heartbeat_task, "heartbeat", heartbeat, NULL,
                          99, HEARTBEAT_PERIOD);
}

void cleanup_module(void)
{
    end = 1;
    rtdm_task_join_nrt(&heartbeat_task, 100);
}


Jan

--------------enig6B6C7F75AE74A9657301E9DF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDu/y2niDOoMHTA+kRAhdmAJ91r9B/18S4+K39dSHR6wzHiOBV8QCfWm1m
LIEbNm8BamFxx0pU49zkoQw=
=Beb6
-----END PGP SIGNATURE-----

--------------enig6B6C7F75AE74A9657301E9DF--

