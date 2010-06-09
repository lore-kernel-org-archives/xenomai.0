Content-Type: text/plain; charset="utf-8"
Date: Wed, 09 Jun 2010 15:26:00 +0200
From: "Nils Armbruster" <nils-a@domain.hid>
In-Reply-To: <4C0F58C7.1060700@domain.hid>
Message-ID: <20100609132600.302600@domain.hid>
MIME-Version: 1.0
References: <20100609084823.99850@domain.hid> <4C0F58C7.1060700@domain.hid>
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] xeno_can_mem driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org


-------- Original-Nachricht --------
> Datum: Wed, 09 Jun 2010 11:03:03 +0200
> Von: Wolfgang Grandegger <wg@domain.hid>
> An: Nils Armbruster <nils-a@domain.hid>
> CC: smolorz@domain.hid, xenomai@xenomai.org
> Betreff: Re: [Xenomai-help] xeno_can_mem driver

> On 06/09/2010 10:48 AM, Nils Armbruster wrote:
> > Thank you for your reply !
> > 
> >>>  I'm currently trying to get the can-interfaces of an Samsung S3C2440
> >>>   based board working (NetDCU10). The used Linux kernel version is 
> >>> 2.6.19,
> >>>   because this was deliverd in the BSP. I patched this kernel with 
> >>> Xenomai
> >>>   2.4.0., as this was the newest Version I managed the Kernel to
> compile
> >>>   with.
> >>>
> >>>  The standard driver delivered with the board (lincan 0.3.3) mappes
> the
> >>>   can devices to 10000000-10000007 : onboard-can
> >>>  10000008-1000000f :
> >>>  onboard-can
> >>
> >> Hmm, the SJA1000 has 32 registers, not just 8.
> >>
> > 
> > This is strange, cause the original driver just maps these 8 registers.
> 
> How does the read/write register access function look like in your
> lincan driver?

The registers in lincan driver are written as follows:

extern inline void can_write_reg(const struct canchip_t *chip, unsigned char data, unsigned address)
{
	unsigned long address_to_write;
	address_to_write = chip->chip_base_addr+address;
	chip->write_register(chip, data, address_to_write);
}

where through chip->write_register the following function is called:

void netdcux_can_write_register(const struct canchip_t *chip, unsigned data, unsigned long address)
{
	struct candevice_t *candev = chip->hostdevice;
	struct netdcux_can *nx_can = (struct netdcux_can*)candev->private_data;
	int chipnr;

	chipnr = (address & (0xF << 28)) >> 28;
	nx_can->send_byte_can(chipnr, (0xFF & address), data, (void *)nx_can);
}

adress should be 0x10000000 + Reg so chipnr should be just 0x10000000  after the bit operations.
I think nx_can->send_byte_can calls this function:

void FS_OnBoard_can_data_out(int if_nr, unsigned char addr, unsigned char data, void *dev)
{
	struct netdcux_can *nx_can = (struct netdcux_can *)dev;
	unsigned long can_flags;

#ifdef FS_CAN_DEBUG
	printk("OnBoard_can_out[%d] addr: %x value: %x\n", if_nr, addr, data);
#endif
	spin_lock_irqsave(&fscan_atomic_lock, can_flags);
	iowrite8(addr, nx_can->if_virtaddr_addr[if_nr]);
	iowrite8(data, nx_can->if_virtaddr_data[if_nr]);
	spin_unlock_irqrestore(&fscan_atomic_lock, can_flags);
}

So I think the address of the can controller should still be 0x10000000.
Or am I thinking wrong?

> 
> > 
> >>>  So I tried to use the driver xeno_can_mem.
> >>>
> >>>  I use
> >>>  modprobe xen_can_mem mem=0x10000000 irq=17 clock=48000000
> 
> Where did you get irq=17 from? From /proc/interrups?
> 
> > Sorry for my stupid question, but how can I find out where the registers
> are mapped?
> > In the original driver the base address is defined as 0x10000000.
> > Port size ist defined as 4 and when the memory region is requested twice
> of the port size is requested:
> > request_mem_region(mem_addr, nx_can->if_portsize * 2, "onboard-can")
> > 
> > Do you have any suggestions how I should proceed?
> 
> I assume that the lincan driver source code is under the GPL. Feel free
> to post it here so we can have a closer look.
> 
> Wolfgang.

-- 
GRATIS für alle GMX-Mitglieder: Die maxdome Movie-FLAT!
Jetzt freischalten unter http://portal.gmx.net/de/go/maxdome01

