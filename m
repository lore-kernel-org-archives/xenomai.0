Message-ID: <53D50BA6.5010905@xenomai.org>
Date: Sun, 27 Jul 2014 16:24:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.3.1406196001.31160.xenomai@xenomai.org>
 <1D528D51-ACBB-4794-87A2-250E8E61D81B@gmail.com>
In-Reply-To: <1D528D51-ACBB-4794-87A2-250E8E61D81B@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Latency Test Results (xeno-test) on Xilinx Zynq XC702
 Board with Xenomai 2.6.3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andreas Glatz <andi.glatz@gmail.com>, xenomai@xenomai.org

On 07/25/2014 10:34 AM, Andreas Glatz wrote:
> 
>>
>> Message: 5
>> Date: Thu, 24 Jul 2014 11:16:23 +0200
>> From: Philippe Gerum <rpm@xenomai.org>
>> To: "Botev, Roumen" <roumen.botev@brooks.com>,  "xenomai@xenomai.org"
>> 	<xenomai@xenomai.org>
>> Subject: Re: [Xenomai] Latency Test Results (xeno-test) on Xilinx Zynq
>> 	XC702 Board with Xenomai 2.6.3
>> Message-ID: <53D0CEE7.6010208@xenomai.org>
>> Content-Type: text/plain; charset=ISO-8859-1
>>
>> On 07/21/2014 08:50 PM, Botev, Roumen wrote:
>>> Hello, All,
>>>
>>> I am running Xenomai's out of the box battery of tests (xeno-test)  
>>> on a Xilinx Zynq XC702 evaluation board.
>>>
>>> I am new to Xenomai and I am wondering if these results look good  
>>> to people having more experience in running Xenomai on a Cortex-A9  
>>> hardware. In particular, I had higher expectations of the average  
>>> and worst case latency numbers - I was expecting < 10 usec worst  
>>> latency for the highest priority user mode task. Here is the  
>>> summary of the latency test (the full output of the test is  
>>> attached to this message):
>>>
>>> RTT|  00:15:04  (periodic user-mode task, 1000 us period, priority  
>>> 99)
>>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat  
>>> best|--lat worst
>>> . . . . . . . . . .
>>> ---| 
>>> -----------| 
>>> -----------|-----------|--------|------|-------------------------
>>> RTS|      3.675|     14.049|     35.913|       0|     0|     
>>> 00:15:04/00:15:04
>>>
>>
>> Figures look ok particularly in dual core mode, regarding the  
>> scheduling
>> latency of a userland thread over a 1Khz period. A large part of such
>> latency is induced by cache effects, including those entailed by
>> switching memory contexts.
>>
> 
> 
> I tried the test on an omap4460 (A9; 2x1GHz) with Linux 3.14.1 and  
> Xenomai 2.6.3 and got similar results:
> 
> RTT|  00:15:04  (periodic user-mode task, 1000 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|-- 
> lat worst
> RTD|     10.428|     14.131|     19.923|       0|     0|       
> 6.943|     27.980
> Load script terminated, terminating checked scripts
> ---| 
> -----------| 
> -----------|-----------|--------|------|-------------------------
> RTS|      6.943|     14.483|     27.980|       0|     0|     
> 00:15:04/00:15:04
> 
> So does it makes sense to try and further optimise the cache access  
> for bringing down the latency or is it as good as it can get?

The I-pipe for 3.14 disables the L2 cache "write-allocate" policy,
which, on my omap4430 at least brings down latencies under 25us at 10
kHz. As Philippe said, the figures at 10kHz are usually smaller than
those at 1kHz.

I will run long tests this week to confirm the I-pipe for 3.14 figures.


-- 
                                                                Gilles.

