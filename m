MIME-Version: 1.0
From: adilkaraoz <adilkaraoz@domain.hid>
Date: Sun, 26 Dec 2010 20:39:40 +0200
Message-ID: <AANLkTim+BeV2q5stB-ErSVqF9Oy5BJTHtZF29aPN1c6w@domain.hid>
Content-Type: multipart/alternative; boundary=90e6ba53b44609210a0498548cd7
Subject: [Xenomai-help] PCI1711 Rtdm driver reading and writing error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--90e6ba53b44609210a0498548cd7
Content-Type: text/plain; charset=ISO-8859-1

I am writing rtdm driver for PCI1711 card. I got base adress and configured
it. But when I write digtal output or Dac, I can't see changes at those
registers. My Code is below please help me.

#include <rtdm/rtdm_driver.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/vmalloc.h>
#include <asm/io.h>
#include <linux/ioport.h>
#include <linux/cdev.h>
#include <asm/uaccess.h>

#include "xeno_pci1711_driver.h"

static int __devinit pci1711_probe(struct pci_dev *dev, const struct
pci_device_id *id);
static void __devexit pci1711_remove(struct pci_dev *dev);
int xeno_pci1711_rt_open(struct rtdm_dev_context    *context,
                     rtdm_user_info_t           *user_info,
                     int                        oflags);
int xeno_pci1711_rt_close(struct rtdm_dev_context   *context,
                      rtdm_user_info_t          *user_info);
int xeno_pci1711_rt_ioctl(struct rtdm_dev_context   *context,
                      rtdm_user_info_t          *user_info,
                      int                       cmd,
                      void                      *arg);

//int pci1711_rt_rw(struct rtdm_dev_context
*,rtdm_user_info_t*,void*,size_t);

/**
* module info
*/
MODULE_DESCRIPTION("RTDM driver for PCI1711");
MODULE_AUTHOR("Adil Karaoz");
MODULE_LICENSE("GPL");

/**
* global variables
*/
int first_loop=0;
int ret_loop_val=0;

int isRegister = -1;

/**
* define devices our driver supports
*/
static struct pci_device_id pci1711_ids[]={

{PCI_VENDORID_PLX, PCI_DEVICEID_1711, PCI_SUB_VENDORID_PLX,
PCI_SUB_DEVICEID_1711, 0, 0, 0},
 { }
};

/**
* export pci_device_id structure to user space, allowing hotplug
*/
MODULE_DEVICE_TABLE (pci, pci1711_ids);

/**
* create pci_driver structure,
* and register it in pci1711_driver_init_module,
* unregister in pci1711_exit_module
*/
static struct pci_driver pci1711_driver = {

.name     = DRV_NAME,
.id_table = pci1711_ids,
 .probe    = pci1711_probe,
.remove   = __devexit_p(pci1711_remove),
};

/**
 * info on our pic1711 card
 */
struct pci1711_context{
  /* address in kernel space (virtual memory) */
  void __iomem       *base_address;
  /* physical address */
  unsigned long      location;
  /* size/length of the memory */
  unsigned long      mem_size;
  struct rtdm_device *device;
  int                dev_id;
};

struct pci1711_context pci1711_struct;
struct pci1711_context *pci1711_card = &pci1711_struct;

/**
 * ioctl() implementation
 */
