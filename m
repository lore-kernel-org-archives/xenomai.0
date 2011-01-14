From: "Peter Hua" <Phua@domain.hid>
Date: Fri, 14 Jan 2011 14:50:18 -0800
Message-ID: <004d01cbb43d$6a763e90$3f62bbb0$@innovative-dsp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_004E_01CBB3FA.5C6A5720"
Content-Language: en-us
Subject: [Xenomai-help] rtdm_irq_request() returns error
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
Cc: pwfhua@domain.hid

This is a multipart message in MIME format.

------=_NextPart_000_004E_01CBB3FA.5C6A5720
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_004F_01CBB3FA.5C6A5720"


------=_NextPart_001_004F_01CBB3FA.5C6A5720
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

 

My call to rtdm_irq_request() is returnning error -16.  I have verified all
inputs.  I am running Xenomai 2.4.10 on Red Hat 5.5 (kernel 2.6.29.1).  Here
is the snippit; the complete file is also attached.  Please help.

 

 

err = rtdm_irq_request(&ctx->irq_handle, ctx->pdev->irq,

                               (rtdm_irq_handler_t)malibu_intr_handler,

                               irqtype,

                               context->device->proc_name,  (void *)ctx);

 

 

 

/**

* This a driver written to interface with DSP boards from Innovative
Integration

* It utilizes the RTDM device APIs from the Xenomai realtime Linux project.

*

*/

 

#include <linux/version.h>

#include <linux/kernel.h>

#include <linux/module.h>

#include <linux/init.h>

#include <linux/pci.h>

#include <linux/interrupt.h>

#include <linux/delay.h>

#include <linux/workqueue.h>

#include <linux/reboot.h>

#include <linux/slab.h>

#include <linux/cdev.h>

#include <linux/spinlock.h>

#include <linux/pagemap.h>

#include <linux/semaphore.h>

#include <linux/list.h>

#include <asm/uaccess.h>

#include <asm/dma.h>

#include <asm/delay.h>

#include <asm/io.h>

#include <asm/msr.h>

#include <asm/page.h>

 

#include <rtdm/rtdm_driver.h>

 

#include "malibu.h"

 

#define VENDOR_ID                 0x1303

#define       DRV_NAME            "malibu"

#define SIZE_MAX          1024

#define SOME_SUB_CLASS                1303

 

 

static void errMsg(int line, const char *place, const char *msg)

{

    printk(KERN_ALERT "malibu: Error at %s() line: %d, %s\n", place, line,
msg);

}

 

#define       MY_ERR(s)   errMsg(__LINE__, __FUNCTION__, s)

 

static void logMsg(int line, const char *place, const char *msg)

{

    printk(KERN_INFO "MalibuDrv_RT: %s() line: %d, %s\n", place, line, msg);

}

 

#define       MY_PRINT(s) logMsg(__LINE__, __FUNCTION__, s);

 

typedef struct {

    void*                 kAddr;

    uint64_t  start;

    uint64_t  end;

    uint64_t  size;

} MyBar;

 

typedef struct {

    void*                 kAddr;

    dma_addr_t       physAddr;

    uint32_t  size;

} MyBuf;

 

typedef struct {

    struct list_head list;

    struct cdev                 cdev;

    struct device     *sysdev;

    struct pci_dev   *pdev;

    dev_t                myDevT;

 

    MyBar               bars[MALIBU_BAR_MAX];

    MyBuf               bufs[MALIBU_BUF_MAX];

 

    wait_queue_head_t     intrWait;

    struct fasync_struct* async_queue;

    int                     mySig;

    void*                 intrStatusAddr;

    u32                            intrMask;

    u8                     intrWriteback;

    u32                            iQueue[MALIBU_INTR_MAX];

    u32                            iPtrLow;

    u32                            iPtrHi;

    void                  (*cntxtFunc)(void*);

    void                  *cntxtArg;

 

    u16                            devOpen;

    u8                     wrOpen;

    u8                     numBars;

    u8                     isIrqEnabled;

    int                 dev_id;

    struct rtdm_device *xen_rtdm_device;

    rtdm_irq_t         irq_handle;  /* device IRQ handle */

} MyData;

 

static struct class* devClass;

static dev_t           baseDevT;

 

static int      devCnt = 0;

LIST_HEAD(devList);

 

static int fasync(int fd, struct file *filep, int mode);

//static irqreturn_t board_handler(unsigned int irq, void *dev_id, struct
pt_regs *regs);

static int malibu_intr_handler(rtdm_irq_t * irq_context);

 

static char msgbuf[1000];

 

static int malibu_rtdm_open(struct rtdm_dev_context *context,

                        rtdm_user_info_t * user_info, int oflags)

//static int open(struct inode *inodep, struct file *filep)

{

    MyData *md, *ctx;

    bool found=false;

    int err=0;

 

    MY_PRINT("start");

    ctx = (MyData *)context->dev_private;

 

    list_for_each_entry(md, &devList, list) {

         if (md->dev_id == context->device->device_id)

         {

                found = true;

                MY_PRINT("device FOUND");

 

                sprintf (msgbuf, "md=%p, md->device_id=%d", md, md->dev_id);

                MY_PRINT(msgbuf);

 

                memcpy(ctx, md, sizeof(MyData));

 

                break;

         }

    }

 

    if(!found)

    {

        MY_ERR("no matching device");

        return -ENODEV;

    }

 

 

    if (ctx->wrOpen && (oflags & FMODE_WRITE)) {

            MY_ERR("device already opened");

            return -EBUSY;

    }

 

 

    if (oflags & FMODE_WRITE)

    {

        ctx->iPtrLow = 0;

        ctx->iPtrHi = 0;

        ctx->mySig = SIGIO;

        ctx->cntxtFunc = 0;

        ctx->cntxtArg = 0;

 

        static unsigned long irqtype = (RTDM_IRQTYPE_SHARED |
RTDM_IRQTYPE_EDGE);

 

        sprintf(msgbuf, "irqtype=%d", irqtype);

        MY_PRINT(msgbuf);

 

        err = rtdm_irq_request(&ctx->irq_handle, ctx->pdev->irq,

                               (rtdm_irq_handler_t)malibu_intr_handler,

                               irqtype,

                               context->device->proc_name,  (void *)ctx);

 

        if(err != 0)

        {

            sprintf(msgbuf, "rtdm_irq_request() failed, err=%d, irq=%d,
proc_name=%s",

                    err, ctx->pdev->irq, context->device->proc_name);

            MY_ERR(msgbuf);

            return err;

        }

 

        sprintf(msgbuf, "rtdm_irq_request() OK, irq=%d", ctx->irq_handle);

        MY_PRINT(msgbuf);

 

#if 0

        if (request_irq(md->pdev->irq, (irq_handler_t)board_handler,
IRQF_SHARED, DRV_NAME, (void*)md)) {

                MY_ERR("irq request error");

                return -ENODEV;

        }

#endif

 

        ctx->wrOpen = 1;

    }

 

    ctx->devOpen++;

 

    MY_PRINT("end OK");

    return 0;

}

 

/**

* Close the device

*

* This function is called when the device shall be closed.

*

*/

static int malibu_rtdm_close(struct rtdm_dev_context *context,

                            rtdm_user_info_t * user_info)

{   

    MyData *ctx = context->dev_private;

    rtdm_irq_free(&ctx->irq_handle);

 

    sprintf(msgbuf, "ctx=0x%p, irq=%d", ctx, ctx->irq_handle);

    MY_PRINT(msgbuf);

    MY_PRINT("closing device");

    return 0;

}

 

#if 1

static void freeBuffer(MyData* md, int n)

{

    MyBuf* b = &md->bufs[n];

    if (b->size == 0) return;

    dma_free_coherent(&md->pdev->dev, b->size, b->kAddr, b->physAddr);

    b->size = 0;

}

 

static int release(struct inode *inode, struct file *filep)

{

    int           i;

    MyData*            md = (MyData*) filep->private_data;

 

    md->devOpen--;

 

    if (filep->f_mode & FMODE_WRITE) {

            md->wrOpen = 0;

            free_irq(md->pdev->irq, md);

            for (i = 0; i < MALIBU_BUF_MAX; i++) freeBuffer(md, i);

            fasync(-1, filep, 0);

    }

 

    return 0;

}

 

//static int ioctl(struct inode *inodep, struct file *filep, unsigned int
cmd, unsigned long arg)

int malibu_rtdm_ioctl(struct rtdm_dev_context   *context,

                      rtdm_user_info_t          *user_info,

                      int                       cmd,

                      void                      *arg)

{

    MyData* md = (MyData *)context->dev_private;

    int err = 0;

    int retval = 0;

    ioc_param_struct param = {0,0};

 

    if (_IOC_TYPE(cmd) != MALIBU_IOC_MAGIC) return -ENOTTY;

 

    /*

    * the direction is a bitmask, and VERIFY_WRITE catches R/W

    * transfers. `Type' is user-oriented, while

    * access_ok is kernel-oriented, so the concept of "read" and

    * "write" is reversed (i.e. when an user wants to read data,

    * the kernel has to write them into the user space)

    *

    * always check the user space address before accessing it

    *

    * access_ok returns 0 for failure!

    */

    if (_IOC_DIR(cmd) & _IOC_READ)

      err = !rtdm_read_user_ok(user_info, arg, sizeof(ioc_param_struct));

    else if (_IOC_DIR(cmd) & _IOC_WRITE)

      err = !rtdm_rw_user_ok(user_info, arg, sizeof(ioc_param_struct));

    if (err) return -EFAULT;

 

    switch(cmd) {

            case MALIBU_GET_INFO: {

                    MalibuDrv_INFO    x;

                    x.vendorId = md->pdev->vendor;

                    x.deviceId = md->pdev->device;

                    x.subVendorId = md->pdev->subsystem_vendor;

                    x.subDeviceId = md->pdev->subsystem_device;

                    x.revision = md->pdev->revision;

                    x.bus = md->pdev->bus->number;

                    x.slot = PCI_SLOT(md->pdev->devfn);

                    x.func = PCI_FUNC(md->pdev->devfn);

                    x.numBars = md->numBars;

 

                    MY_PRINT("copying data to user");

 

                    sprintf(msgbuf, "x.vendorId=0x%x, x.deviceId=0x%x,
x.numBars=%d",

                            md->pdev->vendor, md->pdev->device, x.numBars);

                    MY_PRINT(msgbuf);

                    //return (0 == copy_to_user((void __user*)arg, &x,
sizeof(x))) ? 0 : -EFAULT;

            }

 

            case MALIBU_GET_BAR_SIZE:

                    if (*(int *)arg < 0 || *(int *)arg >= MALIBU_BAR_MAX)
return -EINVAL;

                    return md->bars[*(int *)arg].size;

 

            case MALIBU_ALLOC_BUFFER: {

                    int                        n;

                    MalibuDrv_Buffer  x;

                    MyBuf*                           b;

 

                    //TODO: if (!(filep->f_mode & FMODE_WRITE)) return
-EACCES;

 

                    for (n = 0; n < MALIBU_BUF_MAX; n++) {

                            if (md->bufs[n].size == 0) break;

                    }

                    if (n == MALIBU_BUF_MAX) {

                            MY_ERR("");

                            return -ENOMEM;

                    }

                    if (copy_from_user(&x, (const void __user*)arg,
sizeof(x))) return -EFAULT;

                    b = &md->bufs[n];

 

                    b->size = ((x.size + PAGE_SIZE - 1) / PAGE_SIZE) *
PAGE_SIZE;

                    b->kAddr = dma_alloc_coherent(&md->pdev->dev, b->size,
&b->physAddr, GFP_KERNEL);

                    if (b->kAddr == 0) {

                            b->size = 0;

                            MY_ERR("");

                            return -ENOMEM;

                    }

                    x.physAddr = b->physAddr;

                    x.bufNum = n;

                    x.fileOffset = (n + MALIBU_BAR_MAX) * MALIBU_MMAP_SIZE;

                    if (copy_to_user((void __user*)arg, &x, sizeof(x))) {

                            freeBuffer(md, x.bufNum);

                            return -EFAULT;

                    }

                    ((uint32_t*)b->kAddr)[0] = 0x12345678;

                    ((uint32_t*)b->kAddr)[1] = n;

                    ((uint32_t*)b->kAddr)[2] = md->myDevT;

                    return 0;

            }

 

            case MALIBU_FREE_BUFFER: {

                    int                        i;

                    MalibuDrv_Buffer  x;

 

                    //TODO:if (!(filep->f_mode & FMODE_WRITE)) return
-EACCES;

 

                    if (copy_from_user(&x, (const void __user*)arg,
sizeof(x))) return -EFAULT;

                    for (i = 0; i < MALIBU_BUF_MAX; i++) {

                            if (md->bufs[i].physAddr == x.physAddr) {

                                    freeBuffer(md, i);

                                    break;

                            }

                    }

                    if (i == MALIBU_BUF_MAX) {

                            MY_ERR("");

                            return -ENOMEM;

                    }

                    return 0;

            }

 

            case MALIBU_ISR_ENABLE:

                    //TODO: if (!(filep->f_mode & FMODE_WRITE)) return
-EACCES;

                    enable_irq(md->pdev->irq);

                    md->isIrqEnabled = 1;

                    return 0;

            case MALIBU_ISR_DISABLE:

                    //TODO: if (!(filep->f_mode & FMODE_WRITE)) return
-EACCES;

                    md->isIrqEnabled = 0;

                    disable_irq(md->pdev->irq);

                    return 0;

            case MALIBU_GET_ISR_ENABLED:

                    return md->isIrqEnabled;

            case MALIBU_GET_ISR_DEPTH:

                    return (md->iPtrLow - md->iPtrHi);

            case MALIBU_ISR_CLEAR_ALL:

                    //TODO: if (!(filep->f_mode & FMODE_WRITE)) return
