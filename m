Message-ID: <4447441C.3070400@domain.hid>
Date: Thu, 20 Apr 2006 10:19:40 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Will Linux kernel lose timer ticks when RT thread
	is	running
References: <4546494d0604191120r75d3d5bbs40e37292121f01ed@domain.hid>
	<44474183.8080303@domain.hid>
In-Reply-To: <44474183.8080303@domain.hid>
Content-Type: text/plain; charset=ISO-2022-JP
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Li Yi (Adam) wrote:
> 
>>Hi,
>> 
>>When a real-time thread is running, the Linux kernel will lose Timer 
>>Tick (and lose timer interrupts), is this the expected behavior?
>> 
> 
> 
> No, it should not lose any tick, regardless of the Xenomai port. You are
> likely observing a pecularity of the Blackfin port where Adeos moves
> Linux IRQ handlers (top-halves) in thread context to work-around a high
> scheduling latency source which is Blackfin specific.
> 
> 
>>If yes, in this case,  no interrupts will be passed to Linux domain? 
>>This may cause some services depending on timing in Linux domain do not 
>>work correctly. In another thread I read:
>> 
>>"
>>I do not know if it is what you mean, but when running Xenomai, your
>>tasks are supposed to suspend sufficiently frequently to leave Linux
>>tick normally. This means that if you configured CONFIG_HZ=100, your
>>real-time activity (including kernel-space tasks and user-space tasks in
>>primary mode) is supposed to take a break at least once every 1/100
>>second.
>>--
>>                                           Gilles Chanteperdrix.  
>>"
>>Is this the best solution? Since there may be possibility that a 
>>real-time thread keep running for severl hundred ms (e.g, processing 
>>large block of data).
>> 
> 
> 
> Keep in mind that real-time using a co-scheduling infrastructure in
> Linux is not a matter of pure RTOS design, but rather an issue involving
>  a GPOS+RTOS combination. For this reason, you just should not starve
> the GPOS from the critical resources it needs, and time ticks are some
> of these. If you do so though, what will happen is that the ticks will
> be logged at Adeos level in the various pipeline logs, and played when
> Linux eventually gets back in control as the active Adeos domain. If the
> starvation did not last beyond Linux's robustness to such event, then
> the kernel will catch up with the pending ticks and the system will
> continue normally. IOW, it's not impossible to do lengthy real-time
> processing that might delay/unsynchronize Linux ticks, and this might
> work properly if some breathing time is left to the kernel, but you
> cannot ask the real-time system to drop the determinism just for the
> sake of allowing Linux to tick regularly. It's up to the application
> designer to properly evaluate the real-time load which is going to be
> bearable by the underlying architecture & kernel combo.
> 
> In the particular case of multi-ms processing, I would likely suggest to
> move it to a thread running in secondary mode without interrupt
> shielding, so that Linux asynchronous activities such as interrupt
> handling would still be possible, at the expense of a lesser execution
> time predictability of such processing though.
> 
> 
>> 
>>I tried to run a test on Xenomai-2.1.0 on Blackfin. This test looks like:
>> 
> 
> 
> <snip>
> 
> 
>>+++++++++ end test +++++++++++++++++
>>
>> From the test result, " 23:  BFIN Timer Tick", changed from "33531" to
>>"33732", that is "201 * 10 ＝ 2010 ms". And the "up time" is changed
>>from "335.41 to 337.42", although in fact that "2 + 6 = 8 sec" has
>>passed.
>>
> 
> 
> You may want to make your measurement thread sleep() for a while before
> looking at the final tick counter; this would make sure that the IRQ
> threads have been given enough time to catch up and process all pending
> ticks they have in their log. Btw, did you activate CONFIG_PREEMPT?
> 

Er, sorry. There's no CONFIG_PREEMPT on Blackfin yet.

-- 

Philippe.