int xeno_pci1711_rt_ioctl(struct rtdm_dev_context   *context,
                      rtdm_user_info_t          *user_info,
                      int                       cmd,
                      void                      *arg)
{

  //int err = 0;
  int retval = 0;
  ioc_param_struct param = {0,0};
  ioc_param_struct param2 = {0,0};

  switch(cmd) {

    case PCI1711_IORESET:
      break;

    case 2/*PCI1711_DIOWRITE*/:

       //printk(KERN_DEBUG "writing to registers\n");
         retval = rtdm_safe_copy_from_user(user_info, &param,
                                      arg, sizeof(ioc_param_struct));
         if(retval == 0) {//success
         //@TODO do some checkins, if offset correct...

           iowrite32( param.bv, pci1711_card->base_address + 16 +
param.offset );

           rtdm_printk(KERN_WARNING  "value = %lu port = %u\n", param.bv,
param.offset);
         }else{
          rtdm_printk(KERN_WARNING  "yazilamadi\n");
           return -EFAULT;
         }
         break;

    case 1://PCI1711_DIOREAD:
      //read from register, write to user
      /*if(! capable( CAP_SYS_RAWIO | CAP_SYS_ADMIN ) ){
       printk(KERN_WARNING  "hata is admin\n");
       return -EPERM;
      }*/

      retval = rtdm_safe_copy_from_user(user_info, &param2, arg,
sizeof(ioc_param_struct));

      if(retval == 0) {//success
        //@TODO some checkins, if offset incorrect...
        param.bv = readl( pci1711_card->base_address + 16 + param2.offset );

        rtdm_printk(KERN_WARNING  "value = %lu port = %u\n", param2.bv,
param2.offset);

        if( rtdm_safe_copy_to_user(user_info, arg, &param2,
sizeof(ioc_param_struct)) ){

          rtdm_printk(KERN_WARNING  "hata is copy back\n");

          return -EFAULT;
         }

      }else{
        return -EFAULT;
      }
      break;

    default:
     printk(KERN_WARNING  "default reset = %u write = %lu read = %lu cmd =
%d\n", PCI1711_IORESET, PCI1711_DIOWRITE, PCI1711_DIOREAD, cmd);
       return -ENOTTY;
  }
  return retval;

  return 0;
}

/**********************************************************/
/*            DRIVER OPERATIONS                           */
/**********************************************************/
static const struct rtdm_device xeno_pci1711_driver = {

  struct_version:     RTDM_DEVICE_STRUCT_VER,

  device_flags:       RTDM_NAMED_DEVICE,// | RTDM_EXCLUSIVE,
  context_size:       sizeof(struct pci1711_context),
  device_name:        "",
  //don't try to find DEV_FILE in /dev/ - it's not there -
  //                               this is an RTDM internal identifier
  //you can find it in /proc/iomem

  /* If you do not use kmalloc and kfree, and you made
    sure that there is no syscall in the open/close handler, you
    can declare the open_rt and close_rt handler.
  */

  open_rt:          NULL,//xeno_pci1711_rt_open,
  open_nrt:         xeno_pci1711_rt_open,

  ops: {
    close_rt:       NULL,//xeno_pci1711_rt_close,
    close_nrt:      xeno_pci1711_rt_close,

    ioctl_rt:       (void*)xeno_pci1711_rt_ioctl,
    ioctl_nrt:      NULL,

    read_rt:        NULL,
    read_nrt:       NULL,//pci1711_rt_rw,

    write_rt:       NULL,//pci1711_rt_rw,
    write_nrt:      NULL,//pci1711_rt_rw,
  },

  device_class:       0xff00,
  device_sub_class:   0, //222, //????
  driver_name:        DRV_NAME, //informational driver name
  peripheral_name:    "pci 1711 rtdm", // Informational name
                                     // the device is attached to
  provider_name:      "Adil Karaoz", // Informational name
};

int xeno_pci1711_rt_open(struct rtdm_dev_context    *context,
                     rtdm_user_info_t           *user_info,
                     int                        oflags)
{
  struct pci1711_context *my_context;

  // get the id of the card from the rtdm_device struct
  // of the owning device
  int dev_id = context->device->device_id;

  // get the begin of driver defined context data structure of our driver
  my_context = (struct pci1711_context *)context->dev_private;
  my_context->dev_id = dev_id;

  rtdm_printk( KERN_DEBUG "opening dev with id:%d\n", my_context->dev_id);

  return 0;
}

/**
 * close named rt device
 *
 * as of version 0.1 nothing necessary is provided
 * by this function
 */
int xeno_pci1711_rt_close(struct rtdm_dev_context   *context,
                      rtdm_user_info_t          *user_info)
{
  struct pci1711_context  *my_context;

  // get the context struct
  my_context = (struct pci1711_context *)context->dev_private;
  printk( KERN_DEBUG "closing... id of dev is %d\n", my_context->dev_id);

  return 0;
}

static int pci171x_reset(struct pci_dev *dev)
{

int i;
//#ifdef PCI171X_EXTDEBUG
rtdm_printk( KERN_WARNING "pci1710 EDBG: BGN: pci171x_reset(...)\n");
//#endif
 writew(0x30, pci1711_card->base_address + PCI171x_CNTCTRL);
writew(Control_SW, pci1711_card->base_address + PCI171x_CONTROL); // reset
any operations
 writeb(0, pci1711_card->base_address + PCI171x_CLRFIFO); // clear FIFO
writeb(0, pci1711_card->base_address + PCI171x_CLRINT); // clear INT request
 //start_pacer(dev,-1,0,0); // stop 8254
//devpriv->da_ranges=0;
 //if (this_board->n_aochan) {
writeb(0, pci1711_card->base_address + PCI171x_DAREF); // set DACs to 0..5V
 writew(0, pci1711_card->base_address + PCI171x_DA1); // set DA outputs to
0V
//devpriv->ao_data[0]=0x0000;
 //if (this_board->n_aochan>1) {
writew(0, pci1711_card->base_address + PCI171x_DA2);
//devpriv->ao_data[1]=0x0000;
 //}
//}
writew(0xff, pci1711_card->base_address + PCI171x_DO); // digital outputs to
0
 writeb(0, pci1711_card->base_address + PCI171x_CLRFIFO); // clear FIFO
writeb(0, pci1711_card->base_address + PCI171x_CLRINT); // clear INT request
  //#ifdef PCI171X_EXTDEBUG
rtdm_printk( KERN_WARNING "pci1710 EDBG: END: pci171x_reset(...)\n");
//#endif
return 0;
}

/**
* This function is called by the PCI core when
* it has a struct pci_dev that it thinks this driver wants to control.
*
* Purpose: initialize the device properly
* +set up the rtdm_device structure for this device
*/
static int __devinit pci1711_probe(struct pci_dev *dev, const struct
pci_device_id *id){

 /*
  * @TODO when initializing module, this function "probe" runs two times
  * WHY?
  * and as a side effect base address is initialized two times...
  *
  * the following if-condition avoids two time execution
   */
  struct rtdm_device  *rtdm_dev;
  int          ret_val = 0;
  uint8_t irq;

  rtdm_printk( KERN_WARNING
        "bus number: %c function index: %x vendor: %x device: %x class:
%x\n", dev->bus->number, dev->devfn, dev->vendor, dev->device, dev->class);

  printk( "pci1711 card found!\n" );

  //if-condition evaluates to true in the second loop
  if(first_loop){
      //first_loop =1;
    return ret_loop_val;
  }
  first_loop=1;

  //wake up the device
  ret_val = pci_enable_device(dev);
  if(ret_val!=0){
    printk( KERN_WARNING
        "xeno_pci1711_driver: function pci_enable_device failed\n");
    goto pci_enable_device_err;
  }
  printk(KERN_DEBUG "device woke up!\n");

   //initialization of location and mem_size
  pci1711_card->location = pci_resource_start(dev, PCI_1711_BAR & 0xFFFFFFF0
);
  pci1711_card->mem_size = pci_resource_len(dev, PCI_1711_BAR & 0xFFFFFFF0
);

  //if(pci1711_card->location == 0){
    printk( KERN_WARNING "xeno_pc1711_driver: location = %lx mem = %lx\n",
pci1711_card->location, pci1711_card->mem_size);
  //}

    ret_val = pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
    if (!ret_val){
rtdm_printk("interrupt line no:%d",irq);
 }

  //alloc mem for rtdm structure
  rtdm_dev = kmalloc(sizeof(struct rtdm_device), GFP_KERNEL);
  if(!rtdm_dev){
    printk(KERN_WARNING "xeno_pc1711_driver: kmalloc failed\n");
    ret_val = -ENOMEM; //Insufficient storage space is available.
    goto kmalloc_err;
  }

  //copy the structure to the new memory
  memcpy(rtdm_dev, &xeno_pci1711_driver, sizeof(struct rtdm_device));
  //create filename
  snprintf(rtdm_dev->device_name,
           RTDM_MAX_DEVNAME_LEN, "%s%d", DRV_NAME, 0 /*i*/);
  rtdm_dev->device_id = 0; //i;



  //define two other members of the rtdm_device structure
  rtdm_dev->proc_name = rtdm_dev->device_name;

if ((ret_val = pci_request_region(dev, PCI_1711_BAR & 0xFFFFFFF0,
rtdm_dev->device_name))){

rtdm_printk(KERN_WARNING "xeno_pci1711_driver: device memory allocation
failed!\n");

ret_val = -EBUSY;
 goto request_mem_region_err;

    }


  printk( KERN_DEBUG "going to map memory to kernel space\n");

  //map IO mem to kernel space
  pci1711_card->base_address = ioremap( pci1711_card->location,
pci1711_card->mem_size );

  //pci1711_card->base_address = (void*)(pci1711_card->base_address &
0xFFFFFFFC);

  if(!pci1711_card->base_address){

    rtdm_printk(KERN_WARNING "xeno_pci1711_driver: cannot remap memory
region\n");

    ret_val = -ENODEV;

    goto ioremap_err;
  }

  rtdm_printk(KERN_DEBUG "base address@domain.hid is %p @ %lx \n",
pci1711_card->base_address, pci1711_card->mem_size);

  ret_val = rtdm_dev_register(rtdm_dev);
  if(ret_val < 0){
    printk(KERN_WARNING "xeno_pci1711_driver: cannot register device\n");
    goto dev_register_err;
  }

  pci1711_card->device = rtdm_dev;

   ret_val = pci_set_mwi (dev);
if( ret_val  < 0 ){
 printk(KERN_WARNING "xeno_pci1711_driver: pci_set_mwi error\n");

}

  pci171x_reset(dev);
  //outw( 0xff, pci1711_card->location + 16 );

  return ret_val;

  //clean up code in case of errors
  dev_register_err:
      iounmap(pci1711_card->base_address);

  ioremap_err:
      release_mem_region(pci1711_card->location,
                         pci1711_card->mem_size);

  request_mem_region_err:
  kfree(rtdm_dev);

  kmalloc_err:

  pci_enable_device_err:
      //to get the same ret_val in the second unwanted loop...
      ret_loop_val = ret_val;

  return ret_val;
}

static void __devexit pci1711_remove(struct pci_dev *dev){

  //@TODO:when removing module/driver this function runs two times
  //WHY?

  //the next if condition avoids executing the body of the function
  //more than one time. if-condition evaluates to true in the second
  //loop.
  if(!first_loop){
      //first_loop=0;
    return;
  }
  first_loop=0;

  printk( KERN_DEBUG "removing...\n" );

  //remove char device from the system
  //unregister RTdriver
  if( pci1711_card->device != NULL )
  rtdm_dev_unregister(pci1711_card->device, 1000);


  if( pci1711_card->location != 0 ){
  printk( KERN_DEBUG "removing base address@domain.hid %p @ %lx\n",
pci1711_card->base_address, pci1711_card->mem_size);

   //release virtual memory
   iounmap(pci1711_card->base_address);

   pci_release_region(dev, PCI_1711_BAR & 0xFFFFFFF0 );

   pci_clear_mwi(dev);

  }

  //free allocated memory
  if( pci1711_card->device != NULL )
  kfree(pci1711_card->device);
}

/**
* Init module function
*/
static int pci1711_driver_init_module(void){

static int ret_val;
 printk( KERN_DEBUG "Module pci1711_driver init\n" );
 ret_val = pci_register_driver(&pci1711_driver);
 isRegister = ret_val;
 if( isRegister < 0 ){
      printk("PCI-1711 NOT register \n");
        return(-EIO);

    }
 //pci1711_probe( pcidev, pcidev->driver->id_table );
 return ret_val;
}

/**
* Exit module function
*/
static void pci1711_driver_exit_module(void){

 printk( KERN_DEBUG "Module pci1711_driver exit\n" );
 if( isRegister >= 0 ){
 pci_unregister_driver(&pci1711_driver);
//pci1711_remove(pcidev);
}
}

module_init(pci1711_driver_init_module);
module_exit(pci1711_driver_exit_module);

--90e6ba53b44609210a0498548cd7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf-8"><s=
pan class=3D"Apple-style-span" style=3D"font-family: arial, sans-serif; fon=
t-size: 13px; border-collapse: collapse; "><div>I am writing rtdm driver fo=
r PCI1711 card. I got base adress and configured it. But when I write digta=
l output or Dac, I can&#39;t see changes at those registers. My Code is bel=
ow please help me.</div>

<div><br></div><div><div>#include &lt;rtdm/rtdm_driver.h&gt;</div><div>#inc=
lude &lt;linux/init.h&gt;</div><div>#include &lt;linux/module.h&gt;</div><d=
iv>#include &lt;linux/vmalloc.h&gt;</div><div>#include &lt;asm/io.h&gt;</di=
v>

<div>#include &lt;linux/ioport.h&gt;</div><div>#include &lt;linux/cdev.h&gt=
;</div><div>#include &lt;asm/uaccess.h&gt;</div><div><br></div><div>#includ=
e &quot;xeno_pci1711_driver.h&quot;</div><div><br></div><div>static int __d=
evinit pci1711_probe(struct pci_dev *dev, const struct pci_device_id *id);<=
/div>

<div>static void __devexit pci1711_remove(struct pci_dev *dev);</div><div>i=
nt xeno_pci1711_rt_open(struct rtdm_dev_context =A0 =A0*context,</div><div>=
=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtdm_user_info_t =A0 =A0 =A0 =A0=
 =A0 *user_info,</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0oflags);</div>

<div>int xeno_pci1711_rt_close(struct rtdm_dev_context =A0 *context,</div><=
div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtdm_user_info_t =A0 =A0 =
=A0 =A0 =A0*user_info);</div><div>int xeno_pci1711_rt_ioctl(struct rtdm_dev=
_context =A0 *context,</div><div>
=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtdm_user_info_t =A0 =A0 =A0 =
=A0 =A0*user_info,</div>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 cmd,</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*arg);</div><div=
>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0</div><div>//int pci1711_rt_=
rw(struct rtdm_dev_context *,rtdm_user_info_t*,void*,size_t);</div>

<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0</div><div>/**</div><div=
>* module info</div><div>*/</div><div>MODULE_DESCRIPTION(&quot;RTDM driver =
for PCI1711&quot;);</div><div>MODULE_AUTHOR(&quot;Adil Karaoz&quot;);</div>=
<div>MODULE_LICENSE(&quot;GPL&quot;);</div>

<div><br></div><div>/**</div><div>* global variables</div><div>*/</div><div=
>int first_loop=3D0;</div><div>int ret_loop_val=3D0;</div><div><br></div><d=
iv>int isRegister =3D -1;</div><div><br></div><div>/**</div><div>* define d=
evices our driver supports</div>

<div>*/</div><div>static struct pci_device_id pci1711_ids[]=3D{</div><div><=
br></div><div><span style=3D"white-space: pre-wrap; ">	</span>{PCI_VENDORID=
_PLX, PCI_DEVICEID_1711, PCI_SUB_VENDORID_PLX, PCI_SUB_DEVICEID_1711, 0, 0,=
 0},</div>

<div><span style=3D"white-space: pre-wrap; ">	</span>{ }</div><div><span st=
yle=3D"white-space: pre-wrap; ">	</span></div><div>};</div><div><br></div><=
div>/**</div><div>* export pci_device_id structure to user space, allowing =
hotplug</div>

<div>*/</div><div>MODULE_DEVICE_TABLE (pci, pci1711_ids);</div><div><br></d=
iv><div>/**</div><div>* create pci_driver structure,</div><div>* and regist=
er it in pci1711_driver_init_module,</div><div>* unregister in pci1711_exit=
_module</div>

<div>*/</div><div>static struct pci_driver pci1711_driver =3D {</div><div><=
br></div><div><span style=3D"white-space: pre-wrap; ">	</span>.name =A0 =A0=
 =3D DRV_NAME,</div><div><span style=3D"white-space: pre-wrap; ">	</span>.i=
d_table =3D pci1711_ids,</div>

<div><span style=3D"white-space: pre-wrap; ">	</span>.probe =A0 =A0=3D pci1=
711_probe,</div><div><span style=3D"white-space: pre-wrap; ">	</span>.remov=
e<span style=3D"white-space: pre-wrap; ">	</span>=A0=A0=3D __devexit_p(pci1=
711_remove),</div>

<div>};</div><div><br></div><div>/**</div><div>=A0* info on our pic1711 car=
d</div><div>=A0*/=A0</div><div>struct pci1711_context{</div><div>=A0=A0/* a=
ddress in kernel space (virtual memory) */</div><div>=A0=A0void __iomem =A0=
 =A0 =A0 *base_address;=A0</div>

<div>=A0=A0/* physical address */</div><div>=A0=A0unsigned long =A0 =A0 =A0=
location;</div><div>=A0=A0/* size/length of the memory */</div><div>=A0=A0u=
nsigned long =A0 =A0 =A0mem_size;</div><div>=A0=A0struct rtdm_device *devic=
e;</div><div>=A0=A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_id;</div>

<div>};</div><div><br></div><div>struct pci1711_context pci1711_struct;</di=
v><div>struct pci1711_context *pci1711_card =3D &amp;pci1711_struct;</div><=
div><br></div><div>/**</div><div>=A0* ioctl() implementation</div><div>=A0*=
/</div>

<div>int xeno_pci1711_rt_ioctl(struct rtdm_dev_context =A0 *context,</div><=
div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtdm_user_info_t =A0 =A0 =
=A0 =A0 =A0*user_info,</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd,</div><div>=A0=A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0*arg)</div>

<div>{</div><div><br></div><div>=A0=A0//int err =3D 0;</div><div>=A0=A0int =
retval =3D 0;</div><div>=A0=A0ioc_param_struct param =3D {0,0};</div><div>=
=A0=A0ioc_param_struct param2 =3D {0,0};</div><div><br></div><div>=A0=A0swi=
tch(cmd) {</div><div>=A0=A0 =A0 =A0</div>

<div>=A0=A0 =A0case PCI1711_IORESET:</div><div>=A0=A0 =A0 =A0break;</div><d=
iv>=A0=A0 =A0 =A0</div><div>=A0=A0 =A0case 2/*PCI1711_DIOWRITE*/:</div><div=
>=A0=A0 =A0</div><div>=A0=A0 =A0 =A0 //printk(KERN_DEBUG &quot;writing to r=
egisters\n&quot;);</div><div>=A0=A0 =A0 =A0 =A0 retval =3D rtdm_safe_copy_f=
rom_user(user_info, &amp;param,=A0</div>

<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0arg, sizeof(ioc_param_struct));</div><div>=A0=A0 =A0 =A0 =A0 if(ret=
val =3D=3D 0) {//success</div><div>=A0=A0 =A0 =A0 =A0 //@TODO do some check=
ins, if offset correct...</div><div>=A0=A0 =A0 =A0 =A0</div><div>=A0=A0 =A0=
 =A0 =A0 =A0 iowrite32(=A0<a href=3D"http://param.bv/" target=3D"_blank" st=
yle=3D"color: rgb(20, 125, 186); ">param.bv</a>, pci1711_card-&gt;base_addr=
ess + 16 + param.offset );</div>

<div>=A0=A0 =A0 =A0 =A0 =A0=A0<span style=3D"white-space: pre-wrap; ">		</s=
pan></div><div>=A0=A0 =A0 =A0 =A0 =A0 rtdm_printk(KERN_WARNING =A0&quot;val=
ue =3D %lu port =3D %u\n&quot;,=A0<a href=3D"http://param.bv/" target=3D"_b=
lank" style=3D"color: rgb(20, 125, 186); ">param.bv</a>, param.offset);</di=
v>

<div>=A0=A0 =A0 =A0 =A0 }else{</div><div>=A0=A0 =A0 =A0 =A0=A0<span style=
=3D"white-space: pre-wrap; ">	</span>rtdm_printk(KERN_WARNING =A0&quot;yazi=
lamadi\n&quot;);</div><div>=A0=A0 =A0 =A0 =A0 =A0 return -EFAULT;</div><div=
>=A0=A0 =A0 =A0 =A0 }</div><div>=A0=A0 =A0 =A0 =A0 break;</div>

<div>=A0=A0 =A0 =A0</div><div>=A0=A0 =A0case 1://PCI1711_DIOREAD:</div><div=
>=A0=A0 =A0 =A0//read from register, write to user</div><div>=A0=A0 =A0 =A0=
/*if(! capable( CAP_SYS_RAWIO | CAP_SYS_ADMIN ) ){</div><div>=A0=A0 =A0 =A0=
<span style=3D"white-space: pre-wrap; ">	</span>printk(KERN_WARNING =A0&quo=
t;hata is admin\n&quot;);</div>

<div>=A0=A0 =A0 =A0<span style=3D"white-space: pre-wrap; ">	</span>return -=
EPERM;</div><div>=A0=A0 =A0 =A0}*/</div><div>=A0=A0 =A0 =A0</div><div>=A0=
=A0 =A0 =A0retval =3D rtdm_safe_copy_from_user(user_info, &amp;param2, arg,=
 sizeof(ioc_param_struct));</div>
<div>
=A0=A0 =A0 =A0</div><div>=A0=A0 =A0 =A0if(retval =3D=3D 0) {//success</div>=
<div>=A0=A0 =A0 =A0 =A0//@TODO some checkins, if offset incorrect...</div><=
div>=A0=A0 =A0 =A0 =A0<a href=3D"http://param.bv/" target=3D"_blank" style=
=3D"color: rgb(20, 125, 186); ">param.bv</a>=A0=3D readl( pci1711_card-&gt;=
base_address + 16 + param2.offset );</div>

<div>=A0=A0 =A0 =A0 =A0</div><div>=A0=A0 =A0 =A0 =A0rtdm_printk(KERN_WARNIN=
G =A0&quot;value =3D %lu port =3D %u\n&quot;,=A0<a href=3D"http://param2.bv=
/" target=3D"_blank" style=3D"color: rgb(20, 125, 186); ">param2.bv</a>, pa=
ram2.offset);</div><div>=A0=A0 =A0 =A0 =A0</div>

<div>=A0=A0 =A0 =A0 =A0if( rtdm_safe_copy_to_user(user_info, arg, &amp;para=
m2, sizeof(ioc_param_struct)) ){</div><div>=A0=A0 =A0 =A0 =A0</div><div>=A0=
=A0 =A0 =A0 =A0 =A0rtdm_printk(KERN_WARNING =A0&quot;hata is copy back\n&qu=
ot;);</div><div>=A0=A0 =A0 =A0 =A0 =A0</div>

<div>=A0=A0 =A0 =A0 =A0 =A0return -EFAULT;</div><div>=A0=A0 =A0 =A0 =A0 }</=
div><div>=A0=A0 =A0 =A0 =A0 =A0</div><div>=A0=A0 =A0 =A0}else{</div><div>=
=A0=A0 =A0 =A0 =A0return -EFAULT;</div><div>=A0=A0 =A0 =A0}</div><div>=A0=
=A0 =A0 =A0break;</div><div>=A0=A0 =A0 =A0</div><div>=A0=A0 =A0default:</di=
v><div>

=A0=A0 =A0<span style=3D"white-space: pre-wrap; ">	</span>printk(KERN_WARNI=
NG =A0&quot;default reset =3D %u write =3D %lu read =3D %lu cmd =3D %d\n&qu=
ot;, PCI1711_IORESET, PCI1711_DIOWRITE, PCI1711_DIOREAD, cmd);</div><div>=
=A0=A0 =A0 =A0<span style=3D"white-space: pre-wrap; ">	</span>return -ENOTT=
Y;</div>

<div>=A0=A0}</div><div>=A0=A0return retval;</div><div>=A0=A0</div><div>=A0=
=A0return 0;</div><div>}</div><div><br></div><div>/************************=
**********************************/</div><div>/* =A0 =A0 =A0 =A0 =A0 =A0DRI=
VER OPERATIONS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */</div>

<div>/**********************************************************/</div><div=
>static const struct rtdm_device xeno_pci1711_driver =3D {</div><div><br></=
div><div>=A0=A0struct_version: =A0 =A0 RTDM_DEVICE_STRUCT_VER,</div><div><b=
r></div>

<div>=A0=A0device_flags: =A0 =A0 =A0 RTDM_NAMED_DEVICE,// | RTDM_EXCLUSIVE,=
</div><div>=A0=A0context_size: =A0 =A0 =A0 sizeof(struct pci1711_context),<=
/div><div>=A0=A0device_name: =A0 =A0 =A0 =A0&quot;&quot;,=A0</div><div>=A0=
=A0//don&#39;t try to find DEV_FILE in /dev/ - it&#39;s not there -=A0</div=
>

<div>=A0=A0// =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t=
his is an RTDM internal identifier</div><div>=A0=A0//you can find it in /pr=
oc/iomem</div><div><br></div><div>=A0=A0/* If you do not use kmalloc and kf=
ree, and you made</div><div>=A0=A0 =A0sure that there is no syscall in the =
open/close handler, you</div>

<div>=A0=A0 =A0can declare the open_rt and close_rt handler.</div><div>=A0=
=A0*/</div><div>=A0=A0</div><div>=A0=A0open_rt: =A0 =A0 =A0 =A0 =A0NULL,//x=
eno_pci1711_rt_open,</div><div>=A0=A0open_nrt: =A0 =A0 =A0 =A0 xeno_pci1711=
_rt_open,</div><div><br></div><div>=A0=A0ops: {</div>

<div>=A0=A0 =A0close_rt: =A0 =A0 =A0 NULL,//xeno_pci1711_rt_close,</div><di=
v>=A0=A0 =A0close_nrt: =A0 =A0 =A0xeno_pci1711_rt_close,</div><div><br></di=
v><div>=A0=A0 =A0ioctl_rt: =A0 =A0 =A0 (void*)xeno_pci1711_rt_ioctl,</div><=
div>=A0=A0 =A0ioctl_nrt: =A0 =A0 =A0NULL,</div>

<div><br></div><div>=A0=A0 =A0read_rt: =A0 =A0 =A0 =A0NULL,</div><div>=A0=
=A0 =A0read_nrt: =A0 =A0 =A0 NULL,//pci1711_rt_rw,</div><div><br></div><div=
>=A0=A0 =A0write_rt: =A0 =A0 =A0 NULL,//pci1711_rt_rw,</div><div>=A0=A0 =A0=
write_nrt: =A0 =A0 =A0NULL,//pci1711_rt_rw,</div>

<div>=A0=A0},</div><div><br></div><div>=A0=A0device_class: =A0 =A0 =A0 0xff=
00,=A0</div><div>=A0=A0device_sub_class: =A0 0, //222, //????</div><div>=A0=
=A0driver_name: =A0 =A0 =A0 =A0DRV_NAME, //informational driver name</div><=
div>=A0=A0peripheral_name: =A0 =A0&quot;pci 1711 rtdm&quot;, // Information=
al name=A0</div>

<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 // the device is attached to</div><div>=A0=A0provider_name: =A0 =A0 =
=A0&quot;Adil Karaoz&quot;, // Informational name</div><div>};</div><div><b=
r></div><div>int xeno_pci1711_rt_open(struct rtdm_dev_context =A0 =A0*conte=
xt,</div>

<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtdm_user_info_t =A0 =A0 =
=A0 =A0 =A0 *user_info,</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0oflags)</div><div>{<=
/div><div>=A0=A0struct pci1711_context *my_context;</div><div>=A0=A0</div><=
div>=A0=A0// get the id of the card from the rtdm_device struct=A0</div>

<div>=A0=A0// of the owning device</div><div>=A0=A0int dev_id =3D context-&=
gt;device-&gt;device_id;</div><div>=A0=A0 =A0</div><div>=A0=A0// get the be=
gin of driver defined context data structure of our driver</div><div>=A0=A0=
my_context =3D (struct pci1711_context *)context-&gt;dev_private;</div>

<div>=A0=A0my_context-&gt;dev_id =3D dev_id;</div><div>=A0=A0</div><div>=A0=
=A0rtdm_printk( KERN_DEBUG &quot;opening dev with id:%d\n&quot;, my_context=
-&gt;dev_id);</div><div><br></div><div>=A0=A0return 0;</div><div>}</div><di=
v>=A0=A0 =A0</div><div>

/**</div><div>=A0* close named rt device</div><div>=A0*=A0</div><div>=A0* a=
s of version 0.1 nothing necessary is provided</div><div>=A0* by this funct=
ion</div><div>=A0*/</div><div>int xeno_pci1711_rt_close(struct rtdm_dev_con=
text =A0 *context,</div>

<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rtdm_user_info_t =A0 =A0=
 =A0 =A0 =A0*user_info)</div><div>{</div><div>=A0=A0struct pci1711_context =
=A0*my_context;</div><div>=A0=A0</div><div>=A0=A0// get the context struct<=
/div><div>=A0=A0my_context =3D (struct pci1711_context *)context-&gt;dev_pr=
ivate;</div>

<div>=A0=A0printk( KERN_DEBUG &quot;closing... id of dev is %d\n&quot;, my_=
context-&gt;dev_id);</div><div>=A0=A0</div><div>=A0=A0return 0;</div><div>}=
</div><div><br></div><div>static int pci171x_reset(struct pci_dev *dev)</di=
v><div>
{</div>
<div><br></div><div><span style=3D"white-space: pre-wrap; ">	</span>int i;<=
/div><div><span style=3D"white-space: pre-wrap; ">	</span></div><div>//#ifd=
ef PCI171X_EXTDEBUG</div><div><span style=3D"white-space: pre-wrap; ">	</sp=
an>rtdm_printk( KERN_WARNING &quot;pci1710 EDBG: BGN: pci171x_reset(...)\n&=
quot;);</div>

<div>//#endif</div><div><span style=3D"white-space: pre-wrap; ">	</span></d=
iv><div><span style=3D"white-space: pre-wrap; ">	</span>writew(0x30, pci171=
1_card-&gt;base_address + PCI171x_CNTCTRL);</div><div><span style=3D"white-=
space: pre-wrap; ">	</span>writew(Control_SW, pci1711_card-&gt;base_address=
 + PCI171x_CONTROL);<span style=3D"white-space: pre-wrap; ">	</span>// rese=
t any operations</div>

<div><span style=3D"white-space: pre-wrap; ">	</span>writeb(0, pci1711_card=
-&gt;base_address + PCI171x_CLRFIFO);<span style=3D"white-space: pre-wrap; =
">		</span>// clear FIFO</div><div><span style=3D"white-space: pre-wrap; ">=
	</span>writeb(0, pci1711_card-&gt;base_address + PCI171x_CLRINT);<span sty=
le=3D"white-space: pre-wrap; ">		</span>// clear INT request</div>

<div><span style=3D"white-space: pre-wrap; ">	</span>//start_pacer(dev,-1,0=
,0);<span style=3D"white-space: pre-wrap; ">				</span>// stop 8254</div><d=
iv><span style=3D"white-space: pre-wrap; ">	</span>//devpriv-&gt;da_ranges=
=3D0;</div>

<div><span style=3D"white-space: pre-wrap; ">	</span>//if (this_board-&gt;n=
_aochan) {</div><div><span style=3D"white-space: pre-wrap; ">		</span>write=
b(0, pci1711_card-&gt;base_address + PCI171x_DAREF); // set DACs to 0..5V</=
div>

<div><span style=3D"white-space: pre-wrap; ">		</span>writew(0, pci1711_car=
d-&gt;base_address + PCI171x_DA1);<span style=3D"white-space: pre-wrap; ">	=
	</span>// set DA outputs to 0V</div><div><span style=3D"white-space: pre-w=
rap; ">		</span>//devpriv-&gt;ao_data[0]=3D0x0000;=A0</div>

<div><span style=3D"white-space: pre-wrap; ">		</span>//if (this_board-&gt;=
n_aochan&gt;1) {</div><div><span style=3D"white-space: pre-wrap; ">			</spa=
n>writew(0, pci1711_card-&gt;base_address + PCI171x_DA2);</div><div><span s=
tyle=3D"white-space: pre-wrap; ">			</span>//devpriv-&gt;ao_data[1]=3D0x000=
0;</div>

<div><span style=3D"white-space: pre-wrap; ">		</span>//}</div><div><span s=
tyle=3D"white-space: pre-wrap; ">	</span>//}</div><div><span style=3D"white=
-space: pre-wrap; ">	</span>writew(0xff, pci1711_card-&gt;base_address + PC=
I171x_DO);<span style=3D"white-space: pre-wrap; ">		</span>// digital outpu=
ts to 0</div>