-EACCES;

                    disable_irq(md->pdev->irq);

                    md->iPtrLow = 0;

                    md->iPtrHi = 0;

                    enable_irq(md->pdev->irq);

                    return 0;     // no implemented yet

            case MALIBU_DEQUEUE_ISR: {

                    MalibuDrv_DequeueISR  x;

                    unsigned long                j;

                    int                        ret;

 

                    //TODO: if (!(filep->f_mode & FMODE_WRITE)) return
-EACCES;

                    if (copy_from_user(&x, (const void __user*)arg,
(caddr_t)&x.depth - (caddr_t)&x)) return -EFAULT;

 

                    x.depth = 0;

                    x.cntxtFunc = md->cntxtFunc;

                    x.cntxtArg = md->cntxtArg;

                    x.errno = 0;

                    x.depth = 0;

 

                    j = timeval_to_jiffies(&x.timeout);

                    if (j == 0) {

                            if (md->iPtrLow != md->iPtrHi) {

                                    while (md->iPtrLow != md->iPtrHi &&
x.depth < MALIBU_INTR_MAX) {

                                            x.data[x.depth++] =
md->iQueue[md->iPtrHi % MALIBU_INTR_MAX];

                                            md->iPtrHi++;

                                    }

                            }

                            else {

                                    x.errno = ENODATA;

                            }

                    }

                    else {

                            ret =
wait_event_interruptible_timeout(md->intrWait, md->iPtrLow != md->iPtrHi,
j);

                            if (ret == 0) x.errno = ETIME;

                            else if (ret == -ERESTARTSYS) x.errno =
ERESTARTSYS;

                            else {

                                    while (md->iPtrLow != md->iPtrHi &&
x.depth < MALIBU_INTR_MAX) {

                                            x.data[x.depth++] =
md->iQueue[md->iPtrHi % MALIBU_INTR_MAX];

                                            md->iPtrHi++;

                                    }

                                    jiffies_to_timeval(ret, &x.timeout);

                            }

                    }

                    if (copy_to_user((void __user*)arg, &x,
(caddr_t)&x.data[x.depth] - (caddr_t)&x)) return -EFAULT;

                    return 0;

            }

            case MALIBU_SET_ISR_CTRL: {

                    MalibuDrv_IntCtrl  x;

 

                    //TODO: if (!(filep->f_mode & FMODE_WRITE)) return
-EACCES;

                    if (copy_from_user(&x, (const void __user*)arg,
sizeof(x))) return -EFAULT;

                    md->intrMask = x.mask;

                    md->intrWriteback = x.type;

                    if (x.bar > MALIBU_BAR_MAX) {

                            MY_ERR("");

                            return -EINVAL;

                    }

                    if (x.byteOffset > md->bars[x.bar].size) {

                            MY_ERR("");

                            return -EINVAL;

                    }

                    md->intrStatusAddr = md->bars[x.bar].kAddr +
x.byteOffset;

                    md->cntxtFunc = x.cntxtFunc;

                    md->cntxtArg = x.cntxtArg;

                    return 0;

            }

            case MALIBU_SET_SIG:

                    //TODO: if (!(filep->f_mode & FMODE_WRITE)) return
-EACCES;

                    md->mySig = arg;

                    return 0;

            case MALIBU_FAKE_SIG: {

                    MalibuDrv_FakeISR         x;

 

                    if (copy_from_user(&x, (const void __user*)arg,
sizeof(x))) return -EFAULT;

                    if ((md->iPtrLow - md->iPtrHi) <
MALIBU_INTR_MAX-x.depth-1) {

                            int      i;

 

                            for (i = 0; i < x.depth; i++) {

                                    md->iQueue[md->iPtrLow %
MALIBU_INTR_MAX] = x.data[i];

                                    md->iPtrLow++;

                            }

                            wake_up_interruptible(&md->intrWait);

                            if (md->async_queue)
kill_fasync(&md->async_queue, md->mySig, POLL_IN);

                    }

                    return 0;

            }

            default:

                    return -EINVAL;

    }

}

 

//static irqreturn_t board_handler(unsigned int irq, void *dev_id, struct
pt_regs *regs)

static int malibu_intr_handler(rtdm_irq_t * irq_context)

{

#if 0

    uint32_t  rd;

    MyData*            md = (MyData*) dev_id;

 

    if(md->pdev->irq != irq) return IRQ_NONE;

 

    rd = ioread32(md->intrStatusAddr);

 

    if ((rd & md->intrMask) == 0) return IRQ_NONE;

 

    if ((md->iPtrLow - md->iPtrHi) < MALIBU_INTR_MAX-1) {

            md->iQueue[md->iPtrLow % MALIBU_INTR_MAX] = rd;

            md->iPtrLow++;

            wake_up_interruptible(&md->intrWait);

            if (md->async_queue && md->mySig) kill_fasync(&md->async_queue,
md->mySig, POLL_IN);

    }

    if (md->intrWriteback) iowrite32(rd, md->intrStatusAddr);

#endif

 

    return IRQ_HANDLED;

}

 

static void vma_open(struct vm_area_struct* vma) { }

static void vma_close(struct vm_area_struct* vma) { }

 

static struct vm_operations_struct remap_vm_ops = {

    .open = vma_open,

    .close = vma_close,

};

 

static int mmap(struct file *filep, struct vm_area_struct *vma)

{

    MyData*            md = (MyData*) filep->private_data;

    unsigned long   off = vma->vm_pgoff << PAGE_SHIFT;

    unsigned long   vsize = vma->vm_end - vma->vm_start;

    unsigned long   seg = off / MALIBU_MMAP_SIZE;

    unsigned long   seg_off = off % MALIBU_MMAP_SIZE;

    unsigned long   psize, pfn;

 

    if (seg >= 0 && seg < MALIBU_BAR_MAX) {

            if (md->bars[seg].size == 0) return -EINVAL;

            pfn = (md->bars[seg].start + seg_off) >> PAGE_SHIFT;

            psize = md->bars[seg].size - seg_off;

    }

    else if (seg >= MALIBU_BAR_MAX && seg < MALIBU_BAR_MAX + MALIBU_BUF_MAX)
{

            seg -= MALIBU_BAR_MAX;

            if (md->bufs[seg].size == 0) return -EINVAL;

            pfn = __pa(md->bufs[seg].kAddr + seg_off) >> PAGE_SHIFT;

            psize = md->bufs[seg].size - seg_off;

    }

    else return -EINVAL;

 

    if (vsize > psize) return -EINVAL;

    if (remap_pfn_range(vma, vma->vm_start, pfn, vsize, vma->vm_page_prot))
return -EAGAIN;

 

    vma->vm_ops = &remap_vm_ops;

    vma_open(vma);

    return 0;

}

 

static int fasync(int fd, struct file *filep, int mode)

{

    MyData*            md = (MyData*) filep->private_data;

    return fasync_helper(fd, filep, mode, &md->async_queue);

}

 

static struct file_operations myFileOps = {

    .owner     = THIS_MODULE,

    .open       = malibu_rtdm_open,

    .release   = release,

    .ioctl        = malibu_rtdm_ioctl,

    .mmap    = mmap,

    .fasync    = fasync,

};

 

 

 

static ssize_t showDevInfo(struct device *dev, struct device_attribute*
attr, char *buf)

{

    MyData* md = (MyData*)dev->driver_data;

    return snprintf(buf, PAGE_SIZE,

            "vendor=0x%x\n"

            "device=0x%x\n"

            "subsystem_vendor=0x%x\n"

            "subsystem_device=0x%x\n"

            "revision=0x%x\n"

            "bus=0x%x\n"

            "slot=0x%x\n"

            "func=0x%x\n"

            "numBars=%d\n",

            md->pdev->vendor,

            md->pdev->device,

            md->pdev->subsystem_vendor,

            md->pdev->subsystem_device,

            md->pdev->revision,

            md->pdev->bus->number,

            PCI_SLOT(md->pdev->devfn),

            PCI_FUNC(md->pdev->devfn),

            md->numBars);

}

static DEVICE_ATTR(devInfo, 0444, showDevInfo, NULL);

 

 

/**

* This structure describe the malibu RTDM device

*

*/

static struct rtdm_device malibu_rtdm_device = {

    .struct_version = RTDM_DEVICE_STRUCT_VER,

 

    .device_flags = RTDM_NAMED_DEVICE,

    .context_size = sizeof(MyData),

    .device_name = DRV_NAME,

 

    .open_rt =  malibu_rtdm_open,

    .open_nrt = malibu_rtdm_open,

 

    .ops = {

            .close_rt = malibu_rtdm_close,

            .close_nrt = malibu_rtdm_close,

            .ioctl_rt =  malibu_rtdm_ioctl,

            .ioctl_nrt = malibu_rtdm_ioctl,

            //.read_nrt = NULL,

            //.write_nrt = NULL,

    },

 

 

    .device_class = RTDM_CLASS_EXPERIMENTAL,

    .device_sub_class = SOME_SUB_CLASS,

    .profile_version = 1,

    .driver_name = DRV_NAME,

    .driver_version = RTDM_DRIVER_VER(0, 1, 0),

    .peripheral_name = "Malibu RT driver",

    .provider_name = "Innovative Integration",

    .proc_name = DRV_NAME,

};

 

static int allocEachDev(struct pci_dev *pdev, const struct pci_device_id
*id)

{

    struct rtdm_device  *rtdm_dev;

    int    ret_val = 0;

    MyData *md, *lPtr;

    int  i, bCntr, error, b;

 

    MY_PRINT("start");

 

    if(id->vendor != VENDOR_ID) {

            MY_ERR("");

            return -ENODEV;

    }

 

    md = (MyData*) kzalloc(sizeof(MyData), GFP_KERNEL);

 

    md->pdev = pdev;

 

    sprintf(msgbuf, "pdev->irq=%d", pdev->irq);

    MY_PRINT(msgbuf);

 

    if (pci_enable_device(pdev)) {

            MY_ERR("");

            kfree(md);

            return -ENODEV;

    }

 

    pci_set_master(pdev);

 

    b = 0;

    for (i = 0; i < MALIBU_BAR_MAX; i++) {

            md->bars[b].start        = pci_resource_start(pdev, i);

            md->bars[b].end          = pci_resource_end(pdev, i);

            md->bars[b].size          = pci_resource_len(pdev, i);

            printk(KERN_ERR "bar=%d start=%llx end=%llx len=%llx\n", i,

                    md->bars[b].start,

                    md->bars[b].end,

                    md->bars[b].size);

            if (md->bars[b].size == 0) continue;

            md->bars[b].kAddr      = (void*) ioremap(md->bars[i].start,
md->bars[i].end - md->bars[i].start);

            b++;

    }

    md->numBars = i;

 

    init_waitqueue_head(&md->intrWait);

 

    cdev_init(&md->cdev, &myFileOps);

    md->cdev.owner = THIS_MODULE;

    md->myDevT = MKDEV(MAJOR(baseDevT), MINOR(baseDevT)+devCnt);

    if (cdev_add(&md->cdev, md->myDevT, 1)) {

            MY_ERR("");

            pci_disable_device(md->pdev);

            kfree(md);

            return -ENODEV;

    }

 

    bCntr = 0;

    list_for_each_entry(lPtr, &devList, list) {

            if (lPtr->pdev->device == pdev->device) bCntr++;

    }

 

    md->sysdev = device_create(devClass, &md->pdev->dev, md->myDevT, NULL,
"malibu%04x_%d", pdev->device, bCntr);

    if (IS_ERR(md->sysdev)) {

            MY_ERR("");

            cdev_del(&md->cdev);

            pci_disable_device(md->pdev);

            kfree(md);

            return -ENODEV;

    }

    md->sysdev->driver_data = (void*)md;

 

    error = device_create_file(md->sysdev, &dev_attr_devInfo);

    if (error) {

            MY_ERR("");

            device_destroy(devClass, md->myDevT);

            cdev_del(&md->cdev);

            for (i = 0; i < MALIBU_BAR_MAX; i++) {

                    if (md->bars[i].size) {

                            iounmap(md->bars[i].kAddr);

                            md->bars[i].size = 0;

                    }

            }

            pci_disable_device(md->pdev);

            kfree(md);

            return error;

    }

 

    md->dev_id = devCnt;

 

 

    //alloc mem for rtdm structure

    rtdm_dev = kmalloc(sizeof(struct rtdm_device), GFP_KERNEL);

    if(!rtdm_dev){

      MY_ERR("rtdm_device kmalloc failed\n");

      ret_val = -ENOMEM; //Insufficient storage space is available.

      return ret_val;

    }

 

    //copy the structure to the new memory

    memcpy(rtdm_dev, &malibu_rtdm_device, sizeof(struct rtdm_device));

 

    //create filename

    snprintf(rtdm_dev->device_name,

             RTDM_MAX_DEVNAME_LEN, "malibu_%d", devCnt);

 

    rtdm_dev->device_id = devCnt;

 

    //define two other members of the rtdm_device structure

    rtdm_dev->proc_name = rtdm_dev->device_name;

 

    ret_val = rtdm_dev_register(rtdm_dev);

 

    if(ret_val < 0){

      MY_ERR("failed to register device with RTDM\n");

      ret_val = -ENODEV;

      return ret_val;

    }

 

    md->xen_rtdm_device = rtdm_dev;

 

    list_add_tail(&md->list, &devList);

 

    //always do this last

    devCnt++;

 

    MY_PRINT("end OK");

    return 0;

}

 

static void removeAllDev(struct pci_dev *pdev)

