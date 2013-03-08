Message-ID: <513A440F.7090207@xenomai.org>
Date: Fri, 08 Mar 2013 21:03:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51372B12.2030400@mitrol.it>	<51373149.4050700@xenomai.org>	<5137370B.2050402@mitrol.it>	<51373841.70704@xenomai.org>	<51385910.80203@mitrol.it>	<51388A3A.2090004@xenomai.org>
	<51388DD2.2020805@mitrol.it>	<51388EB2.6000206@xenomai.org>
	<5139DEA2.9050103@mitrol.it>
In-Reply-To: <5139DEA2.9050103@mitrol.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Sporadic problem : rt_task_sleep
	locked	after	debugging
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
Cc: xenomai@xenomai.org

On 03/08/2013 01:50 PM, Paolo Minazzi wrote:

> Il 07/03/2013 13.57, Gilles Chanteperdrix ha scritto:
>> On 03/07/2013 01:53 PM, Paolo Minazzi wrote:
>>
>>> Il 07/03/2013 13.38, Gilles Chanteperdrix ha scritto:
>>>> On 03/07/2013 10:08 AM, Paolo Minazzi wrote:
>>>>
>>>>> Il 06/03/2013 13.36, Gilles Chanteperdrix ha scritto:
>>>>>> On 03/06/2013 01:31 PM, Paolo Minazzi wrote:
>>>>>>
>>>>>>> Il 06/03/2013 13.06, Gilles Chanteperdrix ha scritto:
>>>>>>>> On 03/06/2013 12:40 PM, Paolo Minazzi wrote:
>>>>>>>>
>>>>>>>>> I can generate the problem only debugging with gdb, otherwise there is
>>>>>>>>> no problem.
>>>>>>>>>
>>>>>>>>> Can you help me to undertand what happen ?
>>>>>>>>> Have you got an idea ? do you need other information ?
>>>>>>>> In case it is something which was fixed since Xenomai 2.5.6, could you
>>>>>>>> try Xenomai 2.6.2.1?
>>>>>>>>
>>>>>>> I have not done the port.
>>>>>>> This work is done by an external firm.
>>>>>>> I know well enough the linux kernel, but very very little the xenomai
>>>>>>> internals.
>>>>>> You can use Xenomai 2.6.2.1 with the same version of the I-pipe kernel,
>>>>>> and the I-pipe kernel is the only thing which needs to be ported.
>>>>>>
>>>>>>> I could try ... but it is not easy ....
>>>>>> It should be as easy as:
>>>>>> - keep your kernel patched with the I-pipe patch
>>>>>> - download the newest version of Xenomai, that is 2.6.2.1
>>>>>> - follow the installation instructions, here:
>>>>>> http://www.xenomai.org/documentation/xenomai-2.6/html/README.INSTALL/
>>>>>>
>>>>>>> The problem appear only using gdb .... any ideas ?
>>>>>> Could be the timer programmed for a too short delay, could be something
>>>>>> we already fixed, could be a new bug... Really, testing rapidly the last
>>>>>> version will make us win a lot of time if this is an issue already fixed.
>>>>>>
>>>>>>
>>>>> I Gilles,
>>>>> I have ported to 2.6.1 without problems.
>>>>> To 2.6.2 and 2.6.2.1 I need to add a gcc built-in. My compiler is
>>>> pass --with-atomic-ops=ad-hoc to configure script, this will avoid the
>>>> builtins.
>>>>
>>>>> gcc-4.3.2 and does not have some built-in atomic function.
>>>>> After this I need to change the switch.S because my assembler cannot
>>>> switch.S has been compiling for ages, way before gcc 4.4. Could you show
>>>> me the warning you get?
>>>>
>>>>> compile it. Maybe a newer compiler (gcc>= 4.4) could solve all these
>>>>> problems, but for me this is not a valid solution because other
>>>>> developers of us use a cygwin compiler. We should built a new cygwin
>>>>> compiler ... the libs will be different and so I will have problem with
>>>>> shared libraries .... too complex to solve a sporadic bug using gdb ....
>>>>> I can try to see the 2.6.1.
>>>> The idea of asking you to try 2.6.2.1 is not to ask you to switch to it,
>>>> but simply to do a quick test to see if you can reproduce the issue.
>>>>
>>>>
>>>     CC      drivers/xenomai/testing/switchtest.o
>>>     CC      drivers/xenomai/testing/timerbench.o
>>>     LD      drivers/xenomai/testing/xeno_timerbench.o
>>>     LD      drivers/xenomai/testing/xeno_switchtest.o
>>>     LD      drivers/xenomai/testing/built-in.o
>>>     LD      drivers/xenomai/built-in.o
>>>     LD      drivers/built-in.o
>>>     CC      arch/arm/xenomai/hal.o
>>>     AS      arch/arm/xenomai/switch.o
>>> /home/axel/MarvellEnv/BuildLinux/linux-2.6.31.8/arch/arm/xenomai/switch.S:
>>> Assembler messages:
>>> /home/axel/MarvellEnv/BuildLinux/linux-2.6.31.8/arch/arm/xenomai/switch.S:156:
>>> Error: bad instruction `arm( stmia ip!,{r4-sl,fp,sp,lr})'
>>> /home/axel/MarvellEnv/BuildLinux/linux-2.6.31.8/arch/arm/xenomai/switch.S:157:
>>> Error: bad instruction `thumb( stmia ip!,{r4-sl,fp})'
>>> /home/axel/MarvellEnv/BuildLinux/linux-2.6.31.8/arch/arm/xenomai/switch.S:158:
>>> Error: bad instruction `thumb( str sp,[ip],#4)'
>>> /home/axel/MarvellEnv/BuildLinux/linux-2.6.31.8/arch/arm/xenomai/switch.S:159:
>>> Error: bad instruction `thumb( str lr,[ip],#4)'
>>> /home/axel/MarvellEnv/BuildLinux/linux-2.6.31.8/arch/arm/xenomai/switch.S:170:
>>> Error: bad instruction `arm( add r4,r2,#28)'
>>> /home/axel/MarvellEnv/BuildLinux/linux-2.6.31.8/arch/arm/xenomai/switch.S:171:
>>> Error: bad instruction `arm( ldmia r4,{r4-sl,fp,sp,pc})'
>>> /home/axel/MarvellEnv/BuildLinux/linux-2.6.31.8/arch/arm/xenomai/switch.S:172:
>>> Error: bad instruction `thumb( add ip,r2,#28)'
>>> /home/axel/MarvellEnv/BuildLinux/linux-2.6.31.8/arch/arm/xenomai/switch.S:173:
>>> Error: bad instruction `thumb( ldmia ip!,{r4-sl,fp})'
>>> /home/axel/MarvellEnv/BuildLinux/linux-2.6.31.8/arch/arm/xenomai/switch.S:174:
>>> Error: bad instruction `thumb( ldr sp,[ip],#4)'
>>> /home/axel/MarvellEnv/BuildLinux/linux-2.6.31.8/arch/arm/xenomai/switch.S:175:
>>> Error: bad instruction `thumb( ldr pc,[ip])'
>>> make[2]: *** [arch/arm/xenomai/switch.o] Error 1
>>> make[1]: *** [arch/arm/xenomai] Error 2
>>> make: *** [sub-make] Error 2
>>
>> The issue is not the compiler, the issue is with the linux kernel you
>> use. Could you put me a source tarball on some ftp site?
>>
>> Please try adding:
>> #define ARM(x...)	x
>> #define	THUMB(x...)
>>
>> At the top of switch.S
>>
>>
> Hi Gill,
> 2.6.2.1 seems work ok with a normal xenomai application.
> But testing our complex application (to seach the gdb bug 
> /rt_task_sleep) I found an other small problem.
> Today I have studied this new problem that can be shown and produced 
> with a simple example.
> 
> #include <sys/mman.h>
> #include <native/task.h>
> #include <native/timer.h>
> #include <native/mutex.h>
> #include <native/sem.h>
> #include <pthread.h>
> 
> // PRIO=0 make a fault ! Other values are good
> #define PRIO 0
> 
> RT_TASK tsk;
> 
> void fn(void *arg)
> {
>          while (1)
>          {
>                  rt_task_sleep(1000000);
>          }
> }
> 
> int main(int argc, char *argv[])
> {
>          mlockall(MCL_CURRENT | MCL_FUTURE);
> 
>          rt_timer_set_mode(0);
>          rt_task_set_mode(0, 0, /* T_WARNSW , */ NULL);
> 
>          while (1)
>          {
>                  rt_task_create(&tsk, "demo", 0, PRIO, T_JOINABLE);
>                  // rt_task_start(&tsk, &fn, 0);
>                  rt_task_suspend(&tsk);
>                  rt_task_delete(&tsk);
>                  rt_task_join(&tsk);
>          }
> 
> This is the log :
> 
> / # /D/main
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> pgd = 874d4000
> [00000000] *pgd=01557031, *pte=00000000, *ppte=00000000
> Internal error: Oops: 817 [#1] PREEMPT
> Modules linked in: dp
> CPU: 0    Not tainted  (2.6.31.8 #15)
> PC is at losyscall_event+0x218/0x238
> LR is at schedule+0x46c/0x50c
> pc : [<8008d930>]    lr : [<8025b1ac>]    psr: a0000013
> sp : 80d0def8  ip : fffffe00  fp : 80d0df1c
> r10: 00000000  r9 : 803102a0  r8 : 00000018
> r7 : 00000000  r6 : 80d0dfb0  r5 : 88031210  r4 : 00000001
> r3 : 00000000  r2 : 00b00231  r1 : 87839360  r0 : 00000001
> Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 0005397f  Table: 074d4000  DAC: 00000015
> Process demo (pid: 295, stack limit = 0x80d0c270)
> Stack: (0x80d0def8 to 0x80d0e000)
> dee0:                                                       00000228 
> 80310310
> df00: 80332c40 80332c40 80332c44 00000001 80d0df6c 80d0df20 8007c3cc 
> 8008d728
> df20: 00000200 00000000 80d0dfb0 00000009 fffffdff ffffffff 20000013 
> 80332c40
> df40: 80d0c000 80d0dfb0 00095018 000f0042 000f0042 800202ec 80d0c000 
> 00000000
> df60: 80d0df8c 80d0df70 80026540 8007c314 7edaad24 00095018 000931e4 
> 000f0042
> df80: 00000000 80d0df90 80020254 800264d0 000931e4 0300022b 2aad5ca0 
> 2aad5c7c
> dfa0: 2aad5c7c 00000000 7edaad24 00095018 fffffe00 2aad5ca0 2aad5c7c 
> 2aad5c7c
> dfc0: 7edaad24 00095018 000931e4 000f0042 00000400 00070754 00000000 
> 00000001
> dfe0: 2aad5ca0 2aad5c78 0000de6c 000089e8 20000010 0300022b 00000000 
> 00000000
> Backtrace:
> [<8008d718>] (losyscall_event+0x0/0x238) from [<8007c3cc>] 
> (__ipipe_dispatch_event+0xc8/0x1a8)
> [<8007c304>] (__ipipe_dispatch_event+0x0/0x1a8) from [<80026540>] 
> (__ipipe_syscall_root+0x80/0x128)
> [<800264c0>] (__ipipe_syscall_root+0x0/0x128) from [<80020254>] 
> (vector_swi+0x74/0xb4)
>   r7:000f0042 r6:000931e4 r5:00095018 r4:7edaad24
> Code: 159524a8 03a00001 159536f8 13a00001 (15832000)
> ---[ end trace 8d00a583486ebf82 ]---
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> pgd = 874d4000
> [00000000] *pgd=01557031, *pte=00000000, *ppte=00000000
> Internal error: Oops: 817 [#2] PREEMPT
> Modules linked in: dp
> CPU: 0    Tainted: G      D     (2.6.31.8 #15)
> PC is at losyscall_event+0x218/0x238
> LR is at schedule+0x46c/0x50c
> pc : [<8008d930>]    lr : [<8025b1ac>]    psr: a0000013
> sp : 8790fef8  ip : fffffe00  fp : 8790ff1c
> r10: 00000000  r9 : 803102a0  r8 : 00000018
> r7 : 00000000  r6 : 8790ffb0  r5 : 88031210  r4 : 00000001
> r3 : 00000000  r2 : 00b00231  r1 : 87839360  r0 : 00000001
> Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 0005397f  Table: 074d4000  DAC: 00000015
> Process demo (pid: 297, stack limit = 0x8790e270)
> Stack: (0x8790fef8 to 0x87910000)
> fee0:                                                       00000228 
> 80310310
> ff00: 80332c40 80332c40 80332c44 00000001 8790ff6c 8790ff20 8007c3cc 
> 8008d728
> ff20: 00000200 00000000 8790ffb0 00000009 fffffdff ffffffff 20000013 
> 80332c40
> ff40: 8790e000 8790ffb0 00095028 000f0042 000f0042 800202ec 8790e000 
> 00000000
> ff60: 8790ff8c 8790ff70 80026540 8007c314 7edaad24 00095028 000931e4 
> 000f0042
> ff80: 00000000 8790ff90 80020254 800264d0 000931e4 0300022b 2aad5ca0 
> 2aad5c7c
> ffa0: 2aad5c7c 00000000 7edaad24 00095028 fffffe00 2aad5ca0 2aad5c7c 
> 2aad5c7c
> ffc0: 7edaad24 00095028 000931e4 000f0042 00000400 00070754 00000000 
> 00000001
> ffe0: 2aad5ca0 2aad5c78 0000de6c 000089e8 20000010 0300022b 00443031 
> 00443431
> Backtrace:
> [<8008d718>] (losyscall_event+0x0/0x238) from [<8007c3cc>] 
> (__ipipe_dispatch_event+0xc8/0x1a8)
> [<8007c304>] (__ipipe_dispatch_event+0x0/0x1a8) from [<80026540>] 
> (__ipipe_syscall_root+0x80/0x128)
> [<800264c0>] (__ipipe_syscall_root+0x0/0x128) from [<80020254>] 
> (vector_swi+0x74/0xb4)
>   r7:000f0042 r6:000931e4 r5:00095028 r4:7edaad24
> Code: 159524a8 03a00001 159536f8 13a00001 (15832000)
> ---[ end trace 8d00a583486ebf83 ]---
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> ^Cpgd = 874d4000
> [00000000] *pgd=01557031, *pte=00000000, *ppte=00000000
> Internal error: Oops: 817 [#3] PREEMPT
> Modules linked in: dp
> CPU: 0    Tainted: G      D     (2.6.31.8 #15)
> PC is at losyscall_event+0x218/0x238
> LR is at schedule+0x46c/0x50c
> pc : [<8008d930>]    lr : [<8025b1ac>]    psr: a0000013
> sp : 80dc5ef8  ip : fffffe00  fp : 80dc5f1c
> r10: 00000000  r9 : 803102a0  r8 : 00000018
> r7 : 00000000  r6 : 80dc5fb0  r5 : 88031210  r4 : 00000001
> r3 : 00000000  r2 : 00b00231  r1 : 87839360  r0 : 00000001
> Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 0005397f  Table: 074d4000  DAC: 00000015
> Process demo (pid: 299, stack limit = 0x80dc4270)
> Stack: (0x80dc5ef8 to 0x80dc6000)
> 5ee0:                                                       00000228 
> 80310310
> 5f00: 80332c40 80332c40 80332c44 00000001 80dc5f6c 80dc5f20 8007c3cc 
> 8008d728
> 5f20: 00000200 00000000 80dc5fb0 00000009 fffffdff ffffffff 20000013 
> 80332c40
> 5f40: 80dc4000 80dc5fb0 00095038 000f0042 000f0042 800202ec 80dc4000 
> 00000000
> 5f60: 80dc5f8c 80dc5f70 80026540 8007c314 7edaad24 00095038 000931e4 
> 000f0042
> 5f80: 00000000 80dc5f90 80020254 800264d0 000931e4 0300022b 2aad5ca0 
> 2aad5c7c
> 5fa0: 2aad5c7c 00000000 7edaad24 00095038 fffffe00 2aad5ca0 2aad5c7c 
> 2aad5c7c
> 5fc0: 7edaad24 00095038 000931e4 000f0042 00000400 00070754 00000000 
> 00000001
> 5fe0: 2aad5ca0 2aad5c78 0000de6c 000089e8 20000010 0300022b 00000000 
> 00000000
> Backtrace:
> [<8008d718>] (losyscall_event+0x0/0x238) from [<8007c3cc>] 
> (__ipipe_dispatch_event+0xc8/0x1a8)
> [<8007c304>] (__ipipe_dispatch_event+0x0/0x1a8) from [<80026540>] 
> (__ipipe_syscall_root+0x80/0x128)
> [<800264c0>] (__ipipe_syscall_root+0x0/0x128) from [<80020254>] 
> (vector_swi+0x74/0xb4)
>   r7:000f0042 r6:000931e4 r5:00095038 r4:7edaad24
> Code: 159524a8 03a00001 159536f8 13a00001 (15832000)
> ---[ end trace 8d00a583486ebf84 ]---
> 
> This fault does not freeze the arm, I can countinue to work.
> 
> Ideas ?


Indeed, I can reproduce that. The problem seems to be calling
rt_task_delete before the task has been started. If you start the task,
this will not happen.

-- 
                                                                Gilles.

