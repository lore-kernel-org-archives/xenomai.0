From: Robert Faron <RobertF@Cmslaser.com>
Subject: RTDM PCI information
Date: Mon, 30 Nov 2020 19:12:22 +0000
Message-ID: <BN8PR15MB2915F1ACC0DB693A4BF23B20DBF50@BN8PR15MB2915.namprd15.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

I have been struggling with creating a driver for my FPGA card.  My issue s=
eems to be that I haven't been able to pass the pointer information for the=
 pci_dev.  When registering the device there is no way, from my limited und=
erstanding, to attach information to the device that is created, in my case=
 /dev/rtdm/cms_fpga .

So while the pci_probe works fine and show me the address of BAR0 there is =
no way to pass that data to my .open or .ioctl_rt.  I tried creating my stu=
cture globally but that didn't seem to help. The following is a sample of t=
he module as it currently is, any help would be greatly appreciated.


struct cms_fpga_struct
 {
   rtdm_lock_t lock;
   struct pci_dev *pcidev;
   resource_size_t mmio;
   struct cms_fpga_context context;

 };

static struct cms_fpga_struct *fpga ;
static struct pci_device_id pci_ids[] =3D
{
  {
    PCI_DEVICE(0x1204, 0xec30),
    //.driver_data =3D (unsigned long)&fpga
  },
  {}
};
static struct rtdm_driver CMS_Xenomai_Driver =3D
{
  .profile_info =3D RTDM_PROFILE_INFO(cms,
                                    RTDM_CLASS_EXPERIMENTAL,
                                    1,
                                    1),
  .device_flags =3D RTDM_NAMED_DEVICE|RTDM_EXCLUSIVE,
  .device_count =3D 1,
  .context_size =3D sizeof(struct cms_fpga_struct),
  .ops =3D
    {
      .open     =3D cms_open,
      .ioctl_rt =3D cms_ioctl,
      .ioctl_nrt=3D cms_ioctl,
      .write_rt =3D NULL , //pci_write,
      .write_nrt=3D NULL ,
      .read_rt  =3D NULL , //pci_read,
      .read_nrt =3D NULL



    }
};


static int pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
{
  int ret;
  int err =3D 0 ;
  static struct cms_fpga_struct *fpga;
  rtdm_printk (KERN_DEBUG "Probe 1 %llx", fpga);
  struct rtdm_device *dev;
  dev =3D kmalloc(sizeof(struct rtdm_device) + RTDM_MAX_DEVNAME_LEN, GFP_KE=
RNEL);
  fpga =3D kmalloc(sizeof(struct cms_fpga_struct), GFP_KERNEL);
  if(!dev) goto out; //cleanup;
  dev->driver =3D &CMS_Xenomai_Driver;
  dev->label =3D "cms_fpga";
  dev->device_data=3D(unsigned long long *)fpga;
  rtdm_printk(KERN_DEBUG "Probe 2 %llx", fpga);
  ret =3D rtdm_dev_register(dev);
//  if(!id->driver_data)
//    {
//      rtdm_printk(KERN_DEBUG "No id->driver_data");
//      return -ENODEV;
//    }
//  fpga =3D id->driver_data;
  rtdm_printk (KERN_DEBUG "Probe 3 %llx", fpga);
  if(fpga =3D=3D NULL)
    {
      rtdm_printk(KERN_DEBUG "fpga =3D=3D NULL");
      return -ENOMEM;
    }

  //memset(fpga, 0, sizeof(struct cms_fpga_struct));
  rtdm_lock_init(&fpga->lock);
  if (pci_enable_device(pdev) < 0)
    {
      rtdm_printk(KERN_ERR "FPGA PCI Not enableded");
      goto out;
    }
  fpga->pcidev =3D pdev;
  ret =3D pci_request_region(pdev, BAR_MEM, "CMS-FPGA");
  if(ret < 0)
    {
      rtdm_printk(KERN_DEBUG "Request region failed @ %0x", fpga->mmio);
    }
  fpga->mmio=3Dpci_resource_start(pdev,BAR_MEM);
  dev_info(&(pdev->dev), "MMIO starts at %llx", fpga->mmio);
  rtdm_printk(KERN_DEBUG "Probe 4 %llx", dev->device_data);
  return err;
out:
kfree(fpga);
return -1;
}



NOTICE: This e-mail message and all attachments transmitted with it may con=
tain trade secrets and confidential information intended solely for the use=
 of the addressee. If the reader of this message is not the intended recipi=
ent, you are hereby notified that any reading, dissemination, distribution,=
 copying, or other use of this message or its attachments is strictly prohi=
bited. If you have received this message in error, please notify the sender=
 immediately by telephone at 407-679-9716, and delete this message and all =
copies and backups thereof. Thank you
