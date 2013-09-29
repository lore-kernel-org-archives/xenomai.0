Message-ID: <524850DA.7050407@web.de>
Date: Sun, 29 Sep 2013 18:10:02 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <E1VPeW6-00026B-Hu@xenomai.org> <5246931B.3060503@xenomai.org>
	<52469507.3070101@xenomai.org> <5246A6D3.7070502@xenomai.org>
	<5246B982.6030209@xenomai.org> <5247041A.8090102@xenomai.org>
	<5247FD02.3050605@web.de> <52483F85.10508@xenomai.org>
	<52484951.5050508@web.de> <52484B0D.3040309@xenomai.org>
	<52484B4C.8050004@web.de> <52484EB0.6020807@xenomai.org>
In-Reply-To: <52484EB0.6020807@xenomai.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 2013-09-29 18:00, Philippe Gerum wrote:
> On 09/29/2013 05:46 PM, Jan Kiszka wrote:
>> On 2013-09-29 17:45, Philippe Gerum wrote:
>>> On 09/29/2013 05:37 PM, Jan Kiszka wrote:
>>>> On 2013-09-29 16:56, Philippe Gerum wrote:
>>>>> On 09/29/2013 12:12 PM, Jan Kiszka wrote:
>>>>>> On 2013-09-28 18:30, Philippe Gerum wrote:
>>>>>>> On 09/28/2013 01:12 PM, Gilles Chanteperdrix wrote:
>>>>>>>> On 09/28/2013 11:52 AM, Philippe Gerum wrote:
>>>>>>>>> On 09/28/2013 10:36 AM, Gilles Chanteperdrix wrote:
>>>>>>>>>> On 09/28/2013 10:28 AM, Philippe Gerum wrote:
>>>>>>>>>>> On 09/27/2013 10:19 PM, git repository hosting wrote:
>>>>>>>>>>>> Module: xenomai-gch
>>>>>>>>>>>> Branch: for-forge
>>>>>>>>>>>> Commit: 283fabdf63e23f03a45565fa1f9937f9a5825a59
>>>>>>>>>>>> URL:
>>>>>>>>>>>> http://git.xenomai.org/?p=3Dxenomai-gch.git;a=3Dcommit;h=3D283=
fabdf63e23f03a45565fa1f9937f9a5825a59
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Author: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>>>>>>>>>>> Date:   Sun Sep 15 15:59:52 2013 +0200
>>>>>>>>>>>>
>>>>>>>>>>>> hal/x86: fix smi message
>>>>>>>>>>>>
>>>>>>>>>>>> ---
>>>>>>>>>>>>
>>>>>>>>>>>>        kernel/cobalt/arch/x86/smi.c |    2 +-
>>>>>>>>>>>>        1 files changed, 1 insertions(+), 1 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/kernel/cobalt/arch/x86/smi.c
>>>>>>>>>>>> b/kernel/cobalt/arch/x86/smi.c
>>>>>>>>>>>> index e06734a..124d311 100644
>>>>>>>>>>>> --- a/kernel/cobalt/arch/x86/smi.c
>>>>>>>>>>>> +++ b/kernel/cobalt/arch/x86/smi.c
>>>>>>>>>>>> @@ -123,7 +123,7 @@ void mach_x86_smi_init(void)
>>>>>>>>>>>>            if (smi_state =3D=3D 0) {
>>>>>>>>>>>>                printk("Xenomai: SMI-enabled chipset found, but
>>>>>>>>>>>> SMI "
>>>>>>>>>>>>                       "workaround disabled\n"
>>>>>>>>>>>> -               "         (see xeno_hal.smi parameter). You may
>>>>>>>>>>>> encounter\n"
>>>>>>>>>>>> +               "         (see x86_hal.smi parameter). You may
>>>>>>>>>>>> encounter\n"
>>>>>>>>>>>>                       "         high interrupt latencies!\n");
>>>>>>>>>>>>                pci_dev_put(dev);
>>>>>>>>>>>>                return;
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Strictly speaking, the HAL disappeared from x3, since most of
>>>>>>>>>>> the
>>>>>>>>>>> arch-independant interface is already provided by the interrupt
>>>>>>>>>>> pipeline, and the event driven simulator was dropped. We should
>>>>>>>>>>> not
>>>>>>>>>>> reintroduce it in the naming.
>>>>>>>>>>>
>>>>>>>>>> The parameter name is due to this Makefile chunk:
>>>>>>>>>>
>>>>>>>>>> obj-$(CONFIG_XENOMAI) +=3D x86_hal.o
>>>>>>>>>> x86_hal-y :=3D machine.o mayday.o thread.o smi.o
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> This is a left over, like the message you fixed. Should be
>>>>>>>>> x86_machine
>>>>>>>>> or something along these lines.
>>>>>>>>>
>>>>>>>>
>>>>>>>> x86 alone maybe?
>>>>>>>>
>>>>>>>
>>>>>>> Whatever fits. It's just that the code living under
>>>>>>> kernel/cobalt/arch/*
>>>>>>> is referred to as the machine layer elsewhere.
>>>>>>
>>>>>> Shouldn't this just be added to the Xenomai module (xenomai-y)?
>>>>>>
>>>>>
>>>>> xenomai-y is supposed to include all arch-independent bits, for this
>>>>> reason the machine layer is rather pulled from core-y in arch/*.
>>>>
>>>> If you want a different module name, then please make at least sure
>>>> that
>>>> it includes "xenomai", "xenomai_arch" or so. Current proposals are way
>>>> too generic and confusing for the users.
>>>>
>>>
>>> The point is such information is absolutely not visible to the user.
>>
>> And what else controls where the module parameters end up under
>> /sys/modules?
>>
> =

> I'm discussing the internal sub-module name from the Kbuild hierarchy,
> which is by no mean exported to the user

Sorry, but it is:

	.module_name    =3D KBUILD_MODNAME,

So the KBUILD module name defines the parameter prefixes. And that is
what we should discuss here. I don't mind the kbuild structure otherwise.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130929/15393f8=
b/attachment.pgp>
