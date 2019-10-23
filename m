MIME-Version: 1.0
References: <CAJPjb1LG3HTfUC0FFDATAkb3-6f=nj5J+6d+gdLL3yAwxt8avQ@mail.gmail.com>
 <9224513f-51e2-1ddb-107f-58a1142b3085@siemens.com>
In-Reply-To: <9224513f-51e2-1ddb-107f-58a1142b3085@siemens.com>
From: Rob Miller <rob.miller@broadcom.com>
Date: Wed, 23 Oct 2019 08:48:35 -0400
Message-ID: <CAJPjb1+d___e1BE3tk=us9WAr0HcW3QC5ROgWaRUMPXngudqpQ@mail.gmail.com>
Subject: Re: Xenomai fails to start when running in QEMU VM
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Interestingly, I also get the exact same failure on the xenomai-images
pulled from the git repo.

the errors start right off the bat with:

tsc: Fast calibration failed
tsc: Unable to calibrate against PIT
tsc: No reference (HPET/PMTIMER) available
..
..
clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns:
19112604467 ns
hpet clock event registered
tsc: Fast calibration failed
tsc: Unable to calibrate against PIT
tsc: No reference (HPET/PMTIMER) available
tsc: Marking TSC unstable due to could not calculate TSC khz          <---
kiss of death I believe as Cobalt sees the flag and errors out
..
..
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 comparators , 64-bit 100.000000 MHz counter
clocksource: Switched to clocksource hpet
..
..
[Xenomai] scheduling class idle registered
[Xenomai] scheduling class weak registered
[Xenomai] scheduling class tp registered
[Xenomai] scheduling class pss registered
[Xenomai] scheduling class quota registered
[Xenomai] scheduling class rt registered
I-pipe: high-resolution clock not working               <--- I believe this
looks at the TSC marked as being unstable flag set above and bails out
[Xenomai] init failed, code -19

I dug into the unstable issues on my VM (ie: non xenomai-images repo), and
found that tsc_read_refs(*ref, hpet) is where the problem lies in either
whether using using hpet or not, either the returned ref value is 0 (when
hpet == 1), or the amount of time is took to read from PM (hpet == 0) took
forever (ie: 100000+ cycles) which is at least 2x the SMI_THRESHOLD vlaue
that is allowed in the code. My guess is that even when using the stock
xenomai-images directly, I'll have the same situation.

I read about SMI issues, and given the cycle allowance for SMI
interruptions in the tsc_read_refs() functio, I focused on SMI. In my VM
(ie: non-stock images), I set the linux cmdline option
xenomai.smi=disabled, but no love there either.

Given that both my VM and the stock images fail, I'm now thinking QEMU
version, or underlying host CPU issues, or TBD, is the issue, and thought
I'd first ask the community for guidance as to how to proceed.

Thoughts ideas will be greatly appreciated.


Rob Miller
rob.miller@broadcom.com
(919)721-3339


On Fri, Oct 11, 2019 at 1:32 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 11.10.19 19:25, Rob Miller via Xenomai wrote:
> > Things were working well with my server but when I went to a VM, it fails
> > complaining about no high-res timers.
> >
> > I figure it must be a CPU that I have chosen and am wondering what others
> > are using. I googled for quite a while but can't seem to find any info
> so I
> > thought I would post here for some advice.
> >
>
> Have a look at https://gitlab.denx.de/Xenomai/xenomai-images for working
> configurations for x86, ARM and ARM64 as well as the related QEMU
> parameters - or use that image directly.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>
