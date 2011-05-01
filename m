From: luxInteg <lux-integ@domain.hid>
Date: Sun, 1 May 2011 15:46:01 +0100
References: <201010202246.40024.lux-integ@domain.hid>
	<AANLkTimV=NchWEgTt5SsSroNmF82O0Latu9ciKgmYn07@domain.hid>
In-Reply-To: <AANLkTimV=NchWEgTt5SsSroNmF82O0Latu9ciKgmYn07@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pIXvNdQrmwmzrNO"
Message-Id: <201105011546.01925.lux-integ@domain.hid>
Subject: Re: [Xenomai-help] analogy on 9812/9112 daq cards
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexis Berlemont <alexis.berlemont@domain.hid>
Cc: xenomai@xenomai.org

--Boundary-00=_pIXvNdQrmwmzrNO
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Thursday 21 October 2010 07:24:04 Alexis Berlemont wrote:
> Hi,
> 
> On Wed, Oct 20, 2010 at 11:46 PM, luxInteg <lux-integ@domain.hid> wrote:
> > Greetings,
> > 
> > I had a cursory non-expert  look at analogy and noticed the supported
> > cards are all by NI.  I want to dabble a little with  with xenomai and
> > as a starter with these two daq-cards:-
> > 
> > 
> > http://www.adlinktech.com/PD/web/PD_detail.php?sg-daq&pid=29
> > 
> > and
> > 
> > http://www.adlinktech.com/PD/web/PD_detail.php?pid=566
> > 
> > (both have the amcc5933 PCI intrface)
> > 
> > is there a   template  with  the needed  subroutines  ( or  functions )
> > necessary  have a go at writing a driver for analogy
> > for devices of the above types?
> 
> A good start would be to have a look at the driver "analogy_fake"
> which is just a test driver. Concerning the API for driver
> development, it is described in the Doxygen doc (Modules -> Analogy
> API -> Driver API -> *) at:
> http://www.xenomai.org/documentation/xenomai-2.5/html/api/index.html
> 

Thanks for your advice

I have decided to take the plunge and ATTEMPT porting the comedi driver for 
pci-9118 over to analogy.  ( I stress attempt ).  The comedi driver is 
attached.

I have scanned through  the analogy api and the fake.c driver as suggested.  
But I am unsure how to  work up functions that avoid the use of comedi header 
files uch as:-

#include "comedi_fc.h"
#include "comedi_pci.h"
#include <linux/comedidev.h>

I checked the  the two files  mite.c (for analogy) and mite.c ( for comedi)  { 
both also attached } 
 the former has none of the definitions  above whilst the latter does.
I would thus  be grateful for some guidance of how    calls to  comedi_fc.h, 
comedi_pci.h, and linux/comedidev.h are  'written out'  in a transfer of a 
driver such as pci-9118.c from comedi to analogy.

Thanks in advance.

sincerely
luxInteg.

========

ps sorry for the big attachments,  I  thought of using URLs to the said files 
but found them in git repositories and thus too 
too long and breakable.

--Boundary-00=_pIXvNdQrmwmzrNO
Content-Type: text/x-csrc;
  charset="ISO-8859-1";
  name="mite.c.ANALOGY"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mite.c.ANALOGY"

/**
 * @file
 * Hardware driver for NI Mite PCI interface chip
 *
 * Copyright (C) 1999 David A. Schleef <ds@domain.hid>
 *
 * This code is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published
 * by the Free Software Foundation; either version 2 of the License,
 * or (at your option) any later version.
 *
 * This code is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Xenomai; if not, write to the Free Software Foundation,
 * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 * The NI Mite driver was originally written by Tomasz Motylewski
 * <...>, and ported to comedi by ds.
 *
 * References for specifications:
 *
 * 321747b.pdf  Register Level Programmer Manual (obsolete)
 * 321747c.pdf  Register Level Programmer Manual (new)
 * DAQ-STC reference manual
 *
 * Other possibly relevant info:
 *
 * 320517c.pdf  User manual (obsolete)
 * 320517f.pdf  User manual (new)
 * 320889a.pdf  delete
 * 320906c.pdf  maximum signal ratings
 * 321066a.pdf  about 16x
 * 321791a.pdf  discontinuation of at-mio-16e-10 rev. c
 * 321808a.pdf  about at-mio-16e-10 rev P
 * 321837a.pdf  discontinuation of at-mio-16de-10 rev d
 * 321838a.pdf  about at-mio-16de-10 rev N
 *
 * ISSUES:
 */

#include <asm/system.h>

#include "mite.h"

#ifdef CONFIG_DEBUG_MITE
#define MDPRINTK(fmt, args...) rtdm_printk(fmt, ##args)
#else /* !CONFIG_DEBUG_MITE */
#define MDPRINTK(fmt, args...)
#endif /* CONFIG_DEBUG_MITE */

static LIST_HEAD(mite_devices);

static struct pci_device_id mite_id[] = {
	{PCI_DEVICE(PCI_VENDOR_ID_NATINST, PCI_ANY_ID), },
	{0, }
};

static int mite_probe(struct pci_dev *dev, const struct pci_device_id *id)
{
	int i;
	struct mite_struct *mite;

	mite = kmalloc(sizeof(struct mite_struct), GFP_KERNEL);
	if(mite == NULL)
		return -ENOMEM;

	memset(mite, 0, sizeof(struct mite_struct));

	a4l_lock_init(&mite->lock);
	mite->pcidev = dev;

	for(i = 0; i < MAX_MITE_DMA_CHANNELS; i++) {
		mite->channels[i].mite = mite;
		mite->channels[i].channel = i;
		mite->channels[i].done = 1;
	}

	list_add(&mite->list, &mite_devices);

	return 0;
}

static void mite_remove(struct pci_dev *dev)
{
	struct list_head *this;

	list_for_each(this, &mite_devices) {
		struct mite_struct *mite =
			list_entry(this, struct mite_struct, list);

		if(mite->pcidev == dev) {
			list_del(this);
			kfree(mite);
			break;
		}
	}
}

static struct pci_driver mite_driver = {
	.name = "mite",
	.id_table = mite_id,
	.probe = mite_probe,
	.remove = mite_remove,
};

int mite_setup(struct mite_struct *mite, int use_iodwbsr_1)
{
	unsigned long length;
	resource_size_t addr;
	int i;
	u32 csigr_bits;
	unsigned unknown_dma_burst_bits;

	__a4l_dbg(1, drv_dbg, "mite: starting setup...\n");

	if(pci_enable_device(mite->pcidev)){
		__a4l_err("error enabling mite\n");
		return -EIO;
	}

	pci_set_master(mite->pcidev);

	if (pci_request_regions( mite->pcidev, "mite")) {
		__a4l_err("failed to request mite io regions\n");
		return -EIO;
	};


	/* The PCI BAR0 is the Mite */
	addr = pci_resource_start(mite->pcidev, 0);
	length = pci_resource_len(mite->pcidev, 0);
	mite->mite_phys_addr = addr;
	mite->mite_io_addr = ioremap(addr, length);
	if (!mite->mite_io_addr) {
		__a4l_err("failed to remap mite io memory address\n");
		return -ENOMEM;
	}

	__a4l_dbg(1, drv_dbg,
		  "mite: bar0(mite) 0x%08llx mapped to %p\n",
		  (unsigned long long)mite->mite_phys_addr,
		  mite->mite_io_addr);


	/* The PCI BAR1 is the DAQ */
	addr = pci_resource_start(mite->pcidev, 1);
	length = pci_resource_len(mite->pcidev, 1);
	mite->daq_phys_addr = addr;
	mite->daq_io_addr = ioremap(mite->daq_phys_addr, length);
	if (!mite->daq_io_addr) {
		__a4l_err("failed to remap daq io memory address\n");
		return -ENOMEM;
	}

	__a4l_dbg(1, drv_dbg,
		  "mite: bar0(daq) 0x%08llx mapped to %p\n",
		  (unsigned long long)mite->daq_phys_addr,
		  mite->daq_io_addr);

	if (use_iodwbsr_1) {

		__a4l_dbg(1, drv_dbg,
			  "mite: using I/O Window Base Size register 1\n");

		writel(0, mite->mite_io_addr + MITE_IODWBSR);
		writel(mite->
		       daq_phys_addr | WENAB |
		       MITE_IODWBSR_1_WSIZE_bits(length),
		       mite->mite_io_addr + MITE_IODWBSR_1);
		writel(0, mite->mite_io_addr + MITE_IODWCR_1);
	} else {
		writel(mite->daq_phys_addr | WENAB,
		       mite->mite_io_addr + MITE_IODWBSR);
	}

	/* Make sure dma bursts work.  I got this from running a bus analyzer
	   on a pxi-6281 and a pxi-6713.  6713 powered up with register value
	   of 0x61f and bursts worked.  6281 powered up with register value of
	   0x1f and bursts didn't work.  The NI windows driver reads the register,
	   then does a bitwise-or of 0x600 with it and writes it back.
	*/
	unknown_dma_burst_bits =
		readl(mite->mite_io_addr + MITE_UNKNOWN_DMA_BURST_REG);
	unknown_dma_burst_bits |= UNKNOWN_DMA_BURST_ENABLE_BITS;
	writel(unknown_dma_burst_bits,
	       mite->mite_io_addr + MITE_UNKNOWN_DMA_BURST_REG);

	csigr_bits = readl(mite->mite_io_addr + MITE_CSIGR);
	mite->num_channels = mite_csigr_dmac(csigr_bits);
	if (mite->num_channels > MAX_MITE_DMA_CHANNELS) {
		__a4l_err("MITE: bug? chip claims to have %i dma channels. "
			  "Setting to %i.\n",
			  mite->num_channels, MAX_MITE_DMA_CHANNELS);
		mite->num_channels = MAX_MITE_DMA_CHANNELS;
	}

	__a4l_dbg(1, drv_dbg,
		  "mite: version = %i, type = %i, mite mode = %i, "
		  "interface mode = %i\n",
		  mite_csigr_version(csigr_bits),
		  mite_csigr_type(csigr_bits),
		  mite_csigr_mmode(csigr_bits),
		  mite_csigr_imode(csigr_bits));
	__a4l_dbg(1, drv_dbg,
		  "mite: num channels = %i, write post fifo depth = %i, "
		  "wins = %i, iowins = %i\n",
		  mite_csigr_dmac(csigr_bits),
		  mite_csigr_wpdep(csigr_bits),
		  mite_csigr_wins(csigr_bits),
		  mite_csigr_iowins(csigr_bits));

	for (i = 0; i < mite->num_channels; i++) {
		/* Registers the channel as a free one */
		mite->channel_allocated[i] = 0;
		/* Reset the channel */
		writel(CHOR_DMARESET, mite->mite_io_addr + MITE_CHOR(i));
		/* Disable interrupts */
		writel(CHCR_CLR_DMA_IE | CHCR_CLR_LINKP_IE | CHCR_CLR_SAR_IE |
		       CHCR_CLR_DONE_IE | CHCR_CLR_MRDY_IE | CHCR_CLR_DRDY_IE |
		       CHCR_CLR_LC_IE | CHCR_CLR_CONT_RB_IE,
		       mite->mite_io_addr + MITE_CHCR(i));

		__a4l_dbg(1, drv_dbg, "mite: channel[%d] initialized\n", i);
	}

	mite->used = 1;

	return 0;
}

void mite_unsetup(struct mite_struct *mite)
{
	if (!mite)
		return;

	if (mite->mite_io_addr) {
		iounmap(mite->mite_io_addr);
		mite->mite_io_addr = NULL;
	}

	if (mite->daq_io_addr) {
		iounmap(mite->daq_io_addr);
		mite->daq_io_addr = NULL;
	}

	if(mite->used)
		pci_release_regions( mite->pcidev );

	mite->used = 0;
}

void mite_list_devices(void)
{
	struct list_head *this;

	printk("Analogy: MITE: Available NI device IDs:");
	list_for_each(this, &mite_devices) {
		struct mite_struct *mite =
			list_entry(this, struct mite_struct, list);

		printk(" 0x%04x", mite_device_id(mite));
		if(mite->used)
			printk("(used)");
	}

	printk("\n");
}



struct mite_struct * mite_find_device(int bus, int slot, unsigned short device_id)
{
	struct list_head *this;

	list_for_each(this, &mite_devices) {
		struct mite_struct *mite =
			list_entry(this, struct mite_struct, list);

		if(mite->pcidev->device != device_id)
			continue;

		if((bus <= 0 && slot <= 0) ||
		   (bus == mite->pcidev->bus->number &&
		    slot == PCI_SLOT(mite->pcidev->devfn)))
			return mite;
	}

	return NULL;
}
EXPORT_SYMBOL_GPL(mite_find_device);

struct mite_channel *mite_request_channel_in_range(struct mite_struct *mite,
						   struct mite_dma_descriptor_ring *ring,
						   unsigned min_channel,
						   unsigned max_channel)
{
	int i;
	unsigned long flags;
	struct mite_channel *channel = NULL;

	__a4l_dbg(1, drv_dbg,
		  "mite: mite_request_channel_in_range: "
		  "min_channel = %u, max_channel = %u\n",
		  min_channel, max_channel);

	/* spin lock so mite_release_channel can be called safely from interrupts */
	a4l_lock_irqsave(&mite->lock, flags);
	for (i = min_channel; i <= max_channel; ++i) {

	__a4l_dbg(1, drv_dbg,
		  "mite: mite_request_channel_in_range: "
		  "channel[%d] allocated = %d\n",
		  i, mite->channel_allocated[i]);

		if (mite->channel_allocated[i] == 0) {
			mite->channel_allocated[i] = 1;
			channel = &mite->channels[i];
			channel->ring = ring;
			break;
		}
	}
	a4l_unlock_irqrestore(&mite->lock, flags);
	return channel;
}

void mite_release_channel(struct mite_channel *mite_chan)
{
	struct mite_struct *mite = mite_chan->mite;
	unsigned long flags;

	/* Spin lock to prevent races with mite_request_channel */
	a4l_lock_irqsave(&mite->lock, flags);
	if (mite->channel_allocated[mite_chan->channel]) {
		/* disable all channel's interrupts */
		writel(CHCR_CLR_DMA_IE | CHCR_CLR_LINKP_IE |
		       CHCR_CLR_SAR_IE | CHCR_CLR_DONE_IE |
		       CHCR_CLR_MRDY_IE | CHCR_CLR_DRDY_IE |
		       CHCR_CLR_LC_IE | CHCR_CLR_CONT_RB_IE,
		       mite->mite_io_addr + MITE_CHCR(mite_chan->channel));
		mite_dma_disarm(mite_chan);
		mite_dma_reset(mite_chan);
		mite->channel_allocated[mite_chan->channel] = 0;
		mite_chan->ring = NULL;
		mmiowb();
	}
	a4l_unlock_irqrestore(&mite->lock, flags);
}

void mite_dma_arm(struct mite_channel *mite_chan)
{
	struct mite_struct *mite = mite_chan->mite;
	int chor;
	unsigned long flags;

	MDPRINTK("mite_dma_arm ch%i\n", mite_chan->channel);
	/* Memory barrier is intended to insure any twiddling with the buffer
	   is done before writing to the mite to arm dma transfer */
	smp_mb();
	/* arm */
	chor = CHOR_START;
	a4l_lock_irqsave(&mite->lock, flags);
	mite_chan->done = 0;
	writel(chor, mite->mite_io_addr + MITE_CHOR(mite_chan->channel));
	mmiowb();
	a4l_unlock_irqrestore(&mite->lock, flags);
}

void mite_dma_disarm(struct mite_channel *mite_chan)
{
	struct mite_struct *mite = mite_chan->mite;
	unsigned chor;

	/* disarm */
	chor = CHOR_ABORT;
	writel(chor, mite->mite_io_addr + MITE_CHOR(mite_chan->channel));
}

int mite_buf_change(struct mite_dma_descriptor_ring *ring, a4l_subd_t *subd)
{
	a4l_buf_t *buf = subd->buf;
	unsigned int n_links;
	int i;

	if (ring->descriptors) {
		pci_free_consistent(ring->pcidev,
				    ring->n_links * sizeof(struct mite_dma_descriptor),
				    ring->descriptors, ring->descriptors_dma_addr);
	}
	ring->descriptors = NULL;
	ring->descriptors_dma_addr = 0;
	ring->n_links = 0;

	if (buf->size == 0) {
		return 0;
	}
	n_links = buf->size >> PAGE_SHIFT;

	MDPRINTK("ring->pcidev=%p, n_links=0x%04x\n", ring->pcidev, n_links);

	ring->descriptors =
		pci_alloc_consistent(ring->pcidev,
				     n_links * sizeof(struct mite_dma_descriptor),
				     &ring->descriptors_dma_addr);
	if (!ring->descriptors) {
		printk("MITE: ring buffer allocation failed\n");
		return -ENOMEM;
	}
	ring->n_links = n_links;

	for (i = 0; i < n_links; i++) {
		ring->descriptors[i].count = cpu_to_le32(PAGE_SIZE);
		ring->descriptors[i].addr = cpu_to_le32(buf->pg_list[i]);
		ring->descriptors[i].next =
			cpu_to_le32(ring->descriptors_dma_addr +
				    (i + 1) * sizeof(struct mite_dma_descriptor));
	}

	ring->descriptors[n_links - 1].next =
		cpu_to_le32(ring->descriptors_dma_addr);

	/* Barrier is meant to insure that all the writes to the dma descriptors
	   have completed before the dma controller is commanded to read them */
	smp_wmb();

	return 0;
}

void mite_prep_dma(struct mite_channel *mite_chan,
		   unsigned int num_device_bits, unsigned int num_memory_bits)
{
	unsigned int chor, chcr, mcr, dcr, lkcr;
	struct mite_struct *mite = mite_chan->mite;

	MDPRINTK("mite_prep_dma ch%i\n", mite_chan->channel);

	/* reset DMA and FIFO */
	chor = CHOR_DMARESET | CHOR_FRESET;
	writel(chor, mite->mite_io_addr + MITE_CHOR(mite_chan->channel));

	/* short link chaining mode */
	chcr = CHCR_SET_DMA_IE | CHCR_LINKSHORT | CHCR_SET_DONE_IE |
		CHCR_BURSTEN;
	/*
	 * Link Complete Interrupt: interrupt every time a link
	 * in MITE_RING is completed. This can generate a lot of
	 * extra interrupts, but right now we update the values
	 * of buf_int_ptr and buf_int_count at each interrupt.  A
	 * better method is to poll the MITE before each user
	 * "read()" to calculate the number of bytes available.
	 */
	chcr |= CHCR_SET_LC_IE;
	if (num_memory_bits == 32 && num_device_bits == 16) {
		/* Doing a combined 32 and 16 bit byteswap gets the 16
		   bit samples into the fifo in the right order.
		   Tested doing 32 bit memory to 16 bit device
		   transfers to the analog out of a pxi-6281, which
		   has mite version = 1, type = 4.  This also works
		   for dma reads from the counters on e-series boards.
		*/
		chcr |= CHCR_BYTE_SWAP_DEVICE | CHCR_BYTE_SWAP_MEMORY;
	}

	if (mite_chan->dir == A4L_INPUT) {
		chcr |= CHCR_DEV_TO_MEM;
	}
	writel(chcr, mite->mite_io_addr + MITE_CHCR(mite_chan->channel));

	/* to/from memory */
	mcr = CR_RL(64) | CR_ASEQUP;
	switch (num_memory_bits) {
	case 8:
		mcr |= CR_PSIZE8;
		break;
	case 16:
		mcr |= CR_PSIZE16;
		break;
	case 32:
		mcr |= CR_PSIZE32;
		break;
	default:
		__a4l_err("MITE: bug! "
			  "invalid mem bit width for dma transfer\n");
		break;
	}
	writel(mcr, mite->mite_io_addr + MITE_MCR(mite_chan->channel));

	/* from/to device */
	dcr = CR_RL(64) | CR_ASEQUP;
	dcr |= CR_PORTIO | CR_AMDEVICE | CR_REQSDRQ(mite_chan->channel);
	switch (num_device_bits) {
	case 8:
		dcr |= CR_PSIZE8;
		break;
	case 16:
		dcr |= CR_PSIZE16;
		break;
	case 32:
		dcr |= CR_PSIZE32;
		break;
	default:
		__a4l_info("MITE: bug! "
			   "invalid dev bit width for dma transfer\n");
		break;
	}
	writel(dcr, mite->mite_io_addr + MITE_DCR(mite_chan->channel));

	/* reset the DAR */
	writel(0, mite->mite_io_addr + MITE_DAR(mite_chan->channel));

	/* the link is 32bits */
	lkcr = CR_RL(64) | CR_ASEQUP | CR_PSIZE32;
	writel(lkcr, mite->mite_io_addr + MITE_LKCR(mite_chan->channel));

	/* starting address for link chaining */
	writel(mite_chan->ring->descriptors_dma_addr,
	       mite->mite_io_addr + MITE_LKAR(mite_chan->channel));

	MDPRINTK("exit mite_prep_dma\n");
}

