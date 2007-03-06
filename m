From: Ulrich Schwab <schwab@domain.hid>
Subject: Re: [Xenomai-help] Re: high latency every 8 seconds
Date: Tue, 6 Mar 2007 12:34:51 +0100
References: <45E4646A.10205@domain.hid> <45E48E50.1030502@domain.hid>
	<45ED4351.2020905@domain.hid>
In-Reply-To: <45ED4351.2020905@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200703061234.51460.schwab@domain.hid>
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>

On Tuesday 06 March 2007 11:32, Theo Veenker wrote:
> Jan Kiszka wrote:
> > Theo Veenker wrote:
> >>Jan Kiszka wrote:
> >>>Theo Veenker wrote:
> >>>>Hi all,
> >>>>
> >>>>I'm installing xenomai 2.2.5 (kernel 2.6.17.14) on a number of
> >>>
> >>>When starting new, pick something new, i.e. 2.3 right now. Only if
> >
> > you
> >
> >>>have good reasons, staying at older versions is recommended.
> >>
> >>I would love to, but I couldn't get my software running with 2.3.
> >>I had to convert (a month ago) my software from RTLinux to Xenomai
> >>having only a few days for it. I have a kernel module and an app
> >>that talks to it. I use the posix skin. But with 2.3 apparently
> >>I had to load posixio and something (forgot) manually, but I just
> >>couldn't get these loaded. Since time was running out I decided
> >>to stay with 2.2.5 for the time being (unfortunately).
> >
> > I do understand. But once your time constraints relaxed a bit, please
> > don't forget to post remaining issues here. Maybe they reveal some real
> > bug.
> >
> >>>>systems (MSI 945P, Intel P4 3Ghz). My kernel runs fine on several
> >>>>other/older systems, but on the new systems there is something going
> >>>>on every 8 seconds. See output of latency test below. What could
> >>>>this be? Is this an SMI effect?
> >>>
> >>>Is CONFIG_XENO_HW_SMI_WORKAROUND selected? What does the kernel output
> >>>tell you about if it's working? Do you have an ICH7 chipset on your
> >>>board? Would be another reason to update Xenomai (2.3 takes care of
> >>>it, 2.2.x doesn't)... :)
>
> OK. I finally installed my clients. It took a while because although all
> systems are identical they didn't all behave the same. Apparently some
> MSI 945P boards have problems when installing an ubuntu 686 kernel image.
> Taking a 386 image as a starting point worked.
>
> Recompiled my kernel 2.6.17.14 with xenomai 2.2.5 and SMI WORKAROUND
> selected, but it didn't have any effect. I don't see any xenomai
> output in the kernel logs. Same thing without the workaround. So it
> doesn't even detect SMI. The mobo has a ICH7 chipset.
ICH7 is not in the list of SMI chipsets  in xenomai 2.2.5
compare the file  ksrc/arch/i386/smi.c between versions 2.3 and 2.2.5
This is the only change needed for the SMI detection and workaround
to work for this chipset in 2.2.5, if You decide NOT to switch to 2.3
You will need to enanble the SMI workaround  in the configuration, of course.

Ulrich


