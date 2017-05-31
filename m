From: Nitin Kulkarni <nitink@kth.se>
Date: Wed, 31 May 2017 10:34:56 +0000
Message-ID: <1496226896420.15161@kth.se>
References: <mailman.117.1496166485.4225.xenomai@xenomai.org>
 <1496167354451.78382@kth.se>,
 <e1ed397b-c902-7b7d-5d1c-e78d9c5f8bf0@xenomai.org>
In-Reply-To: <e1ed397b-c902-7b7d-5d1c-e78d9c5f8bf0@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] problem gpio interrupts xenomai3 on the raspberry pi
 2 (or 3)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

This is the output from /proc/interrupts  (Note: irq 300 is the one I have =
requested ) =0A=
=0A=
 root@intel-corei7-64:~# cat /proc/interrupts=0A=
            CPU0       CPU1       CPU2       CPU3=0A=
   0:         84          0          0          0   IO-APIC    2-edge      =
timer=0A=
   3:       7666          0          0          0   IO-APIC    3-fasteoi   =
mmc0=0A=
   4:          0          0          0          0   IO-APIC    4-fasteoi   =
idma64.7=0A=
   5:          0          0          0          0   IO-APIC    5-fasteoi   =
idma64.8=0A=
   6:       1276          0          0          0   IO-APIC    6-fasteoi   =
serial=0A=
   8:          1          0          0          0   IO-APIC    8-fasteoi   =
rtc0=0A=
   9:         39          0          0          0   IO-APIC    9-fasteoi   =
acpi=0A=
  14:          0          0          0          0   IO-APIC   14-fasteoi   =
INT34D1:00, INT34D1:01, INT34D1:02, INT34D1:03, INT34D1:04=0A=
  27:         70          0          0          0   IO-APIC   27-fasteoi   =
idma64.0, i2c_designware.0=0A=
  28:          0          0          0          0   IO-APIC   28-fasteoi   =
idma64.1, i2c_designware.1=0A=
  29:          0          0          0          0   IO-APIC   29-fasteoi   =
idma64.2, i2c_designware.2=0A=
  30:          0          0          0          0   IO-APIC   30-fasteoi   =
idma64.3, i2c_designware.3=0A=
  31:          0          0          0          0   IO-APIC   31-fasteoi   =
idma64.4, i2c_designware.4=0A=
  33:          0          0          0          0   IO-APIC   33-fasteoi   =
idma64.5, i2c_designware.5=0A=
  34:          0          0          0          0   IO-APIC   34-fasteoi   =
idma64.6, i2c_designware.6=0A=
  35:          0          0          0          0   IO-APIC   35-fasteoi   =
idma64.11, pxa2xx-spi.11=0A=
  36:          0          0          0          0   IO-APIC   36-fasteoi   =
idma64.12, pxa2xx-spi.12=0A=
  37:          0          0          0          0   IO-APIC   37-fasteoi   =
idma64.13, pxa2xx-spi.13=0A=
  39:       1483          0          0          0   IO-APIC   39-fasteoi   =
mmc1=0A=
  40:       1141          0          0          0   IO-APIC   40-fasteoi   =
intel_pmc_ipc=0A=
  41:          1          0          0          0   IO-APIC   41-fasteoi   =
bxtwc_irq_chip, bxtwc_irq_chip_level2, bxtwc_irq_chip_tmu=0A=
 120:          1          0          0          0   PCI-MSI 327680-edge    =
  PCIe PME=0A=
 121:       4838          0          0          0   PCI-MSI 344064-edge    =
  xhci_hcd=0A=
 122:         31          0          0          0   PCI-MSI 245760-edge    =
  mei_me=0A=
 142:          0          0          0          0  intel-gpio   19  bq25890=
_irq=0A=
 300:          0          0          0          0  intel-gpio   22  test_in=
terrupt=0A=
 371:         31          0          0          0   PCI-MSI 32768-edge     =
 i915=0A=
 372:       1525          0          0          0   PCI-MSI 524288-edge    =
  iwlwifi=0A=
 373:          0          0          0          0  bxtwc_irq_chip_level2   =
 0  pmic_thermal=0A=
 374:          0          0          0          0  bxtwc_irq_chip_level2   =
 1  pmic_thermal=0A=
 375:          0          0          0          0  bxtwc_irq_chip_level2   =
 2  pmic_thermal=0A=
 383:          1          0          0          0  Whiskey Cove    7  ACPI:=
Event=0A=
 470:          1          0          0          0  bxtwc_irq_chip_level2   =
 7  bxt_wcove_gpio=0A=
 471:          1          0          0          0  bxtwc_irq_chip_level2   =
 5  wcove_typec=0A=
 472:          0          0          0          0  bxtwc_irq_chip_tmu   10 =
 bxt_wcove_tmu=0A=
 473:         69          0          0          0   PCI-MSI 229376-edge    =
  snd_hda_intel=0A=
 NMI:          0          0          0          0   Non-maskable interrupts=
=0A=
 LOC:      12420       8239       7278       6081   Local timer interrupts=
=0A=
 SPU:          0          0          0          0   Spurious interrupts=0A=
 PMI:          0          0          0          0   Performance monitoring =
interrupts=0A=
 IWI:          0          0          0          0   IRQ work interrupts=0A=
 RTR:          0          0          0          0   APIC ICR read retries=
=0A=
 RES:        600        558        934        711   Rescheduling interrupts=
=0A=
 CAL:        142        339        343        348   Function call interrupt=
s=0A=
 TLB:         63         50         75         71   TLB shootdowns=0A=
 TRM:          0          0          0          0   Thermal event interrupt=
s=0A=
 THR:          0          0          0          0   Threshold APIC interrup=
ts=0A=
 DFR:          0          0          0          0   Deferred Error APIC int=
errupts=0A=
 MCE:          0          0          0          0   Machine check exception=
s=0A=
 MCP:          6          6          6          6   Machine check polls=0A=
 ERR:          0=0A=
 MIS:          2=0A=
 PIN:          0          0          0          0   Posted-interrupt notifi=
cation event=0A=
 PIW:          0          0          0          0   Posted-interrupt wakeup=
 event=0A=
=0A=
=0A=
________________________________________=0A=
From: Philippe Gerum <rpm@xenomai.org>=0A=
Sent: Wednesday, May 31, 2017 9:16 AM=0A=
To: Nitin Kulkarni; xenomai@xenomai.org=0A=
Subject: Re: [Xenomai] problem gpio interrupts xenomai3 on the raspberry pi=
 2 (or 3)=0A=
=0A=
On 05/30/2017 08:02 PM, Nitin Kulkarni wrote:=0A=
> Hi Philippe,=0A=
>>From your reply I guess its the same issue  with my SoC also. Do you thin=
k in my case the Intel joule pinctrl driver is not aware of Ipipe ?=0A=
> Do you have any instances where an x86 based SoC was ported to solve this=
 issue ?=0A=
> Thanks for the info it explains a lot of things now.=0A=
=0A=
What is the output of /proc/interrupts on your board?=0A=
=0A=
--=0A=
Philippe.=0A=

