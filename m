Message-ID: <4CCAD231.4090108@domain.hid>
Date: Fri, 29 Oct 2010 15:54:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CC998FB.3070102@domain.hid> <4CC9CBE1.6030006@domain.hid>	
	<1288294469.1816.107.camel@domain.hid> <4CCA70F1.3010501@domain.hid>	
	<1288340853.1816.146.camel@domain.hid>
	<4CCA8E53.5040500@domain.hid>	
	<1288353650.1816.152.camel@domain.hid>
	<4CCAB990.6020609@domain.hid>	
	<1288356408.1816.173.camel@domain.hid>
	<1288357136.1816.177.camel@domain.hid>
In-Reply-To: <1288357136.1816.177.camel@domain.hid>
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

Am 29.10.2010 14:58, Philippe Gerum wrote:
> On Fri, 2010-10-29 at 14:46 +0200, Philippe Gerum wrote:
>> On Fri, 2010-10-29 at 14:09 +0200, Jan Kiszka wrote:
>>> Am 29.10.2010 14:00, Philippe Gerum wrote:
>>>> On Fri, 2010-10-29 at 11:05 +0200, Jan Kiszka wrote:
>>>>> Am 29.10.2010 10:27, Philippe Gerum wrote:
>>>>>> On Fri, 2010-10-29 at 09:00 +0200, Jan Kiszka wrote:
>>>>>>> Am 28.10.2010 21:34, Philippe Gerum wrote:
>>>>>>>> On Thu, 2010-10-28 at 21:15 +0200, Gilles Chanteperdrix wrote:
>>>>>>>>> Jan Kiszka wrote:
>>>>>>>>>> Gilles,
>>>>>>>>>>
>>>>>>>>>> I happened to come across rthal_mark_irq_disabled/enabled on arm. On
>>>>>>>>>> first glance, it looks like these helpers manipulate irq_desc::status
>>>>>>>>>> non-atomically, i.e. without holding irq_desc::lock. Isn't this fragile?
>>>>>>>>>
>>>>>>>>> I have no idea. How do the other architectures do? As far as I know,
>>>>>>>>> this code has been copied from there.
>>>>>>>>
>>>>>>>> Other archs do the same, simply because once an irq is managed by the
>>>>>>>> hal, it may not be shared in any way with the regular kernel. So locking
>>>>>>>> is pointless.
>>>>>>>
>>>>>>> Indeed, I missed that all the other archs have this uninlined in hal.c.
>>>>>>>
>>>>>>> However, this leaves at least a race between xnintr_disable/enable and
>>>>>>> XN_ISR_PROPAGATE (ie. the related Linux path) behind.
>>>>>>
>>>>>> I can't see why XN_ISR_PROPAGATE would be involved here. This service
>>>>>> pends an interrupt in the pipeline log.
>>>>>
>>>>> And this finally lets Linux code run that fiddles with irq_desc::status
>>>>> as well - potentially in parallel to an unsyncrhonized
>>>>> xnintr_irq_disable in a different context. That's the problem.
>>>>
>>>> Propagation happens in primary domain. When is this supposed to conflict
>>>> on the same CPU with linux?
>>>
>>> The propagation triggers the delivery of this IRQ to the Linux domain,
>>> thus at some point there will be Linux accessing the descriptor while
>>> there might be xnintr_irq_enable/disable running on some other CPU (or
>>> it was preempted at the wrong point on the very same CPU).
>>
>> The point is that XN_ISR_PROPAGATE, as a mean to force sharing of an IRQ
>> between both domains is plain wrong. Remove this, and no conflict
>> remains; this is what needs to be addressed. The potential issue between
>> xnintr_enable/disable and the hal routines does not exist, if those
>> callers handle locking properly.
>>
> 
> In any case, I don't think we could accept that sharing, so flipping the
> bits in the hal is in fact pointless. To match the linux locking, we
> should iron the irq_desc::lock, which we won't since this would cause
> massive jittery. We should stick to the basic logic: no sharing,
> therefore no tracking need for the irqflags. I'll kill XN_ISR_PROPAGATE
> in forge at some point, for sure.
> 

Sounds good.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

