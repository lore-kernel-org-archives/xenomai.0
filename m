Message-ID: <4E4456A1.6090704@domain.hid>
Date: Fri, 12 Aug 2011 00:24:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1313097516.90873.YahooMailClassic@domain.hid>
In-Reply-To: <1313097516.90873.YahooMailClassic@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] clock problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philip Ha <philwman@domain.hid>
Cc: Xenomai-help@domain.hid

On 08/11/2011 11:18 PM, Philip Ha wrote:
>> Could you try measuring the jitter in cpu cycles with rdtscll, in
>> kernel-space? If the inaccuracy persists, check that cpufreq is not
>> enabled, and that if running on a multicore system, tscs are
>> synchronized. Apart from that no, no idea.
>>
>> -- 
>>                                            Gilles.
> 
> 
> Hi Gilles,
> 
> I measured the interval between input pulses using rdtsc to grab the 
> cpu cycles. The number of clock cycles between my 1 second input 
> pulses was quite consistent varying by less than 10,000 cycles. On 
> my 1600 MHz system that works out to less than 6 us. This value was 
> consistent between reboots. This indicates to me that the tsc clock 
> is very stable between reboots.
> 
> Looking at /proc/cpuinfo showed that the "cpu MHz" value changes 
> by a small amount during each reboot. It varies from 1600.131 MHz 
> to 1599.628 MHz. The difference between 1600 and 1599.628 MHz 
> accounts exactly for the unexpected latency I described in earlier 
> emails.
> 
> So it would seem that the frequency used for clock time stamps is 
> reported incorrectly when using my Xenomai build. If I boot the system 
> with regular Ubuntu, /proc/cpuinfo consistently reports the frequency 
> as 1600 MHz.
> 
> I do not have CPU scaling set. I am running an Atom dual CPU 
> processor and /proc/cpuinfo shows both processors as having the 
> same frequency. How can I ensure syncronization of the tscs?
> 
> The Xenomai build seems to produce an incorrect cpufreq, any ideas 
> as to why?

The cpu frequency is obtained by the linux kernel calibration procedure.
This same procedure returns the same imprecise results without xenomai.
Now, something in the distro kernel must change the frequency to a nice
round value (a good candidate would be the cpufreq module, except that
the acpi_cpufreq module does not seem to load on my atom).

As a workaround, xenomai proposes kernel parameters to adjust the idea
of the machine clock/cpu frequency. Try adding the following argument on
the kernel command line:

xeno_hal.clockfreq=1600000000 xeno_hal.cpufreq=1600000000

-- 
                                                                Gilles.

