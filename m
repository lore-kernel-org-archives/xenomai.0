MIME-Version: 1.0
References: <CA+K1mPFe0aK+ZyC6cQHH65aQgemojYJy=TcFPe8git2x45sbOQ@mail.gmail.com>
 <b2d425af-2663-9886-e5ad-3ae5325767ae@siemens.com>
In-Reply-To: <b2d425af-2663-9886-e5ad-3ae5325767ae@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Mon, 9 May 2022 13:43:06 -0700
Message-ID: <CA+K1mPH_Aj1QKZKMsvMrgKR1uAkab_-6op7dzmErpmT--Nh2Cw@mail.gmail.com>
Subject: Re: 16550A: failed to get the IRQ line free
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai List <xenomai@xenomai.org>

On Mon, May 9, 2022 at 7:52 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 06.05.22 19:32, C Smith via Xenomai wrote:
> > I have three serial devices connected using 16550A.ko driver. The card
> > is a Moxa PCI 4-port card, where all ports share IRQ 18.
> > Several times per minute in dmesg I get :
> > [Xenomai] xnintr_edge_vec_handler: failed to get the IRQ18 line free
> >
> > Yet I don't think I am losing any serial packet data (I check that with CRCs).
> > This is the code which tries to handle shared interrupts and generates
> > the message:
> > intr.c :
> > static void xnintr_edge_vec_handler(unsigned int irq, void *cookie)
> > ...
> >     if (counter > MAX_EDGEIRQ_COUNTER)
> >         printk(XENO_ERR "%s: failed to get the IRQ%d line free\n",
> >                __FUNCTION__, irq);
> >
> > Does this message mean serial data can be corrupted, or is it harmless?
> > Is there something I can test for you on my system?
> >
> > I'm using Xenomai 3.1.2, ipipe kernel 4.19.229, X86-64.
> > thanks.  -C Smith
>
> This check is a heuristic to detect whether we have a continuously
> firing IRQ source - or a buggy handler that always claims to have done
> something. If we spent 128 loops in the handler loop without ever seeing
> a single run without any handled IRQ, we terminate and pray that this
> will not cause more harm than stay in the loop.

Which part of the intr.c code terminates the handler if counter is too
high? I only see a warning printed if counter is too high.
I ask because maybe I could hack the code to terminate earlier and
check if I lose any serial bytes.

BTW I added a printk to intr.c but I couldn't see it even after I
rebuilt xenomai and did make install. The only way I could see it is
if I rebuilt and did make install of the whole kernel and its modules.
What exactly is intr.c linked to?

> Granted, the longer the chain of shared handler gets, the more likely it
> becomes that heavy IRQ load can trigger this case.
>
> But maybe your problem has a different reason: Are you sure you have
> edge-triggered IRQs here? Legacy INTx is usually rather level-triggered.
> Checking the driver... we hard-code edge, hmm. Maybe because the
> platform IRQs on x86 are edge. What does lspci -vv tell us about that
> card? What does Linux report (/proc/interrupts) when binding it to a
> normal driver? We likely need to make irqtype a module parameter or
> configure it automatically.
> Jan

I doubt the Moxa card has level sensitive interrupts, I assume it is
edge. But here is the lspci -vv output:
03:02.0 Serial controller: Moxa Technologies Co Ltd CP104U (4-port
RS-232 Universal PCI) (prog-if 02 [16550])
       Subsystem: Moxa Technologies Co Ltd CP104U (4-port RS-232 Universal PCI)
       Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
       Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
       Interrupt: pin A routed to IRQ 18
       Region 1: I/O ports at d040 [size=32]
       Region 2: I/O ports at d000 [size=64]
       Region 3: I/O ports at d060 [size=16]

By watching /proc/xenomai/irq for 10 minutes I calculated how many
interrupts I should be getting into the 16550A driver at once with my
packet timing, on 6 serial ports, and it is 90 interrupts in a
cluster. Those come in pretty rapid succession (within a few
milliseconds) but we are talking about serial data and the depth of
the FIFOs, so not all of those interrupts would come exactly
simultaneously. So not really enough interrupts to breach the 128
limit.
Yet when I disconnect one of the external devices and have only 5
serial devices streaming in simultaneously, the "failed to get the
IRQ18 line free" messages stop.

So while that 6th device seems to push this over the edge, I should
also reveal that SMBUS shares an interrupt with my Moxa serial card.
But, I unloaded all xenomai apps and modules, then loaded the SMBUS
driver i2c_i801 and /proc/interrupts shows zero SMBUS interrupts over
time. So I don't think SMBUS is generating any interrupts.
No, there are no other PCI slots I can put the Moxa serial card into
on this motherboard, I tried, all other PCI slots are shared with
active Ethernet/USB etc.

thanks, -C Smith

