Message-ID: <5056D4AE.2010201@web.de>
Date: Mon, 17 Sep 2012 09:43:42 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <5056C385.6090403@xenomai.org>
In-Reply-To: <5056C385.6090403@xenomai.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] IO-APIC latencies
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <Xenomai@xenomai.org>

On 2012-09-17 08:30, Gilles Chanteperdrix wrote:
> =

> Hi,
> =

> looking at x86 latencies, I found that what was taking long on my atom
> was masking the fasteoi interrupts at IO-APIC level. So, I experimented
> an idea: masking at LAPIC level instead of IO-APIC, by using the "task
> priority" register. This seems to improve latencies on my atom:
> =

> http://sisyphus.hd.free.fr/~gilles/core-3.4-latencies/atom.png
> =

> This implies splitting the LAPIC vectors in a high priority and low
> priority sets, the final implementation would use ipipe_enable_irqdesc
> to detect a high priority domain, and change the vector at that time.
> =

> This also improves the latencies on my old PIII with a VIA chipset, but
> it generates spurious interrupts (I do not know if it really is a
> matter, as handling a spurious interrupt is still faster than masking an
> IO-APIC interrupt), the spurious interrupts in that case are a
> documented behaviour of the LAPIC.
> =

> Is there any interest in pursuing this idea, or are x86 with slow
> IO-APIC the exception more than the rule, or having to split the vector
> space appears too great a restriction?

Line-based interrupts are legacy, of decreasing relevance for PCI
devices - likely what we are primarily interesting in here - due to MSI.
So I tend to say "don't worry", specifically as fiddling with vector
allocations will require yet another round of invasive changes to the
IRQ subsystem of Linux.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20120917/d94c6ca=
9/attachment.pgp>
