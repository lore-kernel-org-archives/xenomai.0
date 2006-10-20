Subject: Re: [Adeos-main] [PATCH] x86: revert IRQs replay order
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4538D4C8.1090603@domain.hid>
References: <4538A613.80606@domain.hid> <1161350478.4988.17.camel@domain.hid>
	<4538D4C8.1090603@domain.hid>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 16:05:48 +0200
Message-Id: <1161353148.4988.51.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Fri, 2006-10-20 at 15:53 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Fri, 2006-10-20 at 12:33 +0200, Jan Kiszka wrote:
> >> While digging into a latency issue with multiple IRQs pending (patch
> >> will likely follow soon), I noticed that the replay order on x86 is the
> >> inverse of the hardware order. Instead of iterating from lowest IRQ
> >> number to highest, ipipe currently starts with the highest one. The
> >> attached patch fixes this.
> >>
> > 
> > We want to give a priority boost to virtual IRQs over real ones, at
> > least for the root domain. Since virqs are high-numbered, bsrl has been
> 
> Hmm, are the virtual IRQs differently numbered on blackfin? Because
> there we have ffs behind __ipipe_ffnz.
> 

They are not, but the priority boost for virqs is most significant on
x86, this is why I did not bothered that much for other archs, including
on the Blackfin. The point is that we want the root domain to process
virqs sent by the RTOSes running on higher domains asap, at least before
long and costly Linux interrupt handlers may run; e.g. the IDE interrupt
handler on x86 (which gets even worse if you run that in PIO mode). On
the contrary, the Linux domain handlers over Adeos/Blackfin are
threaded; only a very simple primary handler wakes up the IRQ thread, so
the worst incurred delay before processing the virqs is known, short and
limited.

> > used on purpose to scan the pending IRQ mask. Additionally, low-numbered
> > IRQs have higher priority only if you consider the ISA ones as managed
> > by the 8259. Bringing the APIC into the picture, the APIC-based timer
> > IRQ used by RTOSes over Adeos is a high-numbered one.
> 
> Ok, so there is no simple way to emulate reality, thus we can simply
> leave it as it is. No problem.
> 
> Jan
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
-- 
Philippe.