u32 mite_device_bytes_transferred(struct mite_channel *mite_chan)
{
	struct mite_struct *mite = mite_chan->mite;
	return readl(mite->mite_io_addr + MITE_DAR(mite_chan->channel));
}

u32 mite_bytes_in_transit(struct mite_channel * mite_chan)
{
	struct mite_struct *mite = mite_chan->mite;
	return readl(mite->mite_io_addr +
		     MITE_FCR(mite_chan->channel)) & 0x000000FF;
}

/* Returns lower bound for number of bytes transferred from device to memory */
u32 mite_bytes_written_to_memory_lb(struct mite_channel * mite_chan)
{
	u32 device_byte_count;

	device_byte_count = mite_device_bytes_transferred(mite_chan);
	return device_byte_count - mite_bytes_in_transit(mite_chan);
}

/* Returns upper bound for number of bytes transferred from device to memory */
u32 mite_bytes_written_to_memory_ub(struct mite_channel * mite_chan)
{
	u32 in_transit_count;

	in_transit_count = mite_bytes_in_transit(mite_chan);
	return mite_device_bytes_transferred(mite_chan) - in_transit_count;
}

/* Returns lower bound for number of bytes read from memory for transfer to device */
u32 mite_bytes_read_from_memory_lb(struct mite_channel * mite_chan)
{
	u32 device_byte_count;

	device_byte_count = mite_device_bytes_transferred(mite_chan);
	return device_byte_count + mite_bytes_in_transit(mite_chan);
}

/* Returns upper bound for number of bytes read from memory for transfer to device */
u32 mite_bytes_read_from_memory_ub(struct mite_channel * mite_chan)
{
	u32 in_transit_count;

	in_transit_count = mite_bytes_in_transit(mite_chan);
	return mite_device_bytes_transferred(mite_chan) + in_transit_count;
}

int mite_sync_input_dma(struct mite_channel *mite_chan, a4l_subd_t *subd)
{
	unsigned int nbytes_lb, nbytes_ub;

	nbytes_lb = mite_bytes_written_to_memory_lb(mite_chan);
	nbytes_ub = mite_bytes_written_to_memory_ub(mite_chan);

	if(a4l_buf_prepare_absput(subd, nbytes_ub) != 0) {
		__a4l_err("MITE: DMA overwrite of free area\n");
		return -EPIPE;
	}

	return a4l_buf_commit_absput(subd, nbytes_lb);
}

int mite_sync_output_dma(struct mite_channel *mite_chan, a4l_subd_t *subd)
{
	a4l_buf_t *buf = subd->buf;
	unsigned int nbytes_ub, nbytes_lb;
	int err;

	nbytes_lb = mite_bytes_read_from_memory_lb(mite_chan);
	nbytes_ub = mite_bytes_read_from_memory_ub(mite_chan);

	err = a4l_buf_prepare_absget(subd, nbytes_ub);
	if(err < 0) {
		__a4l_info("MITE: DMA underrun\n");
		return -EPIPE;
	}

	err = a4l_buf_commit_absget(subd, nbytes_lb);

	/* If the MITE has already transfered more than required, we
	   can disable it */
	if (test_bit(A4L_BUF_EOA_NR, &buf->flags))
		writel(CHOR_STOP,
		       mite_chan->mite->mite_io_addr +
		       MITE_CHOR(mite_chan->channel));

	return err;
}

u32 mite_get_status(struct mite_channel *mite_chan)
{
	struct mite_struct *mite = mite_chan->mite;
	u32 status;
	unsigned long flags;

	a4l_lock_irqsave(&mite->lock, flags);
	status = readl(mite->mite_io_addr + MITE_CHSR(mite_chan->channel));
	if (status & CHSR_DONE) {
		mite_chan->done = 1;
		writel(CHOR_CLRDONE,
		       mite->mite_io_addr + MITE_CHOR(mite_chan->channel));
	}
	mmiowb();
	a4l_unlock_irqrestore(&mite->lock, flags);
	return status;
}

int mite_done(struct mite_channel *mite_chan)
{
	struct mite_struct *mite = mite_chan->mite;
	unsigned long flags;
	int done;

	mite_get_status(mite_chan);
	a4l_lock_irqsave(&mite->lock, flags);
	done = mite_chan->done;
	a4l_unlock_irqrestore(&mite->lock, flags);
	return done;
}

#ifdef CONFIG_DEBUG_MITE

static void mite_decode(const char *const bit_str[], unsigned int bits);

/* names of bits in mite registers */

static const char *const mite_CHOR_strings[] = {
	"start", "cont", "stop", "abort",
	"freset", "clrlc", "clrrb", "clrdone",
	"clr_lpause", "set_lpause", "clr_send_tc",
	"set_send_tc", "12", "13", "14",
	"15", "16", "17", "18",
	"19", "20", "21", "22",
	"23", "24", "25", "26",
	"27", "28", "29", "30",
	"dmareset",
};

static const char *const mite_CHCR_strings[] = {
	"continue", "ringbuff", "2", "3",
	"4", "5", "6", "7",
	"8", "9", "10", "11",
	"12", "13", "bursten", "fifodis",
	"clr_cont_rb_ie", "set_cont_rb_ie", "clr_lc_ie", "set_lc_ie",
	"clr_drdy_ie", "set_drdy_ie", "clr_mrdy_ie", "set_mrdy_ie",
	"clr_done_ie", "set_done_ie", "clr_sar_ie", "set_sar_ie",
	"clr_linkp_ie", "set_linkp_ie", "clr_dma_ie", "set_dma_ie",
};

static const char *const mite_MCR_strings[] = {
	"amdevice", "1", "2", "3",
	"4", "5", "portio", "portvxi",
	"psizebyte", "psizehalf (byte & half = word)", "aseqxp1", "11",
	"12", "13", "blocken", "berhand",
	"reqsintlim/reqs0", "reqs1", "reqs2", "rd32",
	"rd512", "rl1", "rl2", "rl8",
	"24", "25", "26", "27",
	"28", "29", "30", "stopen",
};

static const char *const mite_DCR_strings[] = {
	"amdevice", "1", "2", "3",
	"4", "5", "portio", "portvxi",
	"psizebyte", "psizehalf (byte & half = word)", "aseqxp1", "aseqxp2",
	"aseqxp8", "13", "blocken", "berhand",
	"reqsintlim", "reqs1", "reqs2", "rd32",
	"rd512", "rl1", "rl2", "rl8",
	"23", "24", "25", "27",
	"28", "wsdevc", "wsdevs", "rwdevpack",
};

static const char *const mite_LKCR_strings[] = {
	"amdevice", "1", "2", "3",
	"4", "5", "portio", "portvxi",
	"psizebyte", "psizehalf (byte & half = word)", "asequp", "aseqdown",
	"12", "13", "14", "berhand",
	"16", "17", "18", "rd32",
	"rd512", "rl1", "rl2", "rl8",
	"24", "25", "26", "27",
	"28", "29", "30", "chngend",
};

static const char *const mite_CHSR_strings[] = {
	"d.err0", "d.err1", "m.err0", "m.err1",
	"l.err0", "l.err1", "drq0", "drq1",
	"end", "xferr", "operr0", "operr1",
	"stops", "habort", "sabort", "error",
	"16", "conts_rb", "18", "linkc",
	"20", "drdy", "22", "mrdy",
	"24", "done", "26", "sars",
	"28", "lpauses", "30", "int",
};

void mite_dump_regs(struct mite_channel *mite_chan)
{
	unsigned long mite_io_addr =
		(unsigned long)mite_chan->mite->mite_io_addr;
	unsigned long addr = 0;
	unsigned long temp = 0;

	printk("mite_dump_regs ch%i\n", mite_chan->channel);
	printk("mite address is  =0x%08lx\n", mite_io_addr);

	addr = mite_io_addr + MITE_CHOR(mite_chan->channel);
	printk("mite status[CHOR]at 0x%08lx =0x%08lx\n", addr, temp =
	       readl((void *)addr));
	mite_decode(mite_CHOR_strings, temp);
	addr = mite_io_addr + MITE_CHCR(mite_chan->channel);
	printk("mite status[CHCR]at 0x%08lx =0x%08lx\n", addr, temp =
	       readl((void *)addr));
	mite_decode(mite_CHCR_strings, temp);
	addr = mite_io_addr + MITE_TCR(mite_chan->channel);
	printk("mite status[TCR] at 0x%08lx =0x%08x\n", addr,
	       readl((void *)addr));
	addr = mite_io_addr + MITE_MCR(mite_chan->channel);
	printk("mite status[MCR] at 0x%08lx =0x%08lx\n", addr, temp =
	       readl((void *)addr));
	mite_decode(mite_MCR_strings, temp);

	addr = mite_io_addr + MITE_MAR(mite_chan->channel);
	printk("mite status[MAR] at 0x%08lx =0x%08x\n", addr,
	       readl((void *)addr));
	addr = mite_io_addr + MITE_DCR(mite_chan->channel);
	printk("mite status[DCR] at 0x%08lx =0x%08lx\n", addr, temp =
	       readl((void *)addr));
	mite_decode(mite_DCR_strings, temp);
	addr = mite_io_addr + MITE_DAR(mite_chan->channel);
	printk("mite status[DAR] at 0x%08lx =0x%08x\n", addr,
	       readl((void *)addr));
	addr = mite_io_addr + MITE_LKCR(mite_chan->channel);
	printk("mite status[LKCR]at 0x%08lx =0x%08lx\n", addr, temp =
	       readl((void *)addr));
	mite_decode(mite_LKCR_strings, temp);
	addr = mite_io_addr + MITE_LKAR(mite_chan->channel);
	printk("mite status[LKAR]at 0x%08lx =0x%08x\n", addr,
	       readl((void *)addr));

	addr = mite_io_addr + MITE_CHSR(mite_chan->channel);
	printk("mite status[CHSR]at 0x%08lx =0x%08lx\n", addr, temp =
	       readl((void *)addr));
	mite_decode(mite_CHSR_strings, temp);
	addr = mite_io_addr + MITE_FCR(mite_chan->channel);
	printk("mite status[FCR] at 0x%08lx =0x%08x\n\n", addr,
	       readl((void *)addr));
}


static void mite_decode(const char *const bit_str[], unsigned int bits)
{
	int i;

	for (i = 31; i >= 0; i--) {
		if (bits & (1 << i)) {
			printk(" %s", bit_str[i]);
		}
	}
	printk("\n");
}

#endif /* CONFIG_DEBUG_MITE */


static int __init mite_init(void)
{
	int err;

	/* Register the mite's PCI driver */
	err = pci_register_driver(&mite_driver);

	if(err == 0)
		mite_list_devices();

	return err;
}

static void __exit mite_cleanup(void)
{

	/* Unregister the PCI structure driver */
	pci_unregister_driver(&mite_driver);

	/* Just paranoia... */
	while(&mite_devices != mite_devices.next) {
		struct list_head *this = mite_devices.next;
		struct mite_struct *mite =
			list_entry(this, struct mite_struct, list);

		list_del(this);
		kfree(mite);
	}
}

MODULE_LICENSE("GPL");
module_init(mite_init);
module_exit(mite_cleanup);

EXPORT_SYMBOL_GPL(mite_dma_arm);
EXPORT_SYMBOL_GPL(mite_dma_disarm);
EXPORT_SYMBOL_GPL(mite_sync_input_dma);
EXPORT_SYMBOL_GPL(mite_sync_output_dma);
EXPORT_SYMBOL_GPL(mite_setup);
EXPORT_SYMBOL_GPL(mite_unsetup);
EXPORT_SYMBOL_GPL(mite_list_devices);
EXPORT_SYMBOL_GPL(mite_request_channel_in_range);
EXPORT_SYMBOL_GPL(mite_release_channel);
EXPORT_SYMBOL_GPL(mite_prep_dma);
EXPORT_SYMBOL_GPL(mite_buf_change);
EXPORT_SYMBOL_GPL(mite_bytes_written_to_memory_lb);
EXPORT_SYMBOL_GPL(mite_bytes_written_to_memory_ub);
EXPORT_SYMBOL_GPL(mite_bytes_read_from_memory_lb);
EXPORT_SYMBOL_GPL(mite_bytes_read_from_memory_ub);
EXPORT_SYMBOL_GPL(mite_bytes_in_transit);
EXPORT_SYMBOL_GPL(mite_get_status);
EXPORT_SYMBOL_GPL(mite_done);
#ifdef CONFIG_DEBUG_MITE
EXPORT_SYMBOL_GPL(mite_decode);
EXPORT_SYMBOL_GPL(mite_dump_regs);
#endif /* CONFIG_DEBUG_MITE */

--Boundary-00=_pIXvNdQrmwmzrNO
Content-Type: text/x-csrc;
  charset="ISO-8859-1";
  name="mite.c-COMEDI"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mite.c-COMEDI"

/*
    comedi/drivers/mite.c
    Hardware driver for NI Mite PCI interface chip

    COMEDI - Linux Control and Measurement Device Interface
    Copyright (C) 1997-2002 David A. Schleef <ds@domain.hid>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

*/

/*
	The PCI-MIO E series driver was originally written by
	Tomasz Motylewski <...>, and ported to comedi by ds.

	References for specifications:

	   321747b.pdf  Register Level Programmer Manual (obsolete)
	   321747c.pdf  Register Level Programmer Manual (new)
	   DAQ-STC reference manual

	Other possibly relevant info:

	   320517c.pdf  User manual (obsolete)
	   320517f.pdf  User manual (new)
	   320889a.pdf  delete
	   320906c.pdf  maximum signal ratings
	   321066a.pdf  about 16x
	   321791a.pdf  discontinuation of at-mio-16e-10 rev. c
	   321808a.pdf  about at-mio-16e-10 rev P
	   321837a.pdf  discontinuation of at-mio-16de-10 rev d
	   321838a.pdf  about at-mio-16de-10 rev N

	ISSUES:

*/

//#define USE_KMALLOC

#include "mite.h"

#include "comedi_fc.h"
#include "comedi_pci.h"
#include <linux/comedidev.h>

#include <asm/system.h>

#define PCI_MITE_SIZE		4096
#define PCI_DAQ_SIZE		4096
#define PCI_DAQ_SIZE_660X       8192

MODULE_LICENSE("GPL");

struct mite_struct *mite_devices = NULL;

#define TOP_OF_PAGE(x) ((x)|(~(PAGE_MASK)))

void mite_init(void)
{
	struct pci_dev *pcidev;
	struct mite_struct *mite;

	for (pcidev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, NULL);
		pcidev != NULL;
		pcidev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pcidev)) {
		if (pcidev->vendor == PCI_VENDOR_ID_NATINST) {
			unsigned i;

			mite = kzalloc(sizeof(*mite), GFP_KERNEL);
			if (!mite) {
				printk("mite: allocation failed\n");
				pci_dev_put(pcidev);
				return;
			}
			spin_lock_init(&mite->lock);
			mite->pcidev = pci_dev_get(pcidev);
			for (i = 0; i < MAX_MITE_DMA_CHANNELS; ++i) {
				mite->channels[i].mite = mite;
				mite->channels[i].channel = i;
				mite->channels[i].done = 1;
			}
			mite->next = mite_devices;
			mite_devices = mite;
		}
	}
}

static void dump_chip_signature(u32 csigr_bits)
{
	printk("mite: version = %i, type = %i, mite mode = %i, interface mode = %i\n", mite_csigr_version(csigr_bits), mite_csigr_type(csigr_bits), mite_csigr_mmode(csigr_bits), mite_csigr_imode(csigr_bits));
	printk("mite: num channels = %i, write post fifo depth = %i, wins = %i, iowins = %i\n", mite_csigr_dmac(csigr_bits), mite_csigr_wpdep(csigr_bits), mite_csigr_wins(csigr_bits), mite_csigr_iowins(csigr_bits));
}

unsigned mite_fifo_size(struct mite_struct * mite, unsigned channel)
{
	unsigned fcr_bits = readl(mite->mite_io_addr +
		MITE_FCR(channel));
	unsigned empty_count = (fcr_bits >> 16) & 0xff;
	unsigned full_count = fcr_bits & 0xff;
	return empty_count + full_count;
}

