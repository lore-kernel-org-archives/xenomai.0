Message-ID: <460391BE.7010908@domain.hid>
Date: Fri, 23 Mar 2007 09:37:18 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <46002EE0.9040406@domain.hid>
	<460167F8.50703@domain.hid>	<46017CA7.2080801@domain.hid>
	<4601958C.90502@domain.hid> <4601A6E4.9020908@domain.hid>
	<46023991.4020301@domain.hid> <46036D32.7000603@domain.hid>
In-Reply-To: <46036D32.7000603@domain.hid>
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
To: Oliver Hartkopp <socketcan@domain.hid>
Cc: socketcan-core@domain.hid, Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Oliver Hartkopp wrote:
> Wolfgang Grandegger wrote:
>> Jan Kiszka wrote:
>>> Wolfgang Grandegger wrote:
>>>> Oliver Hartkopp wrote:
>>>>
>>>>> I would tend to reduce the notifications to the user by creating a 
>>>>> timer at the first bus error interrupt. The first BE irq would lead 
>>>>> to a CAN_ERR_BUSERROR and after a (configurable) time (e.g.250ms) 
>>>>> the next information about bus errors is allowed to be passed to 
>>>>> the user. After this time period is over a new CAN_ERR_BUSERROR may 
>>>>> be passed to the user containing the count of occurred bus errors 
>>>>> somewhere in the data[]-section of the Error Frame. When a normal 
>>>>> RX/TX-interrupt indicates a 'working' CAN again, the timer would be 
>>>>> terminated.
>>>>>
>>>>> Instead of a fix configurable time we could also think about a 
>>>>> dynamic behaviour (e.g. with increasing periods).
>>>>>
>>>>> What do you think about this?
>>>> The question is if one bus-error does provide enough information on 
>>>> the cause of the electrical problem or if a sequence is better. 
>>>> Furthermore, I personally regard the use of timers as to heavy. But 
>>>> the solution is feasible, of course. Any other opinions?
>>>>
>>>
>>> I think Oliver's suggestions points in the right direction. But instead
>>> of only coding a timer into the stack, I still vote for closing the loop
>>> over the application:
>>>
>>> After the first error in a potential series, the related error frame is
>>> queued, listeners are woken up, and BEI is disabled for now. Once some
>>> listener read the error frame *and* decided to call into the stack for
>>> further bus errors, BEI is enabled again.
>>>
>>> That way the application decides about the error-related IRQ rate and
>>> can easily throttle it by delaying the next receive call. Moreover,
>>> threads of higher priority will be delayed at worst by one error IRQ.
>>> This mechanism just needs some words in the documentation ("Be warned:
>>> error frames may overwhelm you. Throttle your reception!"), but no
>>> further user-visible config options.
>>
>> I understand, BEI interrupts get (re-)enabled in recvmsg() if the 
>> socket wants to receive bus errors. There can me multiple readers, but 
>> that's not a problem. Just some overhead in this function. This would 
>> also simplify the implementation as my previous one with "on-demand" 
>> bus error would be obsolete. I start to like this solution.
> 
> Hm - to reenable the BEI on user interaction would be a nice thing BUT i
> can see several problems:
> 
> 1. In socketcan you have receive queues into the userspace with a length >1

Yes, and they are still used to receive normal and other error messages.

> 2. How can we handle multiple subscribers (A reads three error frames
> and reenables therefore the BEI, B reads nothing in this time). Please
> remember: To have multiple applications it a vital idea from socketcan.

My idea was to re-enable (or trigger) one BEI at the beginning of 
recvmsg in selected. Then all listening sockets will receive all bus 
error messages, e.g. A and B will receive up to the sum of the recvmsg 
calls form A and B. Well, this mixture is not really nice but it will 
downscale the bus error rate to a "digestible" level.

> 3. The count of occured BEIs gets lost (maybe this is unimportant)

I do not regard this as a problem. The purpose of this option is to 
downscale the BEI rate.

> ----
> 
> Regarding (2) the solution could be not to reenable the BEI for a device
> until every subscriber has read his error frame. But this collides with
> a raw-socket that's bound to 'any' device (ifindex = 0).

We cannot do that.

> Regarding (3) we could count the BEIs (which would not reduce the
> interrupt load) or we just stop the BEI after the first occurance which
> might possibly not enough for some people to implement the CAN
> academical correct.
> 
> As you may see here a tight coupling of the problems on the CAN bus with
> the application(s!) is very tricky or even impossible in socketcan.
> Regarding other network devices (like ethernet devices) the notification
> about Layer 1/2 problems is unusual. The concept of creating error
> frames was a good compromise for this reason.
> 
> As i also would like to avoid to create a timer for "bus error
> throttling", i got a new idea:
> 
> - on the first BEI: create an error frame, set a counter to zero and
> save the current timestamp
> - on the next BEI:
>  - increment the counter
>  - check if the time is up for the next error frame (e.g. after 200ms -
> configurable?)
>  - if so: Send the next error frame (including the number of occured
> error frames in this 200ms)
> 
> BEI means ONLY to have a BEI (and no other error).
> 
> Of course this does NOT reduce the interrupt load but all this
> throttling is performed inside the interrupt context. This should not be
> that problem, or is it? And we do not need a timer ...

It's about reducing the very high BEI interrupt rate. A rate of 15kHz is 
_really_ heavy on mid and low end systems and especially for real-time.

> Any comments to this idea?

Well, till now I do not see a 100% satisfactory solution and I do not 
want to make the implementation too sophisticated. Currently I'm in 
favor of my proposes solution with a low default value (10 or even 1):

   config XENO_DRIVERS_CAN_SJA1000_BUS_ERR_LIMIT
         depends on XENO_DRIVERS_CAN_SJA1000
         int "Maximum number of successive bus errors"
         range 0 255
         default 10
         help

         CAN bus errors are very useful for analyzing electrical problems
         but they can come at a very high rate resulting in interrupt
         flooding with bad impact on system performance and real-time
         behavior. This option, if greater than 0, will limit the amount
         of successive bus error interrupts. If the limit is reached, an
         error message with "can_id = CAN_ERR_BUSERR_FLOOD" is sent and
         the bus error interrutps get disabled. They get re-enabled on
         restart of the device and on any successful message transmission
         or reception. Be aware that bus error interrupts are only
         enabled if at least one socket is listening on bus errors.

The user has still all choices. What is you preferred solution?

Wolfgang