{

    MyData *md, *tmp;

 

    MY_PRINT("start");

 

    list_for_each_entry_safe(md, tmp, &devList, list)

    {

        if (md == NULL)

        {

            MY_PRINT("md is NULL");

            return;

        }

 

        int       i;

 

        list_del(&md->list);

 

 

        device_remove_file(md->sysdev, &dev_attr_devInfo);

        device_destroy(devClass, md->myDevT);

        cdev_del(&md->cdev);

 

        for (i = 0; i < MALIBU_BUF_MAX; i++) freeBuffer(md, i);

 

        for (i = 0; i < MALIBU_BAR_MAX; i++) {

            if (md->bars[i].size) {

                iounmap(md->bars[i].kAddr);

                md->bars[i].size = 0;

            }

        }

 

        pci_disable_device(md->pdev);

 

        //remove char device from the system

        //unregister RTdriver

        rtdm_dev_unregister(md->xen_rtdm_device, 1000);

 

        kfree(md->xen_rtdm_device);

        kfree(md);

 

        devCnt--;

}

 

    MY_PRINT("end");

}

#endif

 

static struct pci_device_id ids[] = {

    { PCI_DEVICE(VENDOR_ID, PCI_ANY_ID) },

    { 0 },

};

 

static struct pci_driver pci_driver = {

    .name      = DRV_NAME,

    .id_table  = ids,

    .probe     = allocEachDev,

    .remove   = removeAllDev,

};

 

 

//MODULE_DEVICE_TABLE(pci, ids);

 

static ssize_t showDevCount(struct class *cls, char *buf)

{

    return sprintf(buf, "%d\n", devCnt);

}

 

static CLASS_ATTR(devCount, 0444, showDevCount, NULL);

 

/**

* This function is called when the module is loaded

*

* It simply registers the RTDM device.

*

*/

static int __init mod_init(void)

{

    int error;

 

    MY_PRINT("initializing MalibuDrv_RT module");

 

    devClass = class_create(THIS_MODULE, DRV_NAME);

    if (IS_ERR(devClass)) {

            MY_ERR("");

            return PTR_ERR(devClass);

    }

 

    error = class_create_file(devClass, &class_attr_devCount);

    if (error) {

            MY_ERR("");

            class_destroy(devClass);

            return error;

    }

 

    error = alloc_chrdev_region(&baseDevT, 0, MALIBU_MAX_DEVS, DRV_NAME);

    if (error) {

            MY_ERR("");

            class_remove_file(devClass, &class_attr_devCount);

            class_destroy(devClass);

            return error;

    }

 

    error = pci_register_driver(&pci_driver);

    if (error) {

        MY_ERR("");

        unregister_chrdev_region(baseDevT, MALIBU_MAX_DEVS);

        class_remove_file(devClass, &class_attr_devCount);

        class_destroy(devClass);

        return error;

    }

 

    return error;

}

 

/**

* This function is called when the module is unloaded

*

* It unregister the RTDM device, polling at 1000 ms for pending users.

*

*/

static void __exit mod_exit(void)

{

    MY_PRINT("unregistering MalibuDrv_RT module");

 

    pci_unregister_driver(&pci_driver);

    unregister_chrdev_region(baseDevT, MALIBU_MAX_DEVS);

    class_remove_file(devClass, &class_attr_devCount);

    class_destroy(devClass);

}

 

 

module_init(mod_init);

module_exit(mod_exit);

MODULE_LICENSE("GPL");

 

Thanks,

Peter Hua

 


------=_NextPart_001_004F_01CBB3FA.5C6A5720
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 14 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"DejaVu Sans";
	panose-1:2 11 6 3 3 8 4 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p =
class=3DMsoNormal>Hello,<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>My call to =
<span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>rtdm_irq_request() is returnning error -16.&nbsp; I =
have verified all inputs.&nbsp; I am running Xenomai 2.4.10 on Red Hat =
5.5 (kernel 2.6.29.1).&nbsp; Here is the snippit; the complete file is =
also attached.&nbsp; Please help.<o:p></o:p></span></p><p =
class=3DMsoNormal><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>err =3D rtdm_irq_request(&amp;ctx-&gt;irq_handle, =
ctx-&gt;pdev-&gt;irq,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(rtdm_irq_handler_t)malibu_intr_handler,<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
irqtype,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
context-&gt;device-&gt;proc_name,&nbsp; (<span =
style=3D'color:blue'>void</span> *)ctx);<o:p></o:p></span></p><div =
style=3D'mso-element:para-border-div;border:none;border-bottom:solid =
windowtext 1.0pt;padding:0in 0in 1.0pt 0in'><p class=3DMsoNormal =
style=3D'border:none;padding:0in'><o:p>&nbsp;</o:p></p></div><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>/**<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif";color:green'>* This a =
driver written to interface with DSP boards from Innovative =
Integration<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>* It utilizes the RTDM device APIs from =
the Xenomai realtime Linux project.<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>*<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>*/<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#include</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:#A31515'>&lt;linux/version.h&gt;<o:p></o:p></span></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#include</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:#A31515'>&lt;linux/kernel.h&gt;<o:p></o:p></span></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#include</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:#A31515'>&lt;linux/module.h&gt;<o:p></o:p></span></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#include</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:#A31515'>&lt;linux/init.h&gt;<o:p></o:p></span></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#include</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:#A31515'>&lt;linux/pci.h&gt;<o:p></o:p></span></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#include</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:#A31515'>&lt;linux/interrupt.h&gt;<o:p></o:p></span></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#include</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:#A31515'>&lt;linux/delay.h&gt;<o:p></o:p></span></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#include</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:#A31515'>&lt;linux/workqueue.h&gt;<o:p></o:p></span></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#include</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:#A31515'>&lt;linux/reboot.h&gt;<o:p></o:p></span></span></=
p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#include</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:#A31515'>&lt;linux/slab.h&gt;<o:p></o:p></span></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#include</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:#A31515'>&lt;linux/cdev.h&gt;<o:p></o:p></span></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#include</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:#A31515'>&lt;linux/spinlock.h&gt;<o:p></o:p></span></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#include</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:#A31515'>&lt;linux/pagemap.h&gt;<o:p></o:p></span></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#include</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:#A31515'>&lt;linux/semaphore.h&gt;<o:p></o:p></span></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#include</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:#A31515'>&lt;linux/list.h&gt;<o:p></o:p></span></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#include</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:#A31515'>&lt;asm/uaccess.h&gt;<o:p></o:p></span></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#include</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:#A31515'>&lt;asm/dma.h&gt;<o:p></o:p></span></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#include</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:#A31515'>&lt;asm/delay.h&gt;<o:p></o:p></span></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#include</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:#A31515'>&lt;asm/io.h&gt;<o:p></o:p></span></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#include</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:#A31515'>&lt;asm/msr.h&gt;<o:p></o:p></span></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#include</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:#A31515'>&lt;asm/page.h&gt;<o:p></o:p></span></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:#A31515'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#include</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:#A31515'>&lt;rtdm/rtdm_driver.h&gt;<o:p></o:p></span></spa=
n></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:#A31515'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#include</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:#A31515'>&quot;malibu.h&quot;<o:p></o:p></span></span></p>=
<p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:#A31515'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#define</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> =
VENDOR_ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1303<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#define</span><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
DRV_NAME&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; <span =
style=3D'color:#A31515'>&quot;malibu&quot;<o:p></o:p></span></span></p><p=
 class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#define</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> =
