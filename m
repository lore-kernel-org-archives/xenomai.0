Date: Sat, 02 Mar 2019 11:51:38 +0000
From: Jeff Webb <jeff.webb@protonmail.com>
Reply-To: Jeff Webb <jeff.webb@protonmail.com>
Subject: PCI UDD Questions
Message-ID: <9bPAY4qRJV9drHvKeB8cPL0ezW1gWwEDsDT_Guxrarl-Utu5nWJzEN3otONd_f_m6QxDg_f6lPQ3VqvsJ1Cnzs6kC6c3mZCul1uZmqCwvuY=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I would like to write a generic UDD mini-driver that handles interrupts fro=
m a PCI card like uio_pci_generic does using the UIO framework.

In uio_pci_generic.c, I see this code:

/* Interrupt handler. Read/modify/write the command register to disable
 * the interrupt. */
static irqreturn_t irqhandler(int irq, struct uio_info *info)
{
=09struct uio_pci_generic_dev *gdev =3D to_uio_pci_generic_dev(info);

=09if (!pci_check_and_mask_intx(gdev->pdev))
=09=09return IRQ_NONE;

=09/* UIO core will signal the user process. */
=09return IRQ_HANDLED;
}

Can the pci_check_and_mask_intx() function be called like this from the UDD=
 mini-driver in a real-time context, or is there an alternate method that s=
hould be used?  From looking at the source for the pci_* functions, I would=
 guess that this function cannot be called from RTDM, but I am not sure.  I=
 am not experienced with writing RTDM drivers.

Conversely, on the user-space side, what is the right way to umask the inte=
rrupt?  The example in the "Userspace I/O HOWTO" uses the "pci sysfs interf=
ace, or the libpci library that wraps it", but how to we do this in realtim=
e?  If there is not a good way to do this directly from userspace, then it =
sounds like a UDD_RTIOC_IRQEN ioctl call could accomplish this if the UDD m=
ini-driver's ioctl handler implements UDD_RTIOC_IRQEN by unmasking the inte=
rrupt in the PCI command register using something equivalent to the pci_int=
x() function.  Is this the best solution, or does making this ioctl call in=
troduce additional overhead?

I could also avoid using the PCI command register entirely and just write t=
o a device-specific mask bit in my peripheral, but I would rather implement=
 a generic solution if there is not a performance penalty for using the PCI=
 command register.

If the UDD_RTIOC_IRQEN/IRQDIS are implemented in the mini-driver to mask/un=
mask interrupts using device or PCI registers instead of masking at the IRQ=
 controller level as described above, is there a need to call udd_enable/di=
sable_irq() at all in the mini-driver (e.g. enable interrupts when the driv=
er is loaded, disable when the driver is unloaded)?  It seems like disablin=
g interrupts in this way (at the controller) wouldn't work if the IRQ line =
is shared with another device.  I am not sure whether interrupts are alread=
y enabled at the controller level, or if I need to enable them myself.

Also, if the default UDD ioctl handler is used, it sounds like the UDD_RTIO=
C_IRQEN/IRQDIS ioctls can be used to enable/disable interrupts at the contr=
oller from userspace, but this requires a switch to secondary mode, which w=
ould be problematic for real-time performance.  Is this correct?

Thanks in advance for any advice on this subject.

-Jeff

