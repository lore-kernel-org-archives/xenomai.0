Message-ID: <4CC30152.6060208@domain.hid>
Date: Sat, 23 Oct 2010 17:37:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1287845650.32319352@domain.hid>
In-Reply-To: <1287845650.32319352@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Very high latencies under stress testing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: edward.robbins@domain.hid
Cc: xenomai@xenomai.org

edward.robbins@domain.hid wrote:
> Forgot to copy the list:
> 
> 
> Okay, so smi.c does not appear to contain my the PCI ID of my LPC chip. Motherboard has intel GS45 chipset, and "lspci -nn" says:
> 
> 00:1f.0 ISA bridge [0601]: Intel Corporation ICH9M-E LPC Interface Controller [8086:2917] (rev 03)
> 
> Is this what I'm looking for? (What has ISA got to do with this?)
> 
> This PCI ID is not defined in either include/linux/pci_ids.h or include/asm-generic/xenomai/pci_ids.h, although there are these entries:
> 
> PCI_DEVICE_ID_INTEL_ICH9_7        0x2916
> PCI_DEVICE_ID_INTEL_ICH9_8        0x2918
> 
> So I guess I should add 
> 
> #define PCI_DEVICE_ID_INTEL_ICH9_9        0x2917 

The define exists in include/linux/pci_ids.h as PCI_DEVICE_ID_INTEL_ICH9_1

Adding it to xenoami/pci_ids.s is only useful if you are using an older
kernel which has not got this define. 2.6.33 here has it.

> 
> to xenomai/pci_ids.h, then add this define to smi.c, and see if magic happens?
> 
> Thanks for walking me through this!
> 
> Edward


-- 
                                                                Gilles.