<div><span style=3D"white-space: pre-wrap; ">	</span>writeb(0, pci1711_card=
-&gt;base_address + PCI171x_CLRFIFO);<span style=3D"white-space: pre-wrap; =
">		</span>// clear FIFO</div><div><span style=3D"white-space: pre-wrap; ">=
	</span>writeb(0, pci1711_card-&gt;base_address + PCI171x_CLRINT);<span sty=
le=3D"white-space: pre-wrap; ">		</span>// clear INT request</div>

<div><span style=3D"white-space: pre-wrap; ">	</span></div><div><span style=
=3D"white-space: pre-wrap; ">	</span></div><div><span style=3D"white-space:=
 pre-wrap; ">	</span></div><div>//#ifdef PCI171X_EXTDEBUG</div><div><span s=
tyle=3D"white-space: pre-wrap; ">	</span>rtdm_printk( KERN_WARNING &quot;pc=
i1710 EDBG: END: pci171x_reset(...)\n&quot;);</div>

<div>//#endif</div><div><span style=3D"white-space: pre-wrap; ">	</span>ret=
urn 0;</div><div>}</div><div><br></div><div>/**</div><div>* This function i=
s called by the PCI core when</div><div>* it has a struct pci_dev that it t=
hinks this driver wants to control.</div>

<div>*</div><div>* Purpose: initialize the device properly</div><div>* +set=
 up the rtdm_device structure for this device</div><div>*/</div><div>static=
 int __devinit pci1711_probe(struct pci_dev *dev, const struct pci_device_i=
d *id){</div>

<div><br></div><div><span style=3D"white-space: pre-wrap; ">	</span>=A0/*=
=A0</div><div>=A0=A0* @TODO when initializing module, this function &quot;p=
robe&quot; runs two times</div><div>=A0=A0* WHY?</div><div>=A0=A0* and as a=
 side effect base address is initialized two times...</div>

<div>=A0=A0*</div><div>=A0=A0* the following if-condition avoids two time e=
xecution</div><div>=A0=A0 */</div><div>=A0=A0struct rtdm_device =A0*rtdm_de=
v;</div><div>=A0=A0int =A0 =A0 =A0 =A0 =A0ret_val =3D 0;</div><div>=A0=A0ui=
nt8_t irq;</div><div>=A0=A0</div><div>

=A0=A0rtdm_printk( KERN_WARNING=A0</div><div>=A0=A0 =A0 =A0 =A0&quot;bus nu=
mber: %c function index: %x vendor: %x device: %x class: %x\n&quot;, dev-&g=
t;bus-&gt;number, dev-&gt;devfn, dev-&gt;vendor, dev-&gt;device, dev-&gt;cl=
ass);</div>
<div>
<br></div><div>=A0=A0printk( &quot;pci1711 card found!\n&quot; );</div><div=
>=A0</div><div>=A0=A0//if-condition evaluates to true in the second loop</d=
iv><div>=A0=A0if(first_loop){</div><div>=A0=A0 =A0 =A0//first_loop =3D1;</d=
iv><div>=A0=A0 =A0return ret_loop_val;</div>

<div>=A0=A0}</div><div>=A0=A0first_loop=3D1;</div><div>=A0=A0</div><div>=A0=
=A0//wake up the device</div><div>=A0=A0ret_val =3D pci_enable_device(dev);=
</div><div>=A0=A0if(ret_val!=3D0){</div><div>=A0=A0 =A0printk( KERN_WARNING=
=A0</div><div>=A0=A0 =A0 =A0 =A0&quot;xeno_pci1711_driver: function pci_ena=
ble_device failed\n&quot;);</div>

<div>=A0=A0 =A0goto pci_enable_device_err;</div><div>=A0=A0}</div><div>=A0=
=A0printk(KERN_DEBUG &quot;device woke up!\n&quot;);</div><div><br></div><d=
iv>=A0=A0 //initialization of location and mem_size</div><div>=A0=A0pci1711=
_card-&gt;location =3D pci_resource_start(dev, PCI_1711_BAR &amp; 0xFFFFFFF=
0 );</div>

<div>=A0=A0pci1711_card-&gt;mem_size =3D pci_resource_len(dev, PCI_1711_BAR=
 &amp; 0xFFFFFFF0 );</div><div>=A0=A0</div><div>=A0=A0//if(pci1711_card-&gt=
;location =3D=3D 0){</div><div>=A0=A0 =A0printk( KERN_WARNING &quot;xeno_pc=
1711_driver: location =3D %lx mem =3D %lx\n&quot;, pci1711_card-&gt;locatio=
n, pci1711_card-&gt;mem_size);</div>

<div>=A0=A0//}</div><div>=A0=A0</div><div>=A0=A0 =A0ret_val =3D pci_read_co=
nfig_byte(dev, PCI_INTERRUPT_LINE, &amp;irq);</div><div>=A0=A0 =A0if (!ret_=
val){</div><div><span style=3D"white-space: pre-wrap; ">		</span>rtdm_print=
k(&quot;interrupt line no:%d&quot;,irq);<span style=3D"white-space: pre-wra=
p; ">	</span></div>

<div><span style=3D"white-space: pre-wrap; ">	</span>}</div><div>=A0=A0</di=
v><div>=A0=A0//alloc mem for rtdm structure</div><div>=A0=A0rtdm_dev =3D km=
alloc(sizeof(struct rtdm_device), GFP_KERNEL);</div><div>=A0=A0if(!rtdm_dev=
){</div><div>=A0=A0 =A0printk(KERN_WARNING &quot;xeno_pc1711_driver: kmallo=
c failed\n&quot;);</div>

<div>=A0=A0 =A0ret_val =3D -ENOMEM; //Insufficient storage space is availab=
le.</div><div>=A0=A0 =A0goto kmalloc_err;</div><div>=A0=A0}</div><div>=A0=
=A0=A0</div><div>=A0=A0//copy the structure to the new memory</div><div>=A0=
=A0memcpy(rtdm_dev, &amp;xeno_pci1711_driver, sizeof(struct rtdm_device));<=
/div>

<div>=A0=A0//create filename=A0</div><div>=A0=A0snprintf(rtdm_dev-&gt;devic=
e_name,=A0</div><div>=A0=A0 =A0 =A0 =A0 =A0 RTDM_MAX_DEVNAME_LEN, &quot;%s%=
d&quot;, DRV_NAME, 0 /*i*/);</div><div>=A0=A0rtdm_dev-&gt;device_id =3D 0; =
//i;</div><div>=A0=A0</div><div>

