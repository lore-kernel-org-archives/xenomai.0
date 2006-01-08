Message-ID: <43C14453.3040907@domain.hid>
Date: Sun, 08 Jan 2006 18:56:51 +0200
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency kernel part crashes on ppc64
References: <43C12304.4040802@domain.hid> <43C12CEC.8070403@domain.hid>
In-Reply-To: <43C12CEC.8070403@domain.hid>
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
Cc: xenomai@xenomai.org

Jan Kiszka kirjoitti:
> Heikki Lindholm wrote:
> 
>>Hi,
>>
>>Some recent changes (*cough* RTDM benchmark driver *cough*) broke kernel
>>mode benchmarking for ppc64. Previously klatency worked fine, but now
>>latency -t 1 crashes somewhere in xnpod_schedule. Jan, any pending
>>patches a comin'?
> 
> 
> Nope, it should work as it is. But as Stelian also reported problems on
> his fresh ARM port with the in-kernel test, I cannot exclude that there
> /might/ be a problem in the benchmark.
> 
> As I don't have any ppc64 hanging around somewhere, we will have to go
> through this together. Things I would like to know:

Dammit, I hoped you'd whip up a fix just from me noting a problem. Well, 
all right then, I'll play along...;)

>  o When and how does it crash? At start-up immediately? Or after a
>    while?

I inserted some serial debug prints and it gets two passes to 
eval_outer_loop done (enter/exit function). After that it freezes. 
Without the debug printing it dies with kernel access of illegal memory 
at xnpod_schedule, which btw. has been quite a common place to die.

>  o Are there any details / backtraces available with the crash?

Becaktrace limits to xnpod_schedule if I remember right.

>  o Does -t2 work?

Umm. Probably not. See below.

>  o What happens if your disable "rtdm_event_pulse(&ctx->result_event);"
>    in eval_outer_loop (thus no signalling of intermediate results during
>    the test)? Does it still crash, maybe later during cleanup now?

Doesn't freeze and can be exited with ctrl-c and even re-run.

One odd thing (probably unrelated) is that the first two ioctls get 
called in what seems like wrong order, eg. START_TMTEST first ends up in 
tmbench_ioctl_rt and then _nrt and INTERM_RESULT ends up first in _nrt 
and then _rt.

-- Heikki Lindholm

