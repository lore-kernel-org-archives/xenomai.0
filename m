Message-ID: <459B7800.7040403@domain.hid>
Date: Wed, 03 Jan 2007 10:31:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <459A31E3.40807@domain.hid> <1167744149.30347.2.camel@domain.hid>	
	<459A5E92.6030504@domain.hid> <1167745769.30347.6.camel@domain.hid>	
	<459A64A9.4060707@domain.hid>
	<1167747223.30347.10.camel@domain.hid>	 <459A6A88.8000803@domain.hid>
	<1167749589.30347.35.camel@domain.hid>	 <459A7A35.2060508@domain.hid>
	<1167754774.3189.7.camel@domain.hid>
In-Reply-To: <1167754774.3189.7.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: Timer patches evaluation
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Tue, 2007-01-02 at 16:28 +0100, Jan Kiszka wrote:
> 
>>Philippe Gerum wrote:
>>
>>>...
>>>Not that I would be particularly fond of that, mm, thing, but this would
>>>allow to fix the bogus x86+8254 setup relic, which is likely the only
>>>one which would cause any significant delay among the supported
>>>archs/platforms.
>>
>>BTW, could we define some concrete metrics to asses all the ongoing
>>changes performance-wise? We have the timerbench, we have cyclictest
>>(for large number of timers and for POSIX tests), we have the enhanced
>>runtime statistics for threads and IRQs, now we just need to create
>>meaningful test scenarios and run them / let them run on the different
>>platforms.
>>
>>Interesting is, e.g., how the timer subsystem scales worst case-wise and
>>what piece of the cake remains for Linux under high timer load.
>>Moreover, there is still that tsc2ns conversion improvement to work out
>>- and then to evaluate...
>>
> 
> 
> To add a piece to the puzzle, I would very much like that such metrics
> would be applicable - at least some of them - to the older Xeno releases
> too. A work I have in mind for some time now would be to get a chart of
> the overall Xenomai performances over time (e.g. basic latency tests to
> start with), release after release; something we could automate and
> publish on the website. A very useful regression test, and a nice
> marketing tool (well, provided we don't screw things up too often...).

Maybe we could start with xeno-test and feed its output to gnuplot ?

-- 
                                                 Gilles Chanteperdrix

