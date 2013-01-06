Message-ID: <50EA028A.1070903@web.de>
Date: Mon, 07 Jan 2013 00:02:34 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <50E471AC.2000701@siemens.com> <50E5A0E4.4000108@xenomai.org>
	<50E5A75B.6090507@siemens.com> <50E5B174.2040106@xenomai.org>
	<50E5BF03.5020004@siemens.com> <50E5C134.3010804@xenomai.org>
	<50E5C69E.7090707@siemens.com> <50E6A871.9010008@xenomai.org>
	<50E6ABF7.1050503@siemens.com> <50E6AFC3.5080400@xenomai.org>
	<50E6BB87.4020100@siemens.com> <50E6BE15.2060805@xenomai.org>
	<50E6C112.6070106@siemens.com> <50E6D11E.9090808@xenomai.org>
	<50E9A18D.5040509@xenomai.org>
In-Reply-To: <50E9A18D.5040509@xenomai.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] XNARCH_TIMER_IRQ
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

On 2013-01-06 17:08, Gilles Chanteperdrix wrote:
> On 01/04/2013 01:54 PM, Philippe Gerum wrote:
> =

>> On 01/04/2013 12:46 PM, Jan Kiszka wrote:
>>> On 2013-01-04 12:33, Philippe Gerum wrote:
>>>> On 01/04/2013 12:22 PM, Jan Kiszka wrote:
>>>>> On 2013-01-04 11:32, Philippe Gerum wrote:
>>>>>> On 01/04/2013 11:16 AM, Jan Kiszka wrote:
>>>>>>> On 2013-01-04 11:01, Philippe Gerum wrote:
>>>>>>>> On 01/03/2013 06:57 PM, Jan Kiszka wrote:
>>>>>>>>> On 2013-01-03 18:34, Philippe Gerum wrote:
>>>>>>>>>> On 01/03/2013 06:25 PM, Jan Kiszka wrote:
>>>>>>>>>>> On 2013-01-03 17:27, Philippe Gerum wrote:
>>>>>>>>>>>> On 01/03/2013 04:44 PM, Jan Kiszka wrote:
>>>>>>>>>>>>> On 2013-01-03 16:16, Gilles Chanteperdrix wrote:
>>>>>>>>>>>>>> On 01/02/2013 06:43 PM, Jan Kiszka wrote:
>>>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> this may involve some refactoring of the HAL and a bit of I=
-pipe, so I
>>>>>>>>>>>>>>> better ask first:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Not sure when it changed, but XNARCH_TIMER_IRQ may no longe=
r return the
>>>>>>>>>>>>>>> same values when called on different CPUs. Therefore, It sh=
ould rather
>>>>>>>>>>>>>>> be called XNARCH_THIS_CPU_TIMER_IRQ now.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Looking at its users (an I-pipe debug warning pointed it ou=
t), there are
>>>>>>>>>>>>>>> two that don't expect this: xnintr_query_next() and format_=
irq_proc().
>>>>>>>>>>>>>>> The former actually wants XNARCH_TIMER_IRQ(cpu), the latter=
 needs
