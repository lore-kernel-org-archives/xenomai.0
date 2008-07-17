From: =?ISO-8859-1?Q?Schl=E4gl?= "Manfred jun." <manfred.schlaegl@domain.hid>
Content-Type: text/plain
Date: Thu, 17 Jul 2008 10:12:04 +0200
Message-Id: <1216282324.3472.29.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Generel problem with realtime-tops(like adeos) over
	linux-kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi!

I think we've discovered a generell logical problem with realtime-tops
like adeos over the linux-kernel.

The basic-assumption of such an system is: Linux is not a
realtime-system, so it is not able to provide realtime to it's services,
so no linux-service is able to use realtime-capabilities, so no
linux-service has realtime-requirements.
>From this it follows that we are able use a top like adeos (send
interrupts later, always interrupt the linux-kernel).

But... Linux is able to provide hard-realtime while interrupts are
locked. And many services(driver) use this.

abstract example:
{{{
spin_lock_irqsave
if(hardware_data_valid())
	process_hardware_data()
spin_lock_irqrestore
}}}
works fine without adeos, but with adeos there may be a relative long
interruption between validation and processing. The hardware may overrun
and process_hardware_data is called without valid data...

In our case we have this problem while the rx-interrupt of our
ethernet-driver. The dma is running permanently and generates an overrun
between the error-checking(which would catch the overrun) part and the
data-processing part of the handler.

I think it is possible that there could be many such (latent) problems
in linux-kernel. For example USB which itself has realtime-requirements,
or eventually mtd (lost data as cause of wrong flash-write/erase
timings), ...

So ... what do you think about that.

Best regards
Manfred Schlaegl




