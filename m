Message-ID: <442C46EC.6000605@domain.hid>
Date: Thu, 30 Mar 2006 23:00:28 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Non-deterministic behaviour in primary mode
References: <1143612388.32703.257789950@domain.hid>
	<442A7D19.2000009@domain.hid>
	<1143694058.30209.257882137@domain.hid>
In-Reply-To: <1143694058.30209.257882137@domain.hid>
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
To: Saul <xeno@domain.hid>
Cc: xenomai@xenomai.org

Saul wrote:
> Philippe Gerum wrote:
> 
>>It would be nice to known whether the latency test from the testsuite 
>>has correct latency figures, so that we could rule out any SMI issue.
> 
> 
> See my reply to Jan Kiszka. The max is 55us, but I've just noticed that
> starting xawtv using the bttv driver causes an overrun in the latency
> test, but that may be unrelated.
> 
> 
>>>Anyway, the erratic execution times come and go with the smallest
>>>changes in the program e.g. moving the delay into it's own function or
>>>creating functions for timing the delay loop, so I wouldn't be too
>>>surprised if the problem can't be reproduced.
>>>
>>
>>What /proc/xenomai/stat says during execution btw?
> 
> 
> Here's /proc/xenomai/stat sampled every four seconds:
> 
> CPU  PID    MSW        CSW        PF    STAT      NAME
>   0  0      0/0        42572094   0     00500080  ROOT
> 
> CPU  PID    MSW        CSW        PF    STAT      NAME
>   0  0      0/0        42572110   0     00500080  ROOT
>   0  28088  1/0        8          0     00380084  timed-task
>   0  28089  8/7        15         0     00300081  display-task
> 
> CPU  PID    MSW        CSW        PF    STAT      NAME
>   0  0      0/0        42572164   0     00500080  ROOT
>   0  28088  1/0        35         0     00380084  timed-task
>   0  28089  35/34      69         0     00300081  display-task
> 
> CPU  PID    MSW        CSW        PF    STAT      NAME
>   0  0      0/0        42572216   0     00500080  ROOT
>   0  28088  1/0        61         0     00380084  timed-task
>   0  28089  61/60      121        0     00300081  display-task
> 
> CPU  PID    MSW        CSW        PF    STAT      NAME
>   0  0      0/0        42572272   0     00500080  ROOT
>   0  28088  1/0        89         0     00380084  timed-task
>   0  28089  89/88      177        0     00300081  display-task
> 
> CPU  PID    MSW        CSW        PF    STAT      NAME
>   0  0      0/0        42572296   0     00500080  ROOT
> 
> 
>>>Also, I found that using rt_timer_spin() instead of a real busy loop
>>>does not have the same problem, which indicates that the simple busy
>>>loop is in fact being interrupted during execution.
>>>
>>
>>Just to rule this out, maybe you could try something along these lines:
>>
>>		iopl(3)
>>...
>>		asm("cli");
>>                  RTIME prev_tsc = rt_timer_tsc();
>>                  my_processing();
>>                  RTIME tsc = rt_timer_tsc();
>>		asm("sti");
> 
> 
> Case 1: the original data was the case of the busy loop in a function &
> interrupts enabled.
>   1:  40.017 ms
>   2:  40.017 ms
>   3:  53.357 ms
>   4:  53.356 ms
>   5:  40.017 ms
>   6:  40.020 ms
>   7:  53.355 ms
>   8:  40.020 ms
>   9:  40.017 ms
> 10:  53.356 ms
> 
> Case 2: as suggested, this is the case of having the busy loop in a
> function & interrupts disabled.
>   1:  53.316 ms
>   2:  53.316 ms
>   3:  53.316 ms
>   4:  53.316 ms
>   5:  53.316 ms
>   6:  106.632 ms
>   7:  53.316 ms
>   8:  106.632 ms
>   9:  35.544 ms
>  10:  39.987 ms
> 
> It appears to have made the situation worse?! Note:
> 35.544 = 39.987 * 8/9
> 53.316 = 39.987 * 12/9
> 106.632 = 39.987 * 24/9
> OK, sending me crazy enough without delving to numerological lows.
> Next I tried two more cases...
> 
> Case 3: busy loop inline & interrupts enabled.
>   1:  35.571 ms
>   2:  40.019 ms
>   3:  40.020 ms
>   4:  40.017 ms
>   5:  40.017 ms
>   6:  40.019 ms
>   7:  40.017 ms
>   8:  40.020 ms
>   9:  40.017 ms
>  10:  40.019 ms
> ...
>  55:  53.357 ms
> 
> Case 4: busy loop inline & interrupts disabled.
>   1:  39.987 ms
>   2:  39.987 ms
>   3:  39.987 ms
>   4:  39.987 ms
>   5:  39.987 ms
>   6:  39.987 ms
>   7:  39.987 ms
>   8:  39.987 ms
>   9:  39.987 ms
>  10:  39.987 ms
> 
> Oooooh, that last one looks good :) But even it has produced a 106.632ms
> measure.
> 
> 
>>Out of curiosity, I'd also be interested in looking at the assembly dump 
>>of my_process in the working and non-working cases.
> 
> 
> Well, from the above tests the problem appears to always be there, just
> to varying degrees - I no longer believe there is a working case on my
> PC. Disabling interrupts removes some noise from the signal, but the
> real problem persists. The large increase in computation time (many ms)
> appears to be quantized, made more visible by disabling interrupts. I
> guess placing the delay in a function is simply pushing the execution
> time into the next quantization level. The assembly all looks about the
> same between cases:
> 
> ----------------------------------
> Case 1: busy loop in a function & interrupts enabled.
> my_processing:
>         pushl   %ebp
>         movl    %esp, %ebp
>         movl    $80000000, %eax
>         .p2align 4,,15
> .L2:
>         decl    %eax
>         jne     .L2
>         popl    %ebp
>         ret
> ...snip...
>         call    rt_timer_tsc
>         movl    %eax, %ebx
>         movl    %edx, %esi
>         call    my_processing
>         call    rt_timer_tsc
> 
> ----------------------------------
> Case 2: busy loop in a function & interrupts disabled.
> my_processing:
>         pushl   %ebp
>         movl    %esp, %ebp
>         movl    $80000000, %eax
>         .p2align 4,,15
> .L2:
>         decl    %eax
>         jne     .L2
>         popl    %ebp
>         ret
> ...snip...
> #APP
>         cli
> #NO_APP
>         call    rt_timer_tsc
>         movl    %eax, %ebx
>         movl    %edx, %esi
>         call    my_processing
>         call    rt_timer_tsc
> #APP
>         sti
> #NO_APP
> 
> ----------------------------------
> Case 3: busy loop inline & interrupts enabled.
>         call    rt_timer_tsc
>         movl    %eax, %ebx
>         movl    %edx, %esi
>         movl    $80000000, %eax
>         .p2align 4,,15
> .L13:
>         decl    %eax
>         jne     .L13
>         call    rt_timer_tsc
> 
> ----------------------------------
> Case 4: busy loop inline & interrupts disabled.
> #APP
>         cli
> #NO_APP
>         call    rt_timer_tsc
>         movl    %eax, %ebx
>         movl    %edx, %esi
>         movl    $80000000, %eax
>         .p2align 4,,15
> .L13:
>         decl    %eax
>         jne     .L13
>         call    rt_timer_tsc
> #APP
>         sti
> #NO_APP
> 
> 
> Disabling USB legacy had no effect - was already using a driver that
> should disable it anyway.
> 
> Disabling ACPI caused Case 1&3 to look more alike, and Case 2&4 to
> look more alike - it's still remains that:
> 1) when interrupts are disabled the noise level reduces
> 2) when interrupts are disabled delays are introduced less often
> 3) with interrupts enabled or disabled, large quantized delays occur
> Point 2) could be due to point 1).
> 
> I have no idea what to try next but thanks for the advice. I think some
> progress was made :)
> 

Mm, this really looks like some firmware/BIOS cyclic activity, that 
would hit the busy loop more or less frequently, depending on the 
internal timing of the outer loop. This reminds me that some recent 
Intel chipset are known to prevent global SMI disabling actually, maybe 
this is the case here, so our work-around would be basically useless. 
Another usual suspect is NMI handling (which the Adeos layer does not 
pipeline but rather delivers immediately), but I guess that you did not 
activate the NMI watchdog anyway, so back to square #1, I guess.

-- 

Philippe.

