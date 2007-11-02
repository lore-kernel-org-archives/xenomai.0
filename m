Message-ID: <472B3B5C.9010002@domain.hid>
Date: Fri, 02 Nov 2007 15:59:40 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <fd6a47a90711020421u6c5a6dadqff4864eec6aa188@domain.hid>	
	<472B0EED.40209@domain.hid>	
	<fd6a47a90711020549u5630ec9cgda7042c8c6c0f10a@domain.hid>	
	<fd6a47a90711020636t73e357d5ub9cbca0675adc1d7@domain.hid>
	<fd6a47a90711020730m662abcc9q69fcb4f87ad470cc@domain.hid>
In-Reply-To: <fd6a47a90711020730m662abcc9q69fcb4f87ad470cc@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Registering MSI interrupt with Xenomai fails
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jeroen Van den Keybus wrote:
>      
>     Now looking into xnintr_attach().
> 
>  
> In xnintr_attach(), the crash occurs in xnarch_set_irq_affinity(). If
> the call is removed, the driver works as expected (gaining another 3
> usec of latency). Now investigating ipipe_set_irq_affinity.
>  

arch_setup_msi_irq() creates an IRQ on-the-fly from the current
descriptor which is being converted to an MSI interrupt using
pci_msi_enable(). From that point, the I-pipe might have an obsolete
view of the interrupt map. I suspect an I-pipe issue here.

-- 
Philippe.

