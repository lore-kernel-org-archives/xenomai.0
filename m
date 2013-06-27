From: "Franz Engel" <franz_lambert_engel@yahoo.de>
References: <mailman.1.1371808801.4609.xenomai@xenomai.org>
	<1371820048.30624.YahooMailNeo@web172205.mail.ir2.yahoo.com>
	<51C45C6F.9080109@siemens.com> <000c01ce6f3f$ab320d50$019627f0$@de>
	<51C7E9F2.6090307@siemens.com> <51C7F33B.6070800@siemens.com>
In-Reply-To: <51C7F33B.6070800@siemens.com>
Date: Thu, 27 Jun 2013 19:26:41 +0200
Message-ID: <003701ce735b$7d70dd90$785298b0$@de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: de
Subject: Re: [Xenomai] High latency and smi with intel vendor chip
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: 'Jan Kiszka' <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

> On 2013-06-24 08:40, Jan Kiszka wrote:
> > On 2013-06-22 13:57, Franz Engel wrote:
> >> Franz Engel wrote:
> >>> Jan Kiszkas wrote:
> >>>> Franz Engel wrote:
> >>>> Hi,
> >>>>
> >>>> In my dmesg I get the following message:
> >>>> dmesg | grep -i xeno
> >>>> [    4.478964] I-pipe: head domain Xenomai registered.
> >>>> [    4.494089] Xenomai: hal/x86_64 started.
> >>>> [    4.505969] Xenomai: scheduling class idle registered.
> >>>> [    4.521300] Xenomai: scheduling class rt registered.
> >>>> [    4.538525] Xenomai: real-time nucleus v2.6.2.1 (Day At The
> Beach)
> >>> loaded.
> >>>> [    4.559065] Xenomai: debug mode enabled.
> >>>> [    4.579351] Xenomai: SMI-enabled chipset found
> >>>> [    4.592628] Xenomai: SMI workaround failed!
> >>>> [    4.605677] Xenomai: starting native API services.
> >>>> [    4.619979] Xenomai: starting POSIX services.
> >>>> [    4.633088] Xenomai: starting RTDM services.
> >>>>
> >>>>
> >>>> And I have very high latencies. I read that I should try to insert
> >>>> my
> >>> the ID of my LCP into the /usr/src/xenomai/ksrc/arch/x86/smi.c
> file.
> >>>
> >>> That is no longer true since 2.6.2.1. Xenomai already detects your
> >>> LPC (see above), but the BIOS has apparently locked SMI disabling
> down.
> >>>
> >>> In this case, you may want to play with smi_mask (see documentation
> >>> of "SMI_EN - SMI Control and Enable Register" in the Intel chipset
> >>> manuals) to see if disabling of individual SMI features work. If
> >>> not, the board is useless for low-latency real-time purposes.
> >>
> >> I found the documentation for my chipset. But I'm not sure with the
> >> interpretation. I think that chapter 13.8.3.11 "SMI_EN-SMI Control
> >> and Enable Register"
> >> (http://www.intel.com/content/dam/doc/datasheet/io-controller-hub-
> 10-
> >> family-
> >> datasheet.pdf) is the chapter that descript the options for SMI. But
> >> I don't know how to interpret it. It would be very nice if somebody
> >> could look into and say me how to understand it and how I can use
> >> this information to reduce my latency (if possible).
> >
> > Try to clear bits 18, 17, 14, 13, 11, 6 and 3.
> >
> > You can also use smictrl [1] for these experiments. Maybe you have to
> > add your chipset in this case (it still uses explicit chipset
> > listings, need to port Xenomai's logic over), but you won't have to
> reboot for this.
> 
> Just removed this limitation, smictrl now works like Xenomai /wrt
> detecting compatible chipsets.

I cleared the bits (18, 17, 14, 13, 11, 6 and 3), rather, they were already
cleared. The value of the register was 23. But I have still latencies
between 4us and 90us. Is there a best practice to find out what is the
reason for this latencies?


