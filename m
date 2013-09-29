Message-ID: <52484EB0.6020807@xenomai.org>
Date: Sun, 29 Sep 2013 18:00:48 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <E1VPeW6-00026B-Hu@xenomai.org> <5246931B.3060503@xenomai.org>
	<52469507.3070101@xenomai.org> <5246A6D3.7070502@xenomai.org>
	<5246B982.6030209@xenomai.org> <5247041A.8090102@xenomai.org>
	<5247FD02.3050605@web.de> <52483F85.10508@xenomai.org>
	<52484951.5050508@web.de> <52484B0D.3040309@xenomai.org>
	<52484B4C.8050004@web.de>
In-Reply-To: <52484B4C.8050004@web.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Gilles Chanteperdrix : hal/x86: fix smi
	message
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: xenomai@xenomai.org

On 09/29/2013 05:46 PM, Jan Kiszka wrote:
> On 2013-09-29 17:45, Philippe Gerum wrote:
>> On 09/29/2013 05:37 PM, Jan Kiszka wrote:
>>> On 2013-09-29 16:56, Philippe Gerum wrote:
>>>> On 09/29/2013 12:12 PM, Jan Kiszka wrote:
>>>>> On 2013-09-28 18:30, Philippe Gerum wrote:
>>>>>> On 09/28/2013 01:12 PM, Gilles Chanteperdrix wrote:
>>>>>>> On 09/28/2013 11:52 AM, Philippe Gerum wrote:
>>>>>>>> On 09/28/2013 10:36 AM, Gilles Chanteperdrix wrote:
>>>>>>>>> On 09/28/2013 10:28 AM, Philippe Gerum wrote:
>>>>>>>>>> On 09/27/2013 10:19 PM, git repository hosting wrote:
>>>>>>>>>>> Module: xenomai-gch
>>>>>>>>>>> Branch: for-forge
>>>>>>>>>>> Commit: 283fabdf63e23f03a45565fa1f9937f9a5825a59
>>>>>>>>>>> URL:
>>>>>>>>>>> http://git.xenomai.org/?p=xenomai-gch.git;a=commit;h=283fabdf63e23f03a45565fa1f9937f9a5825a59
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Author: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>>>>>>>>>> Date:   Sun Sep 15 15:59:52 2013 +0200
>>>>>>>>>>>
>>>>>>>>>>> hal/x86: fix smi message
>>>>>>>>>>>
>>>>>>>>>>> ---
>>>>>>>>>>>
>>>>>>>>>>>        kernel/cobalt/arch/x86/smi.c |    2 +-
>>>>>>>>>>>        1 files changed, 1 insertions(+), 1 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/kernel/cobalt/arch/x86/smi.c
>>>>>>>>>>> b/kernel/cobalt/arch/x86/smi.c
>>>>>>>>>>> index e06734a..124d311 100644
>>>>>>>>>>> --- a/kernel/cobalt/arch/x86/smi.c
>>>>>>>>>>> +++ b/kernel/cobalt/arch/x86/smi.c
>>>>>>>>>>> @@ -123,7 +123,7 @@ void mach_x86_smi_init(void)
>>>>>>>>>>>            if (smi_state == 0) {
>>>>>>>>>>>                printk("Xenomai: SMI-enabled chipset found, but
>>>>>>>>>>> SMI "
>>>>>>>>>>>                       "workaround disabled\n"
>>>>>>>>>>> -               "         (see xeno_hal.smi parameter). You may
>>>>>>>>>>> encounter\n"
>>>>>>>>>>> +               "         (see x86_hal.smi parameter). You may
>>>>>>>>>>> encounter\n"
>>>>>>>>>>>                       "         high interrupt latencies!\n");
>>>>>>>>>>>                pci_dev_put(dev);
>>>>>>>>>>>                return;
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Strictly speaking, the HAL disappeared from x3, since most of the
>>>>>>>>>> arch-independant interface is already provided by the interrupt
>>>>>>>>>> pipeline, and the event driven simulator was dropped. We should
>>>>>>>>>> not
>>>>>>>>>> reintroduce it in the naming.
>>>>>>>>>>
>>>>>>>>> The parameter name is due to this Makefile chunk:
>>>>>>>>>
>>>>>>>>> obj-$(CONFIG_XENOMAI) += x86_hal.o
>>>>>>>>> x86_hal-y := machine.o mayday.o thread.o smi.o
>>>>>>>>>
>>>>>>>>
>>>>>>>> This is a left over, like the message you fixed. Should be
>>>>>>>> x86_machine
>>>>>>>> or something along these lines.
>>>>>>>>
>>>>>>>
>>>>>>> x86 alone maybe?
>>>>>>>
>>>>>>
>>>>>> Whatever fits. It's just that the code living under
>>>>>> kernel/cobalt/arch/*
>>>>>> is referred to as the machine layer elsewhere.
>>>>>
>>>>> Shouldn't this just be added to the Xenomai module (xenomai-y)?
>>>>>
>>>>
>>>> xenomai-y is supposed to include all arch-independent bits, for this
>>>> reason the machine layer is rather pulled from core-y in arch/*.
>>>
>>> If you want a different module name, then please make at least sure that
>>> it includes "xenomai", "xenomai_arch" or so. Current proposals are way
>>> too generic and confusing for the users.
>>>
>>
>> The point is such information is absolutely not visible to the user.
>
> And what else controls where the module parameters end up under
> /sys/modules?
>

I'm discussing the internal sub-module name from the Kbuild hierarchy, 
which is by no mean exported to the user, so I see no reason to move 
this to xenomai-y, this would make no sense.

We discussed the *hal parameter name Gilles submitted a patch for, for 
removing any reference to the former hardware abstraction layer, 
replacing it, e.g. by "machine".

I don't have any issue with merging patch introducing a xenomai-specific 
prefix for all named parameters, and make this a policy. But in that 
case, please do fix up all existing parameters accordingly, we currently 
have inconsistencies:

kernel/cobalt/arch/x86/smi.c:module_param_named(smi, smi_state, int, 0400);
kernel/cobalt/arch/x86/smi.c:module_param_named(smi_mask, 
smi_masked_bits, int, 0400);
kernel/cobalt/init.c:module_param_named(timerfreq, timerfreq_arg, ulong, 
0444);
kernel/cobalt/init.c:module_param_named(clockfreq, clockfreq_arg, ulong, 
0444);
kernel/cobalt/init.c:module_param_named(supported_cpus, 
supported_cpus_arg, ulong, 0444);
kernel/cobalt/init.c:module_param_named(disable, disable_arg, ulong, 0444);
kernel/cobalt/sched.c:module_param_named(watchdog_timeout, 
wd_timeout_arg, ulong, 0644);
kernel/cobalt/shadow.c:module_param_named(xenomai_gid, xn_gid_arg, int, 
0644);

-- 
Philippe.

