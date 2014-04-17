Message-ID: <534FBCE9.2060402@xenomai.org>
Date: Thu, 17 Apr 2014 13:37:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1396407588.27578.5.camel@localhost.localdomain>
 <1396999856.2660.7.camel@localhost.localdomain>
 <53449244.8040502@xenomai.org>
 <1397003664.2660.14.camel@localhost.localdomain>
 <1397017658.2660.16.camel@localhost.localdomain>
 <534534FD.5090805@xenomai.org>
 <1397113300.2720.5.camel@localhost.localdomain>
 <5346895B.6080401@xenomai.org>
 <1397159850.2881.3.camel@localhost.localdomain>
 <53471389.6000000@xenomai.org>
 <1397168263.6356.11.camel@localhost.localdomain>
 <534719F5.2020605@xenomai.org>
 <1397169248.6356.15.camel@localhost.localdomain> <53471FDB.50008@xenomai.org>
 <1397170339.6356.17.camel@localhost.localdomain>
 <1397541812.6541.3.camel@localhost.localdomain>
 <534D19FA.3040506@xenomai.org>
 <1397599195.2652.0.camel@localhost.localdomain>
 <534DB1C7.4060905@xenomai.org>
 <1397609916.2652.6.camel@localhost.localdomain>
 <534E328F.5030709@xenomai.org>
 <1397694600.2625.4.camel@localhost.localdomain>
In-Reply-To: <1397694600.2625.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] OMAP L138
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Peter Howard <pjh@northern-ridge.com.au>
Cc: xenomai@xenomai.org

