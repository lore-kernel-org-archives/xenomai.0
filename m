Message-ID: <51129599.3080709@siemens.com>
Date: Wed, 06 Feb 2013 18:40:41 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <51128CE4.4020303@siemens.com> <51128E3E.808@xenomai.org>
	<511293EB.1080502@siemens.com> <5112945F.8080102@xenomai.org>
In-Reply-To: <5112945F.8080102@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe/x86: do not restore during context switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-02-06 18:35, Gilles Chanteperdrix wrote:
> On 02/06/2013 06:33 PM, Jan Kiszka wrote:
> 
>> On 2013-02-06 18:09, Gilles Chanteperdrix wrote:
>>> On 02/06/2013 06:03 PM, Jan Kiszka wrote:
>>>
>>>> Gilles,
>>>>
>>>> do you remember if this core-3.4 change was a performance optimization
>>>> or a necessary fix? Also, I'm not yet understanding why we need all the
>>>> #ifdefs except for the first one which forces fpu.preload to 0.
>>>
>>>
>>> It is a performance optimization, without it, we systematically hit the
>>> maximum latency when the timer would tick during a context switch which
>>> restores the FPU. Note that if you change that, you will probably break
>>> -forge.
>>
>> According to the Intel folks who introduced eagerfpu, xsave, or at least
>> xsaveopt (which I didn't implemented yet) is now faster than serializing
>> clts/stts. On the other hand, the worst case is a full SSE + AVX restore
>> while the target RT task is not depending on the FPU.
> 
> 
> Without xsave, we never restore fpu if the RT task never used it. This
> changes with xsave?

This would change with eagerfpu which depends on xsave. The kernel
sticks with lazy switching in the absence of xsaveopt.

>From the log message of the related commit:

    Reasons driving this model change [Jan: eagerfpu] are:
    
    i. Newer processors support optimized state save/restore using xsaveopt and
    xrstor by tracking the INIT state and MODIFIED state during context-switch.
    This is faster than modifying the cr0.TS bit which has serializing semantics.
    
    ii. Newer glibc versions use SSE for some of the optimized copy/clear routines.
    With certain workloads (like boot, kernel-compilation etc), application
    completes its work with in the first 5 task switches, thus taking upto 5 #DNA
    traps with the kernel not getting a chance to apply the above mentioned
    pre-load heuristic.
    
    iii. Some xstate features (like AMD's LWP feature) don't honor the cr0.TS bit
    and thus will not work correctly in the presence of lazy restore. Non-lazy
    state restore is needed for enabling such features.
    
    Some data on a two socket SNB system:
     * Saved 20K DNA exceptions during boot on a two socket SNB system.
     * Saved 50K DNA exceptions during kernel-compilation workload.
     * Improved throughput of the AVX based checksumming function inside the
       kernel by ~15% as xsave/xrstor is faster than the serializing clts/stts
       pair.

I guess for a first 3.8 version I will now simply force eagerfpu off at
I-pipe level. We should then likely benchmark the current code against
an eagerfpu+xsaveopt-enabled version to decide.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

