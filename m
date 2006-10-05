Message-ID: <ac3922a00610050516j5f06ae37j69ab6efcd9a4eb8e@domain.hid>
Date: Thu, 5 Oct 2006 14:16:36 +0200
From: "Syed Amer Gilani" <amg@domain.hid>
Sender: groove.c@domain.hid
Subject: Re: [Xenomai-help] Xenomai on 2.6.17 ppc
In-Reply-To: <451E8999.2000801@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <ac3922a00609270502s498d99bcv120ccc0f1a9f2a40@domain.hid>
	<451A6E2B.2040901@domain.hid>
	<ac3922a00609270536m396f4af0i4d60929689d4f541@domain.hid>
	<451E8999.2000801@domain.hid>
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
Cc: xenomai-help <xenomai@xenomai.org>

2006/9/30, Wolfgang Grandegger <wg@domain.hid>:
> Syed Amer Gilani wrote:
> > 2006/9/27, Wolfgang Grandegger <wg@domain.hid>:
> >> I posted a commented ADEOS-IPIPE patch for 2.6.18 for PPC end of last
> >> week (see https://mail.gna.org/public/adeos-main/2006-09/msg00009.html).
> >> Unfortunately, the PowerPC Linux kernel is a fast moving target these
> >> day due to the merge ppc, ppc64 -> powerpc and there are a few
> >> significant changes between 2.6.17 and 2.6.18, IIRC. But it's still
> >> worth a try.
> >
> > I already saw that and thought about using it. But you also say later
> > (https://mail.gna.org/public/adeos-main/2006-09/msg00012.html) that it
> > wont work for mpc52xx  and that's what i need :)
>
> I realized, that the differences to Linux 2.6.18 are quite small and non
> critical. Attached is a ADEOS-IPIPE patch for Linux 2.6.17, which should
> work on your MPC5200 as well (the idle loop problem for 6xx is solved).
> Would be nice if you could test the patch and report the results. It's
> difficult these days to get a 2.6.x kernel built and booted on an
> MPC5200 :-(.
>
> Note: this patch requires another small fix for Xenomai (see
> attachment). Philippe, could you please apply it? TIA.

First sorry for the empty Mail, this damn send button is so easily hit ...

The Patch applied fine and the Kernel compiled without Problems.
Booting it on the mpc5200 went also fine. But beyond that i cant tell
you if everything works in order, because is just started to use
xenomai.