int mite_setup2(struct mite_struct *mite, unsigned use_iodwbsr_1)
{
	unsigned long length;
	resource_size_t addr;
	int i;
	u32 csigr_bits;
	unsigned unknown_dma_burst_bits;

	if (comedi_pci_enable(mite->pcidev, "mite")) {
		printk("error enabling mite and requesting io regions\n");
		return -EIO;
	}
	pci_set_master(mite->pcidev);

	addr = pci_resource_start(mite->pcidev, 0);
	mite->mite_phys_addr = addr;
	mite->mite_io_addr = ioremap(addr, PCI_MITE_SIZE);
	if (!mite->mite_io_addr) {
		printk("failed to remap mite io memory address\n");
		return -ENOMEM;
	}
	printk("MITE:0x%08llx mapped to %p ",
		(unsigned long long)mite->mite_phys_addr, mite->mite_io_addr);

	addr = pci_resource_start(mite->pcidev, 1);
	mite->daq_phys_addr = addr;
	length = pci_resource_len(mite->pcidev, 1);
	// In case of a 660x board, DAQ size is 8k instead of 4k (see as shown by lspci output)
	mite->daq_io_addr = ioremap(mite->daq_phys_addr, length);
	if (!mite->daq_io_addr) {
		printk("failed to remap daq io memory address\n");
		return -ENOMEM;
	}
	printk("DAQ:0x%08llx mapped to %p\n",
		(unsigned long long)mite->daq_phys_addr, mite->daq_io_addr);

	if (use_iodwbsr_1) {
		writel(0, mite->mite_io_addr + MITE_IODWBSR);
		printk("mite: using I/O Window Base Size register 1\n");
		writel(mite->
			daq_phys_addr | WENAB |
			MITE_IODWBSR_1_WSIZE_bits(length),
			mite->mite_io_addr + MITE_IODWBSR_1);
		writel(0, mite->mite_io_addr + MITE_IODWCR_1);
	} else {
		writel(mite->daq_phys_addr | WENAB,
			mite->mite_io_addr + MITE_IODWBSR);
	}
	/* make sure dma bursts work.  I got this from running a bus analyzer
	   on a pxi-6281 and a pxi-6713.  6713 powered up with register value
	   of 0x61f and bursts worked.  6281 powered up with register value of
	   0x1f and bursts didn't work.  The NI windows driver reads the register,
	   then does a bitwise-or of 0x600 with it and writes it back.
	 */
	unknown_dma_burst_bits =
		readl(mite->mite_io_addr + MITE_UNKNOWN_DMA_BURST_REG);
	unknown_dma_burst_bits |= UNKNOWN_DMA_BURST_ENABLE_BITS;
	writel(unknown_dma_burst_bits,
		mite->mite_io_addr + MITE_UNKNOWN_DMA_BURST_REG);

	csigr_bits = readl(mite->mite_io_addr + MITE_CSIGR);
	mite->num_channels = mite_csigr_dmac(csigr_bits);
	if (mite->num_channels > MAX_MITE_DMA_CHANNELS) {
		printk("mite: bug? chip claims to have %i dma channels.  Setting to %i.\n", mite->num_channels, MAX_MITE_DMA_CHANNELS);
		mite->num_channels = MAX_MITE_DMA_CHANNELS;
	}
	dump_chip_signature(csigr_bits);
	for (i = 0; i < mite->num_channels; i++) {
		writel(CHOR_DMARESET, mite->mite_io_addr + MITE_CHOR(i));
		/* disable interrupts */
		writel(CHCR_CLR_DMA_IE | CHCR_CLR_LINKP_IE | CHCR_CLR_SAR_IE |
			CHCR_CLR_DONE_IE | CHCR_CLR_MRDY_IE | CHCR_CLR_DRDY_IE |
			CHCR_CLR_LC_IE | CHCR_CLR_CONT_RB_IE,
			mite->mite_io_addr + MITE_CHCR(i));
	}
	mite->fifo_size = mite_fifo_size(mite, 0);
	printk("mite: fifo size is %i.\n", mite->fifo_size);
	mite->used = 1;

	return 0;
}

int mite_setup(struct mite_struct *mite)
{
	return mite_setup2(mite, 0);
}

void mite_cleanup(void)
{
	struct mite_struct *mite, *next;

	for (mite = mite_devices; mite; mite = next) {
		pci_dev_put(mite->pcidev);
		next = mite->next;
		kfree(mite);
	}
}

void mite_unsetup(struct mite_struct *mite)
{
	//unsigned long offset, start, length;

	if (!mite)
		return;

	if (mite->mite_io_addr) {
		iounmap(mite->mite_io_addr);
		mite->mite_io_addr = NULL;
	}
	if (mite->daq_io_addr) {
		iounmap(mite->daq_io_addr);
		mite->daq_io_addr = NULL;
	}
	if (mite->mite_phys_addr) {
		comedi_pci_disable(mite->pcidev);
		mite->mite_phys_addr = 0;
	}

	mite->used = 0;
}

void mite_list_devices(void)
{
	struct mite_struct *mite, *next;

	printk("Available NI device IDs:");
	if (mite_devices)
		for (mite = mite_devices; mite; mite = next) {
			next = mite->next;
			printk(" 0x%04x", mite_device_id(mite));
			if (mite->used)
				printk("(used)");
		}
	printk("\n");

}

struct mite_channel *mite_request_channel_in_range(struct mite_struct *mite,
	struct mite_dma_descriptor_ring *ring, unsigned min_channel,
	unsigned max_channel)
{
	int i;
	unsigned long flags;
	struct mite_channel *channel = NULL;

	// spin lock so mite_release_channel can be called safely from interrupts
	comedi_spin_lock_irqsave(&mite->lock, flags);
	for (i = min_channel; i <= max_channel; ++i) {
		if (mite->channel_allocated[i] == 0) {
			mite->channel_allocated[i] = 1;
			channel = &mite->channels[i];
			channel->ring = ring;
			break;
		}
	}
	comedi_spin_unlock_irqrestore(&mite->lock, flags);
	return channel;
}

void mite_release_channel(struct mite_channel *mite_chan)
{
	struct mite_struct *mite = mite_chan->mite;
	unsigned long flags;

	// spin lock to prevent races with mite_request_channel
	comedi_spin_lock_irqsave(&mite->lock, flags);
	if (mite->channel_allocated[mite_chan->channel]) {
		mite_dma_disarm(mite_chan);
		mite_dma_reset(mite_chan);
/* disable all channel's interrupts (do it after disarm/reset so
MITE_CHCR reg isn't changed while dma is still active!) */
		writel(CHCR_CLR_DMA_IE | CHCR_CLR_LINKP_IE |
			CHCR_CLR_SAR_IE | CHCR_CLR_DONE_IE |
			CHCR_CLR_MRDY_IE | CHCR_CLR_DRDY_IE |
			CHCR_CLR_LC_IE | CHCR_CLR_CONT_RB_IE,
			mite->mite_io_addr + MITE_CHCR(mite_chan->channel));
		mite->channel_allocated[mite_chan->channel] = 0;
		mite_chan->ring = NULL;
		mmiowb();
	}
	comedi_spin_unlock_irqrestore(&mite->lock, flags);
}

void mite_dma_arm(struct mite_channel *mite_chan)
{
	struct mite_struct *mite = mite_chan->mite;
	int chor;
	unsigned long flags;

	MDPRINTK("mite_dma_arm ch%i\n", channel);
	/* memory barrier is intended to insure any twiddling with the buffer
	   is done before writing to the mite to arm dma transfer */
	smp_mb();
	/* arm */
	chor = CHOR_START;
	comedi_spin_lock_irqsave(&mite->lock, flags);
	mite_chan->done = 0;
	writel(chor, mite->mite_io_addr + MITE_CHOR(mite_chan->channel));
	mmiowb();
	comedi_spin_unlock_irqrestore(&mite->lock, flags);
//      mite_dma_tcr(mite, channel);
}

/**************************************/

int mite_buf_change(struct mite_dma_descriptor_ring *ring, comedi_async * async)
{
	unsigned int n_links;
	int i;

	if (ring->descriptors) {
		dma_free_coherent(ring->hw_dev,
			ring->n_links * sizeof(struct mite_dma_descriptor),
			ring->descriptors, ring->descriptors_dma_addr);
	}
	ring->descriptors = NULL;
	ring->descriptors_dma_addr = 0;
	ring->n_links = 0;

	if (async->prealloc_bufsz == 0) {
		return 0;
	}
	n_links = async->prealloc_bufsz >> PAGE_SHIFT;

	MDPRINTK("ring->hw_dev=%p, n_links=0x%04x\n", ring->hw_dev, n_links);

	ring->descriptors =
		dma_alloc_coherent(ring->hw_dev,
		n_links * sizeof(struct mite_dma_descriptor),
		&ring->descriptors_dma_addr, GFP_KERNEL);
	if (!ring->descriptors) {
		printk("mite: ring buffer allocation failed\n");
		return -ENOMEM;
	}
	ring->n_links = n_links;

	for (i = 0; i < n_links; i++) {
		ring->descriptors[i].count = cpu_to_le32(PAGE_SIZE);
		ring->descriptors[i].addr =
			cpu_to_le32(async->buf_page_list[i].dma_addr);
		ring->descriptors[i].next =
			cpu_to_le32(ring->descriptors_dma_addr + (i +
				1) * sizeof(struct mite_dma_descriptor));
	}
	ring->descriptors[n_links - 1].next =
		cpu_to_le32(ring->descriptors_dma_addr);
	/* barrier is meant to insure that all the writes to the dma descriptors
	   have completed before the dma controller is commanded to read them */
	smp_wmb();
	return 0;
}

void mite_prep_dma(struct mite_channel *mite_chan,
	unsigned int num_device_bits, unsigned int num_memory_bits)
{
	unsigned int chor, chcr, mcr, dcr, lkcr;
	struct mite_struct *mite = mite_chan->mite;

	MDPRINTK("mite_prep_dma ch%i\n", mite_chan->channel);

	/* reset DMA and FIFO */
	chor = CHOR_DMARESET | CHOR_FRESET;
	writel(chor, mite->mite_io_addr + MITE_CHOR(mite_chan->channel));

	/* short link chaining mode */
	chcr = CHCR_SET_DMA_IE | CHCR_LINKSHORT | CHCR_SET_DONE_IE |
		CHCR_BURSTEN;
	/*
	 * Link Complete Interrupt: interrupt every time a link
	 * in MITE_RING is completed. This can generate a lot of
	 * extra interrupts, but right now we update the values
	 * of buf_int_ptr and buf_int_count at each interrupt.  A
	 * better method is to poll the MITE before each user
	 * "read()" to calculate the number of bytes available.
	 */
	chcr |= CHCR_SET_LC_IE;
	if (num_memory_bits == 32 && num_device_bits == 16) {
		/* Doing a combined 32 and 16 bit byteswap gets the 16 bit samples into the fifo in the right order.
		   Tested doing 32 bit memory to 16 bit device transfers to the analog out of a pxi-6281,
		   which has mite version = 1, type = 4.  This also works for dma reads from the counters
		   on e-series boards.  */
		chcr |= CHCR_BYTE_SWAP_DEVICE | CHCR_BYTE_SWAP_MEMORY;
	}
	if (mite_chan->dir == COMEDI_INPUT) {
		chcr |= CHCR_DEV_TO_MEM;
	}
	writel(chcr, mite->mite_io_addr + MITE_CHCR(mite_chan->channel));

	/* to/from memory */
	mcr = CR_RL(64) | CR_ASEQUP;
	switch (num_memory_bits) {
	case 8:
		mcr |= CR_PSIZE8;
		break;
	case 16:
		mcr |= CR_PSIZE16;
		break;
	case 32:
		mcr |= CR_PSIZE32;
		break;
	default:
		rt_printk
			("mite: bug! invalid mem bit width for dma transfer\n");
		break;
	}
	writel(mcr, mite->mite_io_addr + MITE_MCR(mite_chan->channel));

	/* from/to device */
	dcr = CR_RL(64) | CR_ASEQUP;
	dcr |= CR_PORTIO | CR_AMDEVICE | CR_REQSDRQ(mite_chan->channel);
	switch (num_device_bits) {
	case 8:
		dcr |= CR_PSIZE8;
		break;
	case 16:
		dcr |= CR_PSIZE16;
		break;
	case 32:
		dcr |= CR_PSIZE32;
		break;
	default:
		rt_printk
			("mite: bug! invalid dev bit width for dma transfer\n");
		break;
	}
	writel(dcr, mite->mite_io_addr + MITE_DCR(mite_chan->channel));

	/* reset the DAR */
	writel(0, mite->mite_io_addr + MITE_DAR(mite_chan->channel));

	/* the link is 32bits */
	lkcr = CR_RL(64) | CR_ASEQUP | CR_PSIZE32;
	writel(lkcr, mite->mite_io_addr + MITE_LKCR(mite_chan->channel));

	/* starting address for link chaining */
	writel(mite_chan->ring->descriptors_dma_addr,
		mite->mite_io_addr + MITE_LKAR(mite_chan->channel));

	MDPRINTK("exit mite_prep_dma\n");
}

u32 mite_device_bytes_transferred(struct mite_channel *mite_chan)
{
	struct mite_struct *mite = mite_chan->mite;
	return readl(mite->mite_io_addr + MITE_DAR(mite_chan->channel));
}

u32 mite_bytes_in_transit(struct mite_channel * mite_chan)
{
	struct mite_struct *mite = mite_chan->mite;
	return readl(mite->mite_io_addr +
		MITE_FCR(mite_chan->channel)) & 0x000000FF;
}

// returns lower bound for number of bytes transferred from device to memory
u32 mite_bytes_written_to_memory_lb(struct mite_channel * mite_chan)
{
	u32 device_byte_count;

	device_byte_count = mite_device_bytes_transferred(mite_chan);
	return device_byte_count - mite_bytes_in_transit(mite_chan);
}

// returns upper bound for number of bytes transferred from device to memory
u32 mite_bytes_written_to_memory_ub(struct mite_channel * mite_chan)
{
	u32 in_transit_count;

	in_transit_count = mite_bytes_in_transit(mite_chan);
	return mite_device_bytes_transferred(mite_chan) - in_transit_count;
}

// returns lower bound for number of bytes read from memory for transfer to device
u32 mite_bytes_read_from_memory_lb(struct mite_channel * mite_chan)
{
	u32 device_byte_count;

	device_byte_count = mite_device_bytes_transferred(mite_chan);
	return device_byte_count + mite_bytes_in_transit(mite_chan);
}

// returns upper bound for number of bytes read from memory for transfer to device
u32 mite_bytes_read_from_memory_ub(struct mite_channel * mite_chan)
{
	u32 in_transit_count;

	in_transit_count = mite_bytes_in_transit(mite_chan);
	return mite_device_bytes_transferred(mite_chan) + in_transit_count;
}

unsigned mite_dma_tcr(struct mite_channel *mite_chan)
{
	struct mite_struct *mite = mite_chan->mite;
	int tcr;
	int lkar;

	lkar = readl(mite->mite_io_addr + MITE_LKAR(mite_chan->channel));
	tcr = readl(mite->mite_io_addr + MITE_TCR(mite_chan->channel));
	MDPRINTK("mite_dma_tcr ch%i, lkar=0x%08x tcr=%d\n", mite_chan->channel,
		lkar, tcr);

	return tcr;
}

void mite_dma_disarm(struct mite_channel *mite_chan)
{
	struct mite_struct *mite = mite_chan->mite;
	unsigned chor;

	/* disarm */
	chor = CHOR_ABORT;
	writel(chor, mite->mite_io_addr + MITE_CHOR(mite_chan->channel));
}

int mite_sync_input_dma(struct mite_channel *mite_chan, comedi_async * async)
{
	int count;
	unsigned int nbytes, old_alloc_count;
	const unsigned bytes_per_scan = cfc_bytes_per_scan(async->subdevice);

	old_alloc_count = async->buf_write_alloc_count;
	// write alloc as much as we can
	comedi_buf_write_alloc(async, async->prealloc_bufsz);

	nbytes = mite_bytes_written_to_memory_lb(mite_chan);
	if ((int)(mite_bytes_written_to_memory_ub(mite_chan) -
			old_alloc_count) > 0) {
		rt_printk("mite: DMA overwrite of free area\n");
		async->events |= COMEDI_CB_OVERFLOW;
		return -1;
	}

	count = nbytes - async->buf_write_count;
	/* it's possible count will be negative due to
	 * conservative value returned by mite_bytes_written_to_memory_lb */
	if (count <= 0) {
		return 0;
	}
	comedi_buf_write_free(async, count);

	async->scan_progress += count;
	if (async->scan_progress >= bytes_per_scan) {
		async->scan_progress %= bytes_per_scan;
		async->events |= COMEDI_CB_EOS;
	}
	async->events |= COMEDI_CB_BLOCK;
	return 0;
}

int mite_sync_output_dma(struct mite_channel *mite_chan, comedi_async * async)
{
	int count;
	u32 nbytes_ub, nbytes_lb;
	unsigned int old_alloc_count;
	u32 stop_count =
		async->cmd.stop_arg * cfc_bytes_per_scan(async->subdevice);

	old_alloc_count = async->buf_read_alloc_count;
	// read alloc as much as we can
	comedi_buf_read_alloc(async, async->prealloc_bufsz);
	nbytes_lb = mite_bytes_read_from_memory_lb(mite_chan);
	if (async->cmd.stop_src == TRIG_COUNT &&
		(int)(nbytes_lb - stop_count) > 0)
		nbytes_lb = stop_count;
	nbytes_ub = mite_bytes_read_from_memory_ub(mite_chan);
	if (async->cmd.stop_src == TRIG_COUNT &&
		(int)(nbytes_ub - stop_count) > 0)
		nbytes_ub = stop_count;
	if ((int)(nbytes_ub - old_alloc_count) > 0) {
		rt_printk("mite: DMA underrun\n");
		async->events |= COMEDI_CB_OVERFLOW;
		return -1;
	}
	count = nbytes_lb - async->buf_read_count;
	if (count <= 0) {
		return 0;
	}
	if (count) {
		comedi_buf_read_free(async, count);
		async->events |= COMEDI_CB_BLOCK;
	}
	return 0;
}

unsigned mite_get_status(struct mite_channel *mite_chan)
{
	struct mite_struct *mite = mite_chan->mite;
	unsigned status;
	unsigned long flags;

	comedi_spin_lock_irqsave(&mite->lock, flags);
	status = readl(mite->mite_io_addr + MITE_CHSR(mite_chan->channel));
	if (status & CHSR_DONE) {
		mite_chan->done = 1;
		writel(CHOR_CLRDONE,
			mite->mite_io_addr + MITE_CHOR(mite_chan->channel));
	}
	mmiowb();
	comedi_spin_unlock_irqrestore(&mite->lock, flags);
	return status;
}

int mite_done(struct mite_channel *mite_chan)
{
	struct mite_struct *mite = mite_chan->mite;
	unsigned long flags;
	int done;

	mite_get_status(mite_chan);
	comedi_spin_lock_irqsave(&mite->lock, flags);
	done = mite_chan->done;
	comedi_spin_unlock_irqrestore(&mite->lock, flags);
	return done;
}

#ifdef DEBUG_MITE

static void mite_decode(char **bit_str, unsigned int bits);

/* names of bits in mite registers */

static const char *const mite_CHOR_strings[] = {
	"start", "cont", "stop", "abort",
	"freset", "clrlc", "clrrb", "clrdone",
	"clr_lpause", "set_lpause", "clr_send_tc",
	"set_send_tc", "12", "13", "14",
	"15", "16", "17", "18",
	"19", "20", "21", "22",
	"23", "24", "25", "26",
	"27", "28", "29", "30",
	"dmareset",
};

static const char *const mite_CHCR_strings[] = {
	"continue", "ringbuff", "2", "3",
	"4", "5", "6", "7",
	"8", "9", "10", "11",
	"12", "13", "bursten", "fifodis",
	"clr_cont_rb_ie", "set_cont_rb_ie", "clr_lc_ie", "set_lc_ie",
	"clr_drdy_ie", "set_drdy_ie", "clr_mrdy_ie", "set_mrdy_ie",
	"clr_done_ie", "set_done_ie", "clr_sar_ie", "set_sar_ie",
	"clr_linkp_ie", "set_linkp_ie", "clr_dma_ie", "set_dma_ie",
};

static const char *const mite_MCR_strings[] = {
	"amdevice", "1", "2", "3",
	"4", "5", "portio", "portvxi",
	"psizebyte", "psizehalf (byte & half = word)", "aseqxp1", "11",
	"12", "13", "blocken", "berhand",
	"reqsintlim/reqs0", "reqs1", "reqs2", "rd32",
	"rd512", "rl1", "rl2", "rl8",
	"24", "25", "26", "27",
	"28", "29", "30", "stopen",
};

