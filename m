Message-ID: <45FEFE64.5010206@domain.hid>
Date: Mon, 19 Mar 2007 22:19:32 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RT-Socket-CAN bus error handling (was CAN errors
	and real-time behaviour (IRQ raise forever and may lock system))
References: <bc4264770703030609w188a675cj618872986ff1071c@domain.hid>	<45FDA81F.2080004@domain.hid>
	<E1HTD6v-0004qo-QI@mailer.emlix.com>	<E1HTDZN-0006rl-2g@domain.hid>	<45FE7578.4000306@domain.hid>
	<45FE8AA2.1030507@domain.hid> <45FEF649.9060205@domain.hid>
In-Reply-To: <45FEF649.9060205@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Wolfgang Grandegger wrote:
> Jan Kiszka wrote:
>> Wolfgang Grandegger wrote:
>>> Sebastian Smolorz wrote:
>>>> Sebastian Smolorz wrote:
>>>>> Hi Jan,
>>>>>
>>>>> Jan Kiszka wrote:
>>>>>> Wolfgang Grandegger wrote:
>>>>>>> you know, on the SJA1000 the bus error interrupt can result in high
>>>>>>> error interrupt rates and even hang the system on slow processors.
>>>>>>> Just
>>>>>>> unplugging the CAN cable can cause such interrupt flooding. This
>>>>>>> problem
>>>>>>>
>>>>>>> popped up again recently and Sebastian proposed:
>>>>>>>> Last summer we had a discussion about the BEI issue on the
>>>>>>>> socketcan-ML. Two additional handling policies popped up:
>>>>>>>> 1. The interface could restart itself after an amount of BEIs, thus
>>>>>>>>    taking responsibility from the user application.
>>>>>>>> 2. The BEI could be completely disabled if no one is interested in
>>>>>>>>    this ype of error frame.
>>>>>>> As 2. is also my preferred solution, I have implemented it. The only
>>>>>>> downside is that you do not see the error counter increasing when
>>>>>>> /proc/rtcan/devices is inspected. We also discussed 1., but
>>>>>>> RT-Socket-CAN does not restart the CAN controller by purpose and 
>>>>>>> just
>>>>>>> stoppping it requires user intervention.
>>>>>> And if there is someone listening, how is the flooding issue on cable
>>>>>> unplug etc. solved by option 2?
>>>>> Hm, maybe we could implement 1 additionally (but without automatical
>>>>> restart)?
>>>> A more precise suggestion: What about letting BEIs appear until
>>>> passive mode is reached and if the TX error counter doesn't count up
>>>> any more (indication of start-up situation discovered by the SJA1000)
>>>> the driver ceases to read out ECC any further (thanks Stephane for the
>>>> hint). The controller would be still operating but not reporting BEIs
>>>> any more. There has to be some mechanism to let BEIs through after the
>>>> situation has normalized. Maybe the driver could check inside the
>>>> interrupt handler if active mode was reached again after the above
>>>> situation occured.
>>> Well, this is rather sophisticated and needs some more careful
>>> evaluation. We might also reach the passive level slowly without
>>> flooding. Furthermore, the method should also be applicable for other
>>> controllers.
>>
>> What is the current behaviour of other controllers?
> 
> Most do not have such detailed error reporting via bus error interrupts. 
> I know just the i82527 reporting bus errors as well.
> 
>>> Let's implement 1. and downscaled printk and wait for the users reaction
>>> , see also my other mail. Then we should bring up this discussion again
>>> on the Socket-CAN-ML to negotiate a common solution.
>>
>> Instead of waiting on some user triggering a (potential) latency mine, I
>> would prefer that we experimentally evaluate the effect. E.g. via an
>> I-pipe tracer dump on a faster and a slower box. I would offer to run
>> some demo code here on our PC104 Phytec boards as well.
> 
> I think we should first run the latency test concurrently and if we 
> discover high latencies an IPIPE trace helps locating the latency peaks.
> 
>> The problem is to define what degree of error-related IRQ load is
>> generally acceptable. We surely can't do this, so we have to document
>> the effect /at least/ and help the users to check it on their own - or
>> we have to avoid it / make it insignificant compared to normal CAN
>> operation (I'm still in favour of this path).
> 
> We speak about a pathological situation and therefore I do not share 
> your concerns. When there are electrical problems or even the cable is 
> not connected, we do have an abnormal mode of operation and CAN related 
> real-time is broken anyhow. The bus error messages are then useful for 
> analyzing the problem. The effect of the bus error interrupts on non-CAN 
> related latencies is another issue but I think it's not that critical 
> either (handling a bus error just requires the reading of 2 SJA1000 
> registers). But I agree, a more detailed analysis of "bus error 
> flooding" would help to understand the impact on the real-time behavior.

And also be aware, that heavy CAN traffic can cause similar latencies as 
well and when there is more than one CAN controller, they can accumulate 
(as I have observed with my PCAN dongle tests). Here a IRQ service task 
or threaded IRQs would help. Maybe this is the right way to go.

Wolfgang.