=A0=A0</div><div><br></div><div>=A0=A0//define two other members of the rtd=
m_device structure</div><div>=A0=A0rtdm_dev-&gt;proc_name =3D rtdm_dev-&gt;=
device_name;</div><div>=A0=A0</div><div><span style=3D"white-space: pre-wra=
p; ">	</span>if ((ret_val =3D pci_request_region(dev, PCI_1711_BAR &amp; 0x=
FFFFFFF0, rtdm_dev-&gt;device_name))){</div>

<div>=A0=A0=A0</div><div><span style=3D"white-space: pre-wrap; ">		</span>r=
tdm_printk(KERN_WARNING &quot;xeno_pci1711_driver: device memory allocation=
 failed!\n&quot;);</div><div>=A0=A0 =A0</div><div><span style=3D"white-spac=
e: pre-wrap; ">		</span>ret_val =3D -EBUSY; =A0=A0</div>

<div><span style=3D"white-space: pre-wrap; ">		</span>goto request_mem_regi=
on_err;</div><div>=A0=A0=A0<span style=3D"white-space: pre-wrap; ">	</span>=
</div><div>=A0=A0=A0<span style=3D"white-space: pre-wrap; ">	</span>}</div>=
<div>=A0=A0=A0<span style=3D"white-space: pre-wrap; ">	</span></div>

