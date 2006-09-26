Subject: Re: [Xenomai-core] Problem with periodic timer on PPC40x solved
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4519553A.3040109@domain.hid>
References: <J67G6W$AFC4CDFDA31A148D03B70B64BA5713E3@domain.hid>
	<1159287029.5084.149.camel@domain.hid>  <4519553A.3040109@domain.hid>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 18:38:54 +0200
Message-Id: <1159288734.5084.159.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Tue, 2006-09-26 at 18:28 +0200, Wolfgang Grandegger wrote:
> Philippe Gerum wrote:
> > On Tue, 2006-09-26 at 16:56 +0200, gilles.chanteperdrix wrote:
> >> ---------- Debut du message initial -----------
> >>
> >> De     : xenomai-core-bounces@domain.hid
> >> A      : niklaus.giger@domain.hid
> >> Copies : xenomai@xenomai.org
> >> Date   : Tue, 26 Sep 2006 16:21:18 +0200
> >> Objet  : Re: [Xenomai-core] Problem with periodic timer on
> >> PPC40x solved
> >>
> >>>> On Mon, 2006-09-25 at 22:29 +0200, Niklaus Giger wrote:
> >>>>>> Am Montag, 25. September 2006 17:57 schrieb Philippe
> >> Gerum:
> >>>>>>> On Sun, 2006-09-24 at 23:07 +0200, Wolfgang
> >> Grandegger wrote:
> >>>>>>>> Niklaus Giger wrote:
> >>>> <..>
> >>>>>> Is the output of lines like "Xenomai: Switching
> >> display-3238 to secondary
> >>>>>> mode after exception #1025 from user-space at
> >> 0x100033c4 (pid 3240)"
> >>>>>> harmless or the result of a activated
> >> CONFIG_XENO_OPT_DEBUG<..> option?
> >>> A known hw issue seems to exist with the 405GP (revD), which
> >> causes the
> >>> ESR to be incorrectly set upon FPU emulation trap, which
> >> would in turn
> >>> cause the spurious exception to be relayed to the nucleus by
> >> Adeos. The
> >>> patch below is _not_ the final fix, but rather a way to
> >> check if this
> >>> message is indeed related to the FPU emulation on your
> >> board. Does it
> >>> silence the exception without breaking the box?
> >> The FPU fault may be the result of the latency display thread
> >> using the
> >> FPU: on systems with emulated FPU, this looks normal.
> >>
> > 
> > This said, we should not switch the task to secondary mode, but rather
> > emulate the FPU ops in primary mode. To this end, we need to make sure
> > that do_mathemu() is not going to choke over this context (e.g.
> > preemption count check issues over CONFIG_PREEMPT when running
> > unmodified uaccess routines). We additionally need to fix the program
> > check exception handler to give the math emulation code a chance to
> > handle the fault before we complain loudly at the nucleus.
> 
> OK, but in general, soft-float emulation should be used on systems 
> without FPU and this is even more important for real-time.

Makes sense. So maybe we should make this a more explicit and formal
warning, to catch missing soft float emulation, actually.

>  This is a 
> tool chain issue. Niklaus, what tool chain are you using?
> 
> Wolfgang.
> 
> 
> 
-- 
Philippe.



