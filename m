Message-ID: <46048354.4060603@domain.hid>
Date: Sat, 24 Mar 2007 02:48:04 +0100
From: Viktor STARK <abraar@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] [RT_PIPE] - User space read() not waking up
References: <20070322215707.232970@domain.hid>
	<b647ffbd0703230142n46a215ddv5ab0e2c984d0d93c@domain.hid>
In-Reply-To: <b647ffbd0703230142n46a215ddv5ab0e2c984d0d93c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Dmitry Adamushko wrote:
>
> Hello,
>  
>
>     I wrote a RT kernel module for a DAQ card. The DAQ card gets
>     interrupts every 200 us (5 kHz) and I've got a RT interrupt
>     handler which wakes up a RT function
>
>
> I guess, you mean a RT task. Is it a kernel or user space task?
>  
It's a kernel space RT task, yes.
>
>     [...]
>     So basically, my question is:
>     If I have rt_pipe_write() writing to a pipe from a kernel module
>     with a 200 us period and I have a read() in a tight loop reading
>     from that same pipe is user space, what could be the origin of the
>     fact that sometimes my read() doesn't get woken up?
>
>
> Xenomai does provide a Linux system with hard real-time support but it 
> doesn't make the Linux kernel itself hard real-time, nor user-space 
> applications which relies merely on the standard kernel services.
>
> Your task (here it even doesn't matter whether it's a linux or xenomai 
> task) relies on read() so it's under control of the linux scheduler, 
> hence it depends on the /scheduling latency/ provided by Linux, not 
> Xenomai.
>
> Roughly speaking, with Xenomai you have 2 domains: primary (all 
> time-critical activities must stay here) and secondary (Linux standard 
> drivers, applications, xenomai tasks while executing linux system calls).
>
> So hard real-time support is provided only as long as your 
> tasks/drivers work in the primary domain. To this goal, (1) drivers 
> are developed with RTDM (preferable way); (2) applications (both 
> kernel and user-space) are developed using one of the Xenomai skins 
> (native, posix, ...).
>
> And as I mentioned above, it's not a case for your task with a read() 
> loop.
>
> So you should probably reconsider your application design to clearly 
> separate the parts that require hard real-time support from the rest.
I do understand the domain separation, but if I got things right, pipes 
can only be read using read() in user space. That's also what the API 
documentation suggests.

Of course, a read() can be scheduled by Linux, but:
1) Why does it happen exactly every 10000 cycles (2 seconds)? The fact 
that this erratic behaviour is so deterministic makes me think that it 
might not be standard Linux related. I mean the fact that it happens 
every 2 seconds (and I mean 2e6 us, not just approximately 2 seconds) 
just makes it look like it's provoked by something which is RT.
2) Even if my read() is scheduled, how comes I only get past the read() 
after the second rt_pipe_write()? One would think that if my read() is 
scheduled I could be waking up after 250 us or 300 us, no? But I'm 
*always* woken up after 2 cycles (that is 400 us).
3) Pipes seemed to be a good way to transfer data from kernel space. 
What other (maybe more deterministic) way would you suggest? I'm not 
asking for a complete program architecture here just a half dozen words 
describing how you would have done it.

Thanks for your help.

Best regards,

Viktor STARK
>
>
> -- 
> Best regards,
> Dmitry Adamushko 