<div>=A0=A0 =A0=A0</div><div>=A0=A0printk( KERN_DEBUG &quot;going to map me=
mory to kernel space\n&quot;);</div><div>=A0=A0</div><div>=A0=A0//map IO me=
m to kernel space</div><div>=A0=A0pci1711_card-&gt;base_address =3D ioremap=
( pci1711_card-&gt;location, pci1711_card-&gt;mem_size );</div>

<div>=A0=A0</div><div>=A0=A0//pci1711_card-&gt;base_address =3D (void*)(pci=
1711_card-&gt;base_address &amp; 0xFFFFFFFC);</div><div>=A0=A0</div><div>=
=A0=A0if(!pci1711_card-&gt;base_address){</div><div>=A0=A0</div><div>=A0=A0=
 =A0rtdm_printk(KERN_WARNING &quot;xeno_pci1711_driver: cannot remap memory=
 region\n&quot;);</div>

<div>=A0=A0 =A0</div><div>=A0=A0 =A0ret_val =3D -ENODEV;</div><div>=A0=A0 =
=A0</div><div>=A0=A0 =A0goto ioremap_err;</div><div>=A0=A0}</div><div>=A0=
=A0</div><div>=A0=A0rtdm_printk(KERN_DEBUG &quot;base address@domain.hid is %p =
@ %lx \n&quot;, pci1711_card-&gt;base_address, pci1711_card-&gt;mem_size);<=
/div>

