Message-ID: <1ce16a2c0709090913u8f60b10r89651400e10a7f7d@domain.hid>
Date: Sun, 9 Sep 2007 18:13:26 +0200
From: "Bachman Kharazmi" <bahkha@domain.hid>
In-Reply-To: <46E41146.1060701@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1ce16a2c0709081159y62fbb73bwb16d2cae7a931774@domain.hid>
	<1189285467.6013.20.camel@domain.hid>
	<1ce16a2c0709090730o1a803c99r70aea4410eda49ed@domain.hid>
	<46E4085F.3080509@domain.hid>
	<1ce16a2c0709090809y5e1732adj5081fcb556734142@domain.hid>
	<46E41146.1060701@domain.hid>
Subject: Re: [Xenomai-help] serial module problems
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

I'm trying to implement a rt java motioncontrol-platform releated to
smerobot.org
I need to control three drives(rs232) connected to brushless dc motors.

The current PC I'm working on has one builtin serial port, and I found
a SUNIX 8port controller. So that's the reason why I'm using the pci
controller.

Anyhow the drivers are fetched from:
http://sunix.com.tw/it/en/DRIVER.php?SID&classnumber=3&usid1=303&usid2=304&Psid=472

I counldn't find any license releated information :/
But source comes with the driver is copied temporarily here:
http://bachman.tor.lindesign.se/tmp/driver/

Are there any chance that modifications in the source will get it going?

Other suggestions about how to solve this are also welcome

thanks
Bachman
On 09/09/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Bachman Kharazmi wrote:
> > sandbox:~/golden_2.6# ls
> > Makefile  README  driver  snxdump  snxlink  snxmknod  snxterm
> > sandbox:~/golden_2.6# modprobe snx_golden
>
> See, you already need some out-of-tree driver to make this adapter work
> with standard Linux - and you expect the driver that comes with Xenomai
> to work with it out of the box?
>
> The question is now *what* is special about this adapter and its driver.
> Where do you have the code from? What's its license?
>
> > sandbox:~/golden_2.6# setserial -g /dev/ttySNX0
> > /dev/ttySNX0, UART: 16650, Port: 0xbc00, IRQ: 3
> > sandbox:~/golden_2.6# setserial -g /dev/ttySNX1
> > /dev/ttySNX1, UART: 16650, Port: 0xbc08, IRQ: 3
> > sandbox:~/golden_2.6# setserial -g /dev/ttySNX2
> > /dev/ttySNX2, UART: 16650, Port: 0xb800, IRQ: 3
> > sandbox:~/golden_2.6# setserial -g /dev/ttySNX3
> > /dev/ttySNX3, UART: 16650, Port: 0xb808, IRQ: 3
> > sandbox:~/golden_2.6# setserial -g /dev/ttySNX4
> > /dev/ttySNX4, UART: 16650, Port: 0xb400, IRQ: 3
> > etc..
> >
> > It's a sunix 4066 8port pci serial controller.
> >
> > The irq file shows:
> > sandbox:~/golden_2.6# cat /proc/xenomai/irq
> > IRQ         CPU0
> >   0:         221         [timer]
> >  34:       10767         [virtual]
> >
> > If this is a irq releated problem, how can I solve it? :/
>
> IRQs only show up there when they are in use, and that is the case when
> the port is opened (ie. the test program is running).
>
> Jan
>
>
>