SIZE_MAX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1024<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#define</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> =
SOME_SUB_CLASS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1303<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>void</span> errMsg(<span =
style=3D'color:blue'>int</span> line, <span =
style=3D'color:blue'>const</span> <span style=3D'color:blue'>char</span> =
*place, <span style=3D'color:blue'>const</span> <span =
style=3D'color:blue'>char</span> *msg)<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; printk(KERN_ALERT <span =
style=3D'color:#A31515'>&quot;malibu: Error at %s() line: %d, =
%s\n&quot;</span>, place, line, msg);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#define</span><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MY_ERR(s)&nbsp;&nbsp; errMsg(__LINE__, __FUNCTION__, =
s)<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>void</span> logMsg(<span =
style=3D'color:blue'>int</span> line, <span =
style=3D'color:blue'>const</span> <span style=3D'color:blue'>char</span> =
*place, <span style=3D'color:blue'>const</span> <span =
style=3D'color:blue'>char</span> *msg)<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; printk(KERN_INFO <span =
style=3D'color:#A31515'>&quot;MalibuDrv_RT: %s() line: %d, =
%s\n&quot;</span>, place, line, msg);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#define</span><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MY_PRINT(s) =
logMsg(__LINE__, __FUNCTION__, s);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>typedef</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>struct</span> {<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
<span =
style=3D'color:blue'>void</span>*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
kAddr;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; uint64_t&nbsp; =
start;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; uint64_t&nbsp; =
end;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; uint64_t&nbsp; =
size;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>} MyBar;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>typedef</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>struct</span> {<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
<span =
style=3D'color:blue'>void</span>*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
kAddr;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
dma_addr_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
physAddr;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; uint32_t&nbsp; =
size;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>} MyBuf;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>typedef</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>struct</span> {<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
<span style=3D'color:blue'>struct</span> list_head =
list;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>struct</span> =
cdev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; cdev;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
<span style=3D'color:blue'>struct</span> device&nbsp;&nbsp;&nbsp;&nbsp; =
*sysdev;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>struct</span> pci_dev&nbsp;&nbsp; =
*pdev;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
dev_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; myDevT;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
MyBar&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; bars[MALIBU_BAR_MAX];<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
MyBuf&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; bufs[MALIBU_BUF_MAX];<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
wait_queue_head_t&nbsp;&nbsp;&nbsp;&nbsp; =
intrWait;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>struct</span> fasync_struct* =
async_queue;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>int</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; mySig;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>void</span>*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
intrStatusAddr;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; intrMask;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
intrWriteback;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; iQueue[MALIBU_INTR_MAX];<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; iPtrLow;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; iPtrHi;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>void</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(*cntxtFunc)(<span =
style=3D'color:blue'>void</span>*);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
<span =
style=3D'color:blue'>void</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*cntxtArg;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
u16&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; devOpen;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
wrOpen;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
numBars;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
u8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
isIrqEnabled;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>int</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dev_id;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>struct</span> rtdm_device =
*xen_rtdm_device;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
rtdm_irq_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
irq_handle;&nbsp; <span style=3D'color:green'>/* device IRQ handle =
*/<o:p></o:p></span></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>} MyData;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>struct</span> <span =
style=3D'color:blue'>class</span>* devClass;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> dev_t =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
baseDevT;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>int</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; devCnt =3D =
0;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>LIST_HEAD(devList);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>int</span> fasync(<span =
style=3D'color:blue'>int</span> fd, <span =
style=3D'color:blue'>struct</span> file *filep, <span =
style=3D'color:blue'>int</span> mode);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif";color:green'>//static =
irqreturn_t board_handler(unsigned int irq, void *dev_id, struct pt_regs =
*regs);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>int</span> malibu_intr_handler(rtdm_irq_t * =
irq_context);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>char</span> msgbuf[1000];<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>int</span> malibu_rtdm_open(<span =
style=3D'color:blue'>struct</span> rtdm_dev_context =
*context,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; rtdm_user_info_t * user_info, <span =
style=3D'color:blue'>int</span> oflags)<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif";color:green'>//static =
int open(struct inode *inodep, struct file =
*filep)<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; MyData *md, =
*ctx;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>bool</span> found=3D<span =
style=3D'color:blue'>false</span>;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
<span style=3D'color:blue'>int</span> err=3D0;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; MY_PRINT(<span =
style=3D'color:#A31515'>&quot;start&quot;</span>);<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; ctx =
=3D (MyData *)context-&gt;dev_private;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; list_for_each_entry(md, =
&amp;devList, list) {<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<span style=3D'color:blue'>if</span> (md-&gt;dev_id =3D=3D =
context-&gt;device-&gt;device_id)<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; found =3D <span =
style=3D'color:blue'>true</span>;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MY_PRINT(<span =
style=3D'color:#A31515'>&quot;device =
FOUND&quot;</span>);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sprintf (msgbuf, <span =
style=3D'color:#A31515'>&quot;md=3D%p, =
md-&gt;device_id=3D%d&quot;</span>, md, =
md-&gt;dev_id);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MY_PRINT(msgbuf);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(ctx, md, <span =
style=3D'color:blue'>sizeof</span>(MyData));<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>break</span>;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span>(!found)<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MY_ERR(<span style=3D'color:#A31515'>&quot;no matching =
device&quot;</span>);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> -ENODEV;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (ctx-&gt;wrOpen &amp;&amp; (oflags &amp; =
FMODE_WRITE)) {<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; MY_ERR(<span style=3D'color:#A31515'>&quot;device already =
opened&quot;</span>);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>return</span> =
-EBUSY;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (oflags &amp; =
FMODE_WRITE)<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; {<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ctx-&gt;iPtrLow =3D 0;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ctx-&gt;iPtrHi =3D 0;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ctx-&gt;mySig =3D SIGIO;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ctx-&gt;cntxtFunc =3D 0;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ctx-&gt;cntxtArg =3D 0;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>static</span> <span =
style=3D'color:blue'>unsigned</span> <span =
style=3D'color:blue'>long</span> irqtype =3D (RTDM_IRQTYPE_SHARED | =
RTDM_IRQTYPE_EDGE);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sprintf(msgbuf, <span =
style=3D'color:#A31515'>&quot;irqtype=3D%d&quot;</span>, =
irqtype);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MY_PRINT(msgbuf);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
rtdm_irq_request(&amp;ctx-&gt;irq_handle, =
ctx-&gt;pdev-&gt;irq,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(rtdm_irq_handler_t)malibu_intr_handler,<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
irqtype,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
context-&gt;device-&gt;proc_name,&nbsp; (<span =
style=3D'color:blue'>void</span> *)ctx);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span>(err !=3D 0)<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; sprintf(msgbuf, <span =
style=3D'color:#A31515'>&quot;rtdm_irq_request() failed, err=3D%d, =
irq=3D%d, proc_name=3D%s&quot;</span>,<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err, =
ctx-&gt;pdev-&gt;irq, =
context-&gt;device-&gt;proc_name);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; MY_ERR(msgbuf);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style=3D'color:blue'>return</span> =
err;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sprintf(msgbuf, <span style=3D'color:#A31515'>&quot;rtdm_irq_request() =
OK, irq=3D%d&quot;</span>, ctx-&gt;irq_handle);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MY_PRINT(msgbuf);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#if</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> =
0<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (request_irq(md-&gt;pdev-&gt;irq, =
(irq_handler_t)board_handler, IRQF_SHARED, DRV_NAME, (<span =
style=3D'color:blue'>void</span>*)md)) {<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MY_ERR(<span =
style=3D'color:#A31515'>&quot;irq request =
error&quot;</span>);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> -ENODEV;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#endif<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ctx-&gt;wrOpen =3D 1;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
ctx-&gt;devOpen++;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; MY_PRINT(<span =
style=3D'color:#A31515'>&quot;end =
OK&quot;</span>);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> 0;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>/**<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif";color:green'>* Close the =
device<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>*<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif";color:green'>* This =
function is called when the device shall be =
closed.<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>*<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>*/<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>int</span> malibu_rtdm_close(<span =
style=3D'color:blue'>struct</span> rtdm_dev_context =
*context,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtdm_user_info_t * =
user_info)<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>{&nbsp;&nbsp; <o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;MyData *ctx =3D =
context-&gt;dev_private;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
rtdm_irq_free(&amp;ctx-&gt;irq_handle);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; sprintf(msgbuf, <span =
style=3D'color:#A31515'>&quot;ctx=3D0x%p, irq=3D%d&quot;</span>, ctx, =
ctx-&gt;irq_handle);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
MY_PRINT(msgbuf);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; MY_PRINT(<span =
style=3D'color:#A31515'>&quot;closing =
device&quot;</span>);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> 0;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#if</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> =
1<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>void</span> freeBuffer(MyData* md, <span =
style=3D'color:blue'>int</span> n)<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; MyBuf* b =3D =
&amp;md-&gt;bufs[n];<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (b-&gt;size =3D=3D 0) <span =
style=3D'color:blue'>return</span>;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
dma_free_coherent(&amp;md-&gt;pdev-&gt;dev, b-&gt;size, b-&gt;kAddr, =
b-&gt;physAddr);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; b-&gt;size =3D =
0;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>int</span> release(<span =
style=3D'color:blue'>struct</span> inode *inode, <span =
style=3D'color:blue'>struct</span> file *filep)<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>int</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; i;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
MyData*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 md =3D (MyData*) filep-&gt;private_data;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
md-&gt;devOpen--;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (filep-&gt;f_mode &amp; FMODE_WRITE) =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; md-&gt;wrOpen =3D 0;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; free_irq(md-&gt;pdev-&gt;irq, md);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>for</span> (i =3D 0; i &lt; =
MALIBU_BUF_MAX; i++) freeBuffer(md, i);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; fasync(-1, filep, 0);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> 0;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>//static int ioctl(struct inode *inodep, =
struct file *filep, unsigned int cmd, unsigned long =
arg)<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>int</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> =
malibu_rtdm_ioctl(<span style=3D'color:blue'>struct</span> =
rtdm_dev_context&nbsp;&nbsp; *context,<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 rtdm_user_info_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*user_info,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 <span =
style=3D'color:blue'>int</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cmd,<o:p></o:p></span></p=
><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 <span =
style=3D'color:blue'>void</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; *arg)<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; MyData* md =3D (MyData =
*)context-&gt;dev_private;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>int</span> err =3D 0;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
<span style=3D'color:blue'>int</span> retval =3D =
0;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; ioc_param_struct param =3D =
{0,0};<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (_IOC_TYPE(cmd) !=3D MALIBU_IOC_MAGIC) =
<span style=3D'color:blue'>return</span> =
-ENOTTY;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp; &nbsp;<span =
style=3D'color:green'>/*<o:p></o:p></span></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>&nbsp;&nbsp;&nbsp; * the direction is a =
bitmask, and VERIFY_WRITE catches R/W<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>&nbsp;&nbsp;&nbsp; * transfers. `Type' =
is user-oriented, while<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>&nbsp;&nbsp;&nbsp; * access_ok is =
kernel-oriented, so the concept of &quot;read&quot; =
and<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>&nbsp;&nbsp;&nbsp; * &quot;write&quot; =
is reversed (i.e. when an user wants to read =
data,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>&nbsp;&nbsp;&nbsp; * the kernel has to =
write them into the user space)<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>&nbsp;&nbsp;&nbsp; =
*<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>&nbsp;&nbsp;&nbsp; * always check the =
user space address before accessing it<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>&nbsp;&nbsp;&nbsp; =
*<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>&nbsp;&nbsp;&nbsp; * access_ok returns 0 =
for failure!<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>&nbsp;&nbsp;&nbsp; =
*/<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (_IOC_DIR(cmd) &amp; =
_IOC_READ)<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
!rtdm_read_user_ok(user_info, arg, <span =
style=3D'color:blue'>sizeof</span>(ioc_param_struct));<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
<span style=3D'color:blue'>else</span> <span =
style=3D'color:blue'>if</span> (_IOC_DIR(cmd) &amp; =
_IOC_WRITE)<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
!rtdm_rw_user_ok(user_info, arg, <span =
style=3D'color:blue'>sizeof</span>(ioc_param_struct));<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
<span style=3D'color:blue'>if</span> (err) <span =
style=3D'color:blue'>return</span> -EFAULT;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>switch</span>(cmd) {<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>case</span> MALIBU_GET_INFO: =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MalibuDrv_INFO&nbsp;&nbsp;&nbsp; x;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; x.vendorId =
=3D md-&gt;pdev-&gt;vendor;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; x.deviceId =
=3D md-&gt;pdev-&gt;device;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
x.subVendorId =3D =
md-&gt;pdev-&gt;subsystem_vendor;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
x.subDeviceId =3D =
md-&gt;pdev-&gt;subsystem_device;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; x.revision =
=3D md-&gt;pdev-&gt;revision;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; x.bus =3D =
md-&gt;pdev-&gt;bus-&gt;number;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; x.slot =3D =
PCI_SLOT(md-&gt;pdev-&gt;devfn);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; x.func =3D =
PCI_FUNC(md-&gt;pdev-&gt;devfn);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; x.numBars =
=3D md-&gt;numBars;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MY_PRINT(<span style=3D'color:#A31515'>&quot;copying data to =
user&quot;</span>);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sprintf(msgbuf, <span style=3D'color:#A31515'>&quot;x.vendorId=3D0x%x, =
x.deviceId=3D0x%x, x.numBars=3D%d&quot;</span>,<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; md-&gt;pdev-&gt;vendor, =
md-&gt;pdev-&gt;device, x.numBars);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MY_PRINT(msgbuf);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:green'>//return (0 =3D=3D copy_to_user((void __user*)arg, =
&amp;x, sizeof(x))) ? 0 : -EFAULT;<o:p></o:p></span></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>case</span> =
MALIBU_GET_BAR_SIZE:<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (*(<span style=3D'color:blue'>int</span> =
*)arg &lt; 0 || *(<span style=3D'color:blue'>int</span> *)arg &gt;=3D =
MALIBU_BAR_MAX) <span style=3D'color:blue'>return</span> =
-EINVAL;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> md-&gt;bars[*(<span =
style=3D'color:blue'>int</span> *)arg].size;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>case</span> =
MALIBU_ALLOC_BUFFER: {<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>int</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; n;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MalibuDrv_Buffer&nbsp; x;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MyBuf*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; b;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:green'>//TODO: if (!(filep-&gt;f_mode &amp; FMODE_WRITE)) =
return -EACCES;<o:p></o:p></span></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>for</span> (n =3D 0; n &lt; MALIBU_BUF_MAX; n++) =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (md-&gt;bufs[n].size =3D=3D 0) <span =
style=3D'color:blue'>break</span>;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (n =3D=3D MALIBU_BUF_MAX) =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MY_ERR(<span =
style=3D'color:#A31515'>&quot;&quot;</span>);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;<span =
style=3D'color:blue'>return</span> -ENOMEM;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (copy_from_user(&amp;x, (<span =
style=3D'color:blue'>const</span> <span style=3D'color:blue'>void</span> =
__user*)arg, <span style=3D'color:blue'>sizeof</span>(x))) <span =
style=3D'color:blue'>return</span> -EFAULT;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b =3D =
&amp;md-&gt;bufs[n];<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b-&gt;size =
=3D ((x.size + PAGE_SIZE - 1) / PAGE_SIZE) * =
PAGE_SIZE;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
b-&gt;kAddr =3D dma_alloc_coherent(&amp;md-&gt;pdev-&gt;dev, b-&gt;size, =
&amp;b-&gt;physAddr, GFP_KERNEL);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (b-&gt;kAddr =3D=3D 0) =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b-&gt;size =3D =
0;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MY_ERR(<span =
style=3D'color:#A31515'>&quot;&quot;</span>);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> -ENOMEM;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; x.physAddr =
=3D b-&gt;physAddr;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; x.bufNum =
=3D n;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
x.fileOffset =3D (n + MALIBU_BAR_MAX) * =
MALIBU_MMAP_SIZE;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (copy_to_user((<span =
style=3D'color:blue'>void</span> __user*)arg, &amp;x, <span =
style=3D'color:blue'>sizeof</span>(x))) {<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freeBuffer(md, =
x.bufNum);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> -EFAULT;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
((uint32_t*)b-&gt;kAddr)[0] =3D 0x12345678;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
((uint32_t*)b-&gt;kAddr)[1] =3D n;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;((uint32_t*)b-&gt;kAddr)[2] =
=3D md-&gt;myDevT;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> 0;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>case</span> MALIBU_FREE_BUFFER: =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>int</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; i;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MalibuDrv_Buffer&nbsp; x;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:green'>//TODO:if (!(filep-&gt;f_mode &amp; FMODE_WRITE)) =
return -EACCES;<o:p></o:p></span></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (copy_from_user(&amp;x, (<span =
style=3D'color:blue'>const</span> <span style=3D'color:blue'>void</span> =
__user*)arg, <span style=3D'color:blue'>sizeof</span>(x))) <span =
style=3D'color:blue'>return</span> -EFAULT;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>for</span> (i =3D 0; i &lt; MALIBU_BUF_MAX; i++) =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (md-&gt;bufs[i].physAddr =3D=3D =
x.physAddr) {<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;freeBuffer(md, i);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; <span =
style=3D'color:blue'>break</span>;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (i =3D=3D MALIBU_BUF_MAX) =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MY_ERR(<span =
style=3D'color:#A31515'>&quot;&quot;</span>);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;<span =
style=3D'color:blue'>return</span> -ENOMEM;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> 0;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>case</span> =
MALIBU_ISR_ENABLE:<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:green'>//TODO: if (!(filep-&gt;f_mode &amp; FMODE_WRITE)) =
return -EACCES;<o:p></o:p></span></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
enable_irq(md-&gt;pdev-&gt;irq);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
md-&gt;isIrqEnabled =3D 1;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> 0;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>case</span> =
MALIBU_ISR_DISABLE:<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:green'>//TODO: if (!(filep-&gt;f_mode &amp; FMODE_WRITE)) =
return -EACCES;<o:p></o:p></span></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
md-&gt;isIrqEnabled =3D 0;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
disable_irq(md-&gt;pdev-&gt;irq);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> 0;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>case</span> =
MALIBU_GET_ISR_ENABLED:<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> =
md-&gt;isIrqEnabled;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>case</span> =
MALIBU_GET_ISR_DEPTH:<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> (md-&gt;iPtrLow - =
md-&gt;iPtrHi);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>case</span> =
MALIBU_ISR_CLEAR_ALL:<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:green'>//TODO: if (!(filep-&gt;f_mode &amp; FMODE_WRITE)) =
return -EACCES;<o:p></o:p></span></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
disable_irq(md-&gt;pdev-&gt;irq);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
md-&gt;iPtrLow =3D 0;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
md-&gt;iPtrHi =3D 0;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
enable_irq(md-&gt;pdev-&gt;irq);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> 0;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:green'>// no implemented =
yet<o:p></o:p></span></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>case</span> MALIBU_DEQUEUE_ISR: =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MalibuDrv_DequeueISR&nbsp; x;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>unsigned</span> <span =
style=3D'color:blue'>long</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
j;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>int</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:green'>//TODO: if (!(filep-&gt;f_mode &amp; FMODE_WRITE)) =
return -EACCES;<o:p></o:p></span></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (copy_from_user(&amp;x, (<span =
style=3D'color:blue'>const</span> <span style=3D'color:blue'>void</span> =
__user*)arg, (caddr_t)&amp;x.depth - (caddr_t)&amp;x)) <span =
style=3D'color:blue'>return</span> -EFAULT;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; x.depth =
=3D 0;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
x.cntxtFunc =3D md-&gt;cntxtFunc;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; x.cntxtArg =
=3D md-&gt;cntxtArg;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; x.errno =
=3D 0;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; x.depth =
=3D 0;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j =3D =
timeval_to_jiffies(&amp;x.timeout);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (j =3D=3D 0) {<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (md-&gt;iPtrLow !=3D md-&gt;iPtrHi) =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; <span style=3D'color:blue'>while</span> (md-&gt;iPtrLow !=3D =
md-&gt;iPtrHi &amp;&amp; x.depth &lt; MALIBU_INTR_MAX) =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
x.data[x.depth++] =3D md-&gt;iQueue[md-&gt;iPtrHi % =
MALIBU_INTR_MAX];<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;md-&gt;iPtrHi++;<o:=
p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>else</span> {<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; x.errno =3D ENODATA;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>else</span> {<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D =
wait_event_interruptible_timeout(md-&gt;intrWait, md-&gt;iPtrLow !=3D =
md-&gt;iPtrHi, j);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (ret =3D=3D 0) x.errno =3D =
ETIME;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>else</span> <span style=3D'color:blue'>if</span> =
(ret =3D=3D -ERESTARTSYS) x.errno =3D =
ERESTARTSYS;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>else</span> {<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; <span style=3D'color:blue'>while</span> (md-&gt;iPtrLow !=3D =
md-&gt;iPtrHi &amp;&amp; x.depth &lt; MALIBU_INTR_MAX) =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
x.data[x.depth++] =3D md-&gt;iQueue[md-&gt;iPtrHi % =
MALIBU_INTR_MAX];<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;md-&gt;iPtrHi++;<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; jiffies_to_timeval(ret, =
&amp;x.timeout);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (copy_to_user((<span =
style=3D'color:blue'>void</span> __user*)arg, &amp;x, =
(caddr_t)&amp;x.data[x.depth] - (caddr_t)&amp;x)) <span =
style=3D'color:blue'>return</span> -EFAULT;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> 0;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>case</span> =
MALIBU_SET_ISR_CTRL: {<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MalibuDrv_IntCtrl&nbsp; x;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:green'>//TODO: if (!(filep-&gt;f_mode &amp; FMODE_WRITE)) =
return -EACCES;<o:p></o:p></span></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (copy_from_user(&amp;x, (<span =
style=3D'color:blue'>const</span> <span style=3D'color:blue'>void</span> =
__user*)arg, <span style=3D'color:blue'>sizeof</span>(x))) <span =
style=3D'color:blue'>return</span> -EFAULT;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
md-&gt;intrMask =3D x.mask;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
md-&gt;intrWriteback =3D x.type;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span =
style=3D'color:blue'>if</span> (x.bar &gt; MALIBU_BAR_MAX) =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MY_ERR(<span =
style=3D'color:#A31515'>&quot;&quot;</span>);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> -EINVAL;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (x.byteOffset &gt; =
md-&gt;bars[x.bar].size) {<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MY_ERR(<span =
style=3D'color:#A31515'>&quot;&quot;</span>);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span =
style=3D'color:blue'>return</span> -EINVAL;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
md-&gt;intrStatusAddr =3D md-&gt;bars[x.bar].kAddr + =
x.byteOffset;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
md-&gt;cntxtFunc =3D x.cntxtFunc;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
md-&gt;cntxtArg =3D x.cntxtArg;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> 0;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>case</span> =
MALIBU_SET_SIG:<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:green'>//TODO: if (!(filep-&gt;f_mode &amp; FMODE_WRITE)) =
return -EACCES;<o:p></o:p></span></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
md-&gt;mySig =3D arg;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> 0;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>case</span> MALIBU_FAKE_SIG: =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MalibuDrv_FakeISR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
x;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (copy_from_user(&amp;x, (<span =
style=3D'color:blue'>const</span> <span style=3D'color:blue'>void</span> =
__user*)arg, <span style=3D'color:blue'>sizeof</span>(x))) <span =
style=3D'color:blue'>return</span> -EFAULT;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> ((md-&gt;iPtrLow - md-&gt;iPtrHi) &lt; =
MALIBU_INTR_MAX-x.depth-1) {<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>int</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
i;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>for</span> (i =3D 0; i &lt; x.depth; i++) =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; md-&gt;iQueue[md-&gt;iPtrLow % MALIBU_INTR_MAX] =3D =
x.data[i];<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; md-&gt;iPtrLow++;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;wake_up_interruptible(&amp;md-&gt;intrWait);<o:p>=
</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (md-&gt;async_queue) =
kill_fasync(&amp;md-&gt;async_queue, md-&gt;mySig, =
POLL_IN);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> 0;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span =
style=3D'color:blue'>default</span>:<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> -EINVAL;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>//static irqreturn_t =
board_handler(unsigned int irq, void *dev_id, struct pt_regs =
*regs)<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>int</span> malibu_intr_handler(rtdm_irq_t * =
irq_context)<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#if</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> =
0<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; uint32_t&nbsp; =
rd;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
MyData*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 md =3D (MyData*) dev_id;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span>(md-&gt;pdev-&gt;irq !=3D irq) <span =
style=3D'color:blue'>return</span> IRQ_NONE;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; rd =3D =
ioread32(md-&gt;intrStatusAddr);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> ((rd &amp; md-&gt;intrMask) =3D=3D 0) =
<span style=3D'color:blue'>return</span> =
IRQ_NONE;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> ((md-&gt;iPtrLow - md-&gt;iPtrHi) &lt; =
MALIBU_INTR_MAX-1) {<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; md-&gt;iQueue[md-&gt;iPtrLow % MALIBU_INTR_MAX] =3D =
rd;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; md-&gt;iPtrLow++;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =
wake_up_interruptible(&amp;md-&gt;intrWait);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>if</span> (md-&gt;async_queue =
&amp;&amp; md-&gt;mySig) kill_fasync(&amp;md-&gt;async_queue, =
md-&gt;mySig, POLL_IN);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
<span style=3D'color:blue'>if</span> (md-&gt;intrWriteback) =
iowrite32(rd, md-&gt;intrStatusAddr);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#endif<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
<span style=3D'color:blue'>return</span> =
IRQ_HANDLED;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>void</span> vma_open(<span =
style=3D'color:blue'>struct</span> vm_area_struct* vma) { =
}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>void</span> vma_close(<span =
style=3D'color:blue'>struct</span> vm_area_struct* vma) { =
}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>struct</span> vm_operations_struct remap_vm_ops =3D =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; .open =3D =
vma_open,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; .close =3D =
vma_close,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>};<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>int</span> mmap(<span =
style=3D'color:blue'>struct</span> file *filep, <span =
style=3D'color:blue'>struct</span> vm_area_struct =
*vma)<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
MyData*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 md =3D (MyData*) filep-&gt;private_data;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
<span style=3D'color:blue'>unsigned</span> <span =
style=3D'color:blue'>long</span>&nbsp;&nbsp; off =3D vma-&gt;vm_pgoff =
&lt;&lt; PAGE_SHIFT;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>unsigned</span> <span =
style=3D'color:blue'>long</span>&nbsp;&nbsp; vsize =3D vma-&gt;vm_end - =
vma-&gt;vm_start;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>unsigned</span> <span =
style=3D'color:blue'>long</span>&nbsp;&nbsp; seg =3D off / =
MALIBU_MMAP_SIZE;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>unsigned</span> <span =
style=3D'color:blue'>long</span>&nbsp;&nbsp; seg_off =3D off % =
MALIBU_MMAP_SIZE;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>unsigned</span> <span =
style=3D'color:blue'>long</span>&nbsp;&nbsp; psize, =
pfn;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (seg &gt;=3D 0 &amp;&amp; seg &lt; =
MALIBU_BAR_MAX) {<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>if</span> =
(md-&gt;bars[seg].size =3D=3D 0) <span =
style=3D'color:blue'>return</span> -EINVAL;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; pfn =3D (md-&gt;bars[seg].start + seg_off) &gt;&gt; =
PAGE_SHIFT;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; psize =3D md-&gt;bars[seg].size - =
seg_off;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
<span style=3D'color:blue'>else</span> <span =
style=3D'color:blue'>if</span> (seg &gt;=3D MALIBU_BAR_MAX &amp;&amp; =
seg &lt; MALIBU_BAR_MAX + MALIBU_BUF_MAX) {<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; seg -=3D MALIBU_BAR_MAX;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>if</span> =
(md-&gt;bufs[seg].size =3D=3D 0) <span =
style=3D'color:blue'>return</span> -EINVAL;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; pfn =3D __pa(md-&gt;bufs[seg].kAddr + seg_off) &gt;&gt; =
PAGE_SHIFT;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; psize =3D md-&gt;bufs[seg].size - =
seg_off;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
<span style=3D'color:blue'>else</span> <span =
style=3D'color:blue'>return</span> -EINVAL;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (vsize &gt; psize) <span =
style=3D'color:blue'>return</span> -EINVAL;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
<span style=3D'color:blue'>if</span> (remap_pfn_range(vma, =
vma-&gt;vm_start, pfn, vsize, vma-&gt;vm_page_prot)) <span =
style=3D'color:blue'>return</span> -EAGAIN;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; vma-&gt;vm_ops =3D =
&amp;remap_vm_ops;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
vma_open(vma);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> 0;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>int</span> fasync(<span =
style=3D'color:blue'>int</span> fd, <span =
style=3D'color:blue'>struct</span> file *filep, <span =
style=3D'color:blue'>int</span> mode)<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
MyData*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 md =3D (MyData*) filep-&gt;private_data;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
<span style=3D'color:blue'>return</span> fasync_helper(fd, filep, mode, =
&amp;md-&gt;async_queue);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>struct</span> file_operations myFileOps =3D =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; .owner&nbsp;&nbsp; &nbsp; =3D =
THIS_MODULE,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; .open&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp; =3D malibu_rtdm_open,<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
.release &nbsp; =3D release,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
.ioctl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
malibu_rtdm_ioctl,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; .mmap&nbsp;&nbsp;&nbsp; =3D =
mmap,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; .fasync&nbsp;&nbsp;&nbsp; =3D =
fasync,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>};<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> ssize_t =
showDevInfo(<span style=3D'color:blue'>struct</span> device *dev, <span =
style=3D'color:blue'>struct</span> device_attribute* attr, <span =
style=3D'color:blue'>char</span> *buf)<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; MyData* md =3D =
(MyData*)dev-&gt;driver_data;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> snprintf(buf, =
PAGE_SIZE,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span =
style=3D'color:#A31515'>&quot;vendor=3D0x%x\n&quot;<o:p></o:p></span></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span =
style=3D'color:#A31515'>&quot;device=3D0x%x\n&quot;<o:p></o:p></span></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span =
style=3D'color:#A31515'>&quot;subsystem_vendor=3D0x%x\n&quot;<o:p></o:p><=
/span></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span =
style=3D'color:#A31515'>&quot;subsystem_device=3D0x%x\n&quot;<o:p></o:p><=
/span></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span =
style=3D'color:#A31515'>&quot;revision=3D0x%x\n&quot;<o:p></o:p></span></=
span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span =
style=3D'color:#A31515'>&quot;bus=3D0x%x\n&quot;<o:p></o:p></span></span>=
</p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span =
style=3D'color:#A31515'>&quot;slot=3D0x%x\n&quot;<o:p></o:p></span></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span =
style=3D'color:#A31515'>&quot;func=3D0x%x\n&quot;<o:p></o:p></span></span=
></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span =
style=3D'color:#A31515'>&quot;numBars=3D%d\n&quot;</span>,<o:p></o:p></sp=
an></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; md-&gt;pdev-&gt;vendor,<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; md-&gt;pdev-&gt;device,<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; md-&gt;pdev-&gt;subsystem_vendor,<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; md-&gt;pdev-&gt;subsystem_device,<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; md-&gt;pdev-&gt;revision,<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; md-&gt;pdev-&gt;bus-&gt;number,<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; PCI_SLOT(md-&gt;pdev-&gt;devfn),<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; PCI_FUNC(md-&gt;pdev-&gt;devfn),<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; md-&gt;numBars);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> DEVICE_ATTR(devInfo, =
0444, showDevInfo, NULL);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>/**<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif";color:green'>* This =
structure describe the malibu RTDM device<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>*<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>*/<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>struct</span> rtdm_device malibu_rtdm_device =3D =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; .struct_version =3D =
RTDM_DEVICE_STRUCT_VER,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; .device_flags =3D =
RTDM_NAMED_DEVICE,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; .context_size =3D <span =
style=3D'color:blue'>sizeof</span>(MyData),<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
.device_name =3D DRV_NAME,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; .open_rt =3D&nbsp; =
malibu_rtdm_open,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; .open_nrt =3D =
malibu_rtdm_open,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; .ops =3D =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; .close_rt =3D malibu_rtdm_close,<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; .close_nrt =3D malibu_rtdm_close,<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; .ioctl_rt =3D&nbsp; =
malibu_rtdm_ioctl,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; .ioctl_nrt =3D malibu_rtdm_ioctl,<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:green'>//.read_nrt =3D =
NULL,<o:p></o:p></span></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:green'>//.write_nrt =3D =
NULL,<o:p></o:p></span></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; },<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; .device_class =3D =
RTDM_CLASS_EXPERIMENTAL,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; .device_sub_class =3D =
SOME_SUB_CLASS,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; .profile_version =3D =
1,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; .driver_name =3D =
DRV_NAME,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; .driver_version =3D =
RTDM_DRIVER_VER(0, 1, 0),<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; .peripheral_name =3D <span =
style=3D'color:#A31515'>&quot;Malibu RT =
driver&quot;</span>,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; .provider_name =3D <span =
style=3D'color:#A31515'>&quot;Innovative =
Integration&quot;</span>,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; .proc_name =3D =
DRV_NAME,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>};<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>int</span> allocEachDev(<span =
style=3D'color:blue'>struct</span> pci_dev *pdev, <span =
style=3D'color:blue'>const</span> <span =
style=3D'color:blue'>struct</span> pci_device_id =
*id)<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>struct</span> rtdm_device&nbsp; =
*rtdm_dev;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>int</span>&nbsp;&nbsp;&nbsp; ret_val =3D =
0;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; MyData *md, =
*lPtr;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>int</span>&nbsp; i, bCntr, error, =
b;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; MY_PRINT(<span =
style=3D'color:#A31515'>&quot;start&quot;</span>);<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span>(id-&gt;vendor !=3D VENDOR_ID) =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; MY_ERR(<span =
style=3D'color:#A31515'>&quot;&quot;</span>);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>return</span> =
-ENODEV;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; md =3D (MyData*) kzalloc(<span =
style=3D'color:blue'>sizeof</span>(MyData), =
GFP_KERNEL);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; md-&gt;pdev =3D =
pdev;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; sprintf(msgbuf, <span =
style=3D'color:#A31515'>&quot;pdev-&gt;irq=3D%d&quot;</span>, =
pdev-&gt;irq);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
MY_PRINT(msgbuf);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (pci_enable_device(pdev)) =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; MY_ERR(<span =
style=3D'color:#A31515'>&quot;&quot;</span>);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; kfree(md);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>return</span> =
-ENODEV;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
pci_set_master(pdev);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; b =3D 0;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
<span style=3D'color:blue'>for</span> (i =3D 0; i &lt; MALIBU_BAR_MAX; =
i++) {<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =
md-&gt;bars[b].start&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
pci_resource_start(pdev, i);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =
md-&gt;bars[b].end&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D pci_resource_end(pdev, i);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; =
md-&gt;bars[b].size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =3D pci_resource_len(pdev, i);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; printk(KERN_ERR <span =
style=3D'color:#A31515'>&quot;bar=3D%d start=3D%llx end=3D%llx =
len=3D%llx\n&quot;</span>, i,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
md-&gt;bars[b].start,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
md-&gt;bars[b].end,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
md-&gt;bars[b].size);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>if</span> (md-&gt;bars[b].size =
=3D=3D 0) <span =
style=3D'color:blue'>continue</span>;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; md-&gt;bars[b].kAddr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
(<span style=3D'color:blue'>void</span>*) ioremap(md-&gt;bars[i].start, =
md-&gt;bars[i].end - md-&gt;bars[i].start);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; b++;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
md-&gt;numBars =3D i;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
init_waitqueue_head(&amp;md-&gt;intrWait);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; cdev_init(&amp;md-&gt;cdev, =
&amp;myFileOps);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; md-&gt;cdev.owner =3D =
THIS_MODULE;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; md-&gt;myDevT =3D =
MKDEV(MAJOR(baseDevT), MINOR(baseDevT)+devCnt);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
<span style=3D'color:blue'>if</span> (cdev_add(&amp;md-&gt;cdev, =
md-&gt;myDevT, 1)) {<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; MY_ERR(<span =
style=3D'color:#A31515'>&quot;&quot;</span>);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; pci_disable_device(md-&gt;pdev);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; kfree(md);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>return</span> =
-ENODEV;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; bCntr =3D =
0;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; list_for_each_entry(lPtr, =
&amp;devList, list) {<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>if</span> =
(lPtr-&gt;pdev-&gt;device =3D=3D pdev-&gt;device) =
bCntr++;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; md-&gt;sysdev =3D =
device_create(devClass, &amp;md-&gt;pdev-&gt;dev, md-&gt;myDevT, NULL, =
<span style=3D'color:#A31515'>&quot;malibu%04x_%d&quot;</span>, =
pdev-&gt;device, bCntr);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (IS_ERR(md-&gt;sysdev)) =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; MY_ERR(<span =
style=3D'color:#A31515'>&quot;&quot;</span>);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; cdev_del(&amp;md-&gt;cdev);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; pci_disable_device(md-&gt;pdev);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; kfree(md);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>return</span> =
-ENODEV;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
md-&gt;sysdev-&gt;driver_data =3D (<span =
style=3D'color:blue'>void</span>*)md;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; error =3D =
device_create_file(md-&gt;sysdev, =
&amp;dev_attr_devInfo);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (error) {<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; MY_ERR(<span =
style=3D'color:#A31515'>&quot;&quot;</span>);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; device_destroy(devClass, =
md-&gt;myDevT);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; cdev_del(&amp;md-&gt;cdev);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>for</span> (i =3D 0; i &lt; =
MALIBU_BAR_MAX; i++) {<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (md-&gt;bars[i].size) =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
iounmap(md-&gt;bars[i].kAddr);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;md-&gt;bars[i].size =3D =
0;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; pci_disable_device(md-&gt;pdev);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; kfree(md);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>return</span> =
error;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; md-&gt;dev_id =3D =
devCnt;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:green'>//alloc mem for rtdm =
structure<o:p></o:p></span></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; rtdm_dev =3D kmalloc(<span =
style=3D'color:blue'>sizeof</span>(<span =
style=3D'color:blue'>struct</span> rtdm_device), =
GFP_KERNEL);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span>(!rtdm_dev){<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MY_ERR(<span =
style=3D'color:#A31515'>&quot;rtdm_device kmalloc =
failed\n&quot;</span>);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret_val =3D -ENOMEM; =
<span style=3D'color:green'>//Insufficient storage space is =
available.<o:p></o:p></span></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> ret_val;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:green'>//copy the structure to the new =
memory<o:p></o:p></span></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; memcpy(rtdm_dev, =
&amp;malibu_rtdm_device, <span style=3D'color:blue'>sizeof</span>(<span =
style=3D'color:blue'>struct</span> =
rtdm_device));<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:green'>//create filename<o:p></o:p></span></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
snprintf(rtdm_dev-&gt;device_name,<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; RTDM_MAX_DEVNAME_LEN, <span =
style=3D'color:#A31515'>&quot;malibu_%d&quot;</span>, =
devCnt);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; rtdm_dev-&gt;device_id =3D =
devCnt;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:green'>//define two other members of the rtdm_device =
structure<o:p></o:p></span></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; rtdm_dev-&gt;proc_name =3D =
rtdm_dev-&gt;device_name;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; ret_val =3D =
rtdm_dev_register(rtdm_dev);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span>(ret_val &lt; 0){<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MY_ERR(<span =
style=3D'color:#A31515'>&quot;failed to register device with =
RTDM\n&quot;</span>);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret_val =3D =
-ENODEV;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> ret_val;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; md-&gt;xen_rtdm_device =3D =
rtdm_dev;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; list_add_tail(&amp;md-&gt;list, =
&amp;devList);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:green'>//always do this =
last<o:p></o:p></span></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; devCnt++;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; MY_PRINT(<span =
style=3D'color:#A31515'>&quot;end =
OK&quot;</span>);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> 0;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>void</span> removeAllDev(<span =
style=3D'color:blue'>struct</span> pci_dev =
*pdev)<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; MyData *md, =
*tmp;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; MY_PRINT(<span =
style=3D'color:#A31515'>&quot;start&quot;</span>);<o:p></o:p></span></p><=
p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(md, tmp, =
&amp;devList, list)<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; {<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (md =3D=3D NULL)<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; MY_PRINT(<span style=3D'color:#A31515'>&quot;md is =
NULL&quot;</span>);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span>;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>int</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
i;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
list_del(&amp;md-&gt;list);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
device_remove_file(md-&gt;sysdev, =
&amp;dev_attr_devInfo);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
device_destroy(devClass, md-&gt;myDevT);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
cdev_del(&amp;md-&gt;cdev);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>for</span> (i =3D 0; i &lt; MALIBU_BUF_MAX; i++) =
freeBuffer(md, i);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>for</span> (i =3D 0; i &lt; MALIBU_BAR_MAX; i++) =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>if</span> (md-&gt;bars[i].size) =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
iounmap(md-&gt;bars[i].kAddr);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; md-&gt;bars[i].size =3D =
0;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
pci_disable_device(md-&gt;pdev);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:green'>//remove char device from the =
system<o:p></o:p></span></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:green'>//unregister =
RTdriver<o:p></o:p></span></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rtdm_dev_unregister(md-&gt;xen_rtdm_device, =
1000);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
kfree(md-&gt;xen_rtdm_device);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
kfree(md);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
devCnt--;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; MY_PRINT(<span =
style=3D'color:#A31515'>&quot;end&quot;</span>);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>#endif<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>struct</span> pci_device_id ids[] =3D =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; { PCI_DEVICE(VENDOR_ID, =
PCI_ANY_ID) },<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; { 0 },<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>};<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>struct</span> pci_driver pci_driver =3D =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
.name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
DRV_NAME,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; .id_table&nbsp; =3D =
ids,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; .probe&nbsp;&nbsp;&nbsp;&nbsp; =
=3D allocEachDev,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; .remove&nbsp;&nbsp; =3D =
removeAllDev,<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>};<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>//MODULE_DEVICE_TABLE(pci, =
ids);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> ssize_t =
showDevCount(<span style=3D'color:blue'>struct</span> <span =
style=3D'color:blue'>class</span> *cls, <span =
style=3D'color:blue'>char</span> *buf)<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> sprintf(buf, <span =
style=3D'color:#A31515'>&quot;%d\n&quot;</span>, =
devCnt);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> CLASS_ATTR(devCount, =
0444, showDevCount, NULL);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>/**<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif";color:green'>* This =
function is called when the module is loaded<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>*<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif";color:green'>* It simply =
registers the RTDM device.<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>*<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>*/<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>int</span> __init mod_init(<span =
style=3D'color:blue'>void</span>)<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>int</span>  error;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; MY_PRINT(<span =
style=3D'color:#A31515'>&quot;initializing MalibuDrv_RT =
module&quot;</span>);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; devClass =3D =
class_create(THIS_MODULE, DRV_NAME);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
<span style=3D'color:blue'>if</span> (IS_ERR(devClass)) =
{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; MY_ERR(<span =
style=3D'color:#A31515'>&quot;&quot;</span>);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>return</span> =
PTR_ERR(devClass);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; error =3D =
class_create_file(devClass, =
&amp;class_attr_devCount);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (error) {<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; MY_ERR(<span =
style=3D'color:#A31515'>&quot;&quot;</span>);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; class_destroy(devClass);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>return</span> =
error;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; error =3D =
alloc_chrdev_region(&amp;baseDevT, 0, MALIBU_MAX_DEVS, =
DRV_NAME);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>if</span> (error) {<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; MY_ERR(<span =
style=3D'color:#A31515'>&quot;&quot;</span>);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; class_remove_file(devClass, =
&amp;class_attr_devCount);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;class_destroy(devClass);<o:p></=
o:p></span></p><p class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; <span style=3D'color:blue'>return</span> =
error;<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; error =3D =
pci_register_driver(&amp;pci_driver);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
<span style=3D'color:blue'>if</span> (error) {<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MY_ERR(<span =
style=3D'color:#A31515'>&quot;&quot;</span>);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
unregister_chrdev_region(baseDevT, =
MALIBU_MAX_DEVS);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
class_remove_file(devClass, =
&amp;class_attr_devCount);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
class_destroy(devClass);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> error;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; <span =
style=3D'color:blue'>return</span> error;<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>/**<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif";color:green'>* This =
function is called when the module is unloaded<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>*<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif";color:green'>* It =
unregister the RTDM device, polling at 1000 ms for pending =
users.<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>*<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:green'>*/<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif";color:blue'>static</span><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'> <span =
style=3D'color:blue'>void</span> __exit mod_exit(<span =
style=3D'color:blue'>void</span>)<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>{<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; MY_PRINT(<span =
style=3D'color:#A31515'>&quot;unregistering MalibuDrv_RT =
module&quot;</span>);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
pci_unregister_driver(&amp;pci_driver);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
unregister_chrdev_region(baseDevT, =
MALIBU_MAX_DEVS);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; class_remove_file(devClass, =
&amp;class_attr_devCount);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>&nbsp;&nbsp;&nbsp; =
class_destroy(devClass);<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>}<o:p></o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal =
style=3D'text-autospace:none'><span style=3D'font-family:"DejaVu =
Sans","sans-serif"'>module_init(mod_init);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu =
Sans","sans-serif"'>module_exit(mod_exit);<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'text-autospace:none'><span =
style=3D'font-family:"DejaVu Sans","sans-serif"'>MODULE_LICENSE(<span =
style=3D'color:#A31515'>&quot;GPL&quot;</span>);<o:p></o:p></span></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Thanks,<o:p></o:p></p><p class=3DMsoNormal>Peter =
Hua<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
------=_NextPart_001_004F_01CBB3FA.5C6A5720--

------=_NextPart_000_004E_01CBB3FA.5C6A5720
Content-Type: text/plain;
	name="malibu.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="malibu.c"

/**
* This a driver written to interface with DSP boards from Innovative =
Integration
* It utilizes the RTDM device APIs from the Xenomai realtime Linux =
project.
*
*/

#include <linux/version.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/pci.h>
#include <linux/interrupt.h>
#include <linux/delay.h>
#include <linux/workqueue.h>
#include <linux/reboot.h>
#include <linux/slab.h>
#include <linux/cdev.h>
#include <linux/spinlock.h>
#include <linux/pagemap.h>
#include <linux/semaphore.h>
#include <linux/list.h>
#include <asm/uaccess.h>
#include <asm/dma.h>
#include <asm/delay.h>
#include <asm/io.h>
#include <asm/msr.h>
#include <asm/page.h>

#include <rtdm/rtdm_driver.h>

#include "malibu.h"

#define VENDOR_ID		0x1303
#define	DRV_NAME		"malibu"
#define SIZE_MAX		1024
#define SOME_SUB_CLASS		1303


static void errMsg(int line, const char *place, const char *msg)
{
    printk(KERN_ALERT "malibu: Error at %s() line: %d, %s\n", place, =
line, msg);
}

#define	MY_ERR(s)	errMsg(__LINE__, __FUNCTION__, s)

static void logMsg(int line, const char *place, const char *msg)
{
    printk(KERN_INFO "MalibuDrv_RT: %s() line: %d, %s\n", place, line, =
msg);
}

#define	MY_PRINT(s)	logMsg(__LINE__, __FUNCTION__, s);

typedef struct {
    void*		kAddr;
    uint64_t	start;
    uint64_t	end;
    uint64_t	size;
} MyBar;

typedef struct {
    void*		kAddr;
    dma_addr_t	physAddr;
    uint32_t	size;
} MyBuf;

typedef struct {
    struct list_head	list;
    struct cdev		cdev;
    struct device	*sysdev;
    struct pci_dev	*pdev;
    dev_t		myDevT;

    MyBar		bars[MALIBU_BAR_MAX];
    MyBuf		bufs[MALIBU_BUF_MAX];

    wait_queue_head_t	intrWait;
    struct fasync_struct* async_queue;
    int			mySig;
    void*		intrStatusAddr;
    u32			intrMask;
    u8			intrWriteback;
    u32			iQueue[MALIBU_INTR_MAX];
    u32			iPtrLow;
    u32			iPtrHi;
    void		(*cntxtFunc)(void*);
    void		*cntxtArg;

    u16			devOpen;
    u8			wrOpen;
    u8			numBars;
    u8			isIrqEnabled;
    int                 dev_id;
    struct rtdm_device *xen_rtdm_device;
    rtdm_irq_t         irq_handle;  /* device IRQ handle */
} MyData;

static struct class*	devClass;
static dev_t 		baseDevT;

static int	devCnt =3D 0;
LIST_HEAD(devList);

static int fasync(int fd, struct file *filep, int mode);
//static irqreturn_t board_handler(unsigned int irq, void *dev_id, =
struct pt_regs *regs);
static int malibu_intr_handler(rtdm_irq_t * irq_context);

static char msgbuf[1000];

static int malibu_rtdm_open(struct rtdm_dev_context *context,
                        rtdm_user_info_t * user_info, int oflags)
//static int open(struct inode *inodep, struct file *filep)
{
    MyData *md, *ctx;
    bool found=3Dfalse;
    int err=3D0;

    MY_PRINT("start");
    ctx =3D (MyData *)context->dev_private;

    list_for_each_entry(md, &devList, list) {
         if (md->dev_id =3D=3D context->device->device_id)
         {
                found =3D true;
                MY_PRINT("device FOUND");

                sprintf (msgbuf, "md=3D%p, md->device_id=3D%d", md, =
md->dev_id);
                MY_PRINT(msgbuf);

                memcpy(ctx, md, sizeof(MyData));

                break;
         }
    }

    if(!found)
    {
        MY_ERR("no matching device");
        return -ENODEV;
    }


    if (ctx->wrOpen && (oflags & FMODE_WRITE)) {
            MY_ERR("device already opened");
            return -EBUSY;
    }


    if (oflags & FMODE_WRITE)
    {
        ctx->iPtrLow =3D 0;
        ctx->iPtrHi =3D 0;
        ctx->mySig =3D SIGIO;
        ctx->cntxtFunc =3D 0;
        ctx->cntxtArg =3D 0;

        static unsigned long irqtype =3D (RTDM_IRQTYPE_SHARED | =
RTDM_IRQTYPE_EDGE);

        sprintf(msgbuf, "irqtype=3D%d", irqtype);
        MY_PRINT(msgbuf);

        err =3D rtdm_irq_request(&ctx->irq_handle, ctx->pdev->irq,
                               (rtdm_irq_handler_t)malibu_intr_handler,
                               irqtype,
                               context->device->proc_name,  (void =
*)ctx);

        if(err !=3D 0)
        {
            sprintf(msgbuf, "rtdm_irq_request() failed, err=3D%d, =
irq=3D%d, proc_name=3D%s",
                    err, ctx->pdev->irq, context->device->proc_name);
            MY_ERR(msgbuf);
            return err;
        }

        sprintf(msgbuf, "rtdm_irq_request() OK, irq=3D%d", =
ctx->irq_handle);
        MY_PRINT(msgbuf);

#if 0
        if (request_irq(md->pdev->irq, (irq_handler_t)board_handler, =
IRQF_SHARED, DRV_NAME, (void*)md)) {
                MY_ERR("irq request error");
                return -ENODEV;
        }
#endif

        ctx->wrOpen =3D 1;
    }

    ctx->devOpen++;

    MY_PRINT("end OK");
    return 0;
}

/**
* Close the device
*
* This function is called when the device shall be closed.
*
*/
static int malibu_rtdm_close(struct rtdm_dev_context *context,
                            rtdm_user_info_t * user_info)
{  =20
    MyData *ctx =3D context->dev_private;
    rtdm_irq_free(&ctx->irq_handle);

    sprintf(msgbuf, "ctx=3D0x%p, irq=3D%d", ctx, ctx->irq_handle);
    MY_PRINT(msgbuf);
    MY_PRINT("closing device");
    return 0;
}

#if 1
static void freeBuffer(MyData* md, int n)
{
    MyBuf* b =3D &md->bufs[n];
    if (b->size =3D=3D 0) return;
    dma_free_coherent(&md->pdev->dev, b->size, b->kAddr, b->physAddr);
    b->size =3D 0;
}

static int release(struct inode *inode, struct file *filep)
{
    int		i;
    MyData*		md =3D (MyData*) filep->private_data;

    md->devOpen--;

    if (filep->f_mode & FMODE_WRITE) {
            md->wrOpen =3D 0;
            free_irq(md->pdev->irq, md);
            for (i =3D 0; i < MALIBU_BUF_MAX; i++) freeBuffer(md, i);
            fasync(-1, filep, 0);
    }

    return 0;
}

//static int ioctl(struct inode *inodep, struct file *filep, unsigned =
int cmd, unsigned long arg)
int malibu_rtdm_ioctl(struct rtdm_dev_context   *context,
                      rtdm_user_info_t          *user_info,
                      int                       cmd,
                      void                      *arg)
{
    MyData* md =3D (MyData *)context->dev_private;
    int err =3D 0;
    int retval =3D 0;
    ioc_param_struct param =3D {0,0};

    if (_IOC_TYPE(cmd) !=3D MALIBU_IOC_MAGIC) return -ENOTTY;

    /*
    * the direction is a bitmask, and VERIFY_WRITE catches R/W
    * transfers. `Type' is user-oriented, while
    * access_ok is kernel-oriented, so the concept of "read" and
    * "write" is reversed (i.e. when an user wants to read data,
    * the kernel has to write them into the user space)
    *
    * always check the user space address before accessing it
    *
    * access_ok returns 0 for failure!
    */
    if (_IOC_DIR(cmd) & _IOC_READ)
      err =3D !rtdm_read_user_ok(user_info, arg, =
sizeof(ioc_param_struct));
    else if (_IOC_DIR(cmd) & _IOC_WRITE)
      err =3D !rtdm_rw_user_ok(user_info, arg, =
sizeof(ioc_param_struct));
    if (err) return -EFAULT;

    switch(cmd) {
            case MALIBU_GET_INFO: {
                    MalibuDrv_INFO	x;
                    x.vendorId =3D md->pdev->vendor;
                    x.deviceId =3D md->pdev->device;
                    x.subVendorId =3D md->pdev->subsystem_vendor;
                    x.subDeviceId =3D md->pdev->subsystem_device;
                    x.revision =3D md->pdev->revision;
                    x.bus =3D md->pdev->bus->number;
                    x.slot =3D PCI_SLOT(md->pdev->devfn);
                    x.func =3D PCI_FUNC(md->pdev->devfn);
                    x.numBars =3D md->numBars;

                    MY_PRINT("copying data to user");

                    sprintf(msgbuf, "x.vendorId=3D0x%x, =
x.deviceId=3D0x%x, x.numBars=3D%d",
                            md->pdev->vendor, md->pdev->device, =
x.numBars);
                    MY_PRINT(msgbuf);
                    //return (0 =3D=3D copy_to_user((void __user*)arg, =
&x, sizeof(x))) ? 0 : -EFAULT;
            }

            case MALIBU_GET_BAR_SIZE:
                    if (*(int *)arg < 0 || *(int *)arg >=3D =
MALIBU_BAR_MAX) return -EINVAL;
                    return md->bars[*(int *)arg].size;

            case MALIBU_ALLOC_BUFFER: {
                    int			n;
                    MalibuDrv_Buffer	x;
                    MyBuf*			b;

                    //TODO: if (!(filep->f_mode & FMODE_WRITE)) return =
-EACCES;

                    for (n =3D 0; n < MALIBU_BUF_MAX; n++) {
                            if (md->bufs[n].size =3D=3D 0) break;
                    }
                    if (n =3D=3D MALIBU_BUF_MAX) {
                            MY_ERR("");
                            return -ENOMEM;
                    }
                    if (copy_from_user(&x, (const void __user*)arg, =
sizeof(x))) return -EFAULT;
                    b =3D &md->bufs[n];

                    b->size =3D ((x.size + PAGE_SIZE - 1) / PAGE_SIZE) * =
PAGE_SIZE;
                    b->kAddr =3D dma_alloc_coherent(&md->pdev->dev, =
b->size, &b->physAddr, GFP_KERNEL);
                    if (b->kAddr =3D=3D 0) {
                            b->size =3D 0;
                            MY_ERR("");
                            return -ENOMEM;
                    }
                    x.physAddr =3D b->physAddr;
                    x.bufNum =3D n;
                    x.fileOffset =3D (n + MALIBU_BAR_MAX) * =
MALIBU_MMAP_SIZE;
                    if (copy_to_user((void __user*)arg, &x, sizeof(x))) =
{
                            freeBuffer(md, x.bufNum);
                            return -EFAULT;
                    }
                    ((uint32_t*)b->kAddr)[0] =3D 0x12345678;
                    ((uint32_t*)b->kAddr)[1] =3D n;
                    ((uint32_t*)b->kAddr)[2] =3D md->myDevT;
                    return 0;
            }

            case MALIBU_FREE_BUFFER: {
                    int			i;
                    MalibuDrv_Buffer	x;

                    //TODO:if (!(filep->f_mode & FMODE_WRITE)) return =
-EACCES;

                    if (copy_from_user(&x, (const void __user*)arg, =
sizeof(x))) return -EFAULT;
                    for (i =3D 0; i < MALIBU_BUF_MAX; i++) {
                            if (md->bufs[i].physAddr =3D=3D x.physAddr) =
{
                                    freeBuffer(md, i);
                                    break;
                            }
                    }
                    if (i =3D=3D MALIBU_BUF_MAX) {
                            MY_ERR("");
                            return -ENOMEM;
                    }
                    return 0;
            }

            case MALIBU_ISR_ENABLE:
                    //TODO: if (!(filep->f_mode & FMODE_WRITE)) return =
-EACCES;
                    enable_irq(md->pdev->irq);
                    md->isIrqEnabled =3D 1;
                    return 0;
            case MALIBU_ISR_DISABLE:
                    //TODO: if (!(filep->f_mode & FMODE_WRITE)) return =
-EACCES;
                    md->isIrqEnabled =3D 0;
                    disable_irq(md->pdev->irq);
                    return 0;
            case MALIBU_GET_ISR_ENABLED:
                    return md->isIrqEnabled;
            case MALIBU_GET_ISR_DEPTH:
                    return (md->iPtrLow - md->iPtrHi);
            case MALIBU_ISR_CLEAR_ALL:
                    //TODO: if (!(filep->f_mode & FMODE_WRITE)) return =
-EACCES;
                    disable_irq(md->pdev->irq);
                    md->iPtrLow =3D 0;
                    md->iPtrHi =3D 0;
                    enable_irq(md->pdev->irq);
                    return 0;	// no implemented yet
            case MALIBU_DEQUEUE_ISR: {
                    MalibuDrv_DequeueISR	x;
                    unsigned long		j;
                    int			ret;

                    //TODO: if (!(filep->f_mode & FMODE_WRITE)) return =
-EACCES;
                    if (copy_from_user(&x, (const void __user*)arg, =
(caddr_t)&x.depth - (caddr_t)&x)) return -EFAULT;

                    x.depth =3D 0;
                    x.cntxtFunc =3D md->cntxtFunc;
                    x.cntxtArg =3D md->cntxtArg;
                    x.errno =3D 0;
                    x.depth =3D 0;

                    j =3D timeval_to_jiffies(&x.timeout);
                    if (j =3D=3D 0) {
                            if (md->iPtrLow !=3D md->iPtrHi) {
                                    while (md->iPtrLow !=3D md->iPtrHi =
&& x.depth < MALIBU_INTR_MAX) {
                                            x.data[x.depth++] =3D =
md->iQueue[md->iPtrHi % MALIBU_INTR_MAX];
                                            md->iPtrHi++;
                                    }
                            }
                            else {
                                    x.errno =3D ENODATA;
                            }
                    }
                    else {
                            ret =3D =
wait_event_interruptible_timeout(md->intrWait, md->iPtrLow !=3D =
md->iPtrHi, j);
                            if (ret =3D=3D 0) x.errno =3D ETIME;
                            else if (ret =3D=3D -ERESTARTSYS) x.errno =
=3D ERESTARTSYS;
                            else {
                                    while (md->iPtrLow !=3D md->iPtrHi =
&& x.depth < MALIBU_INTR_MAX) {
                                            x.data[x.depth++] =3D =
md->iQueue[md->iPtrHi % MALIBU_INTR_MAX];
                                            md->iPtrHi++;
                                    }
                                    jiffies_to_timeval(ret, &x.timeout);
                            }
                    }
                    if (copy_to_user((void __user*)arg, &x, =
(caddr_t)&x.data[x.depth] - (caddr_t)&x)) return -EFAULT;
                    return 0;
            }
            case MALIBU_SET_ISR_CTRL: {
                    MalibuDrv_IntCtrl	x;

                    //TODO: if (!(filep->f_mode & FMODE_WRITE)) return =
-EACCES;
                    if (copy_from_user(&x, (const void __user*)arg, =
sizeof(x))) return -EFAULT;
                    md->intrMask =3D x.mask;
                    md->intrWriteback =3D x.type;
                    if (x.bar > MALIBU_BAR_MAX) {
                            MY_ERR("");
                            return -EINVAL;
                    }
                    if (x.byteOffset > md->bars[x.bar].size) {
                            MY_ERR("");
                            return -EINVAL;
                    }
                    md->intrStatusAddr =3D md->bars[x.bar].kAddr + =
x.byteOffset;
                    md->cntxtFunc =3D x.cntxtFunc;
                    md->cntxtArg =3D x.cntxtArg;
                    return 0;
            }
            case MALIBU_SET_SIG:
                    //TODO: if (!(filep->f_mode & FMODE_WRITE)) return =
-EACCES;
                    md->mySig =3D arg;
                    return 0;
            case MALIBU_FAKE_SIG: {
                    MalibuDrv_FakeISR	x;

                    if (copy_from_user(&x, (const void __user*)arg, =
sizeof(x))) return -EFAULT;
                    if ((md->iPtrLow - md->iPtrHi) < =
MALIBU_INTR_MAX-x.depth-1) {
                            int	i;

                            for (i =3D 0; i < x.depth; i++) {
                                    md->iQueue[md->iPtrLow % =
MALIBU_INTR_MAX] =3D x.data[i];
                                    md->iPtrLow++;
                            }
                            wake_up_interruptible(&md->intrWait);
                            if (md->async_queue) =
kill_fasync(&md->async_queue, md->mySig, POLL_IN);
                    }
                    return 0;
            }
            default:
                    return -EINVAL;
    }
}

//static irqreturn_t board_handler(unsigned int irq, void *dev_id, =
struct pt_regs *regs)
static int malibu_intr_handler(rtdm_irq_t * irq_context)
{
#if 0
    uint32_t	rd;
    MyData*		md =3D (MyData*) dev_id;

    if(md->pdev->irq !=3D irq) return IRQ_NONE;

    rd =3D ioread32(md->intrStatusAddr);

    if ((rd & md->intrMask) =3D=3D 0) return IRQ_NONE;

    if ((md->iPtrLow - md->iPtrHi) < MALIBU_INTR_MAX-1) {
            md->iQueue[md->iPtrLow % MALIBU_INTR_MAX] =3D rd;
            md->iPtrLow++;
            wake_up_interruptible(&md->intrWait);
            if (md->async_queue && md->mySig) =
kill_fasync(&md->async_queue, md->mySig, POLL_IN);
    }
    if (md->intrWriteback) iowrite32(rd, md->intrStatusAddr);
#endif

    return IRQ_HANDLED;
}

static void vma_open(struct vm_area_struct* vma) { }
static void vma_close(struct vm_area_struct* vma) { }

static struct vm_operations_struct remap_vm_ops =3D {
    .open =3D vma_open,
    .close =3D vma_close,
};

static int mmap(struct file *filep, struct vm_area_struct *vma)
{
    MyData*		md =3D (MyData*) filep->private_data;
    unsigned long	off =3D vma->vm_pgoff << PAGE_SHIFT;
    unsigned long	vsize =3D vma->vm_end - vma->vm_start;
    unsigned long	seg =3D off / MALIBU_MMAP_SIZE;
    unsigned long	seg_off =3D off % MALIBU_MMAP_SIZE;
    unsigned long	psize, pfn;

    if (seg >=3D 0 && seg < MALIBU_BAR_MAX) {
            if (md->bars[seg].size =3D=3D 0) return -EINVAL;
            pfn =3D (md->bars[seg].start + seg_off) >> PAGE_SHIFT;
            psize =3D md->bars[seg].size - seg_off;
    }
    else if (seg >=3D MALIBU_BAR_MAX && seg < MALIBU_BAR_MAX + =
MALIBU_BUF_MAX) {
            seg -=3D MALIBU_BAR_MAX;
            if (md->bufs[seg].size =3D=3D 0) return -EINVAL;
            pfn =3D __pa(md->bufs[seg].kAddr + seg_off) >> PAGE_SHIFT;
            psize =3D md->bufs[seg].size - seg_off;
    }
    else return -EINVAL;

    if (vsize > psize) return -EINVAL;
    if (remap_pfn_range(vma, vma->vm_start, pfn, vsize, =
vma->vm_page_prot)) return -EAGAIN;

    vma->vm_ops =3D &remap_vm_ops;
    vma_open(vma);
    return 0;
}

static int fasync(int fd, struct file *filep, int mode)
{
    MyData*		md =3D (MyData*) filep->private_data;
    return fasync_helper(fd, filep, mode, &md->async_queue);
}

static struct file_operations myFileOps =3D {
    .owner   	=3D THIS_MODULE,
    .open    	=3D malibu_rtdm_open,
    .release 	=3D release,
    .ioctl	=3D malibu_rtdm_ioctl,
    .mmap	=3D mmap,
    .fasync	=3D fasync,
};



static ssize_t showDevInfo(struct device *dev, struct device_attribute* =
attr, char *buf)
{
    MyData* md =3D (MyData*)dev->driver_data;
    return snprintf(buf, PAGE_SIZE,
            "vendor=3D0x%x\n"
            "device=3D0x%x\n"
            "subsystem_vendor=3D0x%x\n"
            "subsystem_device=3D0x%x\n"
            "revision=3D0x%x\n"
            "bus=3D0x%x\n"
            "slot=3D0x%x\n"
            "func=3D0x%x\n"
            "numBars=3D%d\n",
            md->pdev->vendor,
            md->pdev->device,
            md->pdev->subsystem_vendor,
            md->pdev->subsystem_device,
            md->pdev->revision,
            md->pdev->bus->number,
            PCI_SLOT(md->pdev->devfn),
            PCI_FUNC(md->pdev->devfn),
            md->numBars);
}
static DEVICE_ATTR(devInfo, 0444, showDevInfo, NULL);


/**
* This structure describe the malibu RTDM device
*
*/
static struct rtdm_device malibu_rtdm_device =3D {
    .struct_version =3D RTDM_DEVICE_STRUCT_VER,

    .device_flags =3D RTDM_NAMED_DEVICE,
    .context_size =3D sizeof(MyData),
    .device_name =3D DRV_NAME,

    .open_rt =3D  malibu_rtdm_open,
    .open_nrt =3D malibu_rtdm_open,

    .ops =3D {
            .close_rt =3D malibu_rtdm_close,
            .close_nrt =3D malibu_rtdm_close,
            .ioctl_rt =3D  malibu_rtdm_ioctl,
            .ioctl_nrt =3D malibu_rtdm_ioctl,
            //.read_nrt =3D NULL,
            //.write_nrt =3D NULL,
    },


    .device_class =3D RTDM_CLASS_EXPERIMENTAL,
    .device_sub_class =3D SOME_SUB_CLASS,
    .profile_version =3D 1,
    .driver_name =3D DRV_NAME,
    .driver_version =3D RTDM_DRIVER_VER(0, 1, 0),
    .peripheral_name =3D "Malibu RT driver",
    .provider_name =3D "Innovative Integration",
    .proc_name =3D DRV_NAME,
};

static int allocEachDev(struct pci_dev *pdev, const struct pci_device_id =
*id)
{
    struct rtdm_device  *rtdm_dev;
    int    ret_val =3D 0;
    MyData *md, *lPtr;
    int	i, bCntr, error, b;

    MY_PRINT("start");

    if(id->vendor !=3D VENDOR_ID) {
            MY_ERR("");
            return -ENODEV;
    }

    md =3D (MyData*) kzalloc(sizeof(MyData), GFP_KERNEL);

    md->pdev =3D pdev;

    sprintf(msgbuf, "pdev->irq=3D%d", pdev->irq);
    MY_PRINT(msgbuf);

    if (pci_enable_device(pdev)) {
            MY_ERR("");
            kfree(md);
            return -ENODEV;
    }

    pci_set_master(pdev);

    b =3D 0;
    for (i =3D 0; i < MALIBU_BAR_MAX; i++) {
            md->bars[b].start	=3D pci_resource_start(pdev, i);
            md->bars[b].end	=3D pci_resource_end(pdev, i);
            md->bars[b].size	=3D pci_resource_len(pdev, i);
            printk(KERN_ERR "bar=3D%d start=3D%llx end=3D%llx =
len=3D%llx\n", i,
                    md->bars[b].start,
                    md->bars[b].end,
                    md->bars[b].size);
            if (md->bars[b].size =3D=3D 0) continue;
            md->bars[b].kAddr	=3D (void*) ioremap(md->bars[i].start, =
md->bars[i].end - md->bars[i].start);
            b++;
    }
    md->numBars =3D i;

    init_waitqueue_head(&md->intrWait);

    cdev_init(&md->cdev, &myFileOps);
    md->cdev.owner =3D THIS_MODULE;
    md->myDevT =3D MKDEV(MAJOR(baseDevT), MINOR(baseDevT)+devCnt);
    if (cdev_add(&md->cdev, md->myDevT, 1)) {
            MY_ERR("");
            pci_disable_device(md->pdev);
            kfree(md);
            return -ENODEV;
    }

    bCntr =3D 0;
    list_for_each_entry(lPtr, &devList, list) {
            if (lPtr->pdev->device =3D=3D pdev->device) bCntr++;
    }

    md->sysdev =3D device_create(devClass, &md->pdev->dev, md->myDevT, =
NULL, "malibu%04x_%d", pdev->device, bCntr);
    if (IS_ERR(md->sysdev)) {
            MY_ERR("");
            cdev_del(&md->cdev);
            pci_disable_device(md->pdev);
            kfree(md);
            return -ENODEV;
    }
    md->sysdev->driver_data =3D (void*)md;

    error =3D device_create_file(md->sysdev, &dev_attr_devInfo);
    if (error) {
            MY_ERR("");
            device_destroy(devClass, md->myDevT);
            cdev_del(&md->cdev);
            for (i =3D 0; i < MALIBU_BAR_MAX; i++) {
                    if (md->bars[i].size) {
                            iounmap(md->bars[i].kAddr);
                            md->bars[i].size =3D 0;
                    }
            }
            pci_disable_device(md->pdev);
            kfree(md);
            return error;
    }

    md->dev_id =3D devCnt;


    //alloc mem for rtdm structure
    rtdm_dev =3D kmalloc(sizeof(struct rtdm_device), GFP_KERNEL);
    if(!rtdm_dev){
      MY_ERR("rtdm_device kmalloc failed\n");
      ret_val =3D -ENOMEM; //Insufficient storage space is available.
      return ret_val;
    }

    //copy the structure to the new memory
    memcpy(rtdm_dev, &malibu_rtdm_device, sizeof(struct rtdm_device));

    //create filename
    snprintf(rtdm_dev->device_name,
             RTDM_MAX_DEVNAME_LEN, "malibu_%d", devCnt);

    rtdm_dev->device_id =3D devCnt;

    //define two other members of the rtdm_device structure
    rtdm_dev->proc_name =3D rtdm_dev->device_name;

    ret_val =3D rtdm_dev_register(rtdm_dev);

    if(ret_val < 0){
      MY_ERR("failed to register device with RTDM\n");
      ret_val =3D -ENODEV;
      return ret_val;
    }

    md->xen_rtdm_device =3D rtdm_dev;

    list_add_tail(&md->list, &devList);

    //always do this last
    devCnt++;

    MY_PRINT("end OK");
    return 0;
}

static void removeAllDev(struct pci_dev *pdev)
{
    MyData *md, *tmp;

    MY_PRINT("start");

    list_for_each_entry_safe(md, tmp, &devList, list)
    {
        if (md =3D=3D NULL)
        {
            MY_PRINT("md is NULL");
            return;
        }

        int	i;

        list_del(&md->list);


        device_remove_file(md->sysdev, &dev_attr_devInfo);
        device_destroy(devClass, md->myDevT);
        cdev_del(&md->cdev);

        for (i =3D 0; i < MALIBU_BUF_MAX; i++) freeBuffer(md, i);

        for (i =3D 0; i < MALIBU_BAR_MAX; i++) {
            if (md->bars[i].size) {
                iounmap(md->bars[i].kAddr);
                md->bars[i].size =3D 0;
            }
        }

        pci_disable_device(md->pdev);

        //remove char device from the system
        //unregister RTdriver
        rtdm_dev_unregister(md->xen_rtdm_device, 1000);

        kfree(md->xen_rtdm_device);
        kfree(md);

        devCnt--;
}

    MY_PRINT("end");
}
#endif

static struct pci_device_id ids[] =3D {
    { PCI_DEVICE(VENDOR_ID, PCI_ANY_ID) },
    { 0 },
};

static struct pci_driver pci_driver =3D {
    .name	=3D DRV_NAME,
    .id_table	=3D ids,
    .probe	=3D allocEachDev,
    .remove	=3D removeAllDev,
};


//MODULE_DEVICE_TABLE(pci, ids);

static ssize_t showDevCount(struct class *cls, char *buf)
{
    return sprintf(buf, "%d\n", devCnt);
}

static CLASS_ATTR(devCount, 0444, showDevCount, NULL);

/**
* This function is called when the module is loaded
*
* It simply registers the RTDM device.
*
*/
static int __init mod_init(void)
{
    int 	error;

    MY_PRINT("initializing MalibuDrv_RT module");

    devClass =3D class_create(THIS_MODULE, DRV_NAME);
    if (IS_ERR(devClass)) {
            MY_ERR("");
            return PTR_ERR(devClass);
    }

    error =3D class_create_file(devClass, &class_attr_devCount);
    if (error) {
            MY_ERR("");
            class_destroy(devClass);
            return error;
    }

    error =3D alloc_chrdev_region(&baseDevT, 0, MALIBU_MAX_DEVS, =
DRV_NAME);
    if (error) {
            MY_ERR("");
            class_remove_file(devClass, &class_attr_devCount);
            class_destroy(devClass);
            return error;
    }

    error =3D pci_register_driver(&pci_driver);
    if (error) {
        MY_ERR("");
        unregister_chrdev_region(baseDevT, MALIBU_MAX_DEVS);
        class_remove_file(devClass, &class_attr_devCount);
        class_destroy(devClass);
        return error;
    }

    return error;
}

/**
* This function is called when the module is unloaded
*
* It unregister the RTDM device, polling at 1000 ms for pending users.
*
*/
static void __exit mod_exit(void)
{
    MY_PRINT("unregistering MalibuDrv_RT module");

    pci_unregister_driver(&pci_driver);
    unregister_chrdev_region(baseDevT, MALIBU_MAX_DEVS);
    class_remove_file(devClass, &class_attr_devCount);
    class_destroy(devClass);
}


module_init(mod_init);
module_exit(mod_exit);
MODULE_LICENSE("GPL");

------=_NextPart_000_004E_01CBB3FA.5C6A5720--


