Message-ID: <441BD80D.4030700@domain.hid>
Date: Sat, 18 Mar 2006 10:51:09 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] O(1) scheduler broken
References: <441B2204.1070406@domain.hid>
In-Reply-To: <441B2204.1070406@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Jan Kiszka wrote:
> Hi,
> 
> I just wanted to test how much the worst-cast jitters improve when
> running multiple timed threads over the O(1) scheduler instead of the
> default one. 

It really depends whether your threads actually wake up simultaneously or not.
The scalable scheduler solves the pathological case where your application has
an insane number of threads _actually_ competing for the current CPU, i.e. all 
being in a runnable state at the same time or within a short window of time. IOW, 
it implements O(1) for the ready queue. We don't use any sequential access for the 
suspended thread queue, and beyond that, I'm even going to kill the latter since 
it's actually useless.

Unfortunately, it already crashes my box with the standard
> latency test. All debug stuff on and serial console attached still does
> not give any output. Looks like a really fatal scheduler crash. :(
>
> Anyone any ideas?

It breaks with the development trunk/ because we are extending the ability of
the core pod to provide a larger priority scale, so that we can provide
VxWorks et al. with a native syscall interface. The new scale likely messes up 
with the priority bitmaps used in the scalable sched. Will fix.

> Jan
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

