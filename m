Message-ID: <4991D290.8020306@domain.hid>
Date: Tue, 10 Feb 2009 20:16:32 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1LWvjc-0006Xw-FB@mailer.emlix.com>
	<4991AF95.1030301@domain.hid>	<E1LWwFb-000754-FT@mailer.emlix.com>
	<4991B98C.8000301@domain.hid> <E1LWwd9-0007TE-Ee@domain.hid>
In-Reply-To: <E1LWwd9-0007TE-Ee@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] strange latency output (xenomai-2.4.5)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Georg Gottleuber <gg@domain.hid>
Cc: xenomai@xenomai.org

Georg Gottleuber wrote:
> 
> Gilles Chanteperdrix schrieb:
>> Georg Gottleuber wrote:
>>> Gilles Chanteperdrix schrieb:
>>>> Georg Gottleuber wrote:
>>>>> Hi,
>>>>>
>>>>> I recently port a  ARM926EJ-S mach to Xenomai
>>>>> (like described in http://www.xenomai.org/index.php/I-pipe:ArmPorting).
>>>>>
>>>>> While testing with latency I got this output:
>>>>> # /usr/xenomai/bin/latency  -p 1000 -h -s -H 500 -t 1
>>>>> == Sampling period: 1000 us
>>>>> == Test mode: in-kernel periodic task
>>>>> == All results in microseconds
>>>>> warming up...
>>>>> RTT|  00:00:01  (in-kernel periodic task, 1000 us period, priority 99)
>>>>> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
>>>>> RTD|      78.992|     104.308|     124.131|       0|      78.992|     124.131
>>>>> ...
>>>>> RTD|      14.678|      68.413|      96.275|       0|       9.528|     155.321
>>>>> RTD|      84.046|     116.435|     175.192|       0|       9.528|     182.139
>>>>> ...                                ^^^^^^^                            ^^^^^^^
>>>> I do not understand, what is wrong with these values ?
>>> It thought, if "lat max" of the current interval is bigger than "lat worst", this "lat
>>> max" updates the "lat worst". So I ask myself, out of which interval comes the updated 182
>>> value?
>> If your machine is highly loaded, like what you get with a ping -f, the
>> "display" thread, which is a non real-time one, may be delayed for more
>> than one second, in which case, it "misses", what is sent by the
>> "sampling" thread, but the sampling thread never looses the worst
>> latency itself, so that when the display thread finally manages to print
>> something, it will print the correct worst case latency.
>>
> 
> Bingo. That's the point. This also explains totally equal lines and missing time
> stamps/lines that I have observed.

Yes, the communication between the sampling and display threads is a
semaphore, so when the display thread is delayed, it will get the
semaphore several times in a row and print the same values.

If your patch is for a machine in the mainline linux, I would be happy
to merge your changes into the I-pipe patch.

It would be interesting if you could try a recent patch with the "FCSE"
option, to see if it works for 926 (it was tested for 920 and xscale
only), and what gains you get on latencies.

-- 
					    Gilles.