static const char *const mite_DCR_strings[] = {
	"amdevice", "1", "2", "3",
	"4", "5", "portio", "portvxi",
	"psizebyte", "psizehalf (byte & half = word)", "aseqxp1", "aseqxp2",
	"aseqxp8", "13", "blocken", "berhand",
	"reqsintlim", "reqs1", "reqs2", "rd32",
	"rd512", "rl1", "rl2", "rl8",
	"23", "24", "25", "27",
	"28", "wsdevc", "wsdevs", "rwdevpack",
};

static const char *const mite_LKCR_strings[] = {
	"amdevice", "1", "2", "3",
	"4", "5", "portio", "portvxi",
	"psizebyte", "psizehalf (byte & half = word)", "asequp", "aseqdown",
	"12", "13", "14", "berhand",
	"16", "17", "18", "rd32",
	"rd512", "rl1", "rl2", "rl8",
	"24", "25", "26", "27",
	"28", "29", "30", "chngend",
};

static const char *const mite_CHSR_strings[] = {
	"d.err0", "d.err1", "m.err0", "m.err1",
	"l.err0", "l.err1", "drq0", "drq1",
	"end", "xferr", "operr0", "operr1",
	"stops", "habort", "sabort", "error",
	"16", "conts_rb", "18", "linkc",
	"20", "drdy", "22", "mrdy",
	"24", "done", "26", "sars",
	"28", "lpauses", "30", "int",
};

void mite_dump_regs(struct mite_channel *mite_chan)
{
	unsigned long mite_io_addr =
		(unsigned long)mite_chan->mite->mite_io_addr;
	unsigned long addr = 0;
	unsigned long temp = 0;

	printk("mite_dump_regs ch%i\n", mite_chan->channel);
	printk("mite address is  =0x%08lx\n", mite_io_addr);

	addr = mite_io_addr + MITE_CHOR(channel);
	printk("mite status[CHOR]at 0x%08lx =0x%08lx\n", addr, temp =
		readl(addr));
	mite_decode(mite_CHOR_strings, temp);
	addr = mite_io_addr + MITE_CHCR(channel);
	printk("mite status[CHCR]at 0x%08lx =0x%08lx\n", addr, temp =
		readl(addr));
	mite_decode(mite_CHCR_strings, temp);
	addr = mite_io_addr + MITE_TCR(channel);
	printk("mite status[TCR] at 0x%08lx =0x%08x\n", addr, readl(addr));
	addr = mite_io_addr + MITE_MCR(channel);
	printk("mite status[MCR] at 0x%08lx =0x%08lx\n", addr, temp =
		readl(addr));
	mite_decode(mite_MCR_strings, temp);

	addr = mite_io_addr + MITE_MAR(channel);
	printk("mite status[MAR] at 0x%08lx =0x%08x\n", addr, readl(addr));
	addr = mite_io_addr + MITE_DCR(channel);
	printk("mite status[DCR] at 0x%08lx =0x%08lx\n", addr, temp =
		readl(addr));
	mite_decode(mite_DCR_strings, temp);
	addr = mite_io_addr + MITE_DAR(channel);
	printk("mite status[DAR] at 0x%08lx =0x%08x\n", addr, readl(addr));
	addr = mite_io_addr + MITE_LKCR(channel);
	printk("mite status[LKCR]at 0x%08lx =0x%08lx\n", addr, temp =
		readl(addr));
	mite_decode(mite_LKCR_strings, temp);
	addr = mite_io_addr + MITE_LKAR(channel);
	printk("mite status[LKAR]at 0x%08lx =0x%08x\n", addr, readl(addr));

	addr = mite_io_addr + MITE_CHSR(channel);
	printk("mite status[CHSR]at 0x%08lx =0x%08lx\n", addr, temp =
		readl(addr));
	mite_decode(mite_CHSR_strings, temp);
	addr = mite_io_addr + MITE_FCR(channel);
	printk("mite status[FCR] at 0x%08lx =0x%08x\n\n", addr, readl(addr));
}

static void mite_decode(char **bit_str, unsigned int bits)
{
	int i;

	for (i = 31; i >= 0; i--) {
		if (bits & (1 << i)) {
			printk(" %s", bit_str[i]);
		}
	}
	printk("\n");
}
#endif

#ifdef MODULE
int __init init_module(void)
{
	mite_init();
	mite_list_devices();

	return 0;
}

void __exit cleanup_module(void)
{
	mite_cleanup();
}

EXPORT_SYMBOL(mite_dma_tcr);
EXPORT_SYMBOL(mite_dma_arm);
EXPORT_SYMBOL(mite_dma_disarm);
EXPORT_SYMBOL(mite_sync_input_dma);
EXPORT_SYMBOL(mite_sync_output_dma);
EXPORT_SYMBOL(mite_setup);
EXPORT_SYMBOL(mite_setup2);
EXPORT_SYMBOL(mite_unsetup);
#if 0
EXPORT_SYMBOL(mite_kvmem_segment_load);
EXPORT_SYMBOL(mite_ll_from_kvmem);
EXPORT_SYMBOL(mite_setregs);
#endif
EXPORT_SYMBOL(mite_devices);
EXPORT_SYMBOL(mite_list_devices);
EXPORT_SYMBOL(mite_request_channel_in_range);
EXPORT_SYMBOL(mite_release_channel);
EXPORT_SYMBOL(mite_prep_dma);
EXPORT_SYMBOL(mite_buf_change);
EXPORT_SYMBOL(mite_bytes_written_to_memory_lb);
EXPORT_SYMBOL(mite_bytes_written_to_memory_ub);
EXPORT_SYMBOL(mite_bytes_read_from_memory_lb);
EXPORT_SYMBOL(mite_bytes_read_from_memory_ub);
EXPORT_SYMBOL(mite_bytes_in_transit);
EXPORT_SYMBOL(mite_get_status);
EXPORT_SYMBOL(mite_done);
#ifdef DEBUG_MITE
EXPORT_SYMBOL(mite_decode);
EXPORT_SYMBOL(mite_dump_regs);
#endif

#endif

--Boundary-00=_pIXvNdQrmwmzrNO
Content-Type: text/x-csrc;
  charset="ISO-8859-1";
  name="adl_pci9118.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="adl_pci9118.c"

/*
 *  comedi/drivers/adl_pci9118.c
 *
 *  hardware driver for ADLink cards:
 *   card:   PCI-9118DG, PCI-9118HG, PCI-9118HR
 *   driver: pci9118dg,  pci9118hg,  pci9118hr
 *
 * Author: Michal Dobes <dobes@domain.hid>
 *
*/
/*
Driver: adl_pci9118
Description: Adlink PCI-9118DG, PCI-9118HG, PCI-9118HR
Author: Michal Dobes <dobes@domain.hid>
Devices: [ADLink] PCI-9118DG (pci9118dg), PCI-9118HG (pci9118hg),
  PCI-9118HR (pci9118hr)
Status: works

This driver supports AI, AO, DI and DO subdevices.
AI subdevice supports cmd and insn interface,
other subdevices support only insn interface.
For AI:
- If cmd->scan_begin_src=TRIG_EXT then trigger input is TGIN (pin 46).
- If cmd->convert_src=TRIG_EXT then trigger input is EXTTRG (pin 44).
- If cmd->start_src/stop_src=TRIG_EXT then trigger input is TGIN (pin 46).
- It is not neccessary to have cmd.scan_end_arg=cmd.chanlist_len but
  cmd.scan_end_arg modulo cmd.chanlist_len must by 0.
- If return value of cmdtest is 5 then you've bad channel list
  (it isn't possible mixture S.E. and DIFF inputs or bipolar and unipolar
  ranges).

There are some hardware limitations:
a) You cann't use mixture of unipolar/bipoar ranges or differencial/single
   ended inputs.
b) DMA transfers must have the length aligned to two samples (32 bit),
   so there is some problems if cmd->chanlist_len is odd. This driver tries
   bypass this with adding one sample to the end of the every scan and discard
   it on output but this cann't be used if cmd->scan_begin_src=TRIG_FOLLOW
   and is used flag TRIG_WAKE_EOS, then driver switch to interrupt driven mode
   with interrupt after every sample.
c) If isn't used DMA then you can use only mode where
   cmd->scan_begin_src=TRIG_FOLLOW.

Configuration options:
  [0] - PCI bus of device (optional)
  [1] - PCI slot of device (optional)
          If bus/slot is not specified, then first available PCI
          card will be used.
  [2] - 0= standard 8 DIFF/16 SE channels configuration
        n= external multiplexer connected, 1<=n<=256
  [3] - 0=autoselect DMA or EOC interrupts operation
        1=disable DMA mode
        3=disable DMA and INT, only insn interface will work
  [4] - sample&hold signal - card can generate signal for external S&H board
        0=use SSHO (pin 45) signal is generated in onboard hardware S&H logic
        0!=use ADCHN7 (pin 23) signal is generated from driver, number
           say how long delay is requested in ns and sign polarity of the hold
           (in this case external multiplexor can serve only 128 channels)
  [5] - 0=stop measure on all hardware errors
        2|=ignore ADOR - A/D Overrun status
	8|=ignore Bover - A/D Burst Mode Overrun status
	256|=ignore nFull - A/D FIFO Full status

*/
#include <linux/comedidev.h>

#include <linux/delay.h>

#include "amcc_s5933.h"
#include "8253.h"
#include "comedi_pci.h"
#include "comedi_fc.h"

/* paranoid checks are broken */
#undef PCI9118_PARANOIDCHECK	/* if defined, then is used code which control correct channel number on every 12 bit sample */

#undef PCI9118_EXTDEBUG		/* if defined then driver prints a lot of messages */

#undef DPRINTK
#ifdef PCI9118_EXTDEBUG
#define DPRINTK(fmt, args...) rt_printk(fmt, ## args)
#else
#define DPRINTK(fmt, args...)
#endif

#define IORANGE_9118 	64	/* I hope */
#define PCI9118_CHANLEN	255	/* len of chanlist, some source say 256, but reality looks like 255 :-( */

#define PCI9118_CNT0	0x00	/* R/W: 8254 couter 0 */
#define PCI9118_CNT1	0x04	/* R/W: 8254 couter 0 */
#define PCI9118_CNT2	0x08	/* R/W: 8254 couter 0 */
#define PCI9118_CNTCTRL	0x0c	/* W:   8254 counter control */
#define PCI9118_AD_DATA	0x10	/* R:   A/D data */
#define PCI9118_DA1	0x10	/* W:   D/A registers */
#define PCI9118_DA2	0x14
#define PCI9118_ADSTAT	0x18	/* R:   A/D status register */
#define PCI9118_ADCNTRL	0x18	/* W:   A/D control register */
#define PCI9118_DI	0x1c	/* R:   digi input register */
#define PCI9118_DO	0x1c	/* W:   digi output register */
#define PCI9118_SOFTTRG	0x20	/* W:   soft trigger for A/D */
#define PCI9118_GAIN	0x24	/* W:   A/D gain/channel register */
#define PCI9118_BURST	0x28	/* W:   A/D burst number register */
#define PCI9118_SCANMOD	0x2c	/* W:   A/D auto scan mode */
#define PCI9118_ADFUNC	0x30	/* W:   A/D function register */
#define PCI9118_DELFIFO	0x34	/* W:   A/D data FIFO reset */
#define PCI9118_INTSRC	0x38	/* R:   interrupt reason register */
#define PCI9118_INTCTRL	0x38	/* W:   interrupt control register */

// bits from A/D control register (PCI9118_ADCNTRL)
#define AdControl_UniP	0x80	/* 1=bipolar, 0=unipolar */
#define AdControl_Diff	0x40	/* 1=differential, 0= single end inputs */
#define AdControl_SoftG	0x20	/* 1=8254 counter works, 0=counter stops */
#define	AdControl_ExtG	0x10	/* 1=8254 countrol controlled by TGIN(pin 46), 0=controled by SoftG */
#define AdControl_ExtM	0x08	/* 1=external hardware trigger (pin 44), 0=internal trigger */
#define AdControl_TmrTr	0x04	/* 1=8254 is iternal trigger source, 0=software trigger is source (register PCI9118_SOFTTRG) */
#define AdControl_Int	0x02	/* 1=enable INT, 0=disable */
#define AdControl_Dma	0x01	/* 1=enable DMA, 0=disable */

// bits from A/D function register (PCI9118_ADFUNC)
#define AdFunction_PDTrg	0x80	/* 1=positive, 0=negative digital trigger (only positive is correct) */
#define AdFunction_PETrg	0x40	/* 1=positive, 0=negative external trigger (only positive is correct) */
#define AdFunction_BSSH		0x20	/* 1=with sample&hold, 0=without */
#define AdFunction_BM		0x10	/* 1=burst mode, 0=normal mode */
#define AdFunction_BS		0x08	/* 1=burst mode start, 0=burst mode stop */
#define AdFunction_PM		0x04	/* 1=post trigger mode, 0=not post trigger */
#define AdFunction_AM		0x02	/* 1=about trigger mode, 0=not about trigger */
#define AdFunction_Start	0x01	/* 1=trigger start, 0=trigger stop */

// bits from A/D status register (PCI9118_ADSTAT)
#define AdStatus_nFull	0x100	/* 0=FIFO full (fatal), 1=not full */
#define AdStatus_nHfull	0x080	/* 0=FIFO half full, 1=FIFO not half full */
#define AdStatus_nEpty	0x040	/* 0=FIFO empty, 1=FIFO not empty */
#define AdStatus_Acmp	0x020	/*  */
#define AdStatus_DTH	0x010	/* 1=external digital trigger */
#define AdStatus_Bover	0x008	/* 1=burst mode overrun (fatal) */
#define AdStatus_ADOS	0x004	/* 1=A/D over speed (warning) */
#define AdStatus_ADOR	0x002	/* 1=A/D overrun (fatal) */
#define AdStatus_ADrdy	0x001	/* 1=A/D already ready, 0=not ready */

// bits for interrupt reason and control (PCI9118_INTSRC, PCI9118_INTCTRL)
// 1=interrupt occur, enable source,  0=interrupt not occur, disable source
#define Int_Timer	0x08	/* timer interrupt */
#define Int_About	0x04	/* about trigger complete */
#define Int_Hfull	0x02	/* A/D FIFO hlaf full */
#define Int_DTrg	0x01	/* external digital trigger */

#define START_AI_EXT	0x01	/* start measure on external trigger */
#define STOP_AI_EXT	0x02	/* stop measure on external trigger */
#define START_AI_INT	0x04	/* start measure on internal trigger */
#define STOP_AI_INT	0x08	/* stop measure on internal trigger */

#define EXTTRG_AI	0	/* ext trg is used by AI */

static const comedi_lrange range_pci9118dg_hr = { 8, {
			BIP_RANGE(5),
			BIP_RANGE(2.5),
			BIP_RANGE(1.25),
			BIP_RANGE(0.625),
			UNI_RANGE(10),
			UNI_RANGE(5),
			UNI_RANGE(2.5),
			UNI_RANGE(1.25)
	}
};

static const comedi_lrange range_pci9118hg = { 8, {
			BIP_RANGE(5),
			BIP_RANGE(0.5),
			BIP_RANGE(0.05),
			BIP_RANGE(0.005),
			UNI_RANGE(10),
			UNI_RANGE(1),
			UNI_RANGE(0.1),
			UNI_RANGE(0.01)
	}
};

#define PCI9118_BIPOLAR_RANGES	4	/* used for test on mixture of BIP/UNI ranges */

static int pci9118_attach(comedi_device * dev, comedi_devconfig * it);
static int pci9118_detach(comedi_device * dev);

typedef struct {
	const char *name;	// board name
	int vendor_id;		// PCI vendor a device ID of card
	int device_id;
	int iorange_amcc;	// iorange for own S5933 region
	int iorange_9118;	// pass thru card region size
	int n_aichan;		// num of A/D chans
	int n_aichand;		// num of A/D chans in diff mode
	int mux_aichan;		// num of A/D chans with external multiplexor
	int n_aichanlist;	// len of chanlist
	int n_aochan;		// num of D/A chans
	int ai_maxdata;		// resolution of A/D
	int ao_maxdata;		// resolution of D/A
	const comedi_lrange *rangelist_ai;	// rangelist for A/D
	const comedi_lrange *rangelist_ao;	// rangelist for D/A
	unsigned int ai_ns_min;	// max sample speed of card v ns
	unsigned int ai_pacer_min;	// minimal pacer value (c1*c2 or c1 in burst)
	int half_fifo_size;	// size of FIFO/2

} boardtype;

