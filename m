Message-ID: <4601958C.90502@domain.hid>
Date: Wed, 21 Mar 2007 21:29:00 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <46002EE0.9040406@domain.hid> <460167F8.50703@domain.hid>
	<46017CA7.2080801@domain.hid>
In-Reply-To: <46017CA7.2080801@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Cc: socketcan-core@domain.hid, xenomai-core <xenomai@xenomai.org>

Oliver Hartkopp wrote:
> Wolfgang Grandegger wrote:
>> Wolfgang Grandegger wrote:
>>   
>>> But flooding can still occur and we 
>>> are thinking about a better way of downscaling or temporarily disabling 
>>> them. Socket-CAN currently restarts the controller after 200 bus errors.
>>> My preferred solution for RT-Socket-CAN currently is to stop the CAN 
>>> controller after a kernel configurable amount of successive bus errors. 
>>> More clever ideas and comments are welcome?
>>>     
>> What do you think about the following method?
>>
>>    config XENO_DRIVERS_CAN_SJA1000_BUS_ERR_LIMIT
>> 	depends on XENO_DRIVERS_CAN_SJA1000
>> 	int "Maximum number of successive bus errors"
>> 	range 0 255
>> 	default 20
>> 	help
>>
>> 	CAN bus errors are very useful for analyzing electrical problems
>>          but they can come at a very high rate resulting in interrupt
>>          flooding with bad impact on system performance and real-time
>>          behavior. This option, if greater than 0, will limit the amount
>>          of successive bus error interrupts. If the limit is reached, an
>>          error message with "can_id = CAN_ERR_BUSERR_FLOOD" is sent. The
>>          bus error counter gets reset on restart of the device and on any
>>          successful message transmission or reception. Be aware that bus
>>          error interrupts are only enabled if at least one socket is
>>          listening on bus errors.
>>
>>   
> 
> Hi Wolfgang,
> 
> what would be the wanted behaviour, after the discussed problem of bus 
> error flooding occurred?

Well, I think the bus error rate should be downscaled without loosing 
vital information concerning the cause of the problem and it should 
require as little user intervention as possible. Treating it like a bus 
error as currently done in Socket-CAN is a bit to strong in my mind.

> Can the Controller be assumed to be 'slightly dead', or what? Is there 
> any chance that the bus heals by itself (=> no more bus errors) and can 
> be used in a normal way? Or is a user interaction recommended or _required_?

Yes, if you plug the cable, the bus errors might go away and the TX done 
interrupt will arrive or you get a bus-off (I have seen both).

> Indeed the slow down of bus errors is a reasonable approach, but your 
> suggested method leaves too many questions open for the user :-/

What questions?

> I would tend to reduce the notifications to the user by creating a timer 
> at the first bus error interrupt. The first BE irq would lead to a 
> CAN_ERR_BUSERROR and after a (configurable) time (e.g.250ms) the next 
> information about bus errors is allowed to be passed to the user. After 
> this time period is over a new CAN_ERR_BUSERROR may be passed to the 
> user containing the count of occurred bus errors somewhere in the 
> data[]-section of the Error Frame. When a normal RX/TX-interrupt 
> indicates a 'working' CAN again, the timer would be terminated.
> 
> Instead of a fix configurable time we could also think about a dynamic 
> behaviour (e.g. with increasing periods).
> 
> What do you think about this?

The question is if one bus-error does provide enough information on the 
cause of the electrical problem or if a sequence is better. Furthermore, 
I personally regard the use of timers as to heavy. But the solution is 
feasible, of course. Any other opinions?

Thanks.

Wolfgang.

