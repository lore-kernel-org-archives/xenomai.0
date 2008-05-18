Message-ID: <483016D8.8050004@domain.hid>
Date: Sun, 18 May 2008 13:45:28 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200805181142.13485.niklaus.giger@domain.hid>
In-Reply-To: <200805181142.13485.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] SOLO: Too limited priorities for vxWorks threads
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
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Niklaus Giger wrote:
> Hi
> 
> I just tried to get a sample test program to run under Xenomai-SOLO
> and run into this panic message:
> Xenomai/SOLO: current implementation restricts VxWorkspriority levels to range [-2..0]
> looking at the code I found at taskLib.c
>> 263     {
>> 264             if (wind_prio < 0 || wind_prio > 255) /* In theory. */
>> 265                     return S_taskLib_ILLEGAL_PRIORITY;
>> 266
>> 267             if (wind_prio >= threadobj_max_prio - 1) /* In practice. */
>> 268                     panic("current implementation restricts VxWorks"
>> 269                           "priority levels to range [%d..0]",
>> 270                           threadobj_max_prio - 2);
>> 271             return OK;
> Therefore I seem to have only the option of priority 0 which is way too limited.
> 

The SOLO version is purely Linux native, so you only get what the underlying
kernel provides you, including in terms of available priority scales. Since RT
threads are members of the SCHED_FIFO class, you get 99 priority levels, unless
you patch the vanilla kernel to handle more. The way to solve this properly for
SOLO is to write a patch against PREEMPT_RT that allows wider priority scales,
and to get it merged upstream.

> I took a look at vxworks/testsuite/task-1.c and found that it spawns a task
> with priority 70. Calling "make check" compiled a few more files but did not run
> any checks.
> 
> After calling make in vxworks/testsuite and callling ./task-1 I got the same
> error.
> 
> I am running the (unpatched) Debian kernel 2.6.24-1-686, as I just wanted to
> run some test without requiring any realtime behaviour. Reading 
> http://www.denx.de/cgi-bin/gitweb.cgi?p=xenomai-solo.git;a=blob;f=README
> I found the sentence "SOLO may also be used with non-PREEMPT_RT kernels, likely
> for basic debugging tasks which do not involve strict real-time requirements"
> and concluded therefore that I should be able to use for my test a "normal"
> kernel.
>

Which is wrong if you plan to compare latencies. You should at least use
PREEMPT_RT to do that, otherwise it's meaningless.

> As glibc I use the Debian lenny version 2.7-10.
> 
> Best regards
> 
> Niklaus Giger
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 
Philippe.

