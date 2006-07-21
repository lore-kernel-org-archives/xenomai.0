From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17600.54714.315590.474838@domain.hid>
Date: Fri, 21 Jul 2006 15:25:14 +0200
Subject: Re: [Xenomai-help] Beginner's question / testsuite / latency
In-Reply-To: <442248c90607201417m24729b7cs23a8b82b719ff1cc@domain.hid>
References: <442248c90607201417m24729b7cs23a8b82b719ff1cc@domain.hid>
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
Cc: xenomai@xenomai.org

Julien Heyman wrote:
 > Hi,
 > 
 > I am currently trying to evaluate Xenomai, and my current setup is :
 > VIA C3 533Mhz processor, Kubuntu 6.06 Linux distribution.
 > I am using Xenomai-2.1.0 over a 2.6.17.4 kernel.
 > When I run the latency part of the testsuite (in a console under KDE), I get
 > results that I cannot understand, so I probably did something wrong
 > (execution trace included below).
 > I get reasonable values during the first seconds, then all of a sudden
 > latencies begin to rise, continuously, to very large values.
 > - I did check that DMA transfer is activated on my HD.
 > - I did select "Enable SMI workaround" + "Globally disable SMI" in the
 > Xenomai
 > options while configuring the kernel.
 > - I have disabled power management at BIOS level and disabled ACPI support
 > and
 > CPU frequency scaling during kernel configuration.
 > - I checked that I don't have anything called "legacy USB" in my BIOS. I do
 > have an "OnChip USB" option enable in the BIOS though.
 > 
 > Any advice would be appreciated !

Some platforms stop their tsc when idle, this would cause serious
trouble for Xenomai. Linux detect such behaviour and print the message:

Losing too many ticks!
TSC cannot be used as a timesource.  
Possible reasons for this are:
  You're running with Speedstep,
  You don't have DMA enabled for your hard disk (see hdparm),
  Incorrect TSC synchronization on an SMP system (see dmesg).
Falling back to a sane timesource now.

Do you see such message in kernel logs ?

If this is the issue you are having, then you may try passing idle=poll
on kernel boot line. Or recompile the kernel selecting a processor that
has no tsc (for example 486), xenomai will then use the 8254 counter to
emulate the tsc.

-- 


					    Gilles Chanteperdrix.

