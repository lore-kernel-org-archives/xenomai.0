From: Sebastian Smolorz <smolorz@domain.hid>
Date: Wed, 9 Jun 2010 15:46:20 +0200
References: <20100609084823.99850@domain.hid> <4C0F58C7.1060700@domain.hid>
	<20100609132600.302600@domain.hid>
In-Reply-To: <20100609132600.302600@domain.hid>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201006091546.20998.smolorz@domain.hid>
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
To: Nils Armbruster <nils-a@domain.hid>
Cc: xenomai@xenomai.org

Nils Armbruster wrote:
> void FS_OnBoard_can_data_out(int if_nr, unsigned char addr, unsigned char
>  data, void *dev) {
> 	struct netdcux_can *nx_can = (struct netdcux_can *)dev;
> 	unsigned long can_flags;
> 
> #ifdef FS_CAN_DEBUG
> 	printk("OnBoard_can_out[%d] addr: %x value: %x\n", if_nr, addr, data);
> #endif
> 	spin_lock_irqsave(&fscan_atomic_lock, can_flags);
> 	iowrite8(addr, nx_can->if_virtaddr_addr[if_nr]);
> 	iowrite8(data, nx_can->if_virtaddr_data[if_nr]);
> 	spin_unlock_irqrestore(&fscan_atomic_lock, can_flags);
> }
> 

Here we have the reason. the SJA1000 registers aren't linearly mapped into 
the memory space of the processor; it seems that every write to such a 
registers needs two iowrite8s: First the address, then the data. So I would 
say the xeno_can_mem driver isn't useful for you. Your CAN hardware needs a 
special RTCAN driver which does not exist yet.

-- 
Sebastian