<div>=A0=A0</div><div>=A0=A0ret_val =3D rtdm_dev_register(rtdm_dev);</div><=
div>=A0=A0if(ret_val &lt; 0){</div><div>=A0=A0 =A0printk(KERN_WARNING &quot=
;xeno_pci1711_driver: cannot register device\n&quot;);</div><div>=A0=A0 =A0=
goto dev_register_err;</div>

<div>=A0=A0}</div><div><br></div><div>=A0=A0pci1711_card-&gt;device =3D rtd=
m_dev;</div><div>=A0=A0</div><div>=A0=A0<span style=3D"white-space: pre-wra=
p; ">	</span>ret_val =3D pci_set_mwi (dev);</div><div><span style=3D"white-=
space: pre-wrap; ">	</span>if( ret_val =A0&lt; 0 ){</div>

<div><span style=3D"white-space: pre-wrap; ">	</span></div><div><span style=
=3D"white-space: pre-wrap; ">		</span>printk(KERN_WARNING &quot;xeno_pci171=
1_driver: pci_set_mwi error\n&quot;);</div><div><br></div><div><span style=
=3D"white-space: pre-wrap; ">	</span>}</div>

<div>=A0=A0</div><div>=A0=A0pci171x_reset(dev);</div><div>=A0=A0//outw( 0xf=
f, pci1711_card-&gt;location + 16 );</div><div>=A0=A0</div><div>=A0=A0retur=
n ret_val;</div><div>=A0=A0</div><div>=A0=A0//clean up code in case of erro=
rs</div><div>=A0=A0dev_register_err:</div>

