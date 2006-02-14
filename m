Message-ID: <fd6a47a90602140744lc1d4365q@domain.hid>
Date: Tue, 14 Feb 2006 16:44:51 +0100
From: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_7143_22762015.1139931891201"
Subject: [Xenomai-core] Handling PCI MSI interrupts
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

------=_Part_7143_22762015.1139931891201
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I'm having problems using MSI interrupts in Xenomai.

When using normal PCI interrupts, my PCI card + RTDM driver work flawlessly=
.
However, I noticed the following while trying to enable MSI (by having Linu=
x
do all the administrative register-fill-ins using pci_enable_msi()):

1. The kernel is compiled for MSI. (PCI_CONFIG_MSI=3Dyes)
2. My card correctly advertises the MSI capability (checked with 'lspci
-v').
3. I do get a new IRQ number in the pci_dev struct (217 instead of 193)
after invoking pci_enable_msi().
4. After pci_enable_smi(), 'lspci -v' correctly indicates that Message
Signalled Interrupts are now enabled (Enable+).
5. I can register the new IRQ with rtdm_request_irq(). Return value is 0.
6. The IRQ number appears in /proc/xenomai/irq.
7. I can enable the new IRQ with rtdm_irq_enable(). Return value is 0.
8. I can disable the new IRQ with rtdm_irq_disable(). Return value is 0.
9. I can unregister the new IRQ with rtdm_irq_free(). Return value is 0.
10. I'm able to do pci_disable_pci() successfully.

If I actually enable the card interrupt, it goes wrong after 7 after arriva=
l
of the first interrupt. The ISR is executed (checked that), which checks if
the card was actually interrupting and, if so, returns with RTDM_IRQ_ENABLE=
.
After that, the machine is absolutely dead (frozen).

Any hints, suggestions or things I may check ?

Jeroen.

------=_Part_7143_22762015.1139931891201
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I'm having problems using MSI interrupts in Xenomai.<br>
<br>
When using normal PCI interrupts, my PCI card + RTDM driver work
flawlessly. However, I noticed the following while trying to enable MSI
(by having Linux do all the administrative register-fill-ins using
pci_enable_msi()):<br>
<br>
1. The kernel is compiled for MSI. (PCI_CONFIG_MSI=3Dyes)<br>
2. My card correctly advertises the MSI capability (checked with 'lspci -v'=
).<br>
3. I do get a new IRQ number in the pci_dev struct (217 instead of 193) aft=
er invoking pci_enable_msi().<br>
4. After pci_enable_smi(), 'lspci -v' correctly indicates that Message Sign=
alled Interrupts are now enabled (Enable+).<br>
5. I can register the new IRQ with rtdm_request_irq(). Return value is 0.<b=
r>
6. The IRQ number appears in /proc/xenomai/irq.<br>
7. I can enable the new IRQ with rtdm_irq_enable(). Return value is 0.<br>
8. I can disable the new IRQ with rtdm_irq_disable(). Return value is 0.<br=
>
9. I can unregister the new IRQ with rtdm_irq_free(). Return value is 0.<br=
>
10. I'm able to do pci_disable_pci() successfully.<br>
<br>
If I actually enable the card interrupt, it goes wrong after 7 after
arrival of the first interrupt. The ISR is executed (checked that),
which checks if the card was actually interrupting and, if so, returns
with RTDM_IRQ_ENABLE. After that, the machine is absolutely dead
(frozen).<br>
<br>
Any hints, suggestions or things I may check ?<br>
<br>
Jeroen.<br>

------=_Part_7143_22762015.1139931891201--

