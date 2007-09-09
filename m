Message-ID: <1ce16a2c0709090809y5e1732adj5081fcb556734142@domain.hid>
Date: Sun, 9 Sep 2007 17:09:58 +0200
From: "Bachman Kharazmi" <bahkha@domain.hid>
In-Reply-To: <46E4085F.3080509@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1ce16a2c0709081159y62fbb73bwb16d2cae7a931774@domain.hid>
	<1189285467.6013.20.camel@domain.hid>
	<1ce16a2c0709090730o1a803c99r70aea4410eda49ed@domain.hid>
	<46E4085F.3080509@domain.hid>
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

sandbox:~/golden_2.6# ls
Makefile  README  driver  snxdump  snxlink  snxmknod  snxterm
sandbox:~/golden_2.6# modprobe snx_golden
sandbox:~/golden_2.6# setserial -g /dev/ttySNX0
/dev/ttySNX0, UART: 16650, Port: 0xbc00, IRQ: 3
sandbox:~/golden_2.6# setserial -g /dev/ttySNX1
/dev/ttySNX1, UART: 16650, Port: 0xbc08, IRQ: 3
sandbox:~/golden_2.6# setserial -g /dev/ttySNX2
/dev/ttySNX2, UART: 16650, Port: 0xb800, IRQ: 3
sandbox:~/golden_2.6# setserial -g /dev/ttySNX3
/dev/ttySNX3, UART: 16650, Port: 0xb808, IRQ: 3
sandbox:~/golden_2.6# setserial -g /dev/ttySNX4
/dev/ttySNX4, UART: 16650, Port: 0xb400, IRQ: 3
etc..

It's a sunix 4066 8port pci serial controller.

The irq file shows:
sandbox:~/golden_2.6# cat /proc/xenomai/irq
IRQ         CPU0
  0:         221         [timer]
 34:       10767         [virtual]

If this is a irq releated problem, how can I solve it? :/

thanks
Bachman

On 09/09/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Bachman Kharazmi wrote:
> > Hi, after doing some modifications as mentioned in your patch I did
> > compile serial as module without problems.
> >
> > My problem is now that I don't have any /dev/rtserX devices :(
> > Do I need that?
>
> Nope. RTDM devices don't show up as Linux devices.
>
> >
> > My goal is to get serial communication working with xenomai for
> > controlling devices.
> >
> > Linux default serial support ain't builtin to kernel anymore.
> > I'm running
> > Linux sandbox 2.6.22 #14 Sun Sep 9 15:01:50 CEST 2007 i686 GNU/Linux
> >
> > I've checked out xenomai using svn according to:
> > svn co http://svn.gna.org/svn/xenomai/trunk xenomai
> > Adeos:
> > adeos-ipipe-2.6.22-i386-1.10-03.patch
> >
> > sandbox:/lib/modules/2.6.22/kernel/drivers/xenomai/serial# insmod
> > ./xeno_16550A.ko io=0x3f8,0xbc00 irq=4,3 tx_fifo=10,20 start_index=0
>
> I bet the IRQ of your external serial adapter is NOT 3. Please check the
> hardware manual.
>
> > sandbox:/lib/modules/2.6.22/kernel/drivers/xenomai/serial# ls /dev/rtser*
> > ls: /dev/rtser*: No such file or directory
> >
> > But I do have:
> > sandbox:/lib/modules/2.6.22/kernel/drivers/xenomai/serial# find /proc/
> > | grep rtser
> > /proc/xenomai/rtdm/rtser1
> > /proc/xenomai/rtdm/rtser1/information
> > /proc/xenomai/rtdm/rtser0
> > /proc/xenomai/rtdm/rtser0/information
> >
> > There's a serial example coming with xenomai, I'm unsure about
> > exactlly what it's supposed to do, or how I should use it. Would be
> > glad if somebody could explain more about how to use the serial ports
> > with xenomai driver.
> >
> > with a crossed cable between serialport1 at mobo and serialport1 at
> > sunix4066 8port controllercard I get:
>
> Basically, you already got its usage. It is a local cross link test,
> running between two serial ports on the same box, that are connected via
> a null modem cable. If the test is successful, you will see some round
> trip statistics (yeah, needs to be documented more explicitly...).
>
> >
> > sandbox:/usr/src/xenomai/examples/rtdm/profiles/serial# ./cross-link
> > main : write-file opened
> > main : write-config written
> > main : read-file opened
> > main : read-config written
> > main : write-task created
> > main : read-task created
> > main : starting write-task
> > main : starting read-task
> >  Nr |   write->irq    |    irq->read    |   write->read   |
> > -----------------------------------------------------------
> > read_task: error on rt_dev_read, code Success
> > main : rtser1 (read) -> closed
> > read_task: exit
>
> There is no output likely due to one adapter being unable to get any
> IRQ. You can check the IRQ activity under /proc/xenomai/irq.
>
> >
> > dmesg: http://pastebin.ca/688553
> > .config: http://pastebin.ca/688558
>
> Also note that Xenomai warns you about potential SMI-related latencies.
> Please see the Xenomai TROUBLESHOOTING doc on this.
>
> Jan
>
>
>