<div>=A0=A0 =A0 =A0iounmap(pci1711_card-&gt;base_address);</div><div>=A0=A0=
</div><div>=A0=A0ioremap_err:</div><div>=A0=A0 =A0 =A0release_mem_region(pc=
i1711_card-&gt;location,=A0</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 pci1711_card-&gt;mem_size);</div>
<div>
=A0=A0</div><div>=A0=A0request_mem_region_err:</div><div>=A0=A0kfree(rtdm_d=
ev);</div><div>=A0=A0</div><div>=A0=A0kmalloc_err:</div><div>=A0=A0</div><d=
iv>=A0=A0pci_enable_device_err:</div><div>=A0=A0 =A0 =A0//to get the same r=
et_val in the second unwanted loop...</div>

<div>=A0=A0 =A0 =A0ret_loop_val =3D ret_val;=A0</div><div>=A0=A0</div><div>=
=A0=A0return ret_val;</div><div>}</div><div><br></div><div>static void __de=
vexit pci1711_remove(struct pci_dev *dev){</div><div><br></div><div>=A0=A0/=
/@TODO:when removing module/driver this function runs two times</div>

<div>=A0=A0//WHY?</div><div>=A0=A0=A0</div><div>=A0=A0//the next if conditi=
on avoids executing the body of the function</div><div>=A0=A0//more than on=
e time. if-condition evaluates to true in the second</div><div>=A0=A0//loop=
.</div><div>=A0=A0if(!first_loop){</div>

<div>=A0=A0 =A0 =A0//first_loop=3D0;</div><div>=A0=A0 =A0return;</div><div>=
=A0=A0}</div><div>=A0=A0first_loop=3D0;</div><div>=A0=A0=A0</div><div>=A0=
=A0printk( KERN_DEBUG &quot;removing...\n&quot; );=A0</div><div>=A0=A0=A0</=
div><div>=A0=A0//remove char device from the system</div>

<div>=A0=A0//unregister RTdriver</div><div>=A0=A0if( pci1711_card-&gt;devic=
e !=3D NULL )</div><div><span style=3D"white-space: pre-wrap; ">	</span>=A0=
=A0rtdm_dev_unregister(pci1711_card-&gt;device, 1000);</div><div><span styl=
e=3D"white-space: pre-wrap; ">	</span>=A0=A0</div>

