Message-ID: <486A9516.6000703@domain.hid>
Date: Tue, 01 Jul 2008 22:35:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <200807010043.33331.leo@domain.hid>
In-Reply-To: <200807010043.33331.leo@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] IRQs and PCIs
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Leopold Palomo Avellaneda <leo@domain.hid>
Cc: xenomai@xenomai.org

Leopold Palomo Avellaneda wrote:
> Hi,
> 
> maybe is an off toppic, but probably some like me has this issue. I have a 
> mainboard with several PCI and two PCIe. I can configure the PCIe to use with 
> rtnet and xenomai without any important problem.
> 
> The mobo has an eth and firewire and vga incorporated, so the pci are free. 
> But now, I would like to add a pci network card. I have three:
> - on for our environtment
> - two for the rtnet (two robot controlers)
> 
> and then I would like to have 4
> - one for another network
> 
> The problem that I have and I don't know how to solve is that the new pci 
> network card share an irq with another device. So, in my case, I have  
> problems with this. With rtnet, I solve this using pcie devices, but now I 
> cannot.
> 
> I have configure the xenomai kernel following the FAQ, and I have tested to 
> assign an IRQ in the BIOS. But I have not be able to make the interface 
> works. I have delays in the interface, and google says ;-) that is a problems 
> of sharing IRQs with the eth. And I believe in that ...
> 
> So, thinking that I would like to use this eth in a normal environment (not 
> rtnet,) but in a box using xenomai, some of you have some "magical" idea, 
> kernel parameter, etc to solve this issue?
> 
> Thanks in advance,

Well, maybe you can configure the cards controlled by rtnet to actually
share their irq ? Maybe this would free irqs for other cards ?

-- 


					    Gilles.

