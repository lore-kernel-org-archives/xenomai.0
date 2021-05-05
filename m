Subject: Re: RTSerial Difference in Behavior Between 2.6.4 & 3.1
References: <CY4PR02MB261531B57960FF9BD47E890BDC489@CY4PR02MB2615.namprd02.prod.outlook.com>
 <39840ca2-483a-1ece-f6e2-c1a49f3fb462@siemens.com>
 <DM5SPR00MB246AF6EA797021E37AAA7CEDC469@DM5SPR00MB246.namprd02.prod.outlook.com>
 <f4e3428b-232d-8d2c-0eb0-6d2a66ee6f2b@siemens.com>
 <DM5PR02MB2620C600FA8043BB5E65FC6CDC5A9@DM5PR02MB2620.namprd02.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <da09edd1-f468-e417-f99b-07d4044cd3b7@siemens.com>
Date: Wed, 5 May 2021 07:42:17 +0200
MIME-Version: 1.0
In-Reply-To: <DM5PR02MB2620C600FA8043BB5E65FC6CDC5A9@DM5PR02MB2620.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alan Gaglio <AGaglio@jerviswebb.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04.05.21 22:40, Alan Gaglio wrote:
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Friday, April 23, 2021 1:52 AM
>> To: Alan Gaglio <AGaglio@jerviswebb.com>; xenomai@xenomai.org
>> Subject: Re: RTSerial Difference in Behavior Between 2.6.4 & 3.1
>>
>> On 22.04.21 20:52, Alan Gaglio wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>> Sent: Wednesday, April 21, 2021 3:00 AM
>>>> To: Alan Gaglio <AGaglio@jerviswebb.com>; xenomai@xenomai.org
>>>> Subject: Re: RTSerial Difference in Behavior Between 2.6.4 & 3.1
>>>>
>>>> On 20.04.21 16:45, Alan Gaglio via Xenomai wrote:
>>>>> I am in the process of upgrading from 32-bit/Xenomai 2.6.4/Ubuntu
>>>>> 14.04.4/ Linux 3.16.7 to 64-bit/Xenomai 3.1/Ubuntu 20.04.1/Linux
>>>>> 5.4.77 and I'm experiencing an rtserial event difference in behavior.
>>>>> Our application depends on single-byte interrupts from rtserial
>>>>> ports, which we're not seeing despite having configured rtserial
>>>>> ports the same between our 2 different image configurations that run
>>>>> on the same
>>>> x86 hardware.
>>>>> Attached is a modified cross-link.c example that highlights this
>>>>> difference in behavior. Also included is relevant detail for each
>>>>> target, build, and sample program output.
>>>>>
>>>>> My modified cross-link.c transmits 26 characters every 1 second and
>>>>> prints the number of RX_PEND events along with reception bins every
>>>>> 26 characters read by the receive thread. Reception bins show the
>>>>> number of bytes read per RX_PEND event [0-16,17+]. The total number
>>>>> of bytes processed equals the sum of all bins multiplied by the
>>>>> quantity they represent. For example, these snipped outputs (from
>>>>> the below greater
>>>>> details) were taken following a total of 208 bytes transmitted. In
>>>>> 2.6.4 we have 208 events * 1 byte = 208 bytes and in 3.1 we have
>>>>> 48 events * 4 bytes + 8 events * 2 bytes = 208 bytes. We
>>>>> expect/desire the second bin to be exclusively non-zero (2.6.4
>>>>> output), indicating an RX_PEND event for each byte that arrives on the
>> serial port.
>>>>>
>>>>> 2.6.4 Output:
>>>>> rx.events=1  | rx.rx_pending=1 | r_t=1618404168709819446 Count= 208
>>>>> bins=0 208 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
>>>>> 3.1 Output:
>>>>> rx.events=1  | rx.rx_pending=2 | r_t=1618406767806828954 Count=  56
>>>>> bins=0 0 8 0 48 0 0 0 0 0 0 0 0 0 0 0 0 0
>>>>>
>>>>> I'm not sure where to take the next level of troubleshooting and am
>>>>> happy to provide additional detail, run tests, etc. The attached
>>>>> cross-link includes some preprocessor defines to modify program
>>>>> behaviors that I can explain if helpful. Details shown below are
>>>>> also attached with line wrapping removed for reference.
>>>>>
>>>>
>>>> Didn't dig through all the detailed information you provided yet, but
>>>> the first questions that come up for me would be
>>>>
>>>>  - do interrupts for the UART arrive at the expected rate, or are they
>>>>    already delayed?
>>>>
>>>>  - already tried to collect a system trace (ftrace event tracing) to
>>>>    gain an overview of what the application does when and what happens
>>>>    Xenomai-wise in the core (context switch, interrupts, etc.)?
>>>>
>>>> If interpreting the trace is tricky, share it. Also taking tracing on
>>>> both 2.6 and
>>>> 3.1 setups can help to find differences.
>>>>
>>>> Jan
>>>>
>>>> --
>>>> Siemens AG, T RDA IOT
>>>> Corporate Competence Center Embedded Linux
>>>
>>> Interpretation support is appreciated, attached are traces from both
>>> setups frozen following reception of the first 26 characters by the receive
>> thread.
>>> For 26 byte transmission at 115200 baud and my configured serial
>>> settings, minimum time from write-to-receive ought to be ~2256 us.
>>> I've reviewed from the start of transmission (rt_16550_write calls
>>> around lines 7888 X2_6/
>>> 6229 X3_1) at a surface level. Both traces show the first interrupt
>>> following rt_16550_write 2322 us from trace freeze, so I don't see a
>>> meaningful delay in overall message transmission time.
>>>
>>> In 2.6, I count a total of 28 rt_16550_interrupts, which corresponds
>>> well to the number of single-character reads output by my test
>>> program. These were generated at appropriate intervals of ~86 (2322/27)
>> us intervals.
>>>
>>> In 3.1, I count a total of 16 rt_16550_interrupts, which I'm having
>>> difficulty making sense of. UART interrupts are not arriving at the
>>> expected rate but instead in less frequent batches in roughly 4 character-
>> time intervals.
>>> The behavior seems like the FIFO depth of the UART is still 4
>>> characters deep despite having specified a FIFO depth 1 in
>>> rtser_config and having read back the configured depth for confirmation.
>>
>> That is pointing to the driver, and you should be able to validate actual
>> against desired registers settings. Already tried to instrument
>> (printk...) the driver(s) along the evaluation of RTSER_SET_FIFO_DEPTH [1]
>> and other manipulations of FCR [2]?
>>
>> Jan
>>
>> [1]
>> https://source.denx.de/Xenomai/xenomai/-
>> /blob/stable/v3.1.x/kernel/drivers/serial/16550A.c#L344
>> [2]
>> https://source.denx.de/Xenomai/xenomai/-
>> /blob/stable/v3.1.x/kernel/drivers/serial/16550A.c#L748
>>
>> --
>> Siemens AG, T RDA IOT
>> Corporate Competence Center Embedded Linux
> 
> Thank you for the helpful suggestions Jan, I finally got back into the issue
> and have it resolved. Our hardware provides UARTs via a Fintek F81866A
> Super IO chip that has some extended configuration registers outside the
> scope of the 16550 driver. A kernel patch from October 27th, 2016
> to the 8250_fintek driver initialize the UART's FIFO Select Registers to
> have a FIFO threshold multiplier (RXFTHR_MODE) of 4x the threshold set by
> the standard FIFO Control Register in the 16550 driver [1]. Our image loads
> the 8250 driver at boot and unloads it upon application execution. As a
> result, the extended configuration settings persist in our F81866A and
> cause the unexpected interrupt behavior witnessed.
> 
> I've confirmed that setting RXFTHR_MODE to a multiplier of 1x
> generates single character interrupts in our 64b/X3.1/U20.04/L5.4.77
> image just like our 32b/X2.6/U14.04/L3.16.7 image. We will make a
> change in our application to ensure proper UART configuration for this
> device going forward. Included is a link to the commit and sample program
> output showing the change to RXFTHR_MODE prior to task execution
> for reference.
> 

OK, great to hear you solved it! If there is anything that could also be
done in the rt_16550A driver, please share a patch or suggest a pattern.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

