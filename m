From: "Heinick, J Michael" <Michael.Heinick@Honeywell.com>
Date: Thu, 9 Jun 2016 17:32:51 +0000
Message-ID: <D9EDB4F689BF9F4EA6F2158A073942732E8008F3@de08ex3008.global.ds.honeywell.com>
References: <D9EDB4F689BF9F4EA6F2158A073942732E8007D6@de08ex3008.global.ds.honeywell.com>
 <20160608193911.GA31360@hermes.click-hack.org>
In-Reply-To: <20160608193911.GA31360@hermes.click-hack.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Xenomai/Cobalt on i7-3770S CPU
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>


-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]=20
Sent: Wednesday, June 08, 2016 3:39 PM
To: Heinick, J Michael
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] Xenomai/Cobalt on i7-3770S CPU

On Wed, Jun 08, 2016 at 09:42:26AM +0000, Heinick, J Michael wrote:
>=20
> We currently have an RTDM driver that is running well on Xenomai/Cobalt 3=
.0.1 on 2 Dell computers with Core2 processors, but will hang (unresponsive=
 mouse and keyboard, no discernable activity) an entire SuperLogics i7 comp=
uter with a Core i7-3770S processor (4 physical cores, 4 logical cores).  T=
he hang occurs in the ioctl function at an rtdm_sem_down call that waits fo=
r the interrupt handler to signal the handling of an interrupt.  We suspect=
 that we have a problem with our kernel build/installation configuration op=
tions.  We have attempted to configure the Core i7-3770S system so that Xen=
omai/Cobalt only uses 2 cores like the other 2 working Core2 computers, but=
 the system still hangs (more detail on the results of our attempt is inclu=
ded beow).  Eventually, we would like to configure Xenomai/Cobalt to run on=
 4 cores of the i7 computer if possible.
>=20
> Any suggestions to help us make/install/configure Xenomai/Cobalt to run o=
n the SuperLogics computer with the i7-3770S processor so that the rtdm_sem=
_down call in the RTDM driver does not hang the entire system would be appr=
eciated.

This sounds like an irq conflict: a device handled by an RTDM driver can no=
t use the same irq line as a device handled by a plain Linux driver without=
 modifying the plain Linux driver. See FAQ for solutions to that problem.

--=20
					    Gilles.
https://click-hack.org


Thanks for the reply, Gilles.

Yes, there was a conflict on irq 16.  We disabled the conflicting component=
 so that now our driver is the only one on irq 16, but the i7-3770S system =
is still hanging.  We know the interrupt handler is receiving the interrupt=
s and handling them without hanging the i7 system.  With the interrupts run=
ning at 20Hz, the handler stores counts of the second and sub-second interr=
upts that we can retrieve with a different ioctl call that does not wait fo=
r an interrupt.  The hang only occurs in the ioctl call at the wait with th=
e rtdm_sem_down call.  The contents of selected files from the /proc direct=
ory are included below.

Thanks for the help so far and any additional help to come,
Mike

<<<<< cat /proc/interrupts >>>>>>>>>>>>>>>>>>>>>>>>>>
           CPU0       CPU1      =20
  0:         23          0   IO-APIC-edge      timer
  1:       1403          0   IO-APIC-edge      i8042
  8:          1          0   IO-APIC-edge      rtc0
  9:          3          0   IO-APIC-fasteoi   acpi
12:       5472          0   IO-APIC-edge      i8042
40:          0          0   PCI-MSI-edge      xhci_hcd
41:          0          0   PCI-MSI-edge      xhci_hcd
42:          0          0   PCI-MSI-edge      xhci_hcd
43:        180         15   PCI-MSI-edge      eth2
44:      14186        148   PCI-MSI-edge      ahci
45:        179         15   PCI-MSI-edge      eth3-rx-0
46:          0          0   PCI-MSI-edge      eth3-tx-0
47:          1          0   PCI-MSI-edge      eth3
48:          0          0   PCI-MSI-edge      ahci
49:         13          0   PCI-MSI-edge      mei_me
50:      21185          0   PCI-MSI-edge      i915
NMI:          1          0   Non-maskable interrupts
LOC:      18135      15491   Local timer interrupts
SPU:          0          0   Spurious interrupts
PMI:          1          0   Performance monitoring interrupts
IWI:        800        447   IRQ work interrupts
RTR:          0          0   APIC ICR read retries
RES:      11895      12632   Rescheduling interrupts
CAL:        456       7273   Function call interrupts
TLB:        389        447   TLB shootdowns
TRM:          0          0   Thermal event interrupts
THR:          0          0   Threshold APIC interrupts
MCE:          0          0   Machine check exceptions
MCP:          3          3   Machine check polls
ERR:          0
MIS:          0
<<<<< cat /proc/xenomai/irq >>>>>>>>>>>>>>>>>>>>>>>>>
  IRQ         CPU0        CPU1
   16:           0           0         tcgrtdm
4352:           0           0         [reschedule]
4353:       18866       18260         [timer/0]
4354:           1           0         [timer-ipi]
4355:           0           0         [sync]
4419:           0         368         [virtual]
<<<<< End of Message >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

