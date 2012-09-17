Message-ID: <5056C385.6090403@xenomai.org>
Date: Mon, 17 Sep 2012 08:30:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] IO-APIC latencies
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <Xenomai@xenomai.org>


Hi,

looking at x86 latencies, I found that what was taking long on my atom
was masking the fasteoi interrupts at IO-APIC level. So, I experimented
an idea: masking at LAPIC level instead of IO-APIC, by using the "task
priority" register. This seems to improve latencies on my atom:

http://sisyphus.hd.free.fr/~gilles/core-3.4-latencies/atom.png

This implies splitting the LAPIC vectors in a high priority and low
priority sets, the final implementation would use ipipe_enable_irqdesc
to detect a high priority domain, and change the vector at that time.

This also improves the latencies on my old PIII with a VIA chipset, but
it generates spurious interrupts (I do not know if it really is a
matter, as handling a spurious interrupt is still faster than masking an
IO-APIC interrupt), the spurious interrupts in that case are a
documented behaviour of the LAPIC.

Is there any interest in pursuing this idea, or are x86 with slow
IO-APIC the exception more than the rule, or having to split the vector
space appears too great a restriction?

Regards.

-- 
                                                                Gilles.

