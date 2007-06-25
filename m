From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <467F5CBF.9040108@domain.hid>
References: <467CD519.1060802@domain.hid> <1182594345.6000.9.camel@domain.hid>
	<467D0684.7030604@domain.hid> <1182623858.6000.139.camel@domain.hid>
	<467E2E9C.90905@domain.hid> <1182708919.7044.201.camel@domain.hid>
	<467F5CBF.9040108@domain.hid>
Content-Type: text/plain
Date: Tue, 26 Jun 2007 00:15:50 +0200
Message-Id: <1182809750.1563.77.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Monotonic, realtime, and other timers
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

On Mon, 2007-06-25 at 08:12 +0200, Jan Kiszka wrote:
> Ok, I think it's time to summarise some results of this thread:
> 
>  - xntimers will be of three kinds: real-time absolute, monotonic
>    absolute, and monotonic relative ones (ie. all POSIX). I'm currently
>    in favour of passing this property on timer start and not pushing
>    parts or more of it into timer init.

I will probably experiment this change in the course of x3-devel anyway,
we'll see what we get from it then.

> 
>  - XNTBISOL will be introduced, a flag that, if set, declares a time
>    base being isolated from the master base (and associates). In my
>    understanding, this flag should be passed to xntbase_alloc and should
>    also leave the wallclock offset initially untouched again.
> 
>  - On xntbase_adjust_time, first define the set of affected time bases:
>    if XNTBISOL is set, only touch the passed base, if it is not set,
>    change all bases in the system that have it cleared as well. For this
>    set of time bases, modify the offset and adjust all running real-time
>    timers.
> 
>  - Make all legacy RTOS skins isolated by default again, but offer a
>    runtime or compile-time switch to add them individually to the gang
>    of synchronised time bases (i.e. POSIX, native, RTDM).
> 
> Did I get it correctly?
> 

Looks good. Regarding the monotonic support, I tend to agree with you:
let's avoid conversions especially if doing so is cheap
implementation-wise.

> Jan
> 
-- 
Philippe.



