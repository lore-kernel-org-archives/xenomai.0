Message-ID: <46023991.4020301@domain.hid>
Date: Thu, 22 Mar 2007 09:08:49 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <46002EE0.9040406@domain.hid>
	<460167F8.50703@domain.hid>	<46017CA7.2080801@domain.hid>
	<4601958C.90502@domain.hid> <4601A6E4.9020908@domain.hid>
In-Reply-To: <4601A6E4.9020908@domain.hid>
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
> Wolfgang Grandegger wrote:
>> Oliver Hartkopp wrote:
>>> Wolfgang Grandegger wrote:
>>>> Wolfgang Grandegger wrote:
>>>>   
>>>>> But flooding can still occur and we 
>>>>> are thinking about a better way of downscaling or temporarily disabling 
>>>>> them. Socket-CAN currently restarts the controller after 200 bus errors.
>>>>> My preferred solution for RT-Socket-CAN currently is to stop the CAN 
>>>>> controller after a kernel configurable amount of successive bus errors. 
>>>>> More clever ideas and comments are welcome?
>>>>>     
>>>> What do you think about the following method?
>>>>
>>>>    config XENO_DRIVERS_CAN_SJA1000_BUS_ERR_LIMIT
>>>> 	depends on XENO_DRIVERS_CAN_SJA1000
>>>> 	int "Maximum number of successive bus errors"
>>>> 	range 0 255
>>>> 	default 20
>>>> 	help
>>>>
>>>> 	CAN bus errors are very useful for analyzing electrical problems
>>>>          but they can come at a very high rate resulting in interrupt
>>>>          flooding with bad impact on system performance and real-time
>>>>          behavior. This option, if greater than 0, will limit the amount
>>>>          of successive bus error interrupts. If the limit is reached, an
>>>>          error message with "can_id = CAN_ERR_BUSERR_FLOOD" is sent. The
>>>>          bus error counter gets reset on restart of the device and on any
>>>>          successful message transmission or reception. Be aware that bus
>>>>          error interrupts are only enabled if at least one socket is
>>>>          listening on bus errors.
>>>>
>>>>   
>>> Hi Wolfgang,
>>>
>>> what would be the wanted behaviour, after the discussed problem of bus 
>>> error flooding occurred?
>> Well, I think the bus error rate should be downscaled without loosing 
>> vital information concerning the cause of the problem and it should 
>> require as little user intervention as possible. Treating it like a bus 
>> error as currently done in Socket-CAN is a bit to strong in my mind.
>>
>>> Can the Controller be assumed to be 'slightly dead', or what? Is there 
>>> any chance that the bus heals by itself (=> no more bus errors) and can 
>>> be used in a normal way? Or is a user interaction recommended or _required_?
>> Yes, if you plug the cable, the bus errors might go away and the TX done 
>> interrupt will arrive or you get a bus-off (I have seen both).
>>
>>> Indeed the slow down of bus errors is a reasonable approach, but your 
>>> suggested method leaves too many questions open for the user :-/
>> What questions?
>>
>>> I would tend to reduce the notifications to the user by creating a timer 
>>> at the first bus error interrupt. The first BE irq would lead to a 
>>> CAN_ERR_BUSERROR and after a (configurable) time (e.g.250ms) the next 
>>> information about bus errors is allowed to be passed to the user. After 
>>> this time period is over a new CAN_ERR_BUSERROR may be passed to the 
>>> user containing the count of occurred bus errors somewhere in the 
>>> data[]-section of the Error Frame. When a normal RX/TX-interrupt 
>>> indicates a 'working' CAN again, the timer would be terminated.
>>>
>>> Instead of a fix configurable time we could also think about a dynamic 
>>> behaviour (e.g. with increasing periods).
>>>
>>> What do you think about this?
>> The question is if one bus-error does provide enough information on the 
>> cause of the electrical problem or if a sequence is better. Furthermore, 
>> I personally regard the use of timers as to heavy. But the solution is 
>> feasible, of course. Any other opinions?
>>
> 
> I think Oliver's suggestions points in the right direction. But instead
> of only coding a timer into the stack, I still vote for closing the loop
> over the application:
> 
> After the first error in a potential series, the related error frame is
> queued, listeners are woken up, and BEI is disabled for now. Once some
> listener read the error frame *and* decided to call into the stack for
> further bus errors, BEI is enabled again.
> 
> That way the application decides about the error-related IRQ rate and
> can easily throttle it by delaying the next receive call. Moreover,
> threads of higher priority will be delayed at worst by one error IRQ.
> This mechanism just needs some words in the documentation ("Be warned:
> error frames may overwhelm you. Throttle your reception!"), but no
> further user-visible config options.

I understand, BEI interrupts get (re-)enabled in recvmsg() if the socket 
wants to receive bus errors. There can me multiple readers, but that's 
not a problem. Just some overhead in this function. This would also 
simplify the implementation as my previous one with "on-demand" bus 
error would be obsolete. I start to like this solution.

> Well, and if there is no thread listening on bus errors, but we want
> stats to be updated once in a while, a slow low-prio timer to re-enable
> BEI might still be created in the stack like Oliver suggested. For
> Xenomai, you could consider pending an rtdm_nrtsig to keep the impact on
> the RT domain low. But that's a minor implementation detail. The
> important point is to avoid uncontrolled error bursts, even over a short
> period (20 bus errors at 1 MBit/s already last for > 1 ms).

I think the above solution is enough. Let's go for it?

Wolfgang.

