From: Dirk Roloff <roloff@domain.hid>
Subject: Re: [Adeos-main] 260 uSec latency and no idea why
Date: Fri, 12 Mar 2004 18:14:54 +0100
References: <200403120744.i2C7iI725496@domain.hid>
In-Reply-To: <200403120744.i2C7iI725496@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <200403121814.54058.roloff@domain.hid>
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos-main@gna.org

> > So it must be the celeron box or some kernel/compiler settings on it.
> >
> > But what is able to delay the delivery of an interrupt if there is no o=
ne
> > calling cli or masking irq's (Both is prohibited by adeos isn't it ?)
>
> It is a software layer - no hardware prhibiting this - so if
> you have a X-server doing cli/sti in the driver or a binary driver that
> does somthing like that - they adeos can't stop it.

There is no X on it. Think of a Box that is very slim.
Its a Satelitereceiver (My problem is the driver for the receiver card - th=
e tests i'am doing are just
to figure out where i get the latencys)
Ok here a list of whats in there:

h/ware:
CPU: Celeron 4 GHz
256 MB MainMemory
A Intel D865GBF MainBoard:
	Intel 856G Chipset
	Intel=AE Extreme Graphics 2 controller (non AGP)
	10/100 Ethernet onBoard (using e100.o module)
	onBoard Audio, USB etc... not user no drivers loaded or compiled in the ke=
rnel
	Two Serial ATA IDE interfaces (ICH5)
ReceiverCard - but driver not loaded while this testings.
A FlashDisk on the IDE-Controler. It is _not_ using DMA !!!!

s/ware:
self compiled Kernel 2.4.24-adeos r10
(All options not needed are disabled - make is smal)
root patition mounted readonly
a ramdisk of 64 MB

>ps fax
  PID  Uid     VmSize Stat Command
    1 root        520 S   init
    2 root            SW  [keventd]
    3 root            SWN [ksoftirqd_CPU0]
    4 root            SW  [kswapd]
    5 root            SW  [bdflush]
    6 root            SW  [kupdated]
   39 root        664 S   /bin/sh
   40 root        524 S   init
   92 root        588 R   ps fax

init is a busybox binary (hmmm ... ok i will check this for cli calls)

Thats it. Any suspects found?

>
> > One thing would be waking a suspended cpu - but i disabled APM.
> > Someone told me Intel SpeedStep switching the mode will take hundrets of
> > MicroSecs but i didn't find what this is yet. Have to google some more.
> >a
>
> could you run the test code in the adeos cvs repository
> and send me the numbers ?

Long mail is on the way to you.
Result:
irq_jitter shows:
Out of bounds 222 us
Out of bounds -223 us

Thanks=20
Dirk


