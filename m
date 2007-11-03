Message-ID: <fd6a47a90711031236g7415be6fn3a6d838846e082ef@domain.hid>
Date: Sat, 3 Nov 2007 20:36:26 +0100
From: "Jeroen Van den Keybus" <jeroen.vandenkeybus@domain.hid>
In-Reply-To: <472CBBAC.7030403@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_7275_15080004.1194118586075"
References: <fd6a47a90711020421u6c5a6dadqff4864eec6aa188@domain.hid>
	<472B0EED.40209@domain.hid>
	<fd6a47a90711020549u5630ec9cgda7042c8c6c0f10a@domain.hid>
	<fd6a47a90711020636t73e357d5ub9cbca0675adc1d7@domain.hid>
	<fd6a47a90711020730m662abcc9q69fcb4f87ad470cc@domain.hid>
	<472B3B5C.9010002@domain.hid>
	<fd6a47a90711031042j568938fev22c3b5a6f99d8e17@domain.hid>
	<472CBBAC.7030403@domain.hid>
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

------=_Part_7275_15080004.1194118586075
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> The I-pipe virtualizes all IOAPIC and ISA interrupts upon startup. Then,
> any code calling pci_msi_enable() would end up allocating a new MSI
> interrupt vector.


I see. So in fact, at least for the Linux domain, which indeed registers all
interrupts upon initialization, every newly created MSI vector should be
revirtualized.



> > Currently it looks like every PCI config space access instruction in
> > read_msi_msg() (used to perform set_msi_irq_affinity) freezes the
> > machine. I have absolutely no clue yet why this happens.
> >
>
> Wild trivial guess, is the irq parameter the expected one, since the
> rest depends on it?


You mean the one passed into xnarch_set_irq_affinity ? Yes, it is
consistently 219 and the mask is 0x3. In set_msi_irq_affinity(), the
associated vector is calculated as 225. I'm not sure the latter one is
correct, but at least it shouldn't freeze the machine upon a PCI config
read.

Could there be any reason why e.g. a pci_config_read_dword() call would in
Xenomai context (because when still in the module probe code, I can perform
the call correctly - in both cases I checked the dev->bus->ops->read/write
pointers and they are identical) ?


Jeroen.

------=_Part_7275_15080004.1194118586075
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">The I-pipe virtualizes all IOAPIC and ISA interrupts upon startup. Then,<br>any code calling pci_msi_enable() would end up allocating a new MSI
<br>interrupt vector.</blockquote>
<div>&nbsp;</div>
<div>I see. So in fact, at least for the Linux domain, which indeed registers all interrupts upon initialization, every newly created MSI vector should be revirtualized.</div>
<div><br>&nbsp;</div>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">&gt; Currently it looks like every PCI config space access instruction in<br>&gt; read_msi_msg() (used to perform set_msi_irq_affinity) freezes the
<br>&gt; machine. I have absolutely no clue yet why this happens.<br>&gt;<br><br>Wild trivial guess, is the irq parameter the expected one, since the<br>rest depends on it?</blockquote>
<div>&nbsp;</div>
<div>You mean the one passed into xnarch_set_irq_affinity ? Yes, it is consistently 219 and the mask is 0x3. In set_msi_irq_affinity(), the associated vector is calculated as 225. I&#39;m not sure the latter one is correct, but at least it shouldn&#39;t freeze the machine upon a PCI config read.
</div>
<div>&nbsp;</div>
<div>Could there be any reason why&nbsp;e.g. a pci_config_read_dword()&nbsp;call would in Xenomai context&nbsp;(because when still in the module probe code, I can&nbsp;perform the call correctly - in both cases I checked the dev-&gt;bus-&gt;ops-&gt;read/write pointers and they are identical) ?
</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Jeroen.</div>

------=_Part_7275_15080004.1194118586075--

