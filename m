Message-ID: <1313416237.20807.YahooMailClassic@domain.hid>
Date: Mon, 15 Aug 2011 06:50:37 -0700 (PDT)
From: Philip Ha <philwman@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-741168697-1313416237=:20807"
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

--0-741168697-1313416237=:20807
Content-Type: text/plain; charset=us-ascii


> The cpu frequency is obtained by the linux kernel calibration procedure.
> This same procedure returns the same imprecise results without xenomai.
> Now, something in the distro kernel must change the frequency to a nice
> round value (a good candidate would be the cpufreq module, except that
> the acpi_cpufreq module does not seem to load on my atom).
>
> As a workaround, xenomai proposes kernel parameters to adjust the idea
> of the machine clock/cpu frequency. Try adding the following argument on
> the kernel command line:
>
> xeno_hal.clockfreq=1600000000 xeno_hal.cpufreq=1600000000


Hi Gilles,

Thank you very much for your help and advice. I tried it out on
our PC, and it worked. The latency between messages stays constant
(only varies to a few microseconds) after each reboot. 

I really appreciate for your help and patience.

Best regards,

Philip Ha 



--0-741168697-1313416237=:20807
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;"><br><pre>&gt; The cpu frequency is obtained by the linux kernel calibration procedure.<br>&gt; This same procedure returns the same imprecise results without xenomai.<br>&gt; Now, something in the distro kernel must change the frequency to a nice<br>&gt; round value (a good candidate would be the cpufreq module, except that<br>&gt; the acpi_cpufreq module does not seem to load on my atom).<br>&gt;<br>&gt; As a workaround, xenomai proposes kernel parameters to adjust the idea<br>&gt; of the machine clock/cpu frequency. Try adding the following argument on<br>&gt; the kernel command line:<br>&gt;<br>&gt; xeno_hal.clockfreq=1600000000 xeno_hal.cpufreq=1600000000<br><br><br>Hi Gilles,<br><br>Thank you very much for your help and advice. I tried it out on<br>our PC, and it worked. The latency between messages stays constant<br>(only varies to a few microseconds)
 after each reboot. <br><br>I really appreciate for your help and patience.<br><br>Best regards,<br><br>Philip Ha <br><br></pre><br></td></tr></table>
--0-741168697-1313416237=:20807--

