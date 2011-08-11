Message-ID: <1313097516.90873.YahooMailClassic@domain.hid>
Date: Thu, 11 Aug 2011 14:18:36 -0700 (PDT)
From: Philip Ha <philwman@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-224367224-1313097516=:90873"
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
To: Xenomai-help@domain.hid

--0-224367224-1313097516=:90873
Content-Type: text/plain; charset=us-ascii

> Could you try measuring the jitter in cpu cycles with rdtscll, in
> kernel-space? If the inaccuracy persists, check that cpufreq is not
> enabled, and that if running on a multicore system, tscs are
> synchronized. Apart from that no, no idea.
>
> -- 
>                                            Gilles.


Hi Gilles,

I measured the interval between input pulses using rdtsc to grab the 
cpu cycles. The number of clock cycles between my 1 second input 
pulses was quite consistent varying by less than 10,000 cycles. On 
my 1600 MHz system that works out to less than 6 us. This value was 
consistent between reboots. This indicates to me that the tsc clock 
is very stable between reboots.

Looking at /proc/cpuinfo showed that the "cpu MHz" value changes 
by a small amount during each reboot. It varies from 1600.131 MHz 
to 1599.628 MHz. The difference between 1600 and 1599.628 MHz 
accounts exactly for the unexpected latency I described in earlier 
emails.

So it would seem that the frequency used for clock time stamps is 
reported incorrectly when using my Xenomai build. If I boot the system 
with regular Ubuntu, /proc/cpuinfo consistently reports the frequency 
as 1600 MHz.

I do not have CPU scaling set. I am running an Atom dual CPU 
processor and /proc/cpuinfo shows both processors as having the 
same frequency. How can I ensure syncronization of the tscs?

The Xenomai build seems to produce an incorrect cpufreq, any ideas 
as to why?

Thanks for all your help.

Philip Ha


--0-224367224-1313097516=:90873
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;"><pre>&gt; Could you try measuring the jitter in cpu cycles with rdtscll, in<br>&gt; kernel-space? If the inaccuracy persists, check that cpufreq is not<br>&gt; enabled, and that if running on a multicore system, tscs are<br>&gt; synchronized. Apart from that no, no idea.<br>&gt;<br>&gt; -- <br>&gt;                                            Gilles.<br><br><br>Hi Gilles,<br><br>I measured the interval between input pulses using rdtsc to grab the <br>cpu cycles. The number of clock cycles between my 1 second input <br>pulses was quite consistent varying by less than 10,000 cycles. On <br>my 1600 MHz system that works out to less than 6 us. This value was <br>consistent between reboots. This indicates to me that the tsc clock <br>is very stable between reboots.<br><br>Looking at /proc/cpuinfo showed that the "cpu MHz" value changes <br>by a small amount during
 each reboot. It varies from 1600.131 MHz <br>to 1599.628 MHz. The difference between 1600 and 1599.628 MHz <br>accounts exactly for the unexpected latency I described in earlier <br>emails.<br><br>So it would seem that the frequency used for clock time stamps is <br>reported incorrectly when using my Xenomai build. If I boot the system <br>with regular Ubuntu, /proc/cpuinfo consistently reports the frequency <br>as 1600 MHz.<br><br>I do not have CPU scaling set. I am running an Atom dual CPU <br>processor and /proc/cpuinfo shows both processors as having the <br>same frequency. How can I ensure syncronization of the tscs?<br><br>The Xenomai build seems to produce an incorrect cpufreq, any ideas <br>as to why?<br><br>Thanks for all your help.<br><br>Philip Ha<br><br></pre></td></tr></table>
--0-224367224-1313097516=:90873--

