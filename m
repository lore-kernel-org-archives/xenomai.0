Message-ID: <4603950D.9040801@domain.hid>
Date: Fri, 23 Mar 2007 09:51:25 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <46002EE0.9040406@domain.hid>
	<460167F8.50703@domain.hid>	<46017CA7.2080801@domain.hid>
	<4601958C.90502@domain.hid> <4601A6E4.9020908@domain.hid>
	<46023991.4020301@domain.hid>
	<46036D32.7000603@domain.hid> <46036F22.60709@domain.hid>
	<46039128.90609@domain.hid>
In-Reply-To: <46039128.90609@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: RT-Socket-CAN bus error rate and latencies
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: socketcan-core@domain.hid, Oliver Hartkopp <socketcan@domain.hid>, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Oliver Hartkopp wrote:
>> Additionally to the written stuff below (please read that first), i want
>> to remark:
>>
>> - Remember that we are talking about a case that is not a standard
>> operation mode but a (temporary) error condition that normally leads to
>> a bus-off state and appears only in development and hardware setup phase!
>> - i would suggest to use some low resolution timestamp (like jiffies)
>> for this, which is very cheap in CPU usage
>> - the throttling should be configured as a driver module parameter (e.g.
>> bei_thr=0 or bei_thr=200 )due to the need of the global use-case. If you
>> are writing a CAN analysis tool you might want to set bei_thr=0 in other
>> cases a default of 200ms might be the right thing.
> 
> We are falling back to #1, i.e. where we are now already. Your
> suggestion doesn't help us to provide a generic RT-stack for Xenomai.
> 
>> Regards,
>> Oliver
>>
>>
>>
>> Oliver Hartkopp wrote:
>>> Wolfgang Grandegger wrote:
>>>> Jan Kiszka wrote:
>>>>> Wolfgang Grandegger wrote:
>>>>>> Oliver Hartkopp wrote:
>>>>>>
>>>>>>> I would tend to reduce the notifications to the user by creating a
>>>>>>> timer at the first bus error interrupt. The first BE irq would
>>>>>>> lead to a CAN_ERR_BUSERROR and after a (configurable) time
>>>>>>> (e.g.250ms) the next information about bus errors is allowed to be
>>>>>>> passed to the user. After this time period is over a new
>>>>>>> CAN_ERR_BUSERROR may be passed to the user containing the count of
>>>>>>> occurred bus errors somewhere in the data[]-section of the Error
>>>>>>> Frame. When a normal RX/TX-interrupt indicates a 'working' CAN
>>>>>>> again, the timer would be terminated.
>>>>>>>
>>>>>>> Instead of a fix configurable time we could also think about a
>>>>>>> dynamic behaviour (e.g. with increasing periods).
>>>>>>>
>>>>>>> What do you think about this?
>>>>>> The question is if one bus-error does provide enough information on
>>>>>> the cause of the electrical problem or if a sequence is better.
>>>>>> Furthermore, I personally regard the use of timers as to heavy. But
>>>>>> the solution is feasible, of course. Any other opinions?
>>>>>>
>>>>> I think Oliver's suggestions points in the right direction. But instead
>>>>> of only coding a timer into the stack, I still vote for closing the
>>>>> loop
>>>>> over the application:
>>>>>
>>>>> After the first error in a potential series, the related error frame is
>>>>> queued, listeners are woken up, and BEI is disabled for now. Once some
>>>>> listener read the error frame *and* decided to call into the stack for
>>>>> further bus errors, BEI is enabled again.
>>>>>
>>>>> That way the application decides about the error-related IRQ rate and
>>>>> can easily throttle it by delaying the next receive call. Moreover,
>>>>> threads of higher priority will be delayed at worst by one error IRQ.
>>>>> This mechanism just needs some words in the documentation ("Be warned:
>>>>> error frames may overwhelm you. Throttle your reception!"), but no
>>>>> further user-visible config options.
>>>> I understand, BEI interrupts get (re-)enabled in recvmsg() if the
>>>> socket wants to receive bus errors. There can me multiple readers,
>>>> but that's not a problem. Just some overhead in this function. This
>>>> would also simplify the implementation as my previous one with
>>>> "on-demand" bus error would be obsolete. I start to like this solution.
>>> Hm - to reenable the BEI on user interaction would be a nice thing BUT i
>>> can see several problems:
>>>
>>> 1. In socketcan you have receive queues into the userspace with a
>>> length >1
> 
> Can you explain to me what the problem behind this is? I don't see it yet.
> 
>>> 2. How can we handle multiple subscribers (A reads three error frames
>>> and reenables therefore the BEI, B reads nothing in this time). Please
>>> remember: To have multiple applications it a vital idea from socketcan.
> 
> Same here, I don't see the issue. A and B will both find the first error
> frame in their queues/ring buffers/whatever. If A has higher priority
> (or gets an earlier timeslice), it may already re-enable BEI before B
> was able to run as well. But that's an application-specific scheduling
> issue and not a problem of the CAN stack (often it is precisely what you
> want when assigning priorities...).
> 
>>> 3. The count of occured BEIs gets lost (maybe this is unimportant)
> 
> Agreed, but I also don't consider this problematic.
> 
>>> ----
>>>
>>> Regarding (2) the solution could be not to reenable the BEI for a device
>>> until every subscriber has read his error frame. But this collides with
>>> a raw-socket that's bound to 'any' device (ifindex = 0).
> 
> That can cause prio-inversion: a low-prio BEI-reader decides about when
> a high-prio one gets the next message. No-go for RT.
> 
>>> Regarding (3) we could count the BEIs (which would not reduce the
>>> interrupt load) or we just stop the BEI after the first occurance which
>>> might possibly not enough for some people to implement the CAN
>>> academical correct.
>>>
>>> As you may see here a tight coupling of the problems on the CAN bus with
>>> the application(s!) is very tricky or even impossible in socketcan.
>>> Regarding other network devices (like ethernet devices) the notification
>>> about Layer 1/2 problems is unusual. The concept of creating error
>>> frames was a good compromise for this reason.
>>>
>>> As i also would like to avoid to create a timer for "bus error
>>> throttling", i got a new idea:
>>>
>>> - on the first BEI: create an error frame, set a counter to zero and
>>> save the current timestamp
>>> - on the next BEI:
>>>  - increment the counter
>>>  - check if the time is up for the next error frame (e.g. after 200ms -
>>> configurable?)
>>>  - if so: Send the next error frame (including the number of occured
>>> error frames in this 200ms)
>>>
>>> BEI means ONLY to have a BEI (and no other error).
>>>
>>> Of course this does NOT reduce the interrupt load but all this
>>> throttling is performed inside the interrupt context. This should not be
>>> that problem, or is it? And we do not need a timer ...
>>>
>>> Any comments to this idea?
>>>
>>> Regards,
>>> Oliver
>>>
> 
> Well, I may oversee some pitfalls of my suggestion, so please help me to
> understand your concerns.

There might be a problem with re-enabling BEI interrupts because we need 
  to read the ECC. OK, I'm going to implement the method as well to 
check for pitfalls.

Wolfgang.


