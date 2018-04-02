Date: Mon, 2 Apr 2018 12:53:45 +0300 (EEST)
From: =?windows-1251?B?2OXi9+Xt6u4g0uDw4PEgw/Do4+7w/OXi6Pc=?=
 <shevchenko.taras@triolcorp.com.ua>
Message-ID: <1073343292.9341406.1522662825706.JavaMail.zimbra@triolcorp.com.ua>
In-Reply-To: <01a99ae9-10b3-1503-aa02-94b7b8d90d90@yandex.ru>
References: <bb8f24a9-17fb-7230-1371-35085882cc6f@xenomai.org>
 <01a99ae9-10b3-1503-aa02-94b7b8d90d90@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai / UDOO x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Olej <o.tsiliuric@yandex.ru>, xenomai <xenomai@xenomai.org>

Good day!=20

So, my system=20

yeti@yeti-UDOO-x86:~/linux-4.13$ uname -r=20
4.13.0-37-generic=20

yeti@yeti-UDOO-x86:~/linux-4.13$ cat /proc/interrupts=20
there is 2 IRQ no PCI* and no IO-apic*=20

304: 1 0 1 1 chv-gpio 50 80860F14:01 cd - this one are present in patched s=
ystem=20

313: 0 0 0 0 INT0002 Virtual GPIO 2 ACPI:Event - this one are not present i=
n patched system=20

and 313 IRQ number are busy by 313: 5 6 6 6 PCI-MSI 425984-edge mei_txe=20

I try to find at sources=20

yeti@yeti-UDOO-x86:~/linux-4.13$ sudo grep -r "chv-gpio"=20
drivers/pinctrl/intel/pinctrl-cherryview.c: .name =3D "chv-gpio",=20

yeti@yeti-UDOO-x86:~/linux-4.13$ sudo grep -r "INT0002"=20
drivers/acpi/x86/utils.c: * The INT0002 device is necessary to clear wakeup=
 interrupt sources=20
