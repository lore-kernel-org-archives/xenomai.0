Message-ID: <fd6a47a90711031042j568938fev22c3b5a6f99d8e17@domain.hid>
Date: Sat, 3 Nov 2007 18:42:45 +0100
From: "Jeroen Van den Keybus" <jeroen.vandenkeybus@domain.hid>
In-Reply-To: <472B3B5C.9010002@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_7151_29021625.1194111765540"
References: <fd6a47a90711020421u6c5a6dadqff4864eec6aa188@domain.hid>
	<472B0EED.40209@domain.hid>
	<fd6a47a90711020549u5630ec9cgda7042c8c6c0f10a@domain.hid>
	<fd6a47a90711020636t73e357d5ub9cbca0675adc1d7@domain.hid>
	<fd6a47a90711020730m662abcc9q69fcb4f87ad470cc@domain.hid>
	<472B3B5C.9010002@domain.hid>
Subject: Re: [Xenomai-core] Registering MSI interrupt with Xenomai fails
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

------=_Part_7151_29021625.1194111765540
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
>
> arch_setup_msi_irq() creates an IRQ on-the-fly from the current
> descriptor which is being converted to an MSI interrupt using
> pci_msi_enable(). From that point, the I-pipe might have an obsolete
> view of the interrupt map. I suspect an I-pipe issue here.



I think the I-pipe is alright. It only cares for the actual interrupt
numbers and irq_desc[] should be current with these numbers upon the
ipipe_virtualize_irq call, which occurs only after enabling MSI, right ?

Currently it looks like every PCI config space access instruction in
read_msi_msg() (used to perform set_msi_irq_affinity) freezes the machine. I
have absolutely no clue yet why this happens.

Jeroen.


--
> Philippe.
>

------=_Part_7151_29021625.1194111765540
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>arch_setup_msi_irq() creates an IRQ on-the-fly from the current<br>descriptor which is being converted to an MSI interrupt using
<br>pci_msi_enable(). From that point, the I-pipe might have an obsolete<br>view of the interrupt map. I suspect an I-pipe issue here.</blockquote><div><br><br>I think the I-pipe is alright. It only cares for the actual interrupt numbers and irq_desc[] should be current with these numbers upon the ipipe_virtualize_irq call, which occurs only after enabling MSI, right ?
<br><br>Currently it looks like every PCI config space access instruction in read_msi_msg() (used to perform set_msi_irq_affinity) freezes the machine. I have absolutely no clue yet why this happens. <br><br> Jeroen.<br><br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">--<br>Philippe.<br></blockquote></div><br>

------=_Part_7151_29021625.1194111765540--

