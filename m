From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Message-ID: <17610.33363.809376.253641@domain.hid>
Date: Fri, 28 Jul 2006 23:32:03 +0200
Subject: Re: [Xenomai-help] Beginner's question / testsuite / latency
In-Reply-To: <200607282317.34990.bidsonux@domain.hid>
References: <442248c90607201417m24729b7cs23a8b82b719ff1cc@domain.hid>
	<200607221152.34298.bidsonux@domain.hid> <44C25DB0.50601@domain.hid>
	<200607282317.34990.bidsonux@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Julien Heyman <bidsonux@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Julien Heyman wrote:
 > > Losing too many ticks!
 > > TSC cannot be used as a timesource. ~
 > > Possible reasons for this are:
 > > ~ You're running with Speedstep,
 > > ~ You don't have DMA enabled for your hard disk (see hdparm),
 > > ~ Incorrect TSC synchronization on an SMP system (see dmesg).
 > > Falling back to a sane timesource now.
 > 
 > > Do you see such message in kernel logs ?
 > 
 > No, I don't get any of these.
 > 
 > > If this is the issue you are having, then you may try passing idle=poll
 > > on kernel boot line. Or recompile the kernel selecting a processor that
 > > has no tsc (for example 486), xenomai will then use the 8254 counter to
 > > emulate the tsc.
 > 
 > I tried to rebuild with CPU=486, but it gives the same result.

Did you try booting with the idle=poll option ? Also, could you try
re-enabling ACPI, except the "processor" module ?

-- 


					    Gilles Chanteperdrix.

