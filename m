From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] your pending RT-Socket-CAN problems (was rtcan
	driver. rtcan_sja_interrupt made interruptible)
Date: Mon, 12 Mar 2007 09:27:53 +0100
References: <45F2B8BB.6060804@domain.hid>
	<bc4264770703110035g6625e8a1t4f195507d72aaf66@domain.hid>
	<45F3CD2C.5000400@domain.hid>
In-Reply-To: <45F3CD2C.5000400@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HQfsj-00025n-6a@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Wolfgang Grandegger wrote:
>
> Access to the parallel port is slow, indeed. Looking to
> rtcan_peak_dng_epp_readreg tells me, that 6 inb/outb are required to
> read one register and if every inb/outb takes up 1-2 us ... puh ... the
> problem gets obvious. Nevertheless, this problem is special for the PCAN
> dongle and it seems to be a bad choice for RT-Socket-CAN. All other
> devices can read/write registers much faster. I'm going to do some more
> tests next week, also with other CAN hardware. Sebastian, have you
> realized similar latency problems with SJA1000 on the ISA bus (which is
> slow as well)?

No, I didn't realize any latency problems with the ISA CAN controller. 
However, I didn't made any discrete latency measure tests. But the fact that 
the SJA1000 driver is used on all robots of the RTS with 1 MB/s laser 
scanners and a few more CAN nodes shows me that the latency impact is not 
critical.

> >
> > Sebastian's opinion is that making it interruptible would be "the
> > start of chaos". I am sure he knows more about this than I ever will
> > but only out of academic interest before I sort this problem out
> > outside the realm of rtcan, I would like to know why.
>
> As I see it, the right solution would be to handle the CAN interrupts by
> a service task and disabled the corresponding IRQ till it's handled. I
> do not see a real problem with this method,

I didn't say it's impossible. My point was that making the CAN ISR just 
interruptible with no other changes is not enough.

> but it requires substantial 
> implementation effort.

Right, and for users who don't have such hardware limits like Roland it is 
probably more important that CAN interrupts are processed with no deferral. 
So we would have to deal with both needs. Therefore my statement in a 
previous mail that all the necessary work won't be done in five minutes.

-- 
Sebastian

