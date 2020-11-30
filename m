MIME-Version: 1.0
References: <BN8PR15MB2915F1ACC0DB693A4BF23B20DBF50@BN8PR15MB2915.namprd15.prod.outlook.com>
In-Reply-To: <BN8PR15MB2915F1ACC0DB693A4BF23B20DBF50@BN8PR15MB2915.namprd15.prod.outlook.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 30 Nov 2020 14:35:56 -0500
Message-ID: <CALLqZ8TiGPC2uKQRjTcnjXoL0FV3y5UrMnp5DLcpEXTD-fgDKg@mail.gmail.com>
Subject: Re: RTDM PCI information
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Robert Faron <RobertF@cmslaser.com>
Cc: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

hi,

On Mon, Nov 30, 2020 at 2:13 PM Robert Faron via Xenomai <
xenomai@xenomai.org> wrote:
>
> I have been struggling with creating a driver for my FPGA card.  My issue
seems to be that I haven't been able to pass the pointer information for
the pci_dev.  When registering the device there is no way, from my limited
understanding, to attach information to the device that is created, in my
case /dev/rtdm/cms_fpga .
>
> So while the pci_probe works fine and show me the address of BAR0 there
is no way to pass that data to my .open or .ioctl_rt.  I tried creating my
stucture globally but that didn't seem to help. The following is a sample
of the module as it currently is, any help would be greatly appreciated.
>
>
> struct cms_fpga_struct
>  {
>    rtdm_lock_t lock;
>    struct pci_dev *pcidev;
>    resource_size_t mmio;
>    struct cms_fpga_context context;
>
>  };
>
Accessing the global version may not work because you have two variables
with the same name at different scopes.
>* static struct cms_fpga_struct *fpga ;*
The above variable seems to be local in the probe function also.

-Greg

> static struct pci_device_id pci_ids[] =
> {
>   {
>     PCI_DEVICE(0x1204, 0xec30),
>     //.driver_data = (unsigned long)&fpga
>   },
>   {}
> };
> static struct rtdm_driver CMS_Xenomai_Driver =
> {
>   .profile_info = RTDM_PROFILE_INFO(cms,
>                                     RTDM_CLASS_EXPERIMENTAL,
>                                     1,
>                                     1),
>   .device_flags = RTDM_NAMED_DEVICE|RTDM_EXCLUSIVE,
>   .device_count = 1,
>   .context_size = sizeof(struct cms_fpga_struct),
>   .ops =
>     {
>       .open     = cms_open,
>       .ioctl_rt = cms_ioctl,
>       .ioctl_nrt= cms_ioctl,
>       .write_rt = NULL , //pci_write,
>       .write_nrt= NULL ,
>       .read_rt  = NULL , //pci_read,
>       .read_nrt = NULL
>
>
>
>     }
> };
>
>
> static int pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> {
>   int ret;
>   int err = 0 ;
>   static struct cms_fpga_struct *fpga;
>   rtdm_printk (KERN_DEBUG "Probe 1 %llx", fpga);
>   struct rtdm_device *dev;
>   dev = kmalloc(sizeof(struct rtdm_device) + RTDM_MAX_DEVNAME_LEN,
GFP_KERNEL);
>   fpga = kmalloc(sizeof(struct cms_fpga_struct), GFP_KERNEL);
>   if(!dev) goto out; //cleanup;
>   dev->driver = &CMS_Xenomai_Driver;
>   dev->label = "cms_fpga";
>   dev->device_data=(unsigned long long *)fpga;
>   rtdm_printk(KERN_DEBUG "Probe 2 %llx", fpga);
>   ret = rtdm_dev_register(dev);
> //  if(!id->driver_data)
> //    {
> //      rtdm_printk(KERN_DEBUG "No id->driver_data");
> //      return -ENODEV;
> //    }
> //  fpga = id->driver_data;
>   rtdm_printk (KERN_DEBUG "Probe 3 %llx", fpga);
>   if(fpga == NULL)
>     {
>       rtdm_printk(KERN_DEBUG "fpga == NULL");
>       return -ENOMEM;
>     }
>
>   //memset(fpga, 0, sizeof(struct cms_fpga_struct));
>   rtdm_lock_init(&fpga->lock);
>   if (pci_enable_device(pdev) < 0)
>     {
>       rtdm_printk(KERN_ERR "FPGA PCI Not enableded");
>       goto out;
>     }
>   fpga->pcidev = pdev;
>   ret = pci_request_region(pdev, BAR_MEM, "CMS-FPGA");
>   if(ret < 0)
>     {
>       rtdm_printk(KERN_DEBUG "Request region failed @ %0x", fpga->mmio);
>     }
>   fpga->mmio=pci_resource_start(pdev,BAR_MEM);
>   dev_info(&(pdev->dev), "MMIO starts at %llx", fpga->mmio);
>   rtdm_printk(KERN_DEBUG "Probe 4 %llx", dev->device_data);
>   return err;
> out:
> kfree(fpga);
> return -1;
> }
>
>
>
> NOTICE: This e-mail message and all attachments transmitted with it may
contain trade secrets and confidential information intended solely for the
use of the addressee. If the reader of this message is not the intended
recipient, you are hereby notified that any reading, dissemination,
distribution, copying, or other use of this message or its attachments is
strictly prohibited. If you have received this message in error, please
notify the sender immediately by telephone at 407-679-9716, and delete this
message and all copies and backups thereof. Thank you
