Message-ID: <50F7C0F0.4040809@web.de>
Date: Thu, 17 Jan 2013 10:14:24 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <50F6FCDB.1020109@siemens.com> <50F7B5BC.20701@xenomai.org>
	<50F7B790.2090500@web.de> <50F7BB97.80600@xenomai.org>
	<50F7C07F.2090800@xenomai.org>
In-Reply-To: <50F7C07F.2090800@xenomai.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [PATCH] ipipe: Re-fix migration helper for legacy
	users
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-01-17 10:12, Philippe Gerum wrote:
> On 01/17/2013 09:51 AM, Philippe Gerum wrote:
>> On 01/17/2013 09:34 AM, Jan Kiszka wrote:
>>> On 2013-01-17 09:26, Philippe Gerum wrote:
>>>> On 01/16/2013 08:17 PM, Jan Kiszka wrote:
>>>>> In the legacy use case, __ipipe_switch_tail will be invoked over the
>>>>> non-root domain after hardening. So clearing of TASK_HARDENING must
>>>>> not
>>>>> be restricted to root.
>>>>>
>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>> ---
>>>>>
>>>>> For the case my analysis was right. With this, Xenomai 2.6 works again
>>>>> here.
>>>>>
>>>>>    kernel/ipipe/core.c |    2 ++
>>>>>    1 files changed, 2 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
>>>>> index 6929156..4695ba8 100644
>>>>> --- a/kernel/ipipe/core.c
>>>>> +++ b/kernel/ipipe/core.c
>>>>> @@ -1124,7 +1124,9 @@ int __ipipe_switch_tail(void)
>>>>>        hard_local_irq_disable();
>>>>>    #endif
>>>>>        x =3D __ipipe_root_p;
>>>>> +#ifndef CONFIG_IPIPE_LEGACY
>>>>>        if (x)
>>>>> +#endif
>>>>>            complete_domain_migration();
>>>>>
>>>>>    #ifndef CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH
>>>>>
>>>>
>>>> The analysis is right. I already fixed this bug in the 3.5 branch, we
>>>> are missing a forward port to 3.5.7.
>>>>
>>>> http://git.denx.de/?p=3Dipipe-2.6.git;a=3Dcommit;h=3D8b11dc5fee73842a2=
4ec4367b57aaa2dcdd67225
>>>>
>>>>
>>>
>>> Would you push your new version?
>>>
>>> Jan
>>
>> These patches introduced between core-3.5-2 and core-3.5-3 were not
>> propagated to core-3.5.7. They are on their way now.
>>
>> ba77ad1 powerpc/ipipe: prevent spurious hw IRQ enabling in activate_mm()
>> 8b11dc5 ipipe: fix domain migration helper
>> 1f0d763 x86_64/ipipe: introduce ipipe_clock_name()
>>
> =

> 8b11dc5 would reintroduce the issue you saw in legacy mode though. Fix
> on its way.

Not sure what you were looking at: 8b11dc5 is part of your public
core-3.5 branch. I was rebasing over it, testing the result and found
his bug.

Jan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130117/8c6c9e4=
6/attachment.pgp>