>>>>>>>>>>>>>>> something like is_timer_irq_on_any_cpus(irq).
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> So I would propose to refactor XNARCH_TIMER_IRQ and RTHAL_T=
IMER_IRQ
>>>>>>>>>>>>>>> accordingly. But this unfortunately requires extensions of =
I-pipe to
>>>>>>>>>>>>>>> provide something like __ipipe_hrtimer_irq(cpu) and
>>>>>>>>>>>>>>> __ipipe_this_cpu_hrtimer_irq. And some ugly workaround in X=
enomai for
>>>>>>>>>>>>>>> older I-pipe versions.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Does this make sense?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Made something similar for forge:
>>>>>>>>>>>>>> http://git.xenomai.org/?p=3Dxenomai-gch.git;a=3Dcommitdiff;h=
=3D37ca257af466e7e5fbfb402b39f088487d048fd5;hp=3Da9971c363fd361b428f1220053=
6bc5a01dff9c05
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Caution, this code is WIP. nktimer will have to move to the pe=
rcpu
>>>>>>>>>>>> scheduler descriptor to complete this.
>>>>>>>>>>>
>>>>>>>>>>> That's nkclock in 2.6. Mostly a cosmetic issue, the interrupt n=
ame will
>>>>>>>>>>> not be properly printed, statistics are already per-cpu. Could =
be
>>>>>>>>>>> improved nevertheless.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> My point is to tell you that what you look to in -forge regardin=
g this
>>>>>>>>>> area is in a state of flux. I'm not referring to 2.6, I'm focusi=
ng
>>>>>>>>>> almost exclusively on 3.x these days.
>>>>>>>>>>
>>>>>>>>>>> Is there an easy way to find out if we have per-CPU timers on s=
ome arch?
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Why should we assume differently?
>>>>>>>>>
>>>>>>>>> To avoid dumping redundant statistic lines when some timer IRQ ha=
s no
>>>>>>>>> home on a given CPU. But as there are also mixed setups possible =
as
>>>>>>>>> Gilles pointed out, we need a different approach, likely just ski=
p when
>>>>>>>>> there are no hits.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Your question sounded like "is it possible to know whether an SMP =
arch
>>>>>>>> may use different per-CPU IRQs for the timer". I was about to answ=
er
>>>>>>>> that testing for any pipeline core API rev >=3D 2 would do, exclud=
ing all
>>>>>>>> legacy patches.
>>>>>>>>
>>>>>>>> For the cosmetic issue you mention, testing rthal_supported_cpus w=
ould do.
>>>>>>>
>>>>>>> Nope, this is not sufficient. A per-CPU timer IRQ would then still
>>>>>>> generate useless lines in stat for all those CPUs it is not bound t=
o.
>>>>>>>
>>>>>>
>>>>>> You know which CPU has a real-time timer attached via
>>>>>> rthal_supported_cpus, which timer IRQ # is attached to each real-time
>>>>>> CPU when per-CPU timer IRQs are supported by the pipeline. For legacy
>>>>>> patches which only allow a common IRQ line for all timers regardless=
 of
>>>>>> the CPU, the matter is solved by design. I still don't get where the
>>>>>> issue would be.
>>>>>
>>>>> rthal_supported_cpus doesn't contain enough information. We need
>>>>>
>>>>> is_valid_irq(irq, cpu):
>>>>> 	if (timer_irq(cpu) =3D=3D irq)
>>>>> 		return true
>>>>> 	for_each_cpu(n)
>>>>> 		if (timer_irq(n) =3D=3D irq)
>>>>> 			return false
>>>>> 	return true
>>>>>
>>>>> for a cleaned up /stat output as we iterate over all combinations of
>>>>> (irq, cpu) there. That for_each_cpu is a bit ugly, and that's why I w=
as
>>>>> considering to derive is_valid_irq from irq.hits > 0.
>>>>>
>>>>
>>>>
>>>> The problem goes away with cpus displayed on lines, and irq # on colum=
ns.
>>>>
>>>
>>> Not applicable to /stat.
>>>
>>
>> No, the real issue is that using /stat to display timer activity as =

>> thread placeholders is not applicable. So that stuff has to move to =

>> another /proc file.
> =

> =

> Ok, so what we need is a different /proc entry for timer activity.

Splitting /proc is not a good idea from the usability POV. The whole
point of showing the load of IRQs in /stat is to have all information in
one place (percentages sum up to 100...).

I've pushed a simple patch via for-upstream in my repo that should be
sufficient for 2.6. We could refine on top later on.

> As
> for the timer/irq association, the real problem is the aggregation of
> statistics for timers sharing the same irq, not unlike what is done for
> shared irqs.

I cannot follow yet what aggregation issue you are referring to. Hits
are already reported per CPU in /irq, so the sharing of the number does
not matter.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130107/a7199b7=
f/attachment.pgp>
