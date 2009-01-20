Message-ID: <4975F2DA.30701@domain.hid>
Date: Tue, 20 Jan 2009 16:50:50 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7AD384F9@domain.hid>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7AD384F9@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] uClibc compile failure
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
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Fillod Stephane wrote:
> Hi,
> 
> I haven't seen a reply to this patch, maybe it has been missed?
>

Actually, it was on queue but delayed by the inlined patch.
The shm_open/unlink should be fixed by now in both the v2.4.x and trunk
branches, I stumbled over them as well while hacking on Blackfin a few weeks
ago; please confirm.

My concern with the inlined patch is basically that it looks like papering over
the problem, but the task will not run in the SCHED_FIFO class anyway, because
it will fail again in the trampoline. However, we do need that task to run in
the SCHED_FIFO class for a number of internal reasons. Could you confirm that
behavior on your target?

TIA,

> https://mail.gna.org/public/xenomai-core/2008-12/msg00009.html
> 
> 
> ---8<-------8<-------8<-------8<-------8<-------8<----
> 
> I have bumped on a compilation failure of Xenomai 2.4.6 with uClibc.
> The mmap64/ftruncate64 functions may not be available, at all.
> So here's an attached patch (xeno-uclibc-link.patch) against 2.4.6,
> FWIW.
> 
> BTW, people stuck with a fascist pthread that lets only superuser use 
> SCHED_FIFO will also need the following patch. Same discussion[1]
> applies.
> [1] https://mail.gna.org/public/xenomai-help/2007-05/msg00330.html
> 
> --- src/skins/native/task.c     9 Jun 2008 09:38:14 -0000       1.5
> +++ src/skins/native/task.c     8 Dec 2008 10:37:55 -0000
> @@ -139,7 +139,13 @@
> 
>         pthread_attr_setinheritsched(&thattr, PTHREAD_EXPLICIT_SCHED);
>         memset(&param, 0, sizeof(param));
> -       if (prio > 0) {
> +       /* There's a limitation in libpthread
> +        * that returns EPERM upon SCHED_FIFO
> +        * for non priviledged users.
> +        * So workaround this for now.
> +        * FIXME (in uClibc/pthread).
> +        */
> +       if (prio > 0 && geteuid() == 0) {
>                 pthread_attr_setschedpolicy(&thattr, SCHED_FIFO);
>                 param.sched_priority = prio;
>         } else
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.

