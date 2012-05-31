Message-ID: <4FC7E0A9.5040804@xenomai.org>
Date: Thu, 31 May 2012 23:20:41 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAMJ=MEcVJCdP4wukwhqL83Ejorprnz32PB3vbpOK584GT1mkvg@mail.gmail.com>
	<4F646AA9.1010809@xenomai.org>
	<CAMJ=MEe4oXvtaR29RBueXzoUYrmpt0GpCbqb-uW9j0fTksnC_g@mail.gmail.com>
	<CAMJ=MEc7XydTXOPQ-d6JUPT-mh8Z9ubg-NkDovA-YFWvF_xRaw@mail.gmail.com>
In-Reply-To: <CAMJ=MEc7XydTXOPQ-d6JUPT-mh8Z9ubg-NkDovA-YFWvF_xRaw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-core] xenomai-forge: round-robin scheduling
 in pSOS skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On 03/27/2012 01:38 PM, Ronny Meeus wrote:

> I did a change and introduced a new function: threadobj_start_global_rr
> The patch is attached to the mail.
>
> I basically have split the installation of the signal handler and the
> activation of the round-robin mode for all tasks into 2 parts.
> The original function  threadobj_start_rr just installs the signal
> handler and starts the timer with the interval that the user has
> specified.
> The newly introduced function (threadobj_start_global_rr) marks all
> tasks as round-robin active and all future tasks will also be marked.
> By splitting the logic of this function it is possible to work in a
> mode where the tasks itself (based on the flags given during
> task-creation or via t_mode) decides on the mode in which it wants to
> run or the application can decide that the round-robin will be
> activated globally (by calling  threadobj_start_global_rr once during
> init for example). In the latter case the round-robin activation
> because global for all threads in the application process.
>
> I tested the change in my version and it looks like it behaves like it
> should be.

Thanks. However, even fixed this way, the round-robin API still has some 
issues. Specifically, the global activation makes no sense at 
copperplate level, since multiple emulators may run concurrently within 
the same process (e.g. turning on VxWorks time slicing globally should 
not affect pSOS tasks).

Implementation-wise, setitimer() is a wrong choice for creating a 
per-thread round-robin timer over the mercury core: NPTL does share 
timers over threads within a process, which does not cope well with 
manual round-robin via the signal handler.

The patch below addresses these issues:

http://git.xenomai.org/?p=xenomai-forge.git;a=commit;h=ad24a4a2fdad9a88b229d0d2fe6da7ac6bd196d6

>
> Thanks
> ---
> Ronny


-- 
Philippe.