static DEFINE_PCI_DEVICE_TABLE(pci9118_pci_table) = {
	{PCI_VENDOR_ID_AMCC, 0x80d9, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
	{0}
};

MODULE_DEVICE_TABLE(pci, pci9118_pci_table);

static const boardtype boardtypes[] = {
	{"pci9118dg", PCI_VENDOR_ID_AMCC, 0x80d9,
			AMCC_OP_REG_SIZE, IORANGE_9118,
			16, 8, 256, PCI9118_CHANLEN, 2, 0x0fff, 0x0fff,
			&range_pci9118dg_hr, &range_bipolar10,
		3000, 12, 512},
	{"pci9118hg", PCI_VENDOR_ID_AMCC, 0x80d9,
			AMCC_OP_REG_SIZE, IORANGE_9118,
			16, 8, 256, PCI9118_CHANLEN, 2, 0x0fff, 0x0fff,
			&range_pci9118hg, &range_bipolar10,
		3000, 12, 512},
	{"pci9118hr", PCI_VENDOR_ID_AMCC, 0x80d9,
			AMCC_OP_REG_SIZE, IORANGE_9118,
			16, 8, 256, PCI9118_CHANLEN, 2, 0xffff, 0x0fff,
			&range_pci9118dg_hr, &range_bipolar10,
		10000, 40, 512},
};

#define n_boardtypes (sizeof(boardtypes)/sizeof(boardtype))

static comedi_driver driver_pci9118 = {
      driver_name:"adl_pci9118",
      module:THIS_MODULE,
      attach:pci9118_attach,
      detach:pci9118_detach,
      num_names:n_boardtypes,
      board_name:&boardtypes[0].name,
      offset:sizeof(boardtype),
};

COMEDI_PCI_INITCLEANUP(driver_pci9118, pci9118_pci_table);

typedef struct {
	unsigned long iobase_a;	// base+size for AMCC chip
	unsigned int master;	// master capable
	struct pci_dev *pcidev;	// ptr to actual pcidev
	unsigned int usemux;	// we want to use external multiplexor!
#ifdef PCI9118_PARANOIDCHECK
	unsigned short chanlist[PCI9118_CHANLEN + 1];	// list of scaned channel
	unsigned char chanlistlen;	// number of scanlist
#endif
	unsigned char AdControlReg;	// A/D control register
	unsigned char IntControlReg;	// Interrupt control register
	unsigned char AdFunctionReg;	// A/D function register
	char valid;		// driver is ok
	char ai_neverending;	// we do unlimited AI
	unsigned int i8254_osc_base;	// frequence of onboard oscilator
	unsigned int ai_do;	// what do AI? 0=nothing, 1 to 4 mode
	unsigned int ai_act_scan;	// how many scans we finished
	unsigned int ai_buf_ptr;	// data buffer ptr in samples
	unsigned int ai_n_chan;	// how many channels is measured
	unsigned int ai_n_scanlen;	// len of actual scanlist
	unsigned int ai_n_realscanlen;	// what we must transfer for one outgoing scan include front/back adds
	unsigned int ai_act_dmapos;	// position in actual real stream
	unsigned int ai_add_front;	// how many channels we must add before scan to satisfy S&H?
	unsigned int ai_add_back;	// how many channels we must add before scan to satisfy DMA?
	unsigned int *ai_chanlist;	// actaul chanlist
	unsigned int ai_timer1;
	unsigned int ai_timer2;
	unsigned int ai_flags;
	char ai12_startstop;	// measure can start/stop on external trigger
	unsigned int ai_divisor1, ai_divisor2;	// divisors for start of measure on external start
	unsigned int ai_data_len;
	sampl_t *ai_data;
	sampl_t ao_data[2];	// data output buffer
	unsigned int ai_scans;	// number of scans to do
	char dma_doublebuf;	// we can use double buffring
	unsigned int dma_actbuf;	// which buffer is used now
	sampl_t *dmabuf_virt[2];	// pointers to begin of DMA buffer
	unsigned long dmabuf_hw[2];	// hw address of DMA buff
	unsigned int dmabuf_size[2];	// size of dma buffer in bytes
	unsigned int dmabuf_use_size[2];	// which size we may now used for transfer
	unsigned int dmabuf_used_size[2];	// which size was trully used
	unsigned int dmabuf_panic_size[2];
	unsigned int dmabuf_samples[2];	// size in samples
	int dmabuf_pages[2];	// number of pages in buffer
	unsigned char cnt0_users;	// bit field of 8254 CNT0 users (0-unused, 1-AO, 2-DI, 3-DO)
	unsigned char exttrg_users;	// bit field of external trigger users (0-AI, 1-AO, 2-DI, 3-DO)
	unsigned int cnt0_divisor;	// actual CNT0 divisor
	void (*int_ai_func) (comedi_device *, comedi_subdevice *, unsigned short, unsigned int, unsigned short);	// ptr to actual interrupt AI function
	unsigned char ai16bits;	// =1 16 bit card
	unsigned char usedma;	// =1 use DMA transfer and not INT
	unsigned char useeoshandle;	// =1 change WAKE_EOS DMA transfer to fit on every second
	unsigned char usessh;	// =1 turn on S&H support
	int softsshdelay;	// >0 use software S&H, numer is requested delay in ns
	unsigned char softsshsample;	// polarity of S&H signal in sample state
	unsigned char softsshhold;	// polarity of S&H signal in hold state
	unsigned int ai_maskerr;	// which warning was printed
	unsigned int ai_maskharderr;	// on which error bits stops
	unsigned int ai_inttrig_start;	// TRIG_INT for start
} pci9118_private;

#define devpriv ((pci9118_private *)dev->private)
#define this_board ((boardtype *)dev->board_ptr)

/*
==============================================================================
*/

static int check_channel_list(comedi_device * dev, comedi_subdevice * s,
	int n_chan, unsigned int *chanlist, int frontadd, int backadd);
static int setup_channel_list(comedi_device * dev, comedi_subdevice * s,
	int n_chan, unsigned int *chanlist, int rot, int frontadd, int backadd,
	int usedma, char eoshandle);
static void start_pacer(comedi_device * dev, int mode, unsigned int divisor1,
	unsigned int divisor2);
static int pci9118_reset(comedi_device * dev);
static int pci9118_exttrg_add(comedi_device * dev, unsigned char source);
static int pci9118_exttrg_del(comedi_device * dev, unsigned char source);
static int pci9118_ai_cancel(comedi_device * dev, comedi_subdevice * s);
static void pci9118_calc_divisors(char mode, comedi_device * dev,
	comedi_subdevice * s, unsigned int *tim1, unsigned int *tim2,
	unsigned int flags, int chans, unsigned int *div1, unsigned int *div2,
	char usessh, unsigned int chnsshfront);

/*
==============================================================================
*/
static int pci9118_insn_read_ai(comedi_device * dev, comedi_subdevice * s,
	comedi_insn * insn, lsampl_t * data)
{

	int n, timeout;

	devpriv->AdControlReg = AdControl_Int & 0xff;
	devpriv->AdFunctionReg = AdFunction_PDTrg | AdFunction_PETrg;
	outl(devpriv->AdFunctionReg, dev->iobase + PCI9118_ADFUNC);	// positive triggers, no S&H, no burst, burst stop, no post trigger, no about trigger, trigger stop

	if (!setup_channel_list(dev, s, 1, &insn->chanspec, 0, 0, 0, 0, 0))
		return -EINVAL;

	outl(0, dev->iobase + PCI9118_DELFIFO);	// flush FIFO

	for (n = 0; n < insn->n; n++) {
		outw(0, dev->iobase + PCI9118_SOFTTRG);	/* start conversion */
		comedi_udelay(2);
		timeout = 100;
		while (timeout--) {
			if (inl(dev->iobase + PCI9118_ADSTAT) & AdStatus_ADrdy)
				goto conv_finish;
			comedi_udelay(1);
		}

		comedi_error(dev, "A/D insn timeout");
		data[n] = 0;
		outl(0, dev->iobase + PCI9118_DELFIFO);	// flush FIFO
		return -ETIME;

	      conv_finish:
		if (devpriv->ai16bits) {
			data[n] =
				(inl(dev->iobase +
					PCI9118_AD_DATA) & 0xffff) ^ 0x8000;
		} else {
			data[n] =
				(inw(dev->iobase +
					PCI9118_AD_DATA) >> 4) & 0xfff;
		}
	}

	outl(0, dev->iobase + PCI9118_DELFIFO);	// flush FIFO
	return n;

}

/*
==============================================================================
*/
static int pci9118_insn_write_ao(comedi_device * dev, comedi_subdevice * s,
	comedi_insn * insn, lsampl_t * data)
{
	int n, chanreg, ch;

	ch = CR_CHAN(insn->chanspec);
	if (ch) {
		chanreg = PCI9118_DA2;
	} else {
		chanreg = PCI9118_DA1;
	}

	for (n = 0; n < insn->n; n++) {
		outl(data[n], dev->iobase + chanreg);
		devpriv->ao_data[ch] = data[n];
	}

	return n;
}

/*
==============================================================================
*/
static int pci9118_insn_read_ao(comedi_device * dev, comedi_subdevice * s,
	comedi_insn * insn, lsampl_t * data)
{
	int n, chan;

	chan = CR_CHAN(insn->chanspec);
	for (n = 0; n < insn->n; n++)
		data[n] = devpriv->ao_data[chan];

	return n;
}

/*
==============================================================================
*/
static int pci9118_insn_bits_di(comedi_device * dev, comedi_subdevice * s,
	comedi_insn * insn, lsampl_t * data)
{
	data[1] = inl(dev->iobase + PCI9118_DI) & 0xf;

	return 2;
}

/*
==============================================================================
*/
static int pci9118_insn_bits_do(comedi_device * dev, comedi_subdevice * s,
	comedi_insn * insn, lsampl_t * data)
{
	if (data[0]) {
		s->state &= ~data[0];
		s->state |= (data[0] & data[1]);
		outl(s->state & 0x0f, dev->iobase + PCI9118_DO);
	}
	data[1] = s->state;

	return 2;
}

/*
==============================================================================
*/
static void interrupt_pci9118_ai_mode4_switch(comedi_device * dev)
{
	devpriv->AdFunctionReg =
		AdFunction_PDTrg | AdFunction_PETrg | AdFunction_AM;
	outl(devpriv->AdFunctionReg, dev->iobase + PCI9118_ADFUNC);
	outl(0x30, dev->iobase + PCI9118_CNTCTRL);
	outl((devpriv->dmabuf_hw[1 - devpriv->dma_actbuf] >> 1) & 0xff,
		dev->iobase + PCI9118_CNT0);
	outl((devpriv->dmabuf_hw[1 - devpriv->dma_actbuf] >> 9) & 0xff,
		dev->iobase + PCI9118_CNT0);
	devpriv->AdFunctionReg |= AdFunction_Start;
	outl(devpriv->AdFunctionReg, dev->iobase + PCI9118_ADFUNC);
}

static unsigned int defragment_dma_buffer(comedi_device * dev,
	comedi_subdevice * s, sampl_t * dma_buffer, unsigned int num_samples)
{
	unsigned int i = 0, j = 0;
	unsigned int start_pos = devpriv->ai_add_front,
		stop_pos = devpriv->ai_add_front + devpriv->ai_n_chan;
	unsigned int raw_scanlen = devpriv->ai_add_front + devpriv->ai_n_chan +
		devpriv->ai_add_back;

	for (i = 0; i < num_samples; i++) {
		if (devpriv->ai_act_dmapos >= start_pos &&
			devpriv->ai_act_dmapos < stop_pos) {
			dma_buffer[j++] = dma_buffer[i];
		}
		devpriv->ai_act_dmapos++;
		devpriv->ai_act_dmapos %= raw_scanlen;
	}

	return j;
}

/*
==============================================================================
*/
static unsigned int move_block_from_dma(comedi_device * dev,
	comedi_subdevice * s, sampl_t * dma_buffer, unsigned int num_samples)
{
	unsigned int num_bytes;

	num_samples = defragment_dma_buffer(dev, s, dma_buffer, num_samples);
	devpriv->ai_act_scan +=
		(s->async->cur_chan + num_samples) / devpriv->ai_n_scanlen;
	s->async->cur_chan += num_samples;
	s->async->cur_chan %= devpriv->ai_n_scanlen;
	num_bytes =
		cfc_write_array_to_buffer(s, dma_buffer,
		num_samples * sizeof(sampl_t));
	if (num_bytes < num_samples * sizeof(sampl_t))
		return -1;
	return 0;
}

/*
==============================================================================
*/
static char pci9118_decode_error_status(comedi_device * dev,
	comedi_subdevice * s, unsigned char m)
{
	if (m & 0x100) {
		comedi_error(dev, "A/D FIFO Full status (Fatal Error!)");
		devpriv->ai_maskerr &= ~0x100L;
	}
	if (m & 0x008) {
		comedi_error(dev,
			"A/D Burst Mode Overrun Status (Fatal Error!)");
		devpriv->ai_maskerr &= ~0x008L;
	}
	if (m & 0x004) {
		comedi_error(dev, "A/D Over Speed Status (Warning!)");
		devpriv->ai_maskerr &= ~0x004L;
	}
	if (m & 0x002) {
		comedi_error(dev, "A/D Overrun Status (Fatal Error!)");
		devpriv->ai_maskerr &= ~0x002L;
	}
	if (m & devpriv->ai_maskharderr) {
		s->async->events |= COMEDI_CB_ERROR | COMEDI_CB_EOA;
		pci9118_ai_cancel(dev, s);
		comedi_event(dev, s);
		return 1;
	}

	return 0;
}

static void pci9118_ai_munge(comedi_device * dev, comedi_subdevice * s,
	void *data, unsigned int num_bytes, unsigned int start_chan_index)
{
	unsigned int i, num_samples = num_bytes / sizeof(sampl_t);
	sampl_t *array = data;

	for (i = 0; i < num_samples; i++) {
		if (devpriv->usedma)
			array[i] = be16_to_cpu(array[i]);
		if (devpriv->ai16bits) {
			array[i] ^= 0x8000;
		} else {
			array[i] = (array[i] >> 4) & 0x0fff;
		}
	}
}

/*
==============================================================================
*/
static void interrupt_pci9118_ai_onesample(comedi_device * dev,
	comedi_subdevice * s, unsigned short int_adstat, unsigned int int_amcc,
	unsigned short int_daq)
{
	register sampl_t sampl;

	s->async->events = 0;

	if (int_adstat & devpriv->ai_maskerr)
		if (pci9118_decode_error_status(dev, s, int_adstat))
			return;

	sampl = inw(dev->iobase + PCI9118_AD_DATA);

#ifdef PCI9118_PARANOIDCHECK
	if (devpriv->ai16bits == 0) {
		if ((sampl & 0x000f) != devpriv->chanlist[s->async->cur_chan]) {	// data dropout!
			rt_printk
				("comedi: A/D  SAMPL - data dropout: received channel %d, expected %d!\n",
				sampl & 0x000f,
				devpriv->chanlist[s->async->cur_chan]);
			s->async->events |= COMEDI_CB_ERROR | COMEDI_CB_EOA;
			pci9118_ai_cancel(dev, s);
			comedi_event(dev, s);
			return;
		}
	}
#endif
	cfc_write_to_buffer(s, sampl);
	s->async->cur_chan++;
	if (s->async->cur_chan >= devpriv->ai_n_scanlen) {	/* one scan done */
		s->async->cur_chan %= devpriv->ai_n_scanlen;
		devpriv->ai_act_scan++;
		if (!(devpriv->ai_neverending))
			if (devpriv->ai_act_scan >= devpriv->ai_scans) {	/* all data sampled */
				pci9118_ai_cancel(dev, s);
				s->async->events |= COMEDI_CB_EOA;
			}
	}

	if (s->async->events)
		comedi_event(dev, s);
}

/*
==============================================================================
*/
static void interrupt_pci9118_ai_dma(comedi_device * dev, comedi_subdevice * s,
	unsigned short int_adstat, unsigned int int_amcc,
	unsigned short int_daq)
{
	unsigned int next_dma_buf, samplesinbuf, sampls, m;

	if (int_amcc & MASTER_ABORT_INT) {
		comedi_error(dev, "AMCC IRQ - MASTER DMA ABORT!");
		s->async->events |= COMEDI_CB_ERROR | COMEDI_CB_EOA;
		pci9118_ai_cancel(dev, s);
		comedi_event(dev, s);
		return;
	}

	if (int_amcc & TARGET_ABORT_INT) {
		comedi_error(dev, "AMCC IRQ - TARGET DMA ABORT!");
		s->async->events |= COMEDI_CB_ERROR | COMEDI_CB_EOA;
		pci9118_ai_cancel(dev, s);
		comedi_event(dev, s);
		return;
	}

	if (int_adstat & devpriv->ai_maskerr)
//      if (int_adstat & 0x106)
		if (pci9118_decode_error_status(dev, s, int_adstat))
			return;

	samplesinbuf = devpriv->dmabuf_use_size[devpriv->dma_actbuf] >> 1;	// number of received real samples
//      DPRINTK("dma_actbuf=%d\n",devpriv->dma_actbuf);

	if (devpriv->dma_doublebuf) {	// switch DMA buffers if is used double buffering
		next_dma_buf = 1 - devpriv->dma_actbuf;
		outl(devpriv->dmabuf_hw[next_dma_buf],
			devpriv->iobase_a + AMCC_OP_REG_MWAR);
		outl(devpriv->dmabuf_use_size[next_dma_buf],
			devpriv->iobase_a + AMCC_OP_REG_MWTC);
		devpriv->dmabuf_used_size[next_dma_buf] =
			devpriv->dmabuf_use_size[next_dma_buf];
		if (devpriv->ai_do == 4)
			interrupt_pci9118_ai_mode4_switch(dev);
	}

	if (samplesinbuf) {
		m = devpriv->ai_data_len >> 1;	// how many samples is to end of buffer
//              DPRINTK("samps=%d m=%d %d %d\n",samplesinbuf,m,s->async->buf_int_count,s->async->buf_int_ptr);
		sampls = m;
		move_block_from_dma(dev, s,
			devpriv->dmabuf_virt[devpriv->dma_actbuf],
			samplesinbuf);
		m = m - sampls;	// m= how many samples was transfered
	}
//      DPRINTK("YYY\n");

	if (!devpriv->ai_neverending)
		if (devpriv->ai_act_scan >= devpriv->ai_scans) {	/* all data sampled */
			pci9118_ai_cancel(dev, s);
			s->async->events |= COMEDI_CB_EOA;
		}

	if (devpriv->dma_doublebuf) {	// switch dma buffers
		devpriv->dma_actbuf = 1 - devpriv->dma_actbuf;
	} else {		// restart DMA if is not used double buffering
		outl(devpriv->dmabuf_hw[0],
			devpriv->iobase_a + AMCC_OP_REG_MWAR);
		outl(devpriv->dmabuf_use_size[0],
			devpriv->iobase_a + AMCC_OP_REG_MWTC);
		if (devpriv->ai_do == 4)
			interrupt_pci9118_ai_mode4_switch(dev);
	}

	comedi_event(dev, s);
}

/*
==============================================================================
*/
static irqreturn_t interrupt_pci9118(int irq, void *d PT_REGS_ARG)
{
	comedi_device *dev = d;
	unsigned int int_daq = 0, int_amcc, int_adstat;

	if (!dev->attached)
		return IRQ_NONE;	// not fully initialized

	int_daq = inl(dev->iobase + PCI9118_INTSRC) & 0xf;	// get IRQ reasons from card
	int_amcc = inl(devpriv->iobase_a + AMCC_OP_REG_INTCSR);	// get INT register from AMCC chip

//      DPRINTK("INT daq=0x%01x amcc=0x%08x MWAR=0x%08x MWTC=0x%08x ADSTAT=0x%02x ai_do=%d\n", int_daq, int_amcc, inl(devpriv->iobase_a+AMCC_OP_REG_MWAR), inl(devpriv->iobase_a+AMCC_OP_REG_MWTC), inw(dev->iobase+PCI9118_ADSTAT)&0x1ff,devpriv->ai_do);

	if ((!int_daq) && (!(int_amcc & ANY_S593X_INT)))
		return IRQ_NONE;	// interrupt from other source

	outl(int_amcc | 0x00ff0000, devpriv->iobase_a + AMCC_OP_REG_INTCSR);	// shutdown IRQ reasons in AMCC

	int_adstat = inw(dev->iobase + PCI9118_ADSTAT) & 0x1ff;	// get STATUS register

	if (devpriv->ai_do) {
		if (devpriv->ai12_startstop)
			if ((int_adstat & AdStatus_DTH) && (int_daq & Int_DTrg)) {	// start stop of measure
				if (devpriv->ai12_startstop & START_AI_EXT) {
					devpriv->ai12_startstop &=
						~START_AI_EXT;
					if (!(devpriv->ai12_startstop &
							STOP_AI_EXT))
						pci9118_exttrg_del(dev, EXTTRG_AI);	// deactivate EXT trigger
					start_pacer(dev, devpriv->ai_do, devpriv->ai_divisor1, devpriv->ai_divisor2);	// start pacer
					outl(devpriv->AdControlReg,
						dev->iobase + PCI9118_ADCNTRL);
				} else {
					if (devpriv->
						ai12_startstop & STOP_AI_EXT) {
						devpriv->ai12_startstop &=
							~STOP_AI_EXT;
						pci9118_exttrg_del(dev, EXTTRG_AI);	// deactivate EXT trigger
						devpriv->ai_neverending = 0;	//well, on next interrupt from DMA/EOC measure will stop
					}
				}
			}

		(devpriv->int_ai_func) (dev, dev->subdevices + 0, int_adstat,
			int_amcc, int_daq);

	}
	return IRQ_HANDLED;
}

/*
==============================================================================
*/
static int pci9118_ai_inttrig(comedi_device * dev, comedi_subdevice * s,
	unsigned int trignum)
{
	if (trignum != devpriv->ai_inttrig_start)
		return -EINVAL;

	devpriv->ai12_startstop &= ~START_AI_INT;
	s->async->inttrig = NULL;

	outl(devpriv->IntControlReg, dev->iobase + PCI9118_INTCTRL);
	outl(devpriv->AdFunctionReg, dev->iobase + PCI9118_ADFUNC);
	if (devpriv->ai_do != 3) {
		start_pacer(dev, devpriv->ai_do, devpriv->ai_divisor1,
			devpriv->ai_divisor2);
		devpriv->AdControlReg |= AdControl_SoftG;
	}
	outl(devpriv->AdControlReg, dev->iobase + PCI9118_ADCNTRL);

	return 1;
}

/*
==============================================================================
*/
static int pci9118_ai_cmdtest(comedi_device * dev, comedi_subdevice * s,
	comedi_cmd * cmd)
{
	int err = 0;
	int tmp, divisor1 = 0, divisor2 = 0;

	/* step 1: make sure trigger sources are trivially valid */

	tmp = cmd->start_src;
	cmd->start_src &= TRIG_NOW | TRIG_EXT | TRIG_INT;
	if (!cmd->start_src || tmp != cmd->start_src)
		err++;

	tmp = cmd->scan_begin_src;
	if (devpriv->master) {
		cmd->scan_begin_src &= TRIG_TIMER | TRIG_EXT | TRIG_FOLLOW;
	} else {
		cmd->scan_begin_src &= TRIG_FOLLOW;
	}
	if (!cmd->scan_begin_src || tmp != cmd->scan_begin_src)
		err++;

	tmp = cmd->convert_src;
	if (devpriv->master) {
		cmd->convert_src &= TRIG_TIMER | TRIG_EXT | TRIG_NOW;
	} else {
		cmd->convert_src &= TRIG_TIMER | TRIG_EXT;
	}
	if (!cmd->convert_src || tmp != cmd->convert_src)
		err++;

	tmp = cmd->scan_end_src;
	cmd->scan_end_src &= TRIG_COUNT;
	if (!cmd->scan_end_src || tmp != cmd->scan_end_src)
		err++;

	tmp = cmd->stop_src;
	cmd->stop_src &= TRIG_COUNT | TRIG_NONE | TRIG_EXT;
	if (!cmd->stop_src || tmp != cmd->stop_src)
		err++;

	if (err)
		return 1;

	/* step 2: make sure trigger sources are unique and mutually compatible */

	if (cmd->start_src != TRIG_NOW &&
		cmd->start_src != TRIG_INT && cmd->start_src != TRIG_EXT) {
		cmd->start_src = TRIG_NOW;
		err++;
	}

	if (cmd->scan_begin_src != TRIG_TIMER &&
		cmd->scan_begin_src != TRIG_EXT &&
		cmd->scan_begin_src != TRIG_INT &&
		cmd->scan_begin_src != TRIG_FOLLOW) {
		cmd->scan_begin_src = TRIG_FOLLOW;
		err++;
	}

	if (cmd->convert_src != TRIG_TIMER &&
		cmd->convert_src != TRIG_EXT && cmd->convert_src != TRIG_NOW) {
		cmd->convert_src = TRIG_TIMER;
		err++;
	}

	if (cmd->scan_end_src != TRIG_COUNT) {
		cmd->scan_end_src = TRIG_COUNT;
		err++;
	}

	if (cmd->stop_src != TRIG_NONE &&
		cmd->stop_src != TRIG_COUNT &&
		cmd->stop_src != TRIG_INT && cmd->stop_src != TRIG_EXT) {
		cmd->stop_src = TRIG_COUNT;
		err++;
	}

	if (cmd->start_src == TRIG_EXT && cmd->scan_begin_src == TRIG_EXT) {
		cmd->start_src = TRIG_NOW;
		err++;
	}

	if (cmd->start_src == TRIG_INT && cmd->scan_begin_src == TRIG_INT) {
		cmd->start_src = TRIG_NOW;
		err++;
	}

	if ((cmd->scan_begin_src & (TRIG_TIMER | TRIG_EXT)) &&
		(!(cmd->convert_src & (TRIG_TIMER | TRIG_NOW)))) {
		cmd->convert_src = TRIG_TIMER;
		err++;
	}

	if ((cmd->scan_begin_src == TRIG_FOLLOW) &&
		(!(cmd->convert_src & (TRIG_TIMER | TRIG_EXT)))) {
		cmd->convert_src = TRIG_TIMER;
		err++;
	}

	if (cmd->stop_src == TRIG_EXT && cmd->scan_begin_src == TRIG_EXT) {
		cmd->stop_src = TRIG_COUNT;
		err++;
	}

	if (err)
		return 2;

	/* step 3: make sure arguments are trivially compatible */

	if (cmd->start_src & (TRIG_NOW | TRIG_EXT))
		if (cmd->start_arg != 0) {
			cmd->start_arg = 0;
			err++;
		}

	if (cmd->scan_begin_src & (TRIG_FOLLOW | TRIG_EXT))
		if (cmd->scan_begin_arg != 0) {
			cmd->scan_begin_arg = 0;
			err++;
		}

	if ((cmd->scan_begin_src == TRIG_TIMER) &&
		(cmd->convert_src == TRIG_TIMER) && (cmd->scan_end_arg == 1)) {
		cmd->scan_begin_src = TRIG_FOLLOW;
		cmd->convert_arg = cmd->scan_begin_arg;
		cmd->scan_begin_arg = 0;
	}

	if (cmd->scan_begin_src == TRIG_TIMER)
		if (cmd->scan_begin_arg < this_board->ai_ns_min) {
			cmd->scan_begin_arg = this_board->ai_ns_min;
			err++;
		}

	if (cmd->scan_begin_src == TRIG_EXT)
		if (cmd->scan_begin_arg) {
			cmd->scan_begin_arg = 0;
			err++;
			if (cmd->scan_end_arg > 65535) {
				cmd->scan_end_arg = 65535;
				err++;
			}
		}

	if (cmd->convert_src & (TRIG_TIMER | TRIG_NOW))
		if (cmd->convert_arg < this_board->ai_ns_min) {
			cmd->convert_arg = this_board->ai_ns_min;
			err++;
		}

	if (cmd->convert_src == TRIG_EXT)
		if (cmd->convert_arg) {
			cmd->convert_arg = 0;
			err++;
		}

	if (cmd->stop_src == TRIG_COUNT) {
		if (!cmd->stop_arg) {
			cmd->stop_arg = 1;
			err++;
		}
	} else {		/* TRIG_NONE */
		if (cmd->stop_arg != 0) {
			cmd->stop_arg = 0;
			err++;
		}
	}

	if (!cmd->chanlist_len) {
		cmd->chanlist_len = 1;
		err++;
	}

	if (cmd->chanlist_len > this_board->n_aichanlist) {
		cmd->chanlist_len = this_board->n_aichanlist;
		err++;
	}

	if (cmd->scan_end_arg < cmd->chanlist_len) {
		cmd->scan_end_arg = cmd->chanlist_len;
		err++;
	}

	if ((cmd->scan_end_arg % cmd->chanlist_len)) {
		cmd->scan_end_arg =
			cmd->chanlist_len * (cmd->scan_end_arg /
			cmd->chanlist_len);
		err++;
	}

	if (err)
		return 3;

	/* step 4: fix up any arguments */

	if (cmd->scan_begin_src == TRIG_TIMER) {
		tmp = cmd->scan_begin_arg;
//              rt_printk("S1 timer1=%u timer2=%u\n",cmd->scan_begin_arg,cmd->convert_arg);
		i8253_cascade_ns_to_timer(devpriv->i8254_osc_base, &divisor1,
			&divisor2, &cmd->scan_begin_arg,
			cmd->flags & TRIG_ROUND_MASK);
//              rt_printk("S2 timer1=%u timer2=%u\n",cmd->scan_begin_arg,cmd->convert_arg);
		if (cmd->scan_begin_arg < this_board->ai_ns_min)
			cmd->scan_begin_arg = this_board->ai_ns_min;
		if (tmp != cmd->scan_begin_arg)
			err++;
	}

	if (cmd->convert_src & (TRIG_TIMER | TRIG_NOW)) {
		tmp = cmd->convert_arg;
		i8253_cascade_ns_to_timer(devpriv->i8254_osc_base, &divisor1,
			&divisor2, &cmd->convert_arg,
			cmd->flags & TRIG_ROUND_MASK);
//              rt_printk("s1 timer1=%u timer2=%u\n",cmd->scan_begin_arg,cmd->convert_arg);
		if (cmd->convert_arg < this_board->ai_ns_min)
			cmd->convert_arg = this_board->ai_ns_min;
		if (tmp != cmd->convert_arg)
			err++;
		if (cmd->scan_begin_src == TRIG_TIMER
			&& cmd->convert_src == TRIG_NOW) {
			if (cmd->convert_arg == 0) {
				if (cmd->scan_begin_arg <
					this_board->ai_ns_min *
					(cmd->scan_end_arg + 2)) {
					cmd->scan_begin_arg =
						this_board->ai_ns_min *
						(cmd->scan_end_arg + 2);
//              rt_printk("s2 timer1=%u timer2=%u\n",cmd->scan_begin_arg,cmd->convert_arg);
					err++;
				}
			} else {
				if (cmd->scan_begin_arg <
					cmd->convert_arg * cmd->chanlist_len) {
					cmd->scan_begin_arg =
						cmd->convert_arg *
						cmd->chanlist_len;
//              rt_printk("s3 timer1=%u timer2=%u\n",cmd->scan_begin_arg,cmd->convert_arg);
					err++;
				}
			}
		}
	}

	if (err)
		return 4;

	if (cmd->chanlist)
		if (!check_channel_list(dev, s, cmd->chanlist_len,
				cmd->chanlist, 0, 0))
			return 5;	// incorrect channels list

	return 0;
}

/*
==============================================================================
*/
static int Compute_and_setup_dma(comedi_device * dev)
{
	unsigned int dmalen0, dmalen1, i;

	DPRINTK("adl_pci9118 EDBG: BGN: Compute_and_setup_dma()\n");
	dmalen0 = devpriv->dmabuf_size[0];
	dmalen1 = devpriv->dmabuf_size[1];
	DPRINTK("1 dmalen0=%d dmalen1=%d ai_data_len=%d\n", dmalen0, dmalen1,
		devpriv->ai_data_len);
	// isn't output buff smaller that our DMA buff?
	if (dmalen0 > (devpriv->ai_data_len)) {
		dmalen0 = devpriv->ai_data_len & ~3L;	// allign to 32bit down
	}
	if (dmalen1 > (devpriv->ai_data_len)) {
		dmalen1 = devpriv->ai_data_len & ~3L;	// allign to 32bit down
	}
	DPRINTK("2 dmalen0=%d dmalen1=%d \n", dmalen0, dmalen1);

	// we want wake up every scan?
	if (devpriv->ai_flags & TRIG_WAKE_EOS) {
		if (dmalen0 < (devpriv->ai_n_realscanlen << 1)) {
			// uff, too short DMA buffer, disable EOS support!
			devpriv->ai_flags &= (~TRIG_WAKE_EOS);
			rt_printk
				("comedi%d: WAR: DMA0 buf too short, cann't support TRIG_WAKE_EOS (%d<%d)\n",
				dev->minor, dmalen0,
				devpriv->ai_n_realscanlen << 1);
		} else {
			// short first DMA buffer to one scan
			dmalen0 = devpriv->ai_n_realscanlen << 1;
			DPRINTK("21 dmalen0=%d ai_n_realscanlen=%d useeoshandle=%d\n", dmalen0, devpriv->ai_n_realscanlen, devpriv->useeoshandle);
			if (devpriv->useeoshandle)
				dmalen0 += 2;
			if (dmalen0 < 4) {
				rt_printk
					("comedi%d: ERR: DMA0 buf len bug? (%d<4)\n",
					dev->minor, dmalen0);
				dmalen0 = 4;
			}
		}
	}
	if (devpriv->ai_flags & TRIG_WAKE_EOS) {
		if (dmalen1 < (devpriv->ai_n_realscanlen << 1)) {
			// uff, too short DMA buffer, disable EOS support!
			devpriv->ai_flags &= (~TRIG_WAKE_EOS);
			rt_printk
				("comedi%d: WAR: DMA1 buf too short, cann't support TRIG_WAKE_EOS (%d<%d)\n",
				dev->minor, dmalen1,
				devpriv->ai_n_realscanlen << 1);
		} else {
			// short second DMA buffer to one scan
			dmalen1 = devpriv->ai_n_realscanlen << 1;
			DPRINTK("22 dmalen1=%d ai_n_realscanlen=%d useeoshandle=%d\n", dmalen1, devpriv->ai_n_realscanlen, devpriv->useeoshandle);
			if (devpriv->useeoshandle)
				dmalen1 -= 2;
			if (dmalen1 < 4) {
				rt_printk
					("comedi%d: ERR: DMA1 buf len bug? (%d<4)\n",
					dev->minor, dmalen1);
				dmalen1 = 4;
			}
		}
	}

	DPRINTK("3 dmalen0=%d dmalen1=%d \n", dmalen0, dmalen1);
	// transfer without TRIG_WAKE_EOS
	if (!(devpriv->ai_flags & TRIG_WAKE_EOS)) {
		// if it's possible then allign DMA buffers to length of scan
		i = dmalen0;
		dmalen0 =
			(dmalen0 / (devpriv->ai_n_realscanlen << 1)) *
			(devpriv->ai_n_realscanlen << 1);
		dmalen0 &= ~3L;
		if (!dmalen0)
			dmalen0 = i;	// uff. very long scan?
		i = dmalen1;
		dmalen1 =
			(dmalen1 / (devpriv->ai_n_realscanlen << 1)) *
			(devpriv->ai_n_realscanlen << 1);
		dmalen1 &= ~3L;
		if (!dmalen1)
			dmalen1 = i;	// uff. very long scan?
		// if measure isn't neverending then test, if it whole fits into one or two DMA buffers
		if (!devpriv->ai_neverending) {
			// fits whole measure into one DMA buffer?
			if (dmalen0 >
				((devpriv->ai_n_realscanlen << 1) *
					devpriv->ai_scans)) {
				DPRINTK("3.0 ai_n_realscanlen=%d ai_scans=%d \n", devpriv->ai_n_realscanlen, devpriv->ai_scans);
				dmalen0 =
					(devpriv->ai_n_realscanlen << 1) *
					devpriv->ai_scans;
				DPRINTK("3.1 dmalen0=%d dmalen1=%d \n", dmalen0,
					dmalen1);
				dmalen0 &= ~3L;
			} else {	// fits whole measure into two DMA buffer?
				if (dmalen1 >
					((devpriv->ai_n_realscanlen << 1) *
						devpriv->ai_scans - dmalen0))
					dmalen1 =
						(devpriv->
						ai_n_realscanlen << 1) *
						devpriv->ai_scans - dmalen0;
				DPRINTK("3.2 dmalen0=%d dmalen1=%d \n", dmalen0,
					dmalen1);
				dmalen1 &= ~3L;
			}
		}
	}

	DPRINTK("4 dmalen0=%d dmalen1=%d \n", dmalen0, dmalen1);

	// these DMA buffer size we'll be used
	devpriv->dma_actbuf = 0;
	devpriv->dmabuf_use_size[0] = dmalen0;
	devpriv->dmabuf_use_size[1] = dmalen1;

	DPRINTK("5 dmalen0=%d dmalen1=%d \n", dmalen0, dmalen1);
#if 0
	if (devpriv->ai_n_scanlen < this_board->half_fifo_size) {
		devpriv->dmabuf_panic_size[0] =
			(this_board->half_fifo_size / devpriv->ai_n_scanlen +
			1) * devpriv->ai_n_scanlen * sizeof(sampl_t);
		devpriv->dmabuf_panic_size[1] =
			(this_board->half_fifo_size / devpriv->ai_n_scanlen +
			1) * devpriv->ai_n_scanlen * sizeof(sampl_t);
	} else {
		devpriv->dmabuf_panic_size[0] =
			(devpriv->ai_n_scanlen << 1) % devpriv->dmabuf_size[0];
		devpriv->dmabuf_panic_size[1] =
			(devpriv->ai_n_scanlen << 1) % devpriv->dmabuf_size[1];
	}
#endif

	outl(inl(devpriv->iobase_a + AMCC_OP_REG_MCSR) & (~EN_A2P_TRANSFERS), devpriv->iobase_a + AMCC_OP_REG_MCSR);	// stop DMA
	outl(devpriv->dmabuf_hw[0], devpriv->iobase_a + AMCC_OP_REG_MWAR);
	outl(devpriv->dmabuf_use_size[0], devpriv->iobase_a + AMCC_OP_REG_MWTC);
	// init DMA transfer
	outl(0x00000000 | AINT_WRITE_COMPL,
		devpriv->iobase_a + AMCC_OP_REG_INTCSR);
//      outl(0x02000000|AINT_WRITE_COMPL, devpriv->iobase_a+AMCC_OP_REG_INTCSR);

	outl(inl(devpriv->iobase_a +
			AMCC_OP_REG_MCSR) | RESET_A2P_FLAGS | A2P_HI_PRIORITY |
		EN_A2P_TRANSFERS, devpriv->iobase_a + AMCC_OP_REG_MCSR);
	outl(inl(devpriv->iobase_a + AMCC_OP_REG_INTCSR) | EN_A2P_TRANSFERS, devpriv->iobase_a + AMCC_OP_REG_INTCSR);	// allow bus mastering

	DPRINTK("adl_pci9118 EDBG: END: Compute_and_setup_dma()\n");
	return 0;
}

/*
==============================================================================
*/
static int pci9118_ai_docmd_sampl(comedi_device * dev, comedi_subdevice * s)
{
	DPRINTK("adl_pci9118 EDBG: BGN: pci9118_ai_docmd_sampl(%d,) [%d]\n",
		dev->minor, devpriv->ai_do);
	switch (devpriv->ai_do) {
	case 1:
		devpriv->AdControlReg |= AdControl_TmrTr;
		break;
	case 2:
		comedi_error(dev, "pci9118_ai_docmd_sampl() mode 2 bug!\n");
		return -EIO;
	case 3:
		devpriv->AdControlReg |= AdControl_ExtM;
		break;
	case 4:
		comedi_error(dev, "pci9118_ai_docmd_sampl() mode 4 bug!\n");
		return -EIO;
	default:
		comedi_error(dev,
			"pci9118_ai_docmd_sampl() mode number bug!\n");
		return -EIO;
	};

	devpriv->int_ai_func = interrupt_pci9118_ai_onesample;	//transfer function

	if (devpriv->ai12_startstop)
		pci9118_exttrg_add(dev, EXTTRG_AI);	// activate EXT trigger

	if ((devpriv->ai_do == 1) || (devpriv->ai_do == 2))
		devpriv->IntControlReg |= Int_Timer;

	devpriv->AdControlReg |= AdControl_Int;

	outl(inl(devpriv->iobase_a + AMCC_OP_REG_INTCSR) | 0x1f00, devpriv->iobase_a + AMCC_OP_REG_INTCSR);	// allow INT in AMCC

	if (!(devpriv->ai12_startstop & (START_AI_EXT | START_AI_INT))) {
		outl(devpriv->IntControlReg, dev->iobase + PCI9118_INTCTRL);
		outl(devpriv->AdFunctionReg, dev->iobase + PCI9118_ADFUNC);
		if (devpriv->ai_do != 3) {
			start_pacer(dev, devpriv->ai_do, devpriv->ai_divisor1,
				devpriv->ai_divisor2);
			devpriv->AdControlReg |= AdControl_SoftG;
		}
		outl(devpriv->IntControlReg, dev->iobase + PCI9118_INTCTRL);
	}

	DPRINTK("adl_pci9118 EDBG: END: pci9118_ai_docmd_sampl()\n");
	return 0;
}

/*
==============================================================================
*/
static int pci9118_ai_docmd_dma(comedi_device * dev, comedi_subdevice * s)
{
	DPRINTK("adl_pci9118 EDBG: BGN: pci9118_ai_docmd_dma(%d,) [%d,%d]\n",
		dev->minor, devpriv->ai_do, devpriv->usedma);
	Compute_and_setup_dma(dev);

	switch (devpriv->ai_do) {
	case 1:
		devpriv->AdControlReg |=
			((AdControl_TmrTr | AdControl_Dma) & 0xff);
		break;
	case 2:
		devpriv->AdControlReg |=
			((AdControl_TmrTr | AdControl_Dma) & 0xff);
		devpriv->AdFunctionReg =
			AdFunction_PDTrg | AdFunction_PETrg | AdFunction_BM |
			AdFunction_BS;
		if (devpriv->usessh && (!devpriv->softsshdelay))
			devpriv->AdFunctionReg |= AdFunction_BSSH;
		outl(devpriv->ai_n_realscanlen, dev->iobase + PCI9118_BURST);
		break;
	case 3:
		devpriv->AdControlReg |=
			((AdControl_ExtM | AdControl_Dma) & 0xff);
		devpriv->AdFunctionReg = AdFunction_PDTrg | AdFunction_PETrg;
		break;
	case 4:
		devpriv->AdControlReg |=
			((AdControl_TmrTr | AdControl_Dma) & 0xff);
		devpriv->AdFunctionReg =
			AdFunction_PDTrg | AdFunction_PETrg | AdFunction_AM;
		outl(devpriv->AdFunctionReg, dev->iobase + PCI9118_ADFUNC);
		outl(0x30, dev->iobase + PCI9118_CNTCTRL);
		outl((devpriv->dmabuf_hw[0] >> 1) & 0xff,
			dev->iobase + PCI9118_CNT0);
		outl((devpriv->dmabuf_hw[0] >> 9) & 0xff,
			dev->iobase + PCI9118_CNT0);
		devpriv->AdFunctionReg |= AdFunction_Start;
		break;
	default:
		comedi_error(dev, "pci9118_ai_docmd_dma() mode number bug!\n");
		return -EIO;
	};

	if (devpriv->ai12_startstop) {
		pci9118_exttrg_add(dev, EXTTRG_AI);	// activate EXT trigger
	}

	devpriv->int_ai_func = interrupt_pci9118_ai_dma;	//transfer function

	outl(0x02000000 | AINT_WRITE_COMPL,
		devpriv->iobase_a + AMCC_OP_REG_INTCSR);

	if (!(devpriv->ai12_startstop & (START_AI_EXT | START_AI_INT))) {
		outl(devpriv->AdFunctionReg, dev->iobase + PCI9118_ADFUNC);
		outl(devpriv->IntControlReg, dev->iobase + PCI9118_INTCTRL);
		if (devpriv->ai_do != 3) {
			start_pacer(dev, devpriv->ai_do, devpriv->ai_divisor1,
				devpriv->ai_divisor2);
			devpriv->AdControlReg |= AdControl_SoftG;
		}
		outl(devpriv->AdControlReg, dev->iobase + PCI9118_ADCNTRL);
	}

	DPRINTK("adl_pci9118 EDBG: BGN: pci9118_ai_docmd_dma()\n");
	return 0;
}

/*
==============================================================================
*/
static int pci9118_ai_cmd(comedi_device * dev, comedi_subdevice * s)
{
	comedi_cmd *cmd = &s->async->cmd;
	unsigned int addchans = 0;
	int ret = 0;

	DPRINTK("adl_pci9118 EDBG: BGN: pci9118_ai_cmd(%d,)\n", dev->minor);
	devpriv->ai12_startstop = 0;
	devpriv->ai_flags = cmd->flags;
	devpriv->ai_n_chan = cmd->chanlist_len;
	devpriv->ai_n_scanlen = cmd->scan_end_arg;
	devpriv->ai_chanlist = cmd->chanlist;
	devpriv->ai_data = s->async->prealloc_buf;
	devpriv->ai_data_len = s->async->prealloc_bufsz;
	devpriv->ai_timer1 = 0;
	devpriv->ai_timer2 = 0;
	devpriv->ai_add_front = 0;
	devpriv->ai_add_back = 0;
	devpriv->ai_maskerr = 0x10e;

	// prepare for start/stop conditions
	if (cmd->start_src == TRIG_EXT)
		devpriv->ai12_startstop |= START_AI_EXT;
	if (cmd->stop_src == TRIG_EXT) {
		devpriv->ai_neverending = 1;
		devpriv->ai12_startstop |= STOP_AI_EXT;
	}
	if (cmd->start_src == TRIG_INT) {
		devpriv->ai12_startstop |= START_AI_INT;
		devpriv->ai_inttrig_start = cmd->start_arg;
		s->async->inttrig = pci9118_ai_inttrig;
	}
#if 0
	if (cmd->stop_src == TRIG_INT) {
		devpriv->ai_neverending = 1;
		devpriv->ai12_startstop |= STOP_AI_INT;
	}
#endif
	if (cmd->stop_src == TRIG_NONE)
		devpriv->ai_neverending = 1;
	if (cmd->stop_src == TRIG_COUNT) {
		devpriv->ai_scans = cmd->stop_arg;
		devpriv->ai_neverending = 0;
	} else {
		devpriv->ai_scans = 0;
	}

	// use sample&hold signal?
	if (cmd->convert_src == TRIG_NOW) {
		devpriv->usessh = 1;
	}			// yes
	else {
		devpriv->usessh = 0;
	}			// no

	DPRINTK("1 neverending=%d scans=%u usessh=%d ai_startstop=0x%2x\n",
		devpriv->ai_neverending, devpriv->ai_scans, devpriv->usessh,
		devpriv->ai12_startstop);

	// use additional sample at end of every scan to satisty DMA 32 bit transfer?
	devpriv->ai_add_front = 0;
	devpriv->ai_add_back = 0;
	devpriv->useeoshandle = 0;
	if (devpriv->master) {
		devpriv->usedma = 1;
		if ((cmd->flags & TRIG_WAKE_EOS) &&
			(devpriv->ai_n_scanlen == 1)) {
			if (cmd->convert_src == TRIG_NOW) {
				devpriv->ai_add_back = 1;
			}
			if (cmd->convert_src == TRIG_TIMER) {
				devpriv->usedma = 0;	// use INT transfer if scanlist have only one channel
			}
		}
		if ((cmd->flags & TRIG_WAKE_EOS) &&
			(devpriv->ai_n_scanlen & 1) &&
			(devpriv->ai_n_scanlen > 1)) {
			if (cmd->scan_begin_src == TRIG_FOLLOW) {
				//vpriv->useeoshandle=1; // change DMA transfer block to fit EOS on every second call
				devpriv->usedma = 0;	// XXX maybe can be corrected to use 16 bit DMA
			} else {	// well, we must insert one sample to end of EOS to meet 32 bit transfer
				devpriv->ai_add_back = 1;
			}
		}
	} else {		// interrupt transfer don't need any correction
		devpriv->usedma = 0;
	}

	// we need software S&H signal? It add  two samples before every scan as minimum
	if (devpriv->usessh && devpriv->softsshdelay) {
		devpriv->ai_add_front = 2;
		if ((devpriv->usedma == 1) && (devpriv->ai_add_back == 1)) {	// move it to front
			devpriv->ai_add_front++;
			devpriv->ai_add_back = 0;
		}
		if (cmd->convert_arg < this_board->ai_ns_min)
			cmd->convert_arg = this_board->ai_ns_min;
		addchans = devpriv->softsshdelay / cmd->convert_arg;
		if (devpriv->softsshdelay % cmd->convert_arg)
			addchans++;
		if (addchans > (devpriv->ai_add_front - 1)) {	// uff, still short :-(
			devpriv->ai_add_front = addchans + 1;
			if (devpriv->usedma == 1)
				if ((devpriv->ai_add_front +
						devpriv->ai_n_chan +
						devpriv->ai_add_back) & 1)
					devpriv->ai_add_front++;	// round up to 32 bit
		}
	}			// well, we now know what must be all added

	devpriv->ai_n_realscanlen =	// what we must take from card in real to have ai_n_scanlen on output?
		(devpriv->ai_add_front + devpriv->ai_n_chan +
		devpriv->ai_add_back) * (devpriv->ai_n_scanlen /
		devpriv->ai_n_chan);

	DPRINTK("2 usedma=%d realscan=%d af=%u n_chan=%d ab=%d n_scanlen=%d\n",
		devpriv->usedma,
		devpriv->ai_n_realscanlen, devpriv->ai_add_front,
		devpriv->ai_n_chan, devpriv->ai_add_back,
		devpriv->ai_n_scanlen);

	// check and setup channel list
	if (!check_channel_list(dev, s, devpriv->ai_n_chan,
			devpriv->ai_chanlist, devpriv->ai_add_front,
			devpriv->ai_add_back))
		return -EINVAL;
	if (!setup_channel_list(dev, s, devpriv->ai_n_chan,
			devpriv->ai_chanlist, 0, devpriv->ai_add_front,
			devpriv->ai_add_back, devpriv->usedma,
			devpriv->useeoshandle))
		return -EINVAL;

	// compute timers settings
	// simplest way, fr=4Mhz/(tim1*tim2), channel manipulation without timers effect
	if (((cmd->scan_begin_src == TRIG_FOLLOW) || (cmd->scan_begin_src == TRIG_EXT) || (cmd->scan_begin_src == TRIG_INT)) && (cmd->convert_src == TRIG_TIMER)) {	// both timer is used for one time
		if (cmd->scan_begin_src == TRIG_EXT) {
			devpriv->ai_do = 4;
		} else {
			devpriv->ai_do = 1;
		}
		pci9118_calc_divisors(devpriv->ai_do, dev, s,
			&cmd->scan_begin_arg, &cmd->convert_arg,
			devpriv->ai_flags, devpriv->ai_n_realscanlen,
			&devpriv->ai_divisor1, &devpriv->ai_divisor2,
			devpriv->usessh, devpriv->ai_add_front);
		devpriv->ai_timer2 = cmd->convert_arg;
	}

	if ((cmd->scan_begin_src == TRIG_TIMER) && ((cmd->convert_src == TRIG_TIMER) || (cmd->convert_src == TRIG_NOW))) {	// double timed action
		if (!devpriv->usedma) {
			comedi_error(dev,
				"cmd->scan_begin_src=TRIG_TIMER works only with bus mastering!");
			return -EIO;
		}

		devpriv->ai_do = 2;
		pci9118_calc_divisors(devpriv->ai_do, dev, s,
			&cmd->scan_begin_arg, &cmd->convert_arg,
			devpriv->ai_flags, devpriv->ai_n_realscanlen,
			&devpriv->ai_divisor1, &devpriv->ai_divisor2,
			devpriv->usessh, devpriv->ai_add_front);
		devpriv->ai_timer1 = cmd->scan_begin_arg;
		devpriv->ai_timer2 = cmd->convert_arg;
	}

	if ((cmd->scan_begin_src == TRIG_FOLLOW)
		&& (cmd->convert_src == TRIG_EXT)) {
		devpriv->ai_do = 3;
	}

	start_pacer(dev, -1, 0, 0);	// stop pacer

	devpriv->AdControlReg = 0;	// bipolar, S.E., use 8254, stop 8354, internal trigger, soft trigger, disable DMA
	outl(devpriv->AdControlReg, dev->iobase + PCI9118_ADCNTRL);
	devpriv->AdFunctionReg = AdFunction_PDTrg | AdFunction_PETrg;	// positive triggers, no S&H, no burst, burst stop, no post trigger, no about trigger, trigger stop
	outl(devpriv->AdFunctionReg, dev->iobase + PCI9118_ADFUNC);
	comedi_udelay(1);
	outl(0, dev->iobase + PCI9118_DELFIFO);	// flush FIFO
	inl(dev->iobase + PCI9118_ADSTAT);	// flush A/D and INT status register
	inl(dev->iobase + PCI9118_INTSRC);

	devpriv->ai_act_scan = 0;
	devpriv->ai_act_dmapos = 0;
	s->async->cur_chan = 0;
	devpriv->ai_buf_ptr = 0;

	if (devpriv->usedma) {
		ret = pci9118_ai_docmd_dma(dev, s);
	} else {
		ret = pci9118_ai_docmd_sampl(dev, s);
	}

	DPRINTK("adl_pci9118 EDBG: END: pci9118_ai_cmd()\n");
	return ret;
}

/*
==============================================================================
*/
static int check_channel_list(comedi_device * dev, comedi_subdevice * s,
	int n_chan, unsigned int *chanlist, int frontadd, int backadd)
{
	unsigned int i, differencial = 0, bipolar = 0;

	/* correct channel and range number check itself comedi/range.c */
	if (n_chan < 1) {
		comedi_error(dev, "range/channel list is empty!");
		return 0;
	}
	if ((frontadd + n_chan + backadd) > s->len_chanlist) {
		rt_printk
			("comedi%d: range/channel list is too long for actual configuration (%d>%d)!",
			dev->minor, n_chan,
			s->len_chanlist - frontadd - backadd);
		return 0;
	}

	if (CR_AREF(chanlist[0]) == AREF_DIFF)
		differencial = 1;	// all input must be diff
	if (CR_RANGE(chanlist[0]) < PCI9118_BIPOLAR_RANGES)
		bipolar = 1;	// all input must be bipolar
	if (n_chan > 1)
		for (i = 1; i < n_chan; i++) {	// check S.E/diff
			if ((CR_AREF(chanlist[i]) == AREF_DIFF) !=
				(differencial)) {
				comedi_error(dev,
					"Differencial and single ended inputs cann't be mixtured!");
				return 0;
			}
			if ((CR_RANGE(chanlist[i]) < PCI9118_BIPOLAR_RANGES) !=
				(bipolar)) {
				comedi_error(dev,
					"Bipolar and unipolar ranges cann't be mixtured!");
				return 0;
			}
			if ((!devpriv->usemux) & (differencial) &
				(CR_CHAN(chanlist[i]) >=
					this_board->n_aichand)) {
				comedi_error(dev,
					"If AREF_DIFF is used then is available only first 8 channels!");
				return 0;
			}
		}

	return 1;
}

/*
==============================================================================
*/
static int setup_channel_list(comedi_device * dev, comedi_subdevice * s,
	int n_chan, unsigned int *chanlist, int rot, int frontadd, int backadd,
	int usedma, char useeos)
{
	unsigned int i, differencial = 0, bipolar = 0;
	unsigned int scanquad, gain, ssh = 0x00;

	DPRINTK("adl_pci9118 EDBG: BGN: setup_channel_list(%d,.,%d,.,%d,%d,%d,%d)\n", dev->minor, n_chan, rot, frontadd, backadd, usedma);

	if (usedma == 1) {
		rot = 8;
		usedma = 0;
	}

	if (CR_AREF(chanlist[0]) == AREF_DIFF)
		differencial = 1;	// all input must be diff
	if (CR_RANGE(chanlist[0]) < PCI9118_BIPOLAR_RANGES)
		bipolar = 1;	// all input must be bipolar

	// All is ok, so we can setup channel/range list

	if (!bipolar) {
		devpriv->AdControlReg |= AdControl_UniP;	// set unibipolar
	} else {
		devpriv->AdControlReg &= ((~AdControl_UniP) & 0xff);	// enable bipolar
	}

	if (differencial) {
		devpriv->AdControlReg |= AdControl_Diff;	// enable diff inputs
	} else {
		devpriv->AdControlReg &= ((~AdControl_Diff) & 0xff);	// set single ended inputs
	}

	outl(devpriv->AdControlReg, dev->iobase + PCI9118_ADCNTRL);	// setup mode

	outl(2, dev->iobase + PCI9118_SCANMOD);	// gods know why this sequence!
	outl(0, dev->iobase + PCI9118_SCANMOD);
	outl(1, dev->iobase + PCI9118_SCANMOD);

#ifdef PCI9118_PARANOIDCHECK
	devpriv->chanlistlen = n_chan;
	for (i = 0; i < (PCI9118_CHANLEN + 1); i++)
		devpriv->chanlist[i] = 0x55aa;
#endif

	if (frontadd) {		// insert channels for S&H
		ssh = devpriv->softsshsample;
		DPRINTK("FA: %04x: ", ssh);
		for (i = 0; i < frontadd; i++) {	// store range list to card
			scanquad = CR_CHAN(chanlist[0]);	// get channel number;
			gain = CR_RANGE(chanlist[0]);	// get gain number
			scanquad |= ((gain & 0x03) << 8);
			outl(scanquad | ssh, dev->iobase + PCI9118_GAIN);
			DPRINTK("%02x ", scanquad | ssh);
			ssh = devpriv->softsshhold;
		}
		DPRINTK("\n ");
	}

	DPRINTK("SL: ", ssh);
	for (i = 0; i < n_chan; i++) {	// store range list to card
		scanquad = CR_CHAN(chanlist[i]);	// get channel number;
#ifdef PCI9118_PARANOIDCHECK
		devpriv->chanlist[i ^ usedma] = (scanquad & 0xf) << rot;
#endif
		gain = CR_RANGE(chanlist[i]);	// get gain number
		scanquad |= ((gain & 0x03) << 8);
		outl(scanquad | ssh, dev->iobase + PCI9118_GAIN);
		DPRINTK("%02x ", scanquad | ssh);
	}
	DPRINTK("\n ");

	if (backadd) {		// insert channels for fit onto 32bit DMA
		DPRINTK("BA: %04x: ", ssh);
		for (i = 0; i < backadd; i++) {	// store range list to card
			scanquad = CR_CHAN(chanlist[0]);	// get channel number;
			gain = CR_RANGE(chanlist[0]);	// get gain number
			scanquad |= ((gain & 0x03) << 8);
			outl(scanquad | ssh, dev->iobase + PCI9118_GAIN);
			DPRINTK("%02x ", scanquad | ssh);
		}
		DPRINTK("\n ");
	}
#ifdef PCI9118_PARANOIDCHECK
	devpriv->chanlist[n_chan ^ usedma] = devpriv->chanlist[0 ^ usedma];	// for 32bit oerations
	if (useeos) {
		for (i = 1; i < n_chan; i++) {	// store range list to card
			devpriv->chanlist[(n_chan + i) ^ usedma] =
				(CR_CHAN(chanlist[i]) & 0xf) << rot;
		}
		devpriv->chanlist[(2 * n_chan) ^ usedma] = devpriv->chanlist[0 ^ usedma];	// for 32bit oerations
		useeos = 2;
	} else {
		useeos = 1;
	}
#ifdef PCI9118_EXTDEBUG
	DPRINTK("CHL: ");
	for (i = 0; i <= (useeos * n_chan); i++) {
		DPRINTK("%04x ", devpriv->chanlist[i]);
	}
	DPRINTK("\n ");
#endif
#endif
	outl(0, dev->iobase + PCI9118_SCANMOD);	// close scan queue
//      comedi_udelay(100);                             // important delay, or first sample will be cripled

	DPRINTK("adl_pci9118 EDBG: END: setup_channel_list()\n");
	return 1;		// we can serve this with scan logic
}

/*
==============================================================================
  calculate 8254 divisors if they are used for dual timing
*/
static void pci9118_calc_divisors(char mode, comedi_device * dev,
	comedi_subdevice * s, unsigned int *tim1, unsigned int *tim2,
	unsigned int flags, int chans, unsigned int *div1, unsigned int *div2,
	char usessh, unsigned int chnsshfront)
{
	DPRINTK("adl_pci9118 EDBG: BGN: pci9118_calc_divisors(%d,%d,.,%u,%u,%u,%d,.,.,,%u,%u)\n", mode, dev->minor, *tim1, *tim2, flags, chans, usessh, chnsshfront);
	switch (mode) {
	case 1:
	case 4:
		if (*tim2 < this_board->ai_ns_min)
			*tim2 = this_board->ai_ns_min;
		i8253_cascade_ns_to_timer(devpriv->i8254_osc_base, div1, div2,
			tim2, flags & TRIG_ROUND_NEAREST);
		DPRINTK("OSC base=%u div1=%u div2=%u timer1=%u\n",
			devpriv->i8254_osc_base, *div1, *div2, *tim1);
		break;
	case 2:
		if (*tim2 < this_board->ai_ns_min)
			*tim2 = this_board->ai_ns_min;
		DPRINTK("1 div1=%u div2=%u timer1=%u timer2=%u\n", *div1, *div2,
			*tim1, *tim2);
		*div1 = *tim2 / devpriv->i8254_osc_base;	// convert timer (burst)
		DPRINTK("2 div1=%u div2=%u timer1=%u timer2=%u\n", *div1, *div2,
			*tim1, *tim2);
		if (*div1 < this_board->ai_pacer_min)
			*div1 = this_board->ai_pacer_min;
		DPRINTK("3 div1=%u div2=%u timer1=%u timer2=%u\n", *div1, *div2,
			*tim1, *tim2);
		*div2 = *tim1 / devpriv->i8254_osc_base;	// scan timer
		DPRINTK("4 div1=%u div2=%u timer1=%u timer2=%u\n", *div1, *div2,
			*tim1, *tim2);
		*div2 = *div2 / *div1;	// major timer is c1*c2
		DPRINTK("5 div1=%u div2=%u timer1=%u timer2=%u\n", *div1, *div2,
			*tim1, *tim2);
		if (*div2 < chans)
			*div2 = chans;
		DPRINTK("6 div1=%u div2=%u timer1=%u timer2=%u\n", *div1, *div2,
			*tim1, *tim2);

		*tim2 = *div1 * devpriv->i8254_osc_base;	// real convert timer

		if (usessh & (chnsshfront == 0))	// use BSSH signal
			if (*div2 < (chans + 2))
				*div2 = chans + 2;

		DPRINTK("7 div1=%u div2=%u timer1=%u timer2=%u\n", *div1, *div2,
			*tim1, *tim2);
		*tim1 = *div1 * *div2 * devpriv->i8254_osc_base;
		DPRINTK("OSC base=%u div1=%u div2=%u timer1=%u timer2=%u\n",
			devpriv->i8254_osc_base, *div1, *div2, *tim1, *tim2);
		break;
	}
	DPRINTK("adl_pci9118 EDBG: END: pci9118_calc_divisors(%u,%u)\n",
		*div1, *div2);
}

/*
==============================================================================
*/
static void start_pacer(comedi_device * dev, int mode, unsigned int divisor1,
	unsigned int divisor2)
{
	outl(0x74, dev->iobase + PCI9118_CNTCTRL);
	outl(0xb4, dev->iobase + PCI9118_CNTCTRL);
//      outl(0x30, dev->iobase + PCI9118_CNTCTRL);
	comedi_udelay(1);

	if ((mode == 1) || (mode == 2) || (mode == 4)) {
		outl(divisor2 & 0xff, dev->iobase + PCI9118_CNT2);
		outl((divisor2 >> 8) & 0xff, dev->iobase + PCI9118_CNT2);
		outl(divisor1 & 0xff, dev->iobase + PCI9118_CNT1);
		outl((divisor1 >> 8) & 0xff, dev->iobase + PCI9118_CNT1);
	}
}

/*
==============================================================================
*/
static int pci9118_exttrg_add(comedi_device * dev, unsigned char source)
{
	if (source > 3)
		return -1;	// incorrect source
	devpriv->exttrg_users |= (1 << source);
	devpriv->IntControlReg |= Int_DTrg;
	outl(devpriv->IntControlReg, dev->iobase + PCI9118_INTCTRL);
	outl(inl(devpriv->iobase_a + AMCC_OP_REG_INTCSR) | 0x1f00, devpriv->iobase_a + AMCC_OP_REG_INTCSR);	// allow INT in AMCC
	return 0;
}

/*
==============================================================================
*/
static int pci9118_exttrg_del(comedi_device * dev, unsigned char source)
{
	if (source > 3)
		return -1;	// incorrect source
	devpriv->exttrg_users &= ~(1 << source);
	if (!devpriv->exttrg_users) {	// shutdown ext trg intterrupts
		devpriv->IntControlReg &= ~Int_DTrg;
		if (!devpriv->IntControlReg)	// all IRQ disabled
			outl(inl(devpriv->iobase_a + AMCC_OP_REG_INTCSR) & (~0x00001f00), devpriv->iobase_a + AMCC_OP_REG_INTCSR);	// disable int in AMCC
		outl(devpriv->IntControlReg, dev->iobase + PCI9118_INTCTRL);
	}
	return 0;
}

/*
==============================================================================
*/
static int pci9118_ai_cancel(comedi_device * dev, comedi_subdevice * s)
{
	if (devpriv->usedma)
		outl(inl(devpriv->iobase_a + AMCC_OP_REG_MCSR) & (~EN_A2P_TRANSFERS), devpriv->iobase_a + AMCC_OP_REG_MCSR);	// stop DMA
	pci9118_exttrg_del(dev, EXTTRG_AI);
	start_pacer(dev, 0, 0, 0);	// stop 8254 counters
	devpriv->AdFunctionReg = AdFunction_PDTrg | AdFunction_PETrg;
	outl(devpriv->AdFunctionReg, dev->iobase + PCI9118_ADFUNC);	// positive triggers, no S&H, no burst, burst stop, no post trigger, no about trigger, trigger stop
	devpriv->AdControlReg = 0x00;
	outl(devpriv->AdControlReg, dev->iobase + PCI9118_ADCNTRL);	// bipolar, S.E., use 8254, stop 8354, internal trigger, soft trigger, disable INT and DMA
	outl(0, dev->iobase + PCI9118_BURST);
	outl(1, dev->iobase + PCI9118_SCANMOD);
	outl(2, dev->iobase + PCI9118_SCANMOD);	// reset scan queue
	outl(0, dev->iobase + PCI9118_DELFIFO);	// flush FIFO

	devpriv->ai_do = 0;
	devpriv->usedma = 0;

	devpriv->ai_act_scan = 0;
	devpriv->ai_act_dmapos = 0;
	s->async->cur_chan = 0;
	s->async->inttrig = NULL;
	devpriv->ai_buf_ptr = 0;
	devpriv->ai_neverending = 0;
	devpriv->dma_actbuf = 0;

	if (!devpriv->IntControlReg)
		outl(inl(devpriv->iobase_a + AMCC_OP_REG_INTCSR) | 0x1f00, devpriv->iobase_a + AMCC_OP_REG_INTCSR);	// allow INT in AMCC

	return 0;
}

/*
==============================================================================
*/
static int pci9118_reset(comedi_device * dev)
{
	devpriv->IntControlReg = 0;
	devpriv->exttrg_users = 0;
	inl(dev->iobase + PCI9118_INTCTRL);
	outl(devpriv->IntControlReg, dev->iobase + PCI9118_INTCTRL);	// disable interrupts source
	outl(0x30, dev->iobase + PCI9118_CNTCTRL);
//        outl(0xb4, dev->iobase + PCI9118_CNTCTRL);
	start_pacer(dev, 0, 0, 0);	// stop 8254 counters
	devpriv->AdControlReg = 0;
	outl(devpriv->AdControlReg, dev->iobase + PCI9118_ADCNTRL);	// bipolar, S.E., use 8254, stop 8354, internal trigger, soft trigger, disable INT and DMA
	outl(0, dev->iobase + PCI9118_BURST);
	outl(1, dev->iobase + PCI9118_SCANMOD);
	outl(2, dev->iobase + PCI9118_SCANMOD);	// reset scan queue
	devpriv->AdFunctionReg = AdFunction_PDTrg | AdFunction_PETrg;
	outl(devpriv->AdFunctionReg, dev->iobase + PCI9118_ADFUNC);	// positive triggers, no S&H, no burst, burst stop, no post trigger, no about trigger, trigger stop

	devpriv->ao_data[0] = 2047;
	devpriv->ao_data[1] = 2047;
	outl(devpriv->ao_data[0], dev->iobase + PCI9118_DA1);	// reset A/D outs to 0V
	outl(devpriv->ao_data[1], dev->iobase + PCI9118_DA2);
	outl(0, dev->iobase + PCI9118_DO);	// reset digi outs to L
	comedi_udelay(10);
	inl(dev->iobase + PCI9118_AD_DATA);
	outl(0, dev->iobase + PCI9118_DELFIFO);	// flush FIFO
	outl(0, dev->iobase + PCI9118_INTSRC);	// remove INT requests
	inl(dev->iobase + PCI9118_ADSTAT);	// flush A/D status register
	inl(dev->iobase + PCI9118_INTSRC);	// flush INT requests
	devpriv->AdControlReg = 0;
	outl(devpriv->AdControlReg, dev->iobase + PCI9118_ADCNTRL);	// bipolar, S.E., use 8254, stop 8354, internal trigger, soft trigger, disable INT and DMA

	devpriv->cnt0_users = 0;
	devpriv->exttrg_users = 0;

	return 0;
}

/*
==============================================================================
*/
static int pci9118_attach(comedi_device * dev, comedi_devconfig * it)
{
	comedi_subdevice *s;
	int ret, pages, i;
	unsigned short master;
	unsigned int irq;
	unsigned long iobase_a, iobase_9;
	struct pci_dev *pcidev;
	int opt_bus, opt_slot;
	const char *errstr;
	unsigned char pci_bus, pci_slot, pci_func;
	u16 u16w;

	rt_printk("comedi%d: adl_pci9118: board=%s", dev->minor,
		this_board->name);

	opt_bus = it->options[0];
	opt_slot = it->options[1];
	if (it->options[3] & 1) {
		master = 0;	// user don't want use bus master
	} else {
		master = 1;
	}

	if ((ret = alloc_private(dev, sizeof(pci9118_private))) < 0) {
		rt_printk(" - Allocation failed!\n");
		return -ENOMEM;
	}

	/* Look for matching PCI device */
	errstr = "not found!";
	pcidev = NULL;
	while (NULL != (pcidev = pci_get_device(PCI_VENDOR_ID_AMCC,
				this_board->device_id, pcidev))) {
		/* Found matching vendor/device. */
		if (opt_bus || opt_slot) {
			/* Check bus/slot. */
			if (opt_bus != pcidev->bus->number
				|| opt_slot != PCI_SLOT(pcidev->devfn))
				continue;	/* no match */
		}
		/*
		 * Look for device that isn't in use.
		 * Enable PCI device and request regions.
		 */
		if (comedi_pci_enable(pcidev, "adl_pci9118")) {
			errstr = "failed to enable PCI device and request regions!";
			continue;
		}
		break;
	}

	if (!pcidev) {
		if (opt_bus || opt_slot) {
			rt_printk(" - Card at b:s %d:%d %s\n",
				opt_bus, opt_slot, errstr);
		} else {
			rt_printk(" - Card %s\n", errstr);
		}
		return -EIO;
	}

	if (master) {
		pci_set_master(pcidev);
	}

	pci_bus = pcidev->bus->number;
	pci_slot = PCI_SLOT(pcidev->devfn);
	pci_func = PCI_FUNC(pcidev->devfn);
	irq = pcidev->irq;
	iobase_a = pci_resource_start(pcidev, 0);
	iobase_9 = pci_resource_start(pcidev, 2);

	rt_printk(", b:s:f=%d:%d:%d, io=0x%4lx, 0x%4lx", pci_bus, pci_slot,
		pci_func, iobase_9, iobase_a);

	dev->iobase = iobase_9;
	dev->board_name = this_board->name;

	devpriv->pcidev = pcidev;
	devpriv->iobase_a = iobase_a;

	pci9118_reset(dev);

	if (it->options[3] & 2)
		irq = 0;	// user don't want use IRQ
	if (irq > 0) {
		if (comedi_request_irq(irq, interrupt_pci9118, IRQF_SHARED,
				"ADLink PCI-9118", dev)) {
			rt_printk(", unable to allocate IRQ %d, DISABLING IT",
				irq);
			irq = 0;	/* Can't use IRQ */
		} else {
			rt_printk(", irq=%u", irq);
		}
	} else {
		rt_printk(", IRQ disabled");
	}

	dev->irq = irq;

	if (master) {		// alloc DMA buffers
		devpriv->dma_doublebuf = 0;
		for (i = 0; i < 2; i++) {
			for (pages = 4; pages >= 0; pages--)
				if ((devpriv->dmabuf_virt[i] = (sampl_t *)
						__get_free_pages(GFP_KERNEL,
							pages)))
					break;
			if (devpriv->dmabuf_virt[i]) {
				devpriv->dmabuf_pages[i] = pages;
				devpriv->dmabuf_size[i] = PAGE_SIZE * pages;
				devpriv->dmabuf_samples[i] =
					devpriv->dmabuf_size[i] >> 1;
				devpriv->dmabuf_hw[i] =
					virt_to_bus((void *)devpriv->
					dmabuf_virt[i]);
			}
		}
		if (!devpriv->dmabuf_virt[0]) {
			rt_printk(", Can't allocate DMA buffer, DMA disabled!");
			master = 0;
		}

		if (devpriv->dmabuf_virt[1])
			devpriv->dma_doublebuf = 1;

	}

	if ((devpriv->master = master)) {
		rt_printk(", bus master");
	} else {
		rt_printk(", no bus master");
	}

	devpriv->usemux = 0;
	if (it->options[2] > 0) {
		devpriv->usemux = it->options[2];
		if (devpriv->usemux > 256)
			devpriv->usemux = 256;	// max 256 channels!
		if (it->options[4] > 0)
			if (devpriv->usemux > 128) {
				devpriv->usemux = 128;	// max 128 channels with softare S&H!
			}
		rt_printk(", ext. mux %d channels", devpriv->usemux);
	}

	devpriv->softsshdelay = it->options[4];
	if (devpriv->softsshdelay < 0) {	// select sample&hold signal polarity
		devpriv->softsshdelay = -devpriv->softsshdelay;
		devpriv->softsshsample = 0x80;
		devpriv->softsshhold = 0x00;
	} else {
		devpriv->softsshsample = 0x00;
		devpriv->softsshhold = 0x80;
	}

	rt_printk(".\n");

	pci_read_config_word(devpriv->pcidev, PCI_COMMAND, &u16w);
	pci_write_config_word(devpriv->pcidev, PCI_COMMAND, u16w | 64);	// Enable parity check for parity error

	if ((ret = alloc_subdevices(dev, 4)) < 0)
		return ret;

	s = dev->subdevices + 0;
	dev->read_subdev = s;
	s->type = COMEDI_SUBD_AI;
	s->subdev_flags = SDF_READABLE | SDF_COMMON | SDF_GROUND | SDF_DIFF;
	if (devpriv->usemux) {
		s->n_chan = devpriv->usemux;
	} else {
		s->n_chan = this_board->n_aichan;
	}
	s->maxdata = this_board->ai_maxdata;
	s->len_chanlist = this_board->n_aichanlist;
	s->range_table = this_board->rangelist_ai;
	s->cancel = pci9118_ai_cancel;
	s->insn_read = pci9118_insn_read_ai;
	if (dev->irq) {
		s->subdev_flags |= SDF_CMD_READ;
		s->do_cmdtest = pci9118_ai_cmdtest;
		s->do_cmd = pci9118_ai_cmd;
		s->munge = pci9118_ai_munge;
	}

	s = dev->subdevices + 1;
	s->type = COMEDI_SUBD_AO;
	s->subdev_flags = SDF_WRITABLE | SDF_GROUND | SDF_COMMON;
	s->n_chan = this_board->n_aochan;
	s->maxdata = this_board->ao_maxdata;
	s->len_chanlist = this_board->n_aochan;
	s->range_table = this_board->rangelist_ao;
	s->insn_write = pci9118_insn_write_ao;
	s->insn_read = pci9118_insn_read_ao;

	s = dev->subdevices + 2;
	s->type = COMEDI_SUBD_DI;
	s->subdev_flags = SDF_READABLE | SDF_GROUND | SDF_COMMON;
	s->n_chan = 4;
	s->maxdata = 1;
	s->len_chanlist = 4;
	s->range_table = &range_digital;
	s->io_bits = 0;		/* all bits input */
	s->insn_bits = pci9118_insn_bits_di;

	s = dev->subdevices + 3;
	s->type = COMEDI_SUBD_DO;
	s->subdev_flags = SDF_WRITABLE | SDF_GROUND | SDF_COMMON;
	s->n_chan = 4;
	s->maxdata = 1;
	s->len_chanlist = 4;
	s->range_table = &range_digital;
	s->io_bits = 0xf;	/* all bits output */
	s->insn_bits = pci9118_insn_bits_do;

	devpriv->valid = 1;
	devpriv->i8254_osc_base = 250;	// 250ns=4MHz
	devpriv->ai_maskharderr = 0x10a;	// default measure crash condition
	if (it->options[5])	// disable some requested
		devpriv->ai_maskharderr &= ~it->options[5];

	switch (this_board->ai_maxdata) {
	case 0xffff:
		devpriv->ai16bits = 1;
		break;
	default:
		devpriv->ai16bits = 0;
		break;
	}
	return 0;
}

/*
==============================================================================
*/
static int pci9118_detach(comedi_device * dev)
{
	if (dev->private) {
		if (devpriv->valid)
			pci9118_reset(dev);
		if (dev->irq)
			comedi_free_irq(dev->irq, dev);
		if (devpriv->pcidev) {
			if (dev->iobase) {
				comedi_pci_disable(devpriv->pcidev);
			}
			pci_dev_put(devpriv->pcidev);
		}
		if (devpriv->dmabuf_virt[0])
			free_pages((unsigned long)devpriv->dmabuf_virt[0],
				devpriv->dmabuf_pages[0]);
		if (devpriv->dmabuf_virt[1])
			free_pages((unsigned long)devpriv->dmabuf_virt[1],
				devpriv->dmabuf_pages[1]);
	}

	return 0;
}

/*
==============================================================================
*/

--Boundary-00=_pIXvNdQrmwmzrNO--


