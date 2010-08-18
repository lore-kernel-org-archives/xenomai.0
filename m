From: Paul <paul_c@domain.hid>
Date: Wed, 18 Aug 2010 20:03:20 +0100
References: <4C6C256A.3060404@domain.hid>
In-Reply-To: <4C6C256A.3060404@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201008182003.20212.paul_c@domain.hid>
Subject: Re: [Xenomai-help] RTDM : Obtaining PCI base address
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, ramoncostacastello@domain.hid

On Wednesday 18 August 2010, Ramon wrote:
> Hi,
>
> In order to introduce myself to RTDM and driver development in
> Xenomai, I'm trying to develop a simple "driver"
> for an advantech PCI-1711 card.
>
> First thing I need to do is obtaining the PCI base address of the
> card. To do this I used an old code I already have :
>
> struct pci_dev *pcidev;
>
> printk("PCI-1711 DETECT PCI \n");
> pcidev=NULL;
> pcidev =pci_get_device (PCI_VENDOR_, PCI_DEVICE_, pcidev );
> if (pcidev==NULL){
> 	printk("PCI-1711 CANNOT BE FOUND \n");
> }
> else{
>      printk("PCI-1711 LOCATED \n");
>      if (pci_enable_device(pcidev)){
>        printk("PCI-1711 NOT ENABLED \n");
>        return(-EIO);
>      }
>      else{
>          printk("PCI-1711 ENABLED \n");
> 	}
>      PCI_BASE_ADRESS_1711= pci_resource_start(pcidev, 1)&   
> PCI_BASE_ADDRESS_MEM_MASK; printk("PCI-1711 DETECT PCI %x
> \n",PCI_BASE_ADRESS_1711); }
>
>
>
> Unfortunatelly PCI_BASE_ADRESS_1711 always takes de 0 value.
>
> Is this type of code already valid in current linux kernels ?
> Could anyone point me to a similar code ?
>
> Thank you in advance
> Ramon

Are you sure you have the right BAR for this card ?
Refering to the Comedi driver, they use pci_resource_start(pcidev, 2) to 
obtain the IO base address (without using PCI_BASE_ADDRESS_MEM_MASK).

Regards, Paul.

