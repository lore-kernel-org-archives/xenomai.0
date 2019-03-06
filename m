From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: PCI UDD Questions
References: <MQAHYHsv-KztU7kmKMe1zEyj1YMioxUAHWXO8cjixmGgcY0FuEcPL73Bj0NZxsH9mlyrmGJ1rhAWMr7ii-ErIRz9qSqRXvnyBibYa3AZSAE=@codecraftsmen.org>
Message-ID: <ecf0bf08-f93e-3c67-a71e-fb25d683930c@xenomai.org>
Date: Wed, 6 Mar 2019 12:24:29 +0100
MIME-Version: 1.0
In-Reply-To: <MQAHYHsv-KztU7kmKMe1zEyj1YMioxUAHWXO8cjixmGgcY0FuEcPL73Bj0NZxsH9mlyrmGJ1rhAWMr7ii-ErIRz9qSqRXvnyBibYa3AZSAE=@codecraftsmen.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <w1@codecraftsmen.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 3/2/19 1:25 PM, Jeff Webb via Xenomai wrote:
> I would like to write a generic UDD mini-driver that handles interrupts from a PCI card like uio_pci_generic does using the UIO framework.
> 
> In uio_pci_generic.c, I see this code:
> 
> /* Interrupt handler. Read/modify/write the command register to disable
>  * the interrupt. */
> static irqreturn_t irqhandler(int irq, struct uio_info *info)
> {
> 	struct uio_pci_generic_dev *gdev =3D to_uio_pci_generic_dev(info);
> 
> 	if (!pci_check_and_mask_intx(gdev->pdev))
> 		return IRQ_NONE;
> 
> 	/* UIO core will signal the user process. */
> 	return IRQ_HANDLED;
> }
> 
> Can the pci_check_and_mask_intx() function be called like this from the UDD mini-driver in a real-time context, or is there an alternate method that should be used?  From looking at the source for the pci_* functions, I would guess that this function cannot be called from RTDM, but I am not sure.  I am not experienced with writing RTDM drivers.

Your assumption is correct, you generally can't call the PCI layer from
the real-time context. First there is the global pci_lock which could be
unwise to convert to a hard lock for supporting this, then there are the
per-bus handlers pci_check_and_mask_intx() indirectly calls, which might
re-enter the main kernel badly.

> 
> Conversely, on the user-space side, what is the right way to umask the interrupt?  The example in the "Userspace I/O HOWTO" uses the "pci sysfs interface, or the libpci library that wraps it", but how to we do this in realtime?  If there is not a good way to do this directly from userspace, then it sounds like a UDD_RTIOC_IRQEN ioctl call could accomplish this if the UDD mini-driver's ioctl handler implements UDD_RTIOC_IRQEN by unmasking the interrupt in the PCI command register using something equivalent to the pci_intx() function.  Is this the best solution, or does making this ioctl call introduce additional overhead?

No particular overhead to expect, but that would still not allow you to
call the PCI layer from the real-time context.

> 
> I could also avoid using the PCI command register entirely and just write to a device-specific mask bit in my peripheral, but I would rather implement a generic solution if there is not a performance penalty for using the PCI command register.
> 

I don't think that using the PCI layer would be cheaper than tweaking
some bit in your device. The former involves a serialization on
pci_lock, then a read-update-write sequence to send the
masking/unmasking command to the bus layer. Sending the acknowledge to
the device in order to stop it from interrupting is the usual way for rt
sources.

> If the UDD_RTIOC_IRQEN/IRQDIS are implemented in the mini-driver to mask/unmask interrupts using device or PCI registers instead of masking at the IRQ controller level as described above, is there a need to call udd_enable/disable_irq() at all in the mini-driver (e.g. enable interrupts when the driver is loaded, disable when the driver is unloaded)?

The latter would be enough. If the device is quiet, there would be no
reason to mask the IRQ line.

>  It seems like disabling interrupts in this way (at the controller) wouldn't work if the IRQ line is shared with another device.

Definitely. Even worse if some of the devices sharing the IRQ line are
dealt with in rt mode, and others in non-rt mode (which would be a
design issue in the first place anyway).

>  I am not sure whether interrupts are already enabled at the controller level, or if I need to enable them myself.

rtdm_irq_request() automatically enables the IRQ line on success.

> 
> Also, if the default UDD ioctl handler is used, it sounds like the UDD_RTIOC_IRQEN/IRQDIS ioctls can be used to enable/disable interrupts at the controller from userspace, but this requires a switch to secondary mode, which would be problematic for real-time performance.  Is this correct?
> 

Yes, IRQ enabling/disabling in the irqchip should not be called from rt
context, so the line switcher in UDD will defer to the root domain for
handling such request. UDD_RTIOC_IRQxx should be used from
init/recovery/cleanup code, they are not supposed to be called from the
time-critical loop.

-- 
Philippe.