On 04/17/2014 02:30 AM, Peter Howard wrote:
> On Wed, 2014-04-16 at 09:34 +0200, Gilles Chanteperdrix wrote:
>> On 04/16/2014 02:58 AM, Peter Howard wrote:
>>> On Wed, 2014-04-16 at 00:25 +0200, Gilles Chanteperdrix wrote:
>>>> On 04/15/2014 11:59 PM, Peter Howard wrote:
>>>>> On Tue, 2014-04-15 at 13:37 +0200, Gilles Chanteperdrix wrote:
>>>>>> On 04/15/2014 08:03 AM, Peter Howard wrote:
>>>>>>> On Fri, 2014-04-11 at 08:52 +1000, Peter Howard wrote:
>>>>>>>> On Fri, 2014-04-11 at 00:48 +0200, Gilles Chanteperdrix wrote:
>>>>>>>>> On 04/11/2014 12:34 AM, Peter Howard wrote:
>>>>>>>>>> On Fri, 2014-04-11 at 00:23 +0200, Gilles Chanteperdrix wrote:
>>>>>>>>>> (Stripping back conversation on this one - apologies if that's bad
>>>>>>>>>> etiquette for this list)
>>>>>>>>>>  
>>>>>>>>>>> Attachment is better. Also please post the changes you made for omapL138
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
>>>>>>>>>> index a075b3e..3d8bc59 100644
>>>>>>>>>> --- a/arch/arm/mach-davinci/Kconfig
>>>>>>>>>> +++ b/arch/arm/mach-davinci/Kconfig
>>>>>>>>>> @@ -41,6 +41,8 @@ config ARCH_DAVINCI_DA850
>>>>>>>>>>  	select ARCH_DAVINCI_DA8XX
>>>>>>>>>>  	select ARCH_HAS_CPUFREQ
>>>>>>>>>>  	select CP_INTC
>>>>>>>>>> +    select IPIPE_ARM_KUSER_TSC if IPIPE
>>>>>>>>>> +    select ARM_FCSE if IPIPE
>>>>>>>>>
>>>>>>>>> You may want to leave the choice of enabling or disabling FCSE to the user.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Understood; at the moment the variance on max latency is really bad if
>>>>>>>> you don't enable FCSE.  When I sort out the crashing issues I'll re-test
>>>>>>>> with it off.
>>>>>>>
>>>>>>> Well, FCSE turned out to be my problem.
>>>>>>>
>>>>>>> More specifically,  FCSE and ARM_FCSE_BEST_EFFORT.  Either a) disabling
>>>>>>> ARM_FCSE altogether, or b) selecting ARM_FCSE with ARM_FCSE_GUARENTEED
>>>>>>> gets rid of the crashes/panics with ipipe latency tracing enabled.
>>>>>>>
>>>>>>> So now things seem reasonably stable, I'll go through the full set of
>>>>>>> tests.  Though I still can't do 'xeno-test -l "dohell -l /opt/ltp"' as
>>>>>>> ltp takes out the system without any ipipe/xenomai bits.
>>>>>>>
>>>>>> Ok, FCSE best effort is currently being validated on 3.14, so it may
>>>>>> well be broken. After all, the raw/* branches are work in progress.
>>>>>>
>>>>>
>>>>> Note: selecting ARM_FCSE_BEST_EFFORT produces the same result on the
>>>>> master branch too . . .
>>>>>
>>>>
>>>> Could you turn CONFIG_ARM_FCSE_MESSAGES on and show us the messages you
>>>> get (with the 3.14 kernel, not the master branch)?
>>>>
>>>
>>> OK - sadly there's not much, but here's what I get from the "dies at, or
>>> immediately after, login" rootfs.  That also has all ipipe debugging,
>>> and stack unwinding, enabled.
>>
>> You should enable CONFIG_DEBUG_USER and boot with the user_debug=29
>> kernel parameter. Disabling stack unwinding enable frame pointers which
>> usually lead to better stack traces.
>>
>>>
>>> Arago Project http://arago-project.org arago ttyS2                              
>>>                                                                                 
>>> Arago 2011.06 arago ttyS2                                                       
>>>                                                                                 
>>> arago login: Unable to handle kernel paging request at virtual address e5902f10 
>>> fcse pid: 0, 0x00000000, hw pid: 0x00000000                                     
>>> pgd = c6934000, hw pgd = c6934000                                               
>>> [e5902f10] *pgd=00000000                                                        
>>> Internal error: Oops: 80000005 [#1] PREEMPT ARM                                 
>>> Modules linked in:                                                              
>>> CPU: 0 PID: 2456 Comm: matrix_guiE Not tainted 3.12.0-ipipe-12092-g1f7fa99-dirt7
>>
>> Please do not base your work on the 3.12 kernel: the previous released
>> I-pipe was 3.10 and the next will be 3.14.
> 
> OK, I now get a decent (long) stack trace on failure:
> 
> Arago Project http://arago-project.org arago ttyS2
> 
> Arago 2011.06 arago ttyS2
> 
> arago login: Unable to handle kernel paging request at virtual address e154000c
> fcse pid: 0, 0x00000000, hw pid: 0x00000000
> pgd = c71d0000, hw pgd = c71d0000
> [e154000c] *pgd=00000000
> Unable to handle kernel paging request at virtual address e154000c
> fcse pid: 0, 0x00000000, hw pid: 0x00000000
> pgd = c71d0000, hw pgd = c71d0000
> [e154000c] *pgd=00000000
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at kernel/ipipe/core.c:605 __ipipe_lock_irq+0x160/0x184()
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 3.14.0-ipipe-38808-gd8d4639-dirty #56
> Backtrace: 
> [<c000d228>] (dump_backtrace) from [<c000d7d0>] (show_stack+0x20/0x24)
>  r6:c04cc8d0 r5:0000025d r4:00000000 r3:00000000
> [<c000d7b0>] (show_stack) from [<c03fa760>] (dump_stack+0x20/0x28)
> [<c03fa740>] (dump_stack) from [<c001f634>] (warn_slowpath_common+0x78/0x98)
> [<c001f5bc>] (warn_slowpath_common) from [<c001f680>] (warn_slowpath_null+0x2c/0x34)
>  r8:00000001 r7:c05b6b80 r6:c0580a98 r5:c059bee6 r4:00000010
> [<c001f654>] (warn_slowpath_null) from [<c008ab40>] (__ipipe_lock_irq+0x160/0x184)
> [<c008a9e0>] (__ipipe_lock_irq) from [<c001b0b0>] (cp_intc_mask_irq+0x68/0x7c)
>  r8:00000001 r7:c05b6b80 r6:c0580a98 r5:00000010 r4:c0575e50 r3:c05b6ba0
> [<c001b048>] (cp_intc_mask_irq) from [<c0065b98>] (handle_edge_irq+0x124/0x170)
>  r4:c0575e50 r3:c001b048
> [<c0065a74>] (handle_edge_irq) from [<c0061560>] (generic_handle_irq+0x28/0x3c)
>  r4:c058afdc r3:c0065a74

As I said, and as explained in the howto, you do not need to call
ipipe_lock_irq in the "mask" callback for an edge irq, you only need to
do that for fasteoi irqs.

The rest seems to be a mix between several issues. Could you enable FCSE
messages?


-- 
                                                                Gilles.

