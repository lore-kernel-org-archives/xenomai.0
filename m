Message-ID: <4CCAB990.6020609@domain.hid>
Date: Fri, 29 Oct 2010 14:09:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CC998FB.3070102@domain.hid> <4CC9CBE1.6030006@domain.hid>	
	<1288294469.1816.107.camel@domain.hid> <4CCA70F1.3010501@domain.hid>	
	<1288340853.1816.146.camel@domain.hid> <4CCA8E53.5040500@domain.hid>
	<1288353650.1816.152.camel@domain.hid>
In-Reply-To: <1288353650.1816.152.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] arm: Unprotected access to irq_desc field?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

Am 29.10.2010 14:00, Philippe Gerum wrote:
> On Fri, 2010-10-29 at 11:05 +0200, Jan Kiszka wrote:
>> Am 29.10.2010 10:27, Philippe Gerum wrote:
>>> On Fri, 2010-10-29 at 09:00 +0200, Jan Kiszka wrote:
>>>> Am 28.10.2010 21:34, Philippe Gerum wrote:
>>>>> On Thu, 2010-10-28 at 21:15 +0200, Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Gilles,
>>>>>>>
>>>>>>> I happened to come across rthal_mark_irq_disabled/enabled on arm. On
>>>>>>> first glance, it looks like these helpers manipulate irq_desc::status
>>>>>>> non-atomically, i.e. without holding irq_desc::lock. Isn't this fragile?
>>>>>>
>>>>>> I have no idea. How do the other architectures do? As far as I know,
>>>>>> this code has been copied from there.
>>>>>
>>>>> Other archs do the same, simply because once an irq is managed by the
>>>>> hal, it may not be shared in any way with the regular kernel. So locking
>>>>> is pointless.
>>>>
>>>> Indeed, I missed that all the other archs have this uninlined in hal.c.
>>>>
>>>> However, this leaves at least a race between xnintr_disable/enable and
>>>> XN_ISR_PROPAGATE (ie. the related Linux path) behind.
>>>
>>> I can't see why XN_ISR_PROPAGATE would be involved here. This service
>>> pends an interrupt in the pipeline log.
>>
>> And this finally lets Linux code run that fiddles with irq_desc::status
>> as well - potentially in parallel to an unsyncrhonized
>> xnintr_irq_disable in a different context. That's the problem.
> 
> Propagation happens in primary domain. When is this supposed to conflict
> on the same CPU with linux?

The propagation triggers the delivery of this IRQ to the Linux domain,
thus at some point there will be Linux accessing the descriptor while
there might be xnintr_irq_enable/disable running on some other CPU (or
it was preempted at the wrong point on the very same CPU).

> 
>>
>>>
>>>>  Not sure if it
>>>> matters practically - but risking silent breakage for this micro
>>>> optimization?
>>>
>>> It was not meant as an optimization; we may not grab the linux
>>> descriptor lock in this context because we may enter it in primary mode.
>>
>> Oh, that lock isn't harden as I somehow assumed. This of course
>> complicates things.
>>
>>>
>>>>  Is disabling/enabling really in the highly
>>>> latency-critical anywhere? Otherwise, I would suggest to just plug this
>>>> by adding the intended lock for this field.
>>>
>>> The caller is expected to manage locking; AFAICS the only one who does
>>> not is the RTAI skin, which is obsolete and removed in 2.6.x, so no big
>>> deal.
>>
>> The problem is that IRQ forwarding to Linux may let this manipulation
>> race with plain Linux code, thus has to synchronize with it. It is a
>> corner case (no one is supposed to pass IRQs down blindly anyway - if at
>> all), but it should at least be documented ("Don't use disable/enable
>> together with IRQ forwarding unless you acquire the descriptor lock
>> properly!").
>>
>> BTW, do we need to track the descriptor state in primary mode at all?
>>
> 
> That is the real issue. I don't see the point of doing this with the
> current kernel code.

Do we need to keep the status in synch with the hardware state for the
case Linux may take over the descriptor again? Or will Linux test the
state when processing a forwarded IRQ? These are the two potential
scenarios that come to my mind. For former could be deferred, but the
latter would be critical again.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

