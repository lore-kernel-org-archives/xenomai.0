Message-ID: <491430F1.3070800@domain.hid>
Date: Fri, 07 Nov 2008 13:13:37 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <loom.20081016T124807-588@domain.hid>	
	<1224605536.10407.15.camel@domain.hid>
	<4905D964.7060805@domain.hid>
	<1225235707.20499.29.camel@domain.hid>
In-Reply-To: <1225235707.20499.29.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Reducing Kernel Mode Interrupt Latency
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henry Bausley <hbausley@domain.hid>
Cc: xenomai@xenomai.org

Henry Bausley wrote:
> We have a 2.2kHz clock signal that triggers an external interrupt.  In
> the ISR we write to an output.  We measure the time between the clock
> signal that is generating the interrupt and the output being set in the
> ISR using a LeCroy 6100A oscilloscope.
> 
> What we do to stress the system is continuously do printf's
> simultaneously to three telnet sessions so we can see how the system
> will perform under heavy Ethernet traffic.  If we don't stress the
> system with the printf's the interrupt jitter is reduced.
> 
> The test are performed identically with RT-Linux and Xenomai with
> virtually identical source code, just a few #ifdef's to accommodate the
> differences in the two api's. 
> 
> I am using Xeno 2.4.5 w/ Kernel 2.6.26 powerpc, gcc 4.2 w/ I-pipe 2.2-04
> and added the patch you posted for the issue with cascaded UIC.
> 
> I am running the yosemite 440EP based hardware @ 533Mhz and the
> canyonlands 460EX based hardware @ 800Mhz.  I don't have any sequoia
> 440EPX hardware.
> 
> My hardware is custom, the 440EP version is only different in that we
> used a larger CPLD for some of our custom hardware.  The 460EX based
> hardware also uses a larger CPLD for our custom hardware, but in
> addition also has ECC memory.
> 
> /proc/xenomai/latency is at 4001
> 
> I attached the config file if that helps.
> 

I have released the first round of optimizations for the powerpc port, based on
faster arithmetics for ns/timebase conversions, a few shortened paths in the
interrupt pipeline, and unmasked context switch support.

In case you want to give it a try, it is available from our development trunk.
You will need to upgrade the I-pipe support to 2.3-00 to enable all the
optimizations.

The result I get here on a Yosemite in test conditions similar to yours gives a
latency figure now < 19 us. Note: this is only a 6 hours test, under interrupt
flood and continuous process creation, so this result remains to be validated.

Hardware:

CPU:   AMCC PowerPC 440EP Rev. B at 533.333 MHz (PLB=133, OPB=66, EBC=66 MHz)
       Bootstrap Option H - Boot ROM Location I2C (Addr 0x52)
       Internal PCI arbiter enabled, PCI async ext clock used
       32 kB I-Cache 32 kB D-Cache
Board: Yosemite - AMCC PPC440EP Evaluation Board, Rev. 9, PCI=66 MHz

Software:

The test used the klatency program, with a 2.2Khz period. The latency
calibration was set to 0, so that there was no attempt to compensate for the
intrinsic latency of the hw/sw combo using anticipated timer shots:

# echo 0 > /proc/xenomai/latency
# insmod xeno_klat.ko period=454
# /usr/xenomai/bin/klatency

In any case, I'd be interested to know whether those results are confirmed on
your setup as well.

-- 
Philippe.

