Message-ID: <4A966DB2.8030202@domain.hid>
Date: Thu, 27 Aug 2009 13:27:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4A96692B.6070704@domain.hid> <4A966AA5.1050406@domain.hid>
	<4A966CDB.7060800@domain.hid>
In-Reply-To: <4A966CDB.7060800@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Negative Latency results
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Puchwein <peter.puchwein@domain.hid>
Cc: xenomai@xenomai.org

Peter Puchwein wrote:
> Gilles Chanteperdrix wrote:
>> Peter Puchwein wrote:
>>> Hi,
>>>
>>> what does a negative latency in the latency-test mean?
>>>
>>> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
>>> worst
>>> RTD|     -56.443|     -54.519|     -33.519|       0|     -57.020|
>>> -28.208
> 
> Hi Gilles,
> 
>> It means that the timer handler ticked before the date it was supposed
>> to tick. This may have several causes:
>> - /proc/xenomai/latency is too high, adjust it
> 
> where can the latency be configured?

in /proc/xenomai/latency

> 
>> - hardware things stop the hardware counter used for timing, or slow it
>> down, such as cpufreq, acpi_processor or even the bios on x86.
> 
> we've checked all config settings due to ACPI and they seem to be ok.

Please show us your .config and boot logs.

> 
> We can live with this small negative latency, are there any known 
> negative effects of the negative latency or can we just leave it.

well 50us early is not exactly "small". A typical latency on x86 is
under 20us, so -50 is way off. It is probably the sign that the timing
is broken, so, it should be investigated and resolved IMO.


-- 
                                          Gilles


