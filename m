Message-ID: <511E5112.9030006@control.lth.se>
Date: Fri, 15 Feb 2013 16:15:30 +0100
From: Anders Blomdell <anders.blomdell@control.lth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] kernel BUG at arch/x86/kernel/ipipe.c:589! on motherboard
	DX79SI
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

I have a DX79SI that dies with "kernel BUG at 
arch/x86/kernel/ipipe.c:589!" when running Xenomai. This is not very 
surprising since when running the system with an ordinary kernel thera 
are a few 'do_IRQ: X.Y No irq handler for vector (irq -1)' each day.

Question is if it would be possible to do something less fatal than 
'BUG_ON(irq < 0);' in the code below:

int __ipipe_handle_irq(struct pt_regs *regs)
{
	struct ipipe_percpu_data *p = __ipipe_this_cpu_ptr(&ipipe_percpu);
	int irq, vector = regs->orig_ax, flags = 0;
	struct pt_regs *tick_regs;

	if (likely(vector < 0)) {
		irq = __this_cpu_read(vector_irq[~vector]);
		BUG_ON(irq < 0);
	} else { /* Software-generated. */
		irq = vector;
		flags = IPIPE_IRQF_NOACK;
	}

Regards

Anders Blomdell

-- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden


