Message-ID: <4D238C44.8000101@domain.hid>
Date: Tue, 04 Jan 2011 22:08:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTim+BeV2q5stB-ErSVqF9Oy5BJTHtZF29aPN1c6w@domain.hid>
In-Reply-To: <AANLkTim+BeV2q5stB-ErSVqF9Oy5BJTHtZF29aPN1c6w@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] PCI1711 Rtdm driver reading and writing error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: adilkaraoz <adilkaraoz@domain.hid>
Cc: xenomai@xenomai.org

adilkaraoz wrote:
>   pci1711_card->location = pci_resource_start(dev, PCI_1711_BAR & 0xFFFFFFF0
> );
>   pci1711_card->mem_size = pci_resource_len(dev, PCI_1711_BAR & 0xFFFFFFF0
> );

I really have doubts about this: the arguments passed to these functions
should be a something ranging from 0 to 5 inclusive. Now, PCI_1711_BAR &
0xFFFFFFF0 seems odd.
If PCI_1711_BAR is less than 0x10, the result of this mask will always be 0.
If PCI_1711_BAR is greater than 0xf, you end up accessing random memory.

Also note that since 2.6.28, there is a pci_ioremap_bar function, which
does all the pci_resouce and ioremap job.

> 
>   //if(pci1711_card->location == 0){
>     printk( KERN_WARNING "xeno_pc1711_driver: location = %lx mem = %lx\n",
> pci1711_card->location, pci1711_card->mem_size);
>   //}
> 
>     ret_val = pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
>     if (!ret_val){
> rtdm_printk("interrupt line no:%d",irq);
>  }

That is not the way to get the interrupt line either, you should use
dev->irq.

-- 
                                                                Gilles.

