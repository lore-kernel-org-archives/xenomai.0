Date: Sat, 23 Oct 2010 15:54:10 +0100 (BST)
From: edward.robbins@domain.hid
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-ID: <1287845650.32319352@domain.hid>
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
To: xenomai@xenomai.org

Forgot to copy the list:=0A=0A=0AOkay, so smi.c does not appear to contain =
my the PCI ID of my LPC chip. Motherboard has intel GS45 chipset, and "lspc=
i -nn" says:=0A=0A00:1f.0 ISA bridge [0601]: Intel Corporation ICH9M-E LPC =
Interface Controller [8086:2917] (rev 03)=0A=0AIs this what I'm looking for=
? (What has ISA got to do with this?)=0A=0AThis PCI ID is not defined in ei=
ther include/linux/pci_ids.h or include/asm-generic/xenomai/pci_ids.h, alth=
ough there are these entries:=0A=0APCI_DEVICE_ID_INTEL_ICH9_7        0x2916=
=0APCI_DEVICE_ID_INTEL_ICH9_8        0x2918=0A=0ASo I guess I should add =
=0A=0A#define PCI_DEVICE_ID_INTEL_ICH9_9        0x2917 =0A=0Ato xenomai/pci=
_ids.h, then add this define to smi.c, and see if magic happens?=0A=0AThank=
s for walking me through this!=0A=0AEdward=0A=0AOn Saturday, 23 October, 20=
10 3:10pm, "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org> said:=
=0A=0A> edward.robbins@domain.hid wrote:=0A>> Oh no...=0A>>=
=0A>> dmesg | grep SMI=0A>>=0A>> CPU0: Thermal monitoring handled by SMI CP=
U1: Thermal monitoring=0A>> handled by SMI=0A>>=0A>> So I guess that didn't=
 work? I have used the 'Globally disable SMIs=0A>> option' at kernel config=
 time.... there is an option in  the BIOS to=0A>> disable SMI but I was hav=
ing problems with it... will investigate.=0A>> Any other options?=0A> =0A> =
See:=0A> http://www.xenomai.org/index.php/Configuring_x86_kernels#In_case_o=
f_high_latencies=0A> =0A> Note that if SMIs are involved in regulating temp=
erature on your system,=0A> disabling them may cause your CPU to overheat. =
So, when running dohell,=0A> you should check the CPU temperature.=0A> =0A>=
 --=0A>                                                                 Gil=
les.=0A> 


