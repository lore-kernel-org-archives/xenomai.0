From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1242330281.3919.12.camel@domain.hid>
References: <1242330281.3919.12.camel@domain.hid>
Content-Type: text/plain
Date: Sun, 17 May 2009 12:55:46 +0200
Message-Id: <1242557746.17138.43.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Xenomai standalone
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Patrick <kpa_info@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 2009-05-14 at 21:44 +0200, Patrick wrote:
> Hello all,
> 
> I would like to know if it's possible to simply "separate" Xenomai
> (nucleus) from Linux and adeos ? My goal is to have a simple RTOS based
> on Xenomai (only native skin in kernel space).
> 
> I have done a quick look at the source and it's seems ok to remove adeos
> by editing hal. About linux, Xenomai seems to need only MM, timer, and
> some part of irq management. Is that right ?
> 
> So do you think that it would be possible to run Xenomai nucleus as a
> standalone RTOS ?
> 

It is, and has already been done actually.

You may want to track how the nucleus and skins are moved on top of the
event-driven simulator running in user-space: i.e. include/asm-sim,
__XENO_SIM__ define. The simulator is basically a C++ library providing
co-routines, and a set of building blocks to mimick typical RTOS
resources (synchs, threads, interrupts etc).

Two more hints:
- the simulator is a good analogy for your problem, because the
simulation engine cannot provide any Linux kernel services, since it is
fully based on userland resources (in this case: from the glibc).
Therefore, if you don't have Linux underneath, this applies as well to
your case.
- track the xnarch_* interface from asm-sim/ (and elsewhere), how it is
implemented, what set of services is defined here. This is key to your
problem.

> Thanks in advance for any help
> 
> Patrick
> 
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



