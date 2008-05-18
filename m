From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sun, 18 May 2008 14:33:07 +0200
References: <200805181142.13485.niklaus.giger@domain.hid>
	<483016D8.8050004@domain.hid>
In-Reply-To: <483016D8.8050004@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200805181433.08142.niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] SOLO: Too limited priorities for vxWorks threads
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Am Sonntag, 18. Mai 2008 schrieb Philippe Gerum:
> Niklaus Giger wrote:
> > Hi
> > 
> > I just tried to get a sample test program to run under Xenomai-SOLO
> > and run into this panic message:
> > Xenomai/SOLO: current implementation restricts VxWorkspriority levels to range [-2..0]
> > looking at the code I found at taskLib.c
> >> 263     {
> >> 264             if (wind_prio < 0 || wind_prio > 255) /* In theory. */
> >> 265                     return S_taskLib_ILLEGAL_PRIORITY;
> >> 266
> >> 267             if (wind_prio >= threadobj_max_prio - 1) /* In practice. */
> >> 268                     panic("current implementation restricts VxWorks"
> >> 269                           "priority levels to range [%d..0]",
> >> 270                           threadobj_max_prio - 2);
> >> 271             return OK;
> > Therefore I seem to have only the option of priority 0 which is way too limited.
> > 
> 
> The SOLO version is purely Linux native, so you only get what the underlying
> kernel provides you, including in terms of available priority scales. Since RT
> threads are members of the SCHED_FIFO class, you get 99 priority levels, unless
> you patch the vanilla kernel to handle more. The way to solve this properly for
> SOLO is to write a patch against PREEMPT_RT that allows wider priority scales,
> and to get it merged upstream.
Sorry, but you did not get my point. I tried to call it with priority 50, which
should be in this range, which I verified with gdb
(gdb) info stack
#0  panic (fmt=0xb7eebb90 "current implementation restricts VxWorkspriority levels to range [%d..0]") at panic.c:45
#1  0xb7eea1ac in check_task_priority (wind_prio=50) at taskLib.c:268
#2  0xb7eea1d9 in __taskInit (task=0x9eda0e0, tcb=0x9eda10c, name=0xbfc43760 "BSysAsyncTimerMgrThread", prio=50, flags=0,
    entry=0x81281c4 <BSysOsWrapperThread_callback(int)>, stacksize=51200) at taskLib.c:284
<...>

I am happy with the rang 0.99 and also will no run any latency tests, as
xenomai-SOLO is for me at the moment just a test bed to check for compiler
error etc, as at the moment I have no running powerpc kernel for my PPC440
target.

Best regards

-- 