drivers/acpi/x86/utils.c: ENTRY("INT0002", "1", ICPU(INTEL_FAM6_ATOM_AIRMON=
T), {}),=20
drivers/platform/x86/Makefile:obj-$(CONFIG_INTEL_INT0002_VGPIO) +=3D intel_=
int0002_vgpio.o=20
drivers/platform/x86/intel_menlow.c: * id is INT0002) which makes use of th=
e platform specific ACPI methods=20
drivers/platform/x86/intel_menlow.c: {"INT0002", 0},=20
drivers/platform/x86/intel_menlow.c: /* Looking for ACPI device MEM0 with h=
ardware id INT0002 */=20
drivers/platform/x86/intel_int0002_vgpio.c: * Intel INT0002 "Virtual GPIO" =
driver=20
drivers/platform/x86/intel_int0002_vgpio.c: * This is modelled in ACPI thro=
ugh the INT0002 ACPI device, which is=20
drivers/platform/x86/intel_int0002_vgpio.c: * This driver will bind to the =
INT0002 device, and register as a GPIO=20
drivers/platform/x86/intel_int0002_vgpio.c:#define DRV_NAME "INT0002 Virtua=
l GPIO"=20
drivers/platform/x86/intel_int0002_vgpio.c: * need to handle the INT0002 de=
vice on Baytrail too.=20
drivers/platform/x86/intel_int0002_vgpio.c: /* Menlow has a different INT00=
02 device? <sigh> */=20
drivers/platform/x86/intel_int0002_vgpio.c: IRQF_SHARED | IRQF_NO_THREAD, "=
INT0002", chip);=20
drivers/platform/x86/intel_int0002_vgpio.c: { "INT0002", 0 },=20
drivers/platform/x86/intel_int0002_vgpio.c:MODULE_DESCRIPTION("Intel INT000=
2 Virtual GPIO driver");=20
drivers/platform/x86/Kconfig:config INTEL_INT0002_VGPIO=20
drivers/platform/x86/Kconfig: tristate "Intel ACPI INT0002 Virtual GPIO dri=
ver"=20
drivers/platform/x86/Kconfig: This is modelled in ACPI through the INT0002 =
ACPI device, which is=20

How I can fix it ?=20

=D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC =E8 =ED=E0=E4=E5=E6=E4=EE=E9 =ED=E0 =F1=EE=
=F2=F0=F3=E4=ED=E8=F7=E5=F1=F2=E2=EE,=20
=D8=E5=E2=F7=E5=ED=EA=EE =D2.=C3.=20


From: "Olej" <o.tsiliuric@yandex.ru>=20
To: "=D8=E5=E2=F7=E5=ED=EA=EE =D2=E0=F0=E0=F1 =C3=F0=E8=E3=EE=F0=FC=E5=E2=
=E8=F7" <shevchenko.taras@triolcorp.com.ua>=20
Sent: Saturday, March 31, 2018 12:32:53 PM=20
Subject: Re: Xenomai / UDOO x86=20

=C2=EE=F2 =E2=F1=E5 =E7=E0=F7=E0=F1=F2=F3=FE =E2=F1=F2=F0=E5=F7=E0=FE=F9=E8=
=E5=F1=FF =C8=D1=D2=CE=D7=CD=C8=CA=C8 =EF=F0=E5=F0=FB=E2=E0=ED=E8=E9 x86:=
=20
[ https://elixir.bootlin.com/linux/v4.15.14/source/arch/x86/kernel/i8259.c =
| https://elixir.bootlin.com/linux/v4.15.14/source/arch/x86/kernel/i8259.c =
]=20
struct irq_chip i8259A_chip =3D {=20
.name =3D "XT-PIC",=20


[ https://elixir.bootlin.com/linux/v4.15.14/source/arch/x86/kernel/apic/io_=
apic.c | https://elixir.bootlin.com/linux/v4.15.14/source/arch/x86/kernel/a=
pic/io_apic.c ]=20
static struct irq_chip ioapic_chip __read_mostly =3D {=20
.name =3D "IO-APIC",=20
...=20
static struct irq_chip ioapic_ir_chip __read_mostly =3D {=20
.name =3D "IR-IO-APIC",=20


[ https://elixir.bootlin.com/linux/v4.15.14/source/arch/x86/kernel/apic/msi=
.c | https://elixir.bootlin.com/linux/v4.15.14/source/arch/x86/kernel/apic/=
msi.c ]=20
static struct irq_chip pci_msi_controller =3D {=20
.name =3D "PCI-MSI",=20


=DF =ED=E8=E3=E4=E5 =E8 =ED=E8=EA=E0=EA =ED=E5 =EC=EE=E3=F3 =ED=E0=E9=F2=E8=
 =E2=F1=F2=F0=E5=F7=E0=FE=F9=E5=E5=F1=FF =E2 =E2=E0=F8=E5=EC /proc/interrup=
ts:=20
304: 1 0 0 0 chv-gpio 50 80860F14:01 cd=20

=D5=EE=F2=FF =EE=ED=EE =E4=EE=EB=E6=ED=EE =E1=FB=F2=FC =E3=E4=E5-=F2=EE =F2=
=E0=EC: [ https://elixir.bootlin.com/linux/v4.15.14/source/arch/x86/kernel =
| https://elixir.bootlin.com/linux/v4.15.14/source/arch/x86/kernel ]=20

=D2=EE=F7=ED=EE =F2=E0=EA =EA=E0=EA =E8 =FF, =E5=E3=EE, =ED=E0=E2=E5=F0=ED=
=EE=E5, =ED=E5 =E7=ED=E0=E5=F2 =E8 Adeos Interrupt Pipe: [ https://ru.bmstu=
.wiki/Adeos_(Adaptive_Domain_Environment_for_Operating_Systems) | https://r=
u.bmstu.wiki/Adeos_(Adaptive_Domain_Environment_for_Operating_Systems) ]=20



30.03.2018 21:01, Philippe Gerum =EF=E8=F8=E5=F2:=20




BQ_BEGIN

Hi all,
I finished some experiments to figure out what is going on
so  again
I have udoo board x86 ultra

1) Use ubuntu with vanile kernel 4.10.0-28 or 4.13.0-37 or 4.9.51   no prob=
lem with sd card , all work perfectly
2) Use 4.9.51 with ipipe patch   -pipe-core -4.9.51-x86-4.patch  guide to s=
ystem no responce
 when i insert sd-card or insert own rtdm module for gpio test  and gpio in=
terrupt occured
3) I use xenomai from git branch  stable-3.0.y (download yesterday)
4) there is options from menuconfig that I enable/disable=20



Interrupt issues are most likely an I-pipe problem with your hardware.
There are several interrupt controllers on the board, each controller
driver has to be fixed up for supporting interrupt pipelining.

On x86, this work has already been done for the common APIC and IO-APIC
chips, I suspect that some GPIO pin controller driver has not been fixed
up in your case.

To find out which one, boot your vanilla kernel ensuring that all the
drivers you need are loaded, then have a look at the label column of
/proc/interrupts. The name of the controller is mentioned there:

$ cat /proc/interrupts

e.g.
           CPU0       CPU1       CPU2       CPU3
   0:         74          0          0          0   IO-APIC    2-edge
                                                    ^^^^^^^
timer
 122:          0          0          0          0   PCI-MSI 294912-edge

                                                    ^^^^^^^
ahci[0000:00:12.0]

Find the corresponding driver in the kernel source, for anything which
is different from IO-APIC, and PCI-*. You may exclude all IRQs with
symbolic names from the list (e.g. LOC, SPU, PMI), only care for
numbered IRQs.

The string you should be looking for is defined in the .name field of
the irqchip descriptor advertised by those drivers.

static struct irq_chip ioapic_chip __read_mostly =3D {
=09.name=09=09=09=3D "IO-APIC",

defined in arch/x86/kernel/apic/io_apic.c

This process of elimination should give you the name of an interrupt
controller driver which has not been fixed up, i.e. not bearing any
CONFIG_IPIPE changes. This one (or maybe several of them) may break the
kernel when CONFIG_IPIPE is enabled for that very reason.

PS: please no private mails, use the mailing list for technical matters.=20

BQ_END


