From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <471753AA.20709@domain.hid>
References: <4705ED3B.4070600@domain.hid>
	<2ff1a98a0710050130j7e0db84dq838aab0417c8bd3f@domain.hid>
	<4705FE04.7000909@domain.hid> <1191576011.20623.114.camel@domain.hid>
	<470611FA.30103@domain.hid> <1191592977.20623.142.camel@domain.hid>
	<470A26BC.506@domain.hid> <1192015852.22917.197.camel@domain.hid>
	<470F7F2E.3020206@domain.hid>  <470F82FF.9020701@domain.hid>
	<1192203284.6499.135.camel@domain.hid>  <470F978B.1000005@domain.hid>
	<1192207431.6499.161.camel@domain.hid>  <4715C70F.4040501@domain.hid>
	<1192610471.5973.4.camel@domain.hid>  <4715CE15.10202@domain.hid>
	<1192612658.5973.11.camel@domain.hid>  <47160AD3.4090109@domain.hid>
	<1192628763.5973.16.camel@domain.hid>  <471621C8.9070006@domain.hid>
	<1192634673.5973.33.camel@domain.hid>  <47162E66.1080406@domain.hid>
	<1192637158.5973.51.camel@domain.hid>  <471753AA.20709@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Date: Thu, 18 Oct 2007 15:18:31 +0200
Message-Id: <1192713511.5884.12.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] awful latencies (~110us)
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
To: CHABAL David <david.chabal@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2007-10-18 at 14:38 +0200, CHABAL David wrote:
> Philippe Gerum a =E9crit :
> > On Wed, 2007-10-17 at 17:46 +0200, CHABAL David wrote:
> >> Philippe Gerum a =E9crit :
> >>> On Wed, 2007-10-17 at 16:52 +0200, CHABAL David wrote:
> >>>>> Grmmff... I think the PIC on this box has some deep troubles; pleas=
e try
> >>>>> this patch, in replacement of the previous ipipe_trace_special
> >>>>> instrumentation:
> >>>>>
> >>>> RTD|       8.348|      10.387|      43.647|       0|       6.098|=20
> >>>> 80.440
> >>>> ---|------------|------------|------------|--------|----------------=
---------
> >>>> RTS|       6.098|      10.020|      80.440|       0|    00:17:20/00:=
17:20
> >>>> [root@domain.hid bin]#
> >>>>
> >>>>
> >>>> IRQ handling takes 17=B5s in the worst case.
> >>>>
> >>>> It takes a long time to write 3 poor bytes...
> >>>>
> >>> Indeed. Each outb to the ISA bus should be somewhere in the 1-2.5 us
> >>> range depending on the hw, maybe a bit higher in case of contention, =
but
> >>> not that much.
> >>>
> >>>> May be is it a SMI problem ??? (Globally disable SMI is on)
> >>>>
> >>> It's less likely with an ICH-2 chipset.
> >>>
> >>> I see that CONFIG_IDEDMA_PCI_AUTO is disabled. Any reason not to use =
PCI
> >>> DMA when available for IDE drives with your hw?
> >>>
> >> I read this about DMA:
> >> http://www.rtai.dk/cgi-bin/gratiswiki.pl?DMA_And_Jitter
> >>
> >=20
> > As usual, usage of DMA in real-time situations is a trade-off, and
> > should be evaluated within the context of the hw at hand. DMA does bus
> > mastering, but OTOH, forcing PIO raises native Linux latencies, which
> > also has some drawbacks for real-time kernels implementing RT/non-RT
> > mode transitions for tasks like Xenomai and RTAI do. For this reason,
> > you may want to try switching PCI DMA on for your platform, until it
> > does prove bad latency-wise.
> >=20
> I tested it but the results are almost the same.
>=20

Good, at least you get PCI DMA back.

> I will try to upgrade my kernel to the 2.6.22 and to test again.
>=20

At this point, it seems reasonable to think that your hw has some
problems. You may want to confirm this by measuring the time spent in
acknowledging interrupts on the slave i8259A in mask_and_ack_8259A(), on
an unpatched 2.6.20 kernel (e.g. using a couple of rdtscll() within a
single interrupt-free section). If you still reach peaks beyond 20us,
then the odds of having the very same issue with newer kernels are high.

> David
--=20
Philippe.



