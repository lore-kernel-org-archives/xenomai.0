Message-ID: <1ce16a2c0709100614j7b2b1d49g1552c654a7a4df5@domain.hid>
Date: Mon, 10 Sep 2007 15:14:04 +0200
From: "Bachman Kharazmi" <bahkha@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] adding PCI support to 16550A.c
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

I've tried to make the pci serial controller visable to the 16550
driver by adding:
## FROM 16550A.c
static int rt_16550_interrupt(rtdm_irq_t * irq_context)
{
	struct rt_16550_context *ctx;
	unsigned long base;
	int mode;
	int iir;
	uint64_t timestamp = rtdm_clock_read();
	int rbytes = 0;
	int events = 0;
	int modem;
	int ret = RTDM_IRQ_NONE;
// TEST
struct pci_dev *pdev = NULL;  // from
http://bachman.tor.lindesign.se/tmp/driver/sunix/snx_golden.c
pdev = pci_get_device(0, 0, pdev); // from
http://bachman.tor.lindesign.se/tmp/driver/sunix/snx_golden.c
//
	ctx = rtdm_irq_get_arg(irq_context, struct rt_16550_context);
	base = ctx->base_addr;
	mode = rt_16550_io_mode_from_ctx(ctx);

	rtdm_lock_get(&ctx->lock);

	while (1) {
		iir = rt_16550_reg_in(mode, base, IIR) & IIR_MASK;
		if (testbits(iir, IIR_PIRQ))
			break;


Loading module:
insmod ./xeno_16550A.ko io=0x3f8,0xbc00 irq=4,3 tx_fifo=10,20 start_index=0

running crosslink test:
sandbox:/usr/src/xenomai/examples/rtdm/profiles/serial# ./cross-link
main : write-file opened
main : write-config written
main : read-file opened
main : read-config written
main : write-task created
main : read-task created
main : starting write-task
main : starting read-task
 Nr |   write->irq    |    irq->read    |   write->read   |
-----------------------------------------------------------
read_task: error on RTSER_RTIOC_WAIT_EVENT, Connection timed out
read_task: error on RTSER_RTIOC_WAIT_EVENT, Connection timed out

any ideas?
regards /Bachman

On 09/09/2007, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> > Are there any chance that modifications in the source will get it going?
>
> Maybe we are just lacking some pci_enable_device() on the right pci_dev.
> That would mean extending xeno_16550A to deal with PCI devices. Surely
> feasible, but it takes time and hardware to test - I'm lacking both.
>
> Are you willing to play a bit with it? Then, as a prototype, you could
> pick up the lookup and enabling code from the snx driver and hack it
> into xeno_16550A. If that works, we could discuss how to establish
> something generic for PCI-based adapters.
>
> Note that I haven't read through that driver in details. There is a
> slight risk that some more bits are different. On the other hand, the
> 16650 UART that seems to be on that card is advertised as
> 16550-compatible, thus it /should/ work...
>
> Jan
>
>
>

