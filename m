Message-ID: <5283846B.8070004@siemens.com>
Date: Wed, 13 Nov 2013 14:53:47 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <528290CE.1030002@xenomai.org> <52837DD0.1050405@siemens.com>
 <52838180.7070701@xenomai.org>
In-Reply-To: <52838180.7070701@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] issues with debugging enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-11-13 14:41, Gilles Chanteperdrix wrote:
> On 11/13/2013 02:25 PM, Jan Kiszka wrote:
>> On 2013-11-12 21:34, Gilles Chanteperdrix wrote:
>>>
>>> Hi,
>>>
>>> for a change, I ran the xeno-regression-test with a lot of debugging and
>>> options known to having caused problems in the past and found two
>>> issues:
>>>
>>> on x86 SMP, with full dynticks and debugging enabled (preemptible kernel
>>> debugging, mutex, spinlocks, and sleep inside spinlocks), I get the
>>> series of warnings at the end of the mail.
>>
>> We are currently facing crashes inside __switch_to, FPU related
>> (non-existing save area).
> 
> Probably the issue solved by this patch:
> http://git.xenomai.org/?p=ipipe-gch.git;a=commit;h=9b3320eef67e3f118f96065c8c2584b715710d94

Thought I had everything, but I lost track, and it's missing here. Will
merge and give it a try.

> 
> 
>> Once that is sorted out, we can have a look at
>> that scenario as well. Do you have the .config online somewhere?
> 
> http://sisyphus.hd.free.fr/~gilles/config-nestor

OK, thanks.

> 
>>> on ARM, when a fault occurs, the fault ode is entered with hardware irqs
>>> off (this is a recent change in the mainline kernel, this code used to
>>> be executed with hardware irqs on), so I do:
>>>
>>> ipipe_stall_root();
>>> hard_local_irq_enabled();
>>>
>>> But the context checking does not like that.
>>>
>>> Any idea how to fix these?
>>
>> Only ARM's SMP version of ipipe_stall_root() contains
>> ipipe_stall_root(), UP and at least x86 do not have this. I understand
>> that it makes sense to deny this call over non-root, but as it is about
>> fixing up imbalances in the pipeline state, ipipe_stall_root() is likely
>> not the best choice. What about open-coding the relevant check for the
>> domain? Maybe it also works to push the check to the end of
>> ipipe_stall_root, i.e. after fixing up the pipeline state.
> 
> I have to run again the test and check what really happens, because like
> Philippe said, it may be that I am using ipipe_stall_root() when
> entering this code over non root context, and that would be incorrect.
> I have to report the trap to the pipeline first so as to give a chance
> to Xenomai to relax the thread, then enable irqs over root.
> 

OK.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

