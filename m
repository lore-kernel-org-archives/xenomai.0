Message-ID: <464C5940.2040406@domain.hid>
Date: Thu, 17 May 2007 15:31:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <17996.15540.824415.263562@domain.hid>	<464C4DE4.1040402@domain.hid>	<17996.20586.564091.503622@domain.hid>	<464C51F7.3000407@domain.hid>
	<17996.21557.378577.691298@domain.hid>
In-Reply-To: <17996.21557.378577.691298@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] Use tsc for implementation
	of	clock_gettime.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Jan Kiszka wrote:
>  > >  > Gilles Chanteperdrix wrote:
>  > >  > > Hi,
>  > >  > > 
>  > >  > > here comes, for review, a patch which reduces the overhead of
>  > >  > > clock_gettime by directly reading the tsc in user-space for
>  > >  > > architectures that support it.
>  > >  > 
>  > >  > Highly welcome. But I have one concern: How and when do you propagate
>  > >  > wallclock_offset changes to user space?
>  > > 
>  > > Since clock_settime is not implemented, never, but if clock_settime was
>  > > implemented, clock_settime would re-issue the __xn_sys_info syscall.
>  > 
>  > This excludes automatic clock adjustment, something I'm convinced we
>  > will have to provide in the future.
> 
> When we provide automatic clock adjustment, we will have to devise
> something more subtle than just an offset, so we will have to redesign

I think offset + scaling factor.

> posix clocks support anyway. Maybe clock_gettime(CLOCK_REALTIME) will
> then always be a syscall. After all, rt_timer_read is a syscall. If you
> want the fast clock, use CLOCK_MONOTONIC or rt_timer_tsc.

Actually, the issue of the intermediate approach starts earlier: as soon
as you have clock_settime. Then you need to sync the offset across
applications in different processes.

Having clock_monotonic (and maybe also rt_timer_tsc2ns) as a fast
variant already now is not bad. But beyond that, before introducing a
new interface between kernel and user space, I would like to consider
the effort to get it future-proof immediately. That doesn't mean that we
already have to implement clock adjustment, but we may already prepare
the prerequisites.

Jan

