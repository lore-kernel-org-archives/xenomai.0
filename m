Message-ID: <4A966AA5.1050406@domain.hid>
Date: Thu, 27 Aug 2009 13:14:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4A96692B.6070704@domain.hid>
In-Reply-To: <4A96692B.6070704@domain.hid>
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
> Hi,
> 
> what does a negative latency in the latency-test mean?
> 
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
> worst
> RTD|     -56.443|     -54.519|     -33.519|       0|     -57.020|
> -28.208

It means that the timer handler ticked before the date it was supposed
to tick. This may have several causes:
- /proc/xenomai/latency is too high, adjust it
- hardware things stop the hardware counter used for timing, or slow it
down, such as cpufreq, acpi_processor or even the bios on x86.


-- 
                                          Gilles


