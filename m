Subject: Re: failing smokey tests
References: <4aa7e93eb7c44ec793f9c6bb2c9d8587@boschrexroth.nl>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <75f20bdf-6dc0-d9f2-461d-ba771f590aee@siemens.com>
Date: Fri, 20 Mar 2020 13:35:07 +0100
MIME-Version: 1.0
In-Reply-To: <4aa7e93eb7c44ec793f9c6bb2c9d8587@boschrexroth.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bradley Valdenebro Peter (DC-AE/ESW52)" <Peter.BradleyValdenebro@boschrexroth.nl>, "xenomai@xenomai.org" <xenomai@xenomai.org>, Quirin Gylstorff <quirin.gylstorff@siemens.com>

On 20.03.20 13:23, Bradley Valdenebro Peter (DC-AE/ESW52) via Xenomai wrote:
> Hello Xenomai team,
> 
> We are currently running a Xenomai/Linux setup on a Zynq Z-7020 SoC (We run Linux on CPU0 and Xenomai on CPU1):
> 	$ uname -a
> 		Linux wom03 4.14.110-mainline #1 SMP PREEMPT Tue Mar 17 17:25:22 CET 2020 armv7l GNU/Linux
> 	$ cat /proc/xenomai/version
> 		3.1
> 	$ cat /proc/ipipe/version
> 		7
> 
> We are experiencing two problems with the smokey tests:
> 
> 1. posix_cond (check POSIX condition variable services). This tests fails 8 out of 10 executions with the following message:
> 	
> 	$ sudo /usr/bin/smokey --run=14 --verbose=2
> 		autoinit_simple_conddestroy
> 		autoinit_simple_condwait
> 		simple_condwait
> 		relative_condwait
> 		autoinit_absolute_condwait
> 		cond_wait waited 9998.799 us
> 
> By looking at the test autoinit_absolute_condwait it looks like a timed conditional wait should timeout after 10000us. This is measured in the test and checked.
> If it's lower than 10000us it will fail. Should it always be equal or higher than 10000us? Are 9998.799us not acceptable?
> 

Did you run autotune prior to smokey? Maybe latencies are not properly 
tuned so that we overshoot.

That said, some tolerance for such scenarios might be needed here.

> 2. memory_coreheap and memory_heapmem
> First execution of any of these tests goes fine but later executions of any of them always result in a system freeze and a power cycle is necessary.
> E.g.: If I execute memory_coreheap after a power cycle it will succeed. If I later execute memory_heapmem it will freeze.
>          Or if I execute memory_heapmem after a power cycle it will succeed. If I later execute it again it will freeze.

Sounds like as if uninitialized memory is biting here.

> 
> It freezes just after printing "(running the pattern check test for 'heapmem' -- this may take some time)"
> 
> By freeze I mean the system is unresponsive. I cannot even ping the system.
> If I had to guess it looks like something isn't freed or cleaned-up properly after the test.

Does your system have the Xenomai watchdog enabled? If we only lock up 
in an endless loop, that should kick in and make the case analyzable 
(e.g. with gdb).

We run those tests on ARMv7 as well (BeagleBone Black and QEMU), but - 
Quiring, correct me if I'm wrong - not multiple times in a row.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