<div>=A0=A0</div><div>=A0=A0if( pci1711_card-&gt;location !=3D 0 ){</div><d=
iv><span style=3D"white-space: pre-wrap; ">	</span>=A0=A0printk( KERN_DEBUG=
 &quot;removing base address@domain.hid %p @ %lx\n&quot;, pci1711_card-&gt;base=
_address, pci1711_card-&gt;mem_size);</div>

<div>=A0=A0</div><div>=A0=A0<span style=3D"white-space: pre-wrap; ">	</span=
>//release virtual memory</div><div>=A0=A0<span style=3D"white-space: pre-w=
rap; ">	</span>iounmap(pci1711_card-&gt;base_address);</div><div>=A0=A0<spa=
n style=3D"white-space: pre-wrap; ">	</span></div>

<div>=A0=A0<span style=3D"white-space: pre-wrap; ">	</span>pci_release_regi=
on(dev, PCI_1711_BAR &amp; 0xFFFFFFF0 );</div><div>=A0=A0<span style=3D"whi=
te-space: pre-wrap; ">	</span></div><div>=A0=A0<span style=3D"white-space: =
pre-wrap; ">	</span>pci_clear_mwi(dev);</div>

<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0</div><div>=A0=A0}</div><=
div>=A0=A0</div><div>=A0=A0//free allocated memory</div><div>=A0=A0if( pci1=
711_card-&gt;device !=3D NULL )</div><div>=A0<span style=3D"white-space: pr=
e-wrap; ">	</span>kfree(pci1711_card-&gt;device);</div>

<div>}</div><div><br></div><div>/**</div><div>* Init module function</div><=
div>*/</div><div>static int pci1711_driver_init_module(void){</div><div><br=
></div><div><span style=3D"white-space: pre-wrap; ">	</span>static int ret_=
val;</div>

<div><span style=3D"white-space: pre-wrap; ">	</span>printk( KERN_DEBUG &qu=
ot;Module pci1711_driver init\n&quot; );</div><div><span style=3D"white-spa=
ce: pre-wrap; ">	</span></div><div><span style=3D"white-space: pre-wrap; ">=
	</span>ret_val =3D pci_register_driver(&amp;pci1711_driver);</div>

<div><span style=3D"white-space: pre-wrap; ">	</span></div><div><span style=
=3D"white-space: pre-wrap; ">	</span>isRegister =3D ret_val;</div><div><spa=
n style=3D"white-space: pre-wrap; ">	</span></div><div><span style=3D"white=
-space: pre-wrap; ">	</span>if( isRegister &lt; 0 ){</div>

<div><span style=3D"white-space: pre-wrap; ">	</span></div><div>=A0=A0 =A0<=
span style=3D"white-space: pre-wrap; ">	</span>printk(&quot;PCI-1711 NOT re=
gister \n&quot;);</div><div>=A0=A0 =A0 =A0 =A0return(-EIO);</div><div>=A0=
=A0 =A0 =A0 =A0</div><div>=A0=A0 =A0}</div>

<div><span style=3D"white-space: pre-wrap; ">	</span></div><div><span style=
=3D"white-space: pre-wrap; ">	</span>//pci1711_probe( pcidev, pcidev-&gt;dr=
iver-&gt;id_table );</div><div><span style=3D"white-space: pre-wrap; ">	</s=
pan></div>

<div><span style=3D"white-space: pre-wrap; ">	</span>return ret_val;</div><=
div>}</div><div><br></div><div>/**</div><div>* Exit module function</div><d=
iv>*/</div><div>static void pci1711_driver_exit_module(void){</div><div>
<br>
</div><div><span style=3D"white-space: pre-wrap; ">	</span>printk( KERN_DEB=
UG &quot;Module pci1711_driver exit\n&quot; );</div><div><span style=3D"whi=
te-space: pre-wrap; ">	</span></div><div><span style=3D"white-space: pre-wr=
ap; ">	</span>if( isRegister &gt;=3D 0 ){</div>

<div><span style=3D"white-space: pre-wrap; ">		</span>pci_unregister_driver=
(&amp;pci1711_driver);</div><div><span style=3D"white-space: pre-wrap; ">		=
</span>//pci1711_remove(pcidev);</div><div><span style=3D"white-space: pre-=
wrap; ">	</span>}</div>

<div>}</div><div><br></div><div>module_init(pci1711_driver_init_module);</d=
iv><div>module_exit(pci1711_driver_exit_module);</div></div></span><br>

--90e6ba53b44609210a0498548cd7--

