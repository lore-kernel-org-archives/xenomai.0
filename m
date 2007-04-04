Message-ID: <4613D7CC.2040703@domain.hid>
Date: Wed, 04 Apr 2007 18:52:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] large latencies on a Dell D620 dual core laptop
References: <20070403143122.4ac4ffaf@domain.hid>	<46124C61.3070107@domain.hid>	<20070403162752.2d4a1ae6@domain.hid>	<46126603.1050007@domain.hid>	<20070403170416.6c3f7ded@domain.hid>	<46126DC3.8070905@domain.hid>	<20070403171828.2da9c6fa@domain.hid>	<46127166.9040503@domain.hid>	<20070403175535.7340cc06@domain.hid>	<46127DD8.8060502@domain.hid>
	<20070404181558.0ba333da@domain.hid>
In-Reply-To: <20070404181558.0ba333da@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
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
To: Daniel Simon <Daniel.Simon@domain.hid>
Cc: xenomai@xenomai.org

Daniel Simon wrote:
> On Tue, 03 Apr 2007 18:16:24 +0200
> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> 
> 
>>Maybe there is a way to disable legacy power management at BIOS level ?
> 
> 
> there was a remaining potential source of PM interrupts in the bios (from the
> serial ata), which is now disabled. I did testing with various configurations:
> 
> -in runlevel 1 the tests in /usr/xenomai/bin are generally succesfully
> performed, with max latencies in the range of 5-10 us (output of xeno-test
> attached)
> 
> -in runlevel 3 the laptop freezes after a while, e.g. when rmmoding xeno_native
> after a succesful latency test, or when modprobing xeno_posix

What is the difference between runlevel 1 and runlevel 3 ?

> 
> -under X control is mostly lost immediatly after modprobing xeno_native...  may
> be I am too greedy?

Usually, X should only induce high latencies. You can avoid such
latencies by adding the "NoAccel" option to /etc/X11/XF86Config-4, maybe
you can try the NoAccel trick to solve your issues as well ?

-- 
                                                 Gilles Chanteperdrix

