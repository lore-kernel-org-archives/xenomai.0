Message-ID: <b2d425af-2663-9886-e5ad-3ae5325767ae@siemens.com>
Date: Mon, 9 May 2022 16:52:02 +0200
MIME-Version: 1.0
Subject: Re: 16550A: failed to get the IRQ line free
Content-Language: en-US
References: <CA+K1mPFe0aK+ZyC6cQHH65aQgemojYJy=TcFPe8git2x45sbOQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CA+K1mPFe0aK+ZyC6cQHH65aQgemojYJy=TcFPe8git2x45sbOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: C Smith <csmithquestions@gmail.com>, Xenomai List <xenomai@xenomai.org>

On 06.05.22 19:32, C Smith via Xenomai wrote:
> I have three serial devices connected using 16550A.ko driver. The card
> is a Moxa PCI 4-port card, where all ports share IRQ 18.
> Several times per minute in dmesg I get :
> [Xenomai] xnintr_edge_vec_handler: failed to get the IRQ18 line free
> 
> Yet I don't think I am losing any serial packet data (I check that with CRCs).
> This is the code which tries to handle shared interrupts and generates
> the message:
> intr.c :
> static void xnintr_edge_vec_handler(unsigned int irq, void *cookie)
> ...
>     if (counter > MAX_EDGEIRQ_COUNTER)
>         printk(XENO_ERR "%s: failed to get the IRQ%d line free\n",
>                __FUNCTION__, irq);
> 
> Does this message mean serial data can be corrupted, or is it harmless?
> Is there something I can test for you on my system?
> 
> I'm using Xenomai 3.1.2, ipipe kernel 4.19.229, X86-64.
> thanks.  -C Smith

This check is a heuristic to detect whether we have a continuously
firing IRQ source - or a buggy handler that always claims to have done
something. If we spent 128 loops in the handler loop without ever seeing
a single run without any handled IRQ, we terminate and pray that this
will not cause more harm than stay in the loop.

Granted, the longer the chain of shared handler gets, the more likely it
becomes that heavy IRQ load can trigger this case.

But maybe your problem has a different reason: Are you sure you have
edge-triggered IRQs here? Legacy INTx is usually rather level-triggered.
Checking the driver... we hard-code edge, hmm. Maybe because the
platform IRQs on x86 are edge. What does lspci -vv tell us about that
card? What does Linux report (/proc/interrupts) when binding it to a
normal driver? We likely need to make irqtype a module parameter or
configure it automatically.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

