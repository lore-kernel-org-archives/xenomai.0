Message-ID: <1ce16a2c0709101142r6cf2d624oe443807575eadcfa@domain.hid>
Date: Mon, 10 Sep 2007 20:42:30 +0200
From: "Bachman Kharazmi" <bahkha@domain.hid>
In-Reply-To: <46E58BE4.9090109@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1ce16a2c0709100614u3f23fce9yd2be767406fa536a@domain.hid>
	<46E58BE4.9090109@domain.hid>
Subject: Re: [Xenomai-help] adding PCI support to 16550A.c
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

A guy recommended me to try to get things going with the working
mobo-serialport first before playing with linux drivers and serial
controllers.. probabily a good point to start at.

Anyhow I tried to used your cross-link.c to write ASCII to serialport
rtser0. I connected the cable to the dc motor drive which accepts
ASCII commands with CR(\r\n) at the end of every command line.
The light version of your code that I was testing with looks like:
http://pastebin.ca/690561

I'm trying to write two simple commands in the example, but I couldn't
get it working. Don't know why :/

First when I got that working it would be even nicer to be able to
give a argument to the binary which is a ASCII command(string) written
to rtser0.

thanks
/Bachman
On 10/09/2007, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Bachman Kharazmi wrote:
> > I've tried to make the pci serial controller visable to the 16550
> > driver by adding:
> > ## FROM 16550A.c
> > static int rt_16550_interrupt(rtdm_irq_t * irq_context)
> > {
> >       struct rt_16550_context *ctx;
> >       unsigned long base;
> >       int mode;
> >       int iir;
> >       uint64_t timestamp = rtdm_clock_read();
> >       int rbytes = 0;
> >       int events = 0;
> >       int modem;
> >       int ret = RTDM_IRQ_NONE;
> > // TEST
> > struct pci_dev *pdev = NULL;  // from
> > http://bachman.tor.lindesign.se/tmp/driver/sunix/snx_golden.c
> > pdev = pci_get_device(0, 0, pdev); // from
>                        ^^^^^^
> You need to provide the fitting vendor and device ID here. Then you have
> to call pci_device_enable on that pdev - if it's not NULL (ie. not
> found). That should tell us if it's already enough to enable the device.
>
> Jan
>
>
>

