References: <CAJ2oMh+tuym1dPNGFoF4ucy+X-1fpsca9h=9RCrxTEGJmAM52g@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a65c271a-38a1-1b5e-4037-7a62464a0a0a@xenomai.org>
Date: Tue, 7 Feb 2017 10:25:09 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ2oMh+tuym1dPNGFoF4ucy+X-1fpsca9h=9RCrxTEGJmAM52g@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Q: UDD sample code ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ran Shalit <ranshalit@gmail.com>, xenomai@xenomai.org

On 02/07/2017 08:31 AM, Ran Shalit wrote:
> Hello,
> 
> I would like to write a UDD driver.
> The API are documented very well, yet a simple example can help here.
> 
> Does anyone have an example to share ?
> 

A trivial driver for a random PCI device having two BARs we want to
expose to user-space via the mmap() interface, along with a way for some
application thread to wait for IRQ events received from that device (see
udd_notify_event(), automatically called by UDD upon interrupt receipt
since udd_device.irq contains a valid IRQ number).

#include <linux/kernel.h>
#include <linux/module.h>
#include <rtdm/driver.h>
#include <linux/init.h>
#include <linux/pci.h>
#include <rtdm/udd.h>

static int foo_open(struct rtdm_fd *fd, int oflags)
{
	return 0;
}

static void foo_close(struct rtdm_fd *fd)
{
}

static int foo_mmap(struct rtdm_fd *fd, struct vm_area_struct *vma)
{
	struct udd_memregion *rn;
	struct udd_device *udd;
	int ret;

	udd = udd_get_device(fd);
	rn = udd->mem_regions + rtdm_fd_minor(fd);

	switch (rn->type) {
	case UDD_MEM_PHYS:
		ret = rtdm_mmap_iomem(vma, rn->addr);
		break;
	case UDD_MEM_LOGICAL:
		ret = rtdm_mmap_kmem(vma, (void *)rn->addr);
		break;
	case UDD_MEM_VIRTUAL:
		ret = rtdm_mmap_vmem(vma, (void *)rn->addr);
		break;
	default:
		ret = -EINVAL;
	}

	return ret;
}

int foo_interrupt(struct udd_device *udd)
{
	/* ack device interrupt, UDD will call udd_notify_event() next */

	return RTDM_IRQ_HANDLED;
}

static struct udd_device udd = {
	.device_flags = RTDM_NAMED_DEVICE,
	.device_name = "foo",
	.ops = {
		.interrupt = foo_interrupt,
		.close = foo_close,
		.open = foo_open,
		.mmap = foo_mmap,
	}
};

#define PCI_VENDOR_ID_WHATEVER 	0x????
#define PCI_DEVICE_ID_FOO  	0x????

static struct pci_device_id foo_pci_ids[] = {
	{ PCI_DEVICE(PCI_VENDOR_ID_WHATEVER, PCI_DEVICE_ID_FOO) },
	{0,}
};

static int foo_pci_probe(struct pci_dev *dev, const struct pci_device_id
*id)
{
	unsigned int regs_len, mem_len;
	unsigned long regs, mem;
	int ret;

	ret = pci_enable_device(dev);
	if (ret < 0)
		return ret;

	regs = pci_resource_start(dev, 0);
	regs_len  = pci_resource_end(dev, 0) - regs;

	mem = pci_resource_start(dev, 1);
	mem_len  = pci_resource_end(dev, 1) - mem;

	/* exposed as /dev/rtdm/foo,mapper0 */
	udd.mem_regions[0].name = "foo-regs";
	udd.mem_regions[0].addr = regs;
	udd.mem_regions[0].len = regs_len;
	udd.mem_regions[0].type = UDD_MEM_PHYS;

	/* exposed as /dev/rtdm/foo,mapper1 */
	udd.mem_regions[1].name = "foo-mem";
	udd.mem_regions[1].addr = mem;
	udd.mem_regions[1].len = mem_len;
	udd.mem_regions[1].type = UDD_MEM_PHYS;

	/* Enable automatic notification. */
	udd.irq = dev->irq;

	ret = udd_register_device(&udd);
	if (ret)
		printk(KERN_ERR "failed to register FOO driver (%d)\n",
		       ret);

	return ret;
}

static void foo_pci_remove(struct pci_dev *dev)
{
	udd_unregister_device(&udd);
	pci_disable_device(dev);
}

static struct pci_driver foo_pci_driver = {
	.name = "foo",
	.remove = foo_pci_remove,
	.id_table = foo_pci_ids,
	.probe = foo_pci_probe,
};

static int __init foo_init(void)
{
	return pci_register_driver(&foo_pci_driver);
}
static void __exit foo_exit(void)
{
	pci_unregister_driver(&foo_pci_driver);
}

MODULE_LICENSE("GPL");
module_init(foo_init);
module_exit(foo_exit);

-- 
Philippe.

