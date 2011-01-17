From: "Peter Hua" <Phua@domain.hid>
Date: Mon, 17 Jan 2011 08:59:08 -0800
Message-ID: <007901cbb667$db66b860$92342920$@innovative-dsp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_007A_01CBB624.CD4414A0"
Content-Language: en-us
Subject: [Xenomai-help] Xenomai mmap
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

------=_NextPart_000_007A_01CBB624.CD4414A0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_007B_01CBB624.CD4414A0"


------=_NextPart_001_007B_01CBB624.CD4414A0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Is there any example code to map PCI registers into user space?  I am having
problem getting functions rtdm_iomap_to_user and mmap to compile.   My code
is attached.  

 

Xenomai - 2.4.10

Kernel - 2.6.29.1

OS - Red Hat 5.5

 

 

Thanks in advance,

Peter Hua

 


------=_NextPart_001_007B_01CBB624.CD4414A0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 14 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri","sans-serif";}
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
vlink=3Dpurple><div class=3DWordSection1><p class=3DMsoPlainText>Is =
there any example code to map PCI registers into user space?&nbsp; I am =
having problem getting functions rtdm_iomap_to_user and mmap to compile. =
&nbsp;&nbsp;My code is attached.&nbsp; <o:p></o:p></p><p =
class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p =
class=3DMsoPlainText>Xenomai &#8211; 2.4.10<o:p></o:p></p><p =
class=3DMsoPlainText>Kernel &#8211; 2.6.29.1<o:p></o:p></p><p =
class=3DMsoPlainText>OS &#8211; Red Hat 5.5<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Thanks in =
advance,<o:p></o:p></p><p class=3DMsoNormal>Peter Hua<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
------=_NextPart_001_007B_01CBB624.CD4414A0--

------=_NextPart_000_007A_01CBB624.CD4414A0
Content-Type: text/plain;
	name="malibu.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="malibu.c"

/**=0A=
* This a driver written to interface with DSP boards from Innovative =
Integration=0A=
* It utilizes the RTDM device APIs from the Xenomai realtime Linux =
project.=0A=
*=0A=
*/=0A=
=0A=
#include <linux/version.h>=0A=
#include <linux/kernel.h>=0A=
#include <linux/module.h>=0A=
#include <linux/init.h>=0A=
#include <linux/pci.h>=0A=
#include <linux/interrupt.h>=0A=
#include <linux/delay.h>=0A=
#include <linux/workqueue.h>=0A=
#include <linux/reboot.h>=0A=
#include <linux/slab.h>=0A=
#include <linux/cdev.h>=0A=
#include <linux/spinlock.h>=0A=
#include <linux/pagemap.h>=0A=
#include <linux/semaphore.h>=0A=
#include <linux/list.h>=0A=
#include <linux/vmalloc.h>=0A=
#include <linux/mman.h>=0A=
#include <asm/uaccess.h>=0A=
#include <asm/dma.h>=0A=
#include <asm/delay.h>=0A=
#include <asm/io.h>=0A=
#include <asm/msr.h>=0A=
#include <asm/page.h>=0A=
#include <linux/mman.h>=0A=
=0A=
#include <asm-generic/system.h>=0A=
#include <rtdm/rtdm_driver.h>=0A=
=0A=
=0A=
#include "malibu.h"=0A=
=0A=
#define VENDOR_ID		0x1303=0A=
#define	DRV_NAME		"malibu"=0A=
#define SIZE_MAX		1024=0A=
#define SOME_SUB_CLASS		1303=0A=
=0A=
=0A=
static void errMsg(int line, const char *place, const char *msg)=0A=
{=0A=
    rtdm_printk(KERN_ALERT "malibu: Error at %s() line: %d, %s\n", =
place, line, msg);=0A=
}=0A=
=0A=
#define	MY_ERR(s)	errMsg(__LINE__, __FUNCTION__, s)=0A=
=0A=
static void logMsg(int line, const char *place, const char *msg)=0A=
{=0A=
    rtdm_printk(KERN_INFO "MalibuDrv_RT: %s() line: %d, %s\n", place, =
line, msg);=0A=
}=0A=
=0A=
#define	MY_PRINT(s)	logMsg(__LINE__, __FUNCTION__, s);=0A=
=0A=
typedef struct {=0A=
    void*	kAddr;=0A=
    uint64_t	start;=0A=
    uint64_t	end;=0A=
    uint64_t	size;=0A=
} MyBar;=0A=
=0A=
typedef struct {=0A=
    void*	kAddr;=0A=
    dma_addr_t	physAddr;=0A=
    uint32_t	size;=0A=
} MyBuf;=0A=
=0A=
typedef struct {=0A=
    struct list_head	list;=0A=
    struct cdev		cdev;=0A=
    struct device	*sysdev;=0A=
    struct pci_dev	*pdev;=0A=
    dev_t		myDevT;=0A=
=0A=
    MyBar		bars[MALIBU_BAR_MAX];=0A=
    MyBuf		bufs[MALIBU_BUF_MAX];  //DMA buffers=0A=
=0A=
    wait_queue_head_t	intrWait;=0A=
    struct fasync_struct* async_queue;=0A=
    int			mySig;=0A=
    void*		intrStatusAddr;=0A=
    u32			intrMask;=0A=
    u8			intrWriteback;=0A=
    u32			iQueue[MALIBU_INTR_MAX];=0A=
    u32			iPtrLow;=0A=
    u32			iPtrHi;=0A=
    void		(*cntxtFunc)(void*);=0A=
    void		*cntxtArg;=0A=
=0A=
    u16			devOpen;=0A=
    u8			wrOpen;=0A=
    u8			numBars;=0A=
    u8			isIrqEnabled;=0A=
    int                 dev_id;=0A=
    struct rtdm_device *xen_rtdm_device;=0A=
    rtdm_irq_t         irq_handle;  /* device IRQ handle */=0A=
} MyData;=0A=
=0A=
=0A=
=0A=
static struct class*	devClass;=0A=
static dev_t 		baseDevT;=0A=
=0A=
static int	devCnt =3D 0;=0A=
LIST_HEAD(devList);=0A=
=0A=
static int fasync(int fd, struct file *filep, int mode);=0A=
static int malibu_intr_handler(rtdm_irq_t * irq_context);=0A=
=0A=
static char msgbuf[1000];=0A=
=0A=
int MyMmap(struct file *filep, struct vm_area_struct *vma);=0A=
=0A=
static struct file_operations myFileOps =3D {=0A=
    .owner   	=3D THIS_MODULE,=0A=
    //.release 	=3D release,=0A=
    .mmap	=3D MyMmap,=0A=
    //.fasync	=3D fasync,=0A=
};=0A=
=0A=
static int malibu_rtdm_open(struct rtdm_dev_context *context,=0A=
                        rtdm_user_info_t * user_info, int oflags)=0A=
//static int open(struct inode *inodep, struct file *filep)=0A=
{=0A=
    MyData *md, *ctx;=0A=
    bool found=3Dfalse;=0A=
    int err=3D0;=0A=
    unsigned long vaddr;=0A=
=0A=
    MY_PRINT("start");=0A=
    ctx =3D (MyData *)context->dev_private;=0A=
=0A=
    list_for_each_entry(md, &devList, list) {=0A=
         if (md->dev_id =3D=3D context->device->device_id)=0A=
         {=0A=
                found =3D true;=0A=
                MY_PRINT("device FOUND");=0A=
=0A=
                sprintf (msgbuf, "md=3D%p, md->device_id=3D%d", md, =
md->dev_id);=0A=
                MY_PRINT(msgbuf);=0A=
=0A=
                memcpy(ctx, md, sizeof(MyData));=0A=
=0A=
                break;=0A=
         }=0A=
    }=0A=
=0A=
    if(!found)=0A=
    {=0A=
        MY_ERR("no matching device");=0A=
        return -ENODEV;=0A=
    }=0A=
=0A=
=0A=
    if (ctx->wrOpen && (oflags & FMODE_WRITE)) {=0A=
            MY_ERR("device already opened");=0A=
            return -EBUSY;=0A=
    }=0A=
=0A=
#if 0=0A=
    /* mark pages reserved so that remap_pfn_range works */=0A=
    int b;=0A=
    for(b=3D0;b<MALIBU_BAR_MAX;b++)=0A=
    {=0A=
        if (ctx->bars[b].kAddr =3D=3D NULL)=0A=
            break;=0A=
=0A=
        for (vaddr =3D (unsigned long)ctx->bars[b].kAddr;=0A=
             vaddr < (unsigned long)ctx->bars[b].kAddr + =
ctx->bars[b].size;=0A=
             vaddr +=3D PAGE_SIZE)=0A=
            SetPageReserved(virt_to_page(vaddr));=0A=
    }=0A=
=0A=
    sprintf(msgbuf, "reserved, b=3D%d", b);=0A=
    MY_PRINT(msgbuf);=0A=
#endif=0A=
=0A=
    if (oflags & FMODE_WRITE)=0A=
    {=0A=
        ctx->iPtrLow =3D 0;=0A=
        ctx->iPtrHi =3D 0;=0A=
        ctx->mySig =3D SIGIO;=0A=
        ctx->cntxtFunc =3D 0;=0A=
        ctx->cntxtArg =3D 0;=0A=
=0A=
        static unsigned long irqtype =3D (RTDM_IRQTYPE_SHARED | =
RTDM_IRQTYPE_EDGE);=0A=
=0A=
        sprintf(msgbuf, "irqtype=3D%d", irqtype);=0A=
        MY_PRINT(msgbuf);=0A=
=0A=
        err =3D rtdm_irq_request(&ctx->irq_handle, ctx->pdev->irq,=0A=
                               (rtdm_irq_handler_t)malibu_intr_handler,=0A=
                               irqtype,=0A=
                               context->device->proc_name,  (void *)ctx);=0A=
=0A=
        if(err !=3D 0)=0A=
        {=0A=
            sprintf(msgbuf, "rtdm_irq_request() failed, err=3D%d, =
irq=3D%d, proc_name=3D%s",=0A=
                    err, ctx->pdev->irq, context->device->proc_name);=0A=
            MY_ERR(msgbuf);=0A=
            return err;=0A=
        }=0A=
=0A=
        sprintf(msgbuf, "rtdm_irq_request() OK, irq=3D%d", =
ctx->irq_handle);=0A=
        MY_PRINT(msgbuf);=0A=
=0A=
        ctx->wrOpen =3D 1;=0A=
    }=0A=
=0A=
    ctx->devOpen++;=0A=
=0A=
    MY_PRINT("end OK");=0A=
    return 0;=0A=
}=0A=
=0A=
/**=0A=
* Close the device=0A=
*=0A=
* This function is called when the device shall be closed.=0A=
*=0A=
*/=0A=
static int malibu_rtdm_close(struct rtdm_dev_context *context,=0A=
                            rtdm_user_info_t * user_info)=0A=
{=0A=
    MyData *ctx =3D context->dev_private;=0A=
=0A=
    rtdm_irq_free(&ctx->irq_handle);=0A=
=0A=
    MY_PRINT("closing device");=0A=
    return 0;=0A=
}=0A=
=0A=
static void freeBuffer(MyData* md, int n)=0A=
{=0A=
    MyBuf* b =3D &md->bufs[n];=0A=
    if (b->size =3D=3D 0) return;=0A=
    dma_free_coherent(&md->pdev->dev, b->size, b->kAddr, b->physAddr);=0A=
    b->size =3D 0;=0A=
}=0A=
=0A=
static int release(struct inode *inode, struct file *filep)=0A=
{=0A=
    int		i;=0A=
    MyData*		md =3D (MyData*) filep->private_data;=0A=
=0A=
    md->devOpen--;=0A=
=0A=
    if (filep->f_mode & FMODE_WRITE) {=0A=
            md->wrOpen =3D 0;=0A=
            //free_irq(md->pdev->irq, md);=0A=
            rtdm_irq_free(&md->irq_handle);=0A=
=0A=
            for (i =3D 0; i < MALIBU_BUF_MAX; i++) freeBuffer(md, i);=0A=
            fasync(-1, filep, 0);=0A=
    }=0A=
=0A=
    return 0;=0A=
}=0A=
=0A=
/* --- Mmap functions --- */=0A=
=0A=
void malibu_map(struct vm_area_struct *area)=0A=
{=0A=
        //unsigned long *status =3D (unsigned long =
*)area->vm_private_data;=0A=
        //set_bit(MALIBU_BUF_MAP_NR, status);=0A=
}=0A=
=0A=
void malibu_unmap(struct vm_area_struct *area)=0A=
{=0A=
        //unsigned long *status =3D (unsigned long =
*)area->vm_private_data;=0A=
        //clear_bit(MALIBU_BUF_MAP_NR, status);=0A=
}=0A=
=0A=
static struct vm_operations_struct malibu_vm_ops =3D {=0A=
        .open =3D malibu_map,=0A=
        .close =3D malibu_unmap,=0A=
};=0A=
=0A=
static struct vm_area_struct vma;=0A=
=0A=
void * malibu_ioctl_mmap(rtdm_user_info_t *user_info,=0A=
                      MyData *cxt, MalibuDrv_MmapArg *arg)=0A=
{=0A=
        //malibu_mmap_t map_cfg;=0A=
        //malibu_dev_t *dev;=0A=
        //malibu_buf_t *buf;=0A=
        int ret=3D0;=0A=
        void *usrAddr;=0A=
=0A=
        MY_PRINT("start");=0A=
        /* Basic checkings */=0A=
#if 0=0A=
        /* The mmap operation cannot be performed in a=0A=
           real-time context */=0A=
        if (rtdm_in_rt_context()) {=0A=
            MY_ERR("in real-time context");=0A=
            return -ENOSYS;=0A=
        }=0A=
=0A=
       // dev =3D malibu_get_dev(cxt);=0A=
       // buf =3D cxt->buffer;=0A=
=0A=
=0A=
        if (!test_bit(malibu_DEV_ATTACHED_NR, &dev->flags)) {=0A=
                __malibu_err("malibu_ioctl_mmap: cannot mmap on "=0A=
                          "an unattached device\n");=0A=
                return -EINVAL;=0A=
        }=0A=
=0A=
        if (test_bit(malibu_BUF_MAP_NR, &buf->flags)) {=0A=
                __malibu_err("malibu_ioctl_mmap: buffer already =
mapped\n");=0A=
                return -EBUSY;=0A=
        }=0A=
=0A=
        if (rtdm_safe_copy_from_user(cxt->user_info,=0A=
                                     &map_cfg, arg, =
sizeof(malibu_mmap_t)) !=3D 0)=0A=
                return -EFAULT;=0A=
=0A=
=0A=
=0A=
        /* Check the size to be mapped */=0A=
        if (arg->size > cxt->bars[arg->barnum].size)=0A=
        {=0A=
            MY_ERR("bar size exceeded");=0A=
            return -EFAULT;=0A=
        }=0A=
#endif=0A=
=0A=
        /* All the magic is here */=0A=
        sprintf(msgbuf, "kAddr=3D0x%p, size=3D%d", =
cxt->bars[arg->barnum].kAddr, arg->size);=0A=
        MY_PRINT(msgbuf);=0A=
=0A=
=0A=
=0A=
        //arg->size +=3D (PAGE_SIZE - (arg->size % PAGE_SIZE));=0A=
=0A=
        struct file *filp;=0A=
        struct file_operations *old_fops;=0A=
        void *old_priv_data;=0A=
        void *user_addr;=0A=
=0A=
        filp =3D filp_open("/dev/zero", O_RDWR, 0);=0A=
        if (IS_ERR(filp)) {=0A=
            printk("open failed\n");=0A=
            return filp;=0A=
        }=0A=
=0A=
        old_fops =3D filp->f_op;=0A=
        filp->f_op =3D &myFileOps;=0A=
=0A=
        old_priv_data =3D filp->private_data;=0A=
        filp->private_data =3D cxt;=0A=
=0A=
        //down_write(&current->mm->mmap_sem);=0A=
        usrAddr =3D (void *)mmap(=0A=
                0,=0A=
                (size_t)arg->size,=0A=
                (PROT_READ|PROT_WRITE),=0A=
                MAP_SHARED,=0A=
                filp, 0);=0A=
        //up_write(&current->mm->mmap_sem);=0A=
=0A=
        filp->f_op =3D old_fops;=0A=
        filp->private_data =3D old_priv_data;=0A=
=0A=
        filp_close(filp, current->files);=0A=
=0A=
#if 0=0A=
        ret =3D rtdm_iomap_to_user(user_info,=0A=
                                cxt->bars[arg->barnum].kAddr,=0A=
                                arg->size,=0A=
                                PROT_READ | PROT_WRITE,=0A=
                                &usrAddr,   //&arg->userAddr,=0A=
                                &malibu_vm_ops,=0A=
                                NULL);=0A=
=0A=
#endif=0A=
=0A=
        if (ret < 0) {=0A=
            sprintf(msgbuf, "malibu_ioctl_mmap: internal error, "=0A=
                    "rtdm_mmap_to_user failed (err=3D%d)\n", ret);=0A=
            MY_ERR(msgbuf);=0A=
        }=0A=
=0A=
        sprintf(msgbuf, "usrAddr=3D%p", usrAddr);=0A=
        MY_PRINT(msgbuf);=0A=
=0A=
        //rtdm_safe_copy_to_user(cxt->user_info,=0A=
        //                       &arg->UsrAdr, &usrAddr, sizeof(unsigned =
int));=0A=
=0A=
        MY_PRINT("end");=0A=
        return usrAddr;=0A=
=0A=
=0A=
}=0A=
=0A=
=0A=
//static int ioctl(struct inode *inodep, struct file *filep, unsigned =
int cmd, unsigned long arg)=0A=
int malibu_rtdm_ioctl(struct rtdm_dev_context   *context,=0A=
                      rtdm_user_info_t          *user_info,=0A=
                      int                       cmd,=0A=
                      void                      *arg)=0A=
{=0A=
    MyData* md =3D (MyData *)context->dev_private;=0A=
    void *addr;=0A=
    int err;=0A=
    int retval =3D 0;=0A=
    ioc_param_struct param =3D {0,0};=0A=
=0A=
    if (_IOC_TYPE(cmd) !=3D MALIBU_IOC_MAGIC) return -ENOTTY;=0A=
=0A=
    /*=0A=
    * the direction is a bitmask, and VERIFY_WRITE catches R/W=0A=
    * transfers. `Type' is user-oriented, while=0A=
    * access_ok is kernel-oriented, so the concept of "read" and=0A=
    * "write" is reversed (i.e. when an user wants to read data,=0A=
    * the kernel has to write them into the user space)=0A=
    *=0A=
    * always check the user space address before accessing it=0A=
    *=0A=
    * access_ok returns 0 for failure!=0A=
    */=0A=
    if (_IOC_DIR(cmd) & _IOC_READ)=0A=
      err =3D !rtdm_read_user_ok(user_info, arg, =
sizeof(ioc_param_struct));=0A=
    else if (_IOC_DIR(cmd) & _IOC_WRITE)=0A=
      err =3D !rtdm_rw_user_ok(user_info, arg, sizeof(ioc_param_struct));=0A=
    if (err) return -EFAULT;=0A=
=0A=
    switch(cmd) {=0A=
            case MALIBU_MMAP_BLOCK: {=0A=
                    void * usrAddr;=0A=
                    MalibuDrv_MmapArg *mArg =3D (MalibuDrv_MmapArg *)arg;=0A=
                    rtdm_iomap_to_user(user_info,=0A=
                                        mArg->kernAddr,=0A=
                                        mArg->size,=0A=
                                        PROT_READ | PROT_WRITE,=0A=
                                        &usrAddr,   //&arg->userAddr,=0A=
                                        &malibu_vm_ops,=0A=
                                        NULL);=0A=
=0A=
                    mArg->userAddr =3D usrAddr;=0A=
=0A=
                    return (usrAddr);=0A=
=0A=
                    break;=0A=
                }=0A=
=0A=
            case MALIBU_MMAP_BAR: {=0A=
=0A=
                    addr =3D malibu_ioctl_mmap(user_info,=0A=
                                            md, arg);=0A=
=0A=
                    MalibuDrv_MmapArg *tmp =3D (MalibuDrv_MmapArg =
*)(arg);=0A=
                    tmp->userAddr =3D addr;=0A=
=0A=
                    sprintf(msgbuf, "addr=3D%p, addr=3D%d", =
tmp->userAddr, (int)addr);=0A=
                    MY_PRINT(msgbuf);=0A=
=0A=
                    return (int)addr;=0A=
                    break;=0A=
                }=0A=
=0A=
            case MALIBU_GET_INFO: {=0A=
                    MalibuDrv_INFO	x;=0A=
                    x.vendorId =3D md->pdev->vendor;=0A=
                    x.deviceId =3D md->pdev->device;=0A=
                    x.subVendorId =3D md->pdev->subsystem_vendor;=0A=
                    x.subDeviceId =3D md->pdev->subsystem_device;=0A=
                    x.revision =3D md->pdev->revision;=0A=
                    x.bus =3D md->pdev->bus->number;=0A=
                    x.slot =3D PCI_SLOT(md->pdev->devfn);=0A=
                    x.func =3D PCI_FUNC(md->pdev->devfn);=0A=
                    x.numBars =3D md->numBars;=0A=
=0A=
                    MY_PRINT("copying data to user");=0A=
=0A=
                    sprintf(msgbuf, "x.vendorId=3D0x%x, =
x.deviceId=3D0x%x, x.numBars=3D%d",=0A=
                            md->pdev->vendor, md->pdev->device, =
x.numBars);=0A=
                    MY_PRINT(msgbuf);=0A=
=0A=
                    if (user_info)=0A=
                            err =3D rtdm_safe_copy_to_user(user_info, =
arg,=0A=
                                                       &x, sizeof(x));=0A=
                    else=0A=
                            memcpy(arg, &x, sizeof(MalibuDrv_INFO));=0A=
                    break;=0A=
=0A=
                    return err;=0A=
            }=0A=
=0A=
            case MALIBU_GET_BAR_SIZE:=0A=
                    if (*(int *)arg < 0 || *(int *)arg >=3D =
MALIBU_BAR_MAX) return -EINVAL;=0A=
=0A=
                    sprintf(msgbuf, "arg=3D%p, *arg=3D%d", arg, *(int =
*)arg);=0A=
                    MY_PRINT(msgbuf);=0A=
=0A=
                    return md->bars[*(int *)arg].size;=0A=
=0A=
            case MALIBU_ALLOC_BUFFER: {=0A=
                    int			n;=0A=
                    MalibuDrv_Buffer	x;=0A=
                    MyBuf*		b;=0A=
=0A=
                    MY_PRINT("MALIBU_ALLOC_BUFFER start");=0A=
=0A=
                    //TODO: if (!(filep->f_mode & FMODE_WRITE)) return =
-EACCES;=0A=
=0A=
                    for (n =3D 0; n < MALIBU_BUF_MAX; n++) {=0A=
                            if (md->bufs[n].size =3D=3D 0) break;=0A=
                    }=0A=
=0A=
                    MY_PRINT("1");=0A=
=0A=
                    if (n =3D=3D MALIBU_BUF_MAX) {=0A=
                            MY_ERR("MALIBU_BUF_MAX");=0A=
                            return -ENOMEM;=0A=
                    }=0A=
=0A=
                    MY_PRINT("2");=0A=
=0A=
                    if (rtdm_safe_copy_from_user(user_info, &x, (const =
void __user*)arg, sizeof(x)))=0A=
                    {=0A=
                        MY_ERR("rtdm_safe_copy_from_user");=0A=
                        return -EFAULT;=0A=
                    }=0A=
=0A=
                    MY_PRINT("3");=0A=
=0A=
                    b =3D &md->bufs[n];=0A=
=0A=
                    b->size =3D ((x.size + PAGE_SIZE - 1) / PAGE_SIZE) * =
PAGE_SIZE;=0A=
                    b->kAddr =3D dma_alloc_coherent(&md->pdev->dev, =
b->size, &b->physAddr, GFP_KERNEL);=0A=
=0A=
                    MY_PRINT("4");=0A=
=0A=
                    if (b->kAddr =3D=3D 0) {=0A=
                            b->size =3D 0;=0A=
                            MY_ERR("b->kAddr =3D=3D 0");=0A=
                            return -ENOMEM;=0A=
                    }=0A=
=0A=
                    MY_PRINT("5");=0A=
=0A=
                    x.physAddr =3D b->physAddr;=0A=
                    x.bufNum =3D n;=0A=
                    x.fileOffset =3D (n + MALIBU_BAR_MAX) * =
MALIBU_MMAP_SIZE;=0A=
=0A=
                    sprintf(msgbuf, "x.pa=3D0x%p",x.physAddr);=0A=
                    MY_PRINT(msgbuf);=0A=
=0A=
                    if (user_info)=0A=
                            err =3D rtdm_safe_copy_to_user(user_info, =
arg,=0A=
                                                       &x, sizeof(x));=0A=
                    else=0A=
                            memcpy(arg, &x, sizeof(x));=0A=
                    break;=0A=
=0A=
                    MY_PRINT("7");=0A=
=0A=
                    if(err !=3D 0)=0A=
                    {=0A=
                        MY_ERR("rtdm_safe_copy_to_user");=0A=
                        freeBuffer(md, x.bufNum);=0A=
                        return err;=0A=
                    }=0A=
=0A=
                    MY_PRINT("8");=0A=
=0A=
                    ((uint32_t*)b->kAddr)[0] =3D 0x12345678;=0A=
                    ((uint32_t*)b->kAddr)[1] =3D n;=0A=
                    ((uint32_t*)b->kAddr)[2] =3D md->myDevT;=0A=
=0A=
                    MY_PRINT("MALIBU_ALLOC_BUFFER end OK");=0A=
                    return 0;=0A=
            }=0A=
=0A=
            case MALIBU_FREE_BUFFER: {=0A=
                    int			i;=0A=
                    MalibuDrv_Buffer	x;=0A=
=0A=
                    //TODO:if (!(filep->f_mode & FMODE_WRITE)) return =
-EACCES;=0A=
=0A=
                    if (rtdm_safe_copy_from_user(user_info, &x, (const =
void __user*)arg, sizeof(x))) return -EFAULT;=0A=
                    for (i =3D 0; i < MALIBU_BUF_MAX; i++) {=0A=
                            if (md->bufs[i].physAddr =3D=3D x.physAddr) {=0A=
                                    freeBuffer(md, i);=0A=
                                    break;=0A=
                            }=0A=
                    }=0A=
                    if (i =3D=3D MALIBU_BUF_MAX) {=0A=
                            MY_ERR("");=0A=
                            return -ENOMEM;=0A=
                    }=0A=
                    return 0;=0A=
            }=0A=
=0A=
            case MALIBU_ISR_ENABLE:=0A=
                    //TODO: if (!(filep->f_mode & FMODE_WRITE)) return =
-EACCES;=0A=
                    //enable_irq(md->pdev->irq);=0A=
                    rtdm_irq_enable(&md->irq_handle);=0A=
                    md->isIrqEnabled =3D 1;=0A=
                    return 0;=0A=
=0A=
            case MALIBU_ISR_DISABLE:=0A=
                    //TODO: if (!(filep->f_mode & FMODE_WRITE)) return =
-EACCES;=0A=
                    md->isIrqEnabled =3D 0;=0A=
                    //disable_irq(md->pdev->irq);=0A=
                    rtdm_irq_disable(&md->irq_handle);=0A=
                    return 0;=0A=
=0A=
            case MALIBU_GET_ISR_ENABLED:=0A=
                    return md->isIrqEnabled;=0A=
=0A=
            case MALIBU_GET_ISR_DEPTH:=0A=
                    return (md->iPtrLow - md->iPtrHi);=0A=
=0A=
            case MALIBU_ISR_CLEAR_ALL:=0A=
                    //TODO: if (!(filep->f_mode & FMODE_WRITE)) return =
-EACCES;=0A=
                    //disable_irq(md->pdev->irq);=0A=
                    rtdm_irq_disable(&md->irq_handle);=0A=
=0A=
                    md->iPtrLow =3D 0;=0A=
                    md->iPtrHi =3D 0;=0A=
                    //enable_irq(md->pdev->irq);=0A=
                    rtdm_irq_enable(&md->irq_handle);=0A=
                    return 0;	// no implemented yet=0A=
=0A=
            case MALIBU_DEQUEUE_ISR: {=0A=
                    MalibuDrv_DequeueISR	x;=0A=
                    unsigned long		j;=0A=
                    int			ret;=0A=
=0A=
                    //TODO: if (!(filep->f_mode & FMODE_WRITE)) return =
-EACCES;=0A=
                    if (rtdm_safe_copy_from_user(user_info, &x, (const =
void __user*)arg, (caddr_t)&x.depth - (caddr_t)&x)) return -EFAULT;=0A=
=0A=
                    x.depth =3D 0;=0A=
                    x.cntxtFunc =3D md->cntxtFunc;=0A=
                    x.cntxtArg =3D md->cntxtArg;=0A=
                    x.errno =3D 0;=0A=
                    x.depth =3D 0;=0A=
=0A=
                    j =3D timeval_to_jiffies(&x.timeout);=0A=
                    if (j =3D=3D 0) {=0A=
                            if (md->iPtrLow !=3D md->iPtrHi) {=0A=
                                    while (md->iPtrLow !=3D md->iPtrHi =
&& x.depth < MALIBU_INTR_MAX) {=0A=
                                            x.data[x.depth++] =3D =
md->iQueue[md->iPtrHi % MALIBU_INTR_MAX];=0A=
                                            md->iPtrHi++;=0A=
                                    }=0A=
                            }=0A=
                            else {=0A=
                                    x.errno =3D ENODATA;=0A=
                            }=0A=
                    }=0A=
                    else {=0A=
                            ret =3D =
wait_event_interruptible_timeout(md->intrWait, md->iPtrLow !=3D =
md->iPtrHi, j);=0A=
                            if (ret =3D=3D 0) x.errno =3D ETIME;=0A=
                            else if (ret =3D=3D -ERESTARTSYS) x.errno =
=3D ERESTARTSYS;=0A=
                            else {=0A=
                                    while (md->iPtrLow !=3D md->iPtrHi =
&& x.depth < MALIBU_INTR_MAX) {=0A=
                                            x.data[x.depth++] =3D =
md->iQueue[md->iPtrHi % MALIBU_INTR_MAX];=0A=
                                            md->iPtrHi++;=0A=
                                    }=0A=
                                    jiffies_to_timeval(ret, &x.timeout);=0A=
                            }=0A=
                    }=0A=
=0A=
                    if (user_info)=0A=
                            err =3D rtdm_safe_copy_to_user(user_info, =
arg,=0A=
                                                       &x, =
(caddr_t)&x.data[x.depth] - (caddr_t)&x);=0A=
                    else=0A=
                            memcpy(arg, &x, (caddr_t)&x.data[x.depth] - =
(caddr_t)&x);=0A=
                    break;=0A=
=0A=
                    return err;=0A=
            }=0A=
=0A=
            case MALIBU_SET_ISR_CTRL: {=0A=
                    MalibuDrv_IntCtrl	x;=0A=
=0A=
                    //TODO: if (!(filep->f_mode & FMODE_WRITE)) return =
-EACCES;=0A=
                    if (rtdm_safe_copy_from_user(user_info, &x, (const =
void __user*)arg, sizeof(x))) return -EFAULT;=0A=
                    md->intrMask =3D x.mask;=0A=
                    md->intrWriteback =3D x.type;=0A=
                    if (x.bar > MALIBU_BAR_MAX) {=0A=
                            MY_ERR("");=0A=
                            return -EINVAL;=0A=
                    }=0A=
                    if (x.byteOffset > md->bars[x.bar].size) {=0A=
                            MY_ERR("");=0A=
                            return -EINVAL;=0A=
                    }=0A=
                    md->intrStatusAddr =3D md->bars[x.bar].kAddr + =
x.byteOffset;=0A=
                    md->cntxtFunc =3D x.cntxtFunc;=0A=
                    md->cntxtArg =3D x.cntxtArg;=0A=
                    return 0;=0A=
            }=0A=
=0A=
            case MALIBU_SET_SIG:=0A=
                    //TODO: if (!(filep->f_mode & FMODE_WRITE)) return =
-EACCES;=0A=
                    md->mySig =3D arg;=0A=
                    return 0;=0A=
=0A=
            case MALIBU_FAKE_SIG: {=0A=
                    MalibuDrv_FakeISR	x;=0A=
=0A=
                    if (rtdm_safe_copy_from_user(user_info, &x, (const =
void __user*)arg, sizeof(x))) return -EFAULT;=0A=
                    if ((md->iPtrLow - md->iPtrHi) < =
MALIBU_INTR_MAX-x.depth-1) {=0A=
                            int	i;=0A=
=0A=
                            for (i =3D 0; i < x.depth; i++) {=0A=
                                    md->iQueue[md->iPtrLow % =
MALIBU_INTR_MAX] =3D x.data[i];=0A=
                                    md->iPtrLow++;=0A=
                            }=0A=
=0A=
                            wake_up_interruptible(&md->intrWait);=0A=
                            if (md->async_queue) =
kill_fasync(&md->async_queue, md->mySig, POLL_IN);=0A=
                    }=0A=
                    return 0;=0A=
=0A=
=0A=
            }=0A=
            default:=0A=
                    return -EINVAL;=0A=
    }=0A=
}=0A=
=0A=
//static irqreturn_t board_handler(unsigned int irq, void *dev_id, =
struct pt_regs *regs)=0A=
static int malibu_intr_handler(rtdm_irq_t * irq_context)=0A=
{=0A=
    uint32_t rd;=0A=
    MyData *md =3D  rtdm_irq_get_arg(irq_context, MyData);=0A=
=0A=
    //MyData*		md =3D (MyData*) dev_id;=0A=
=0A=
    //if(md->pdev->irq !=3D irq) return IRQ_NONE;=0A=
=0A=
    rd =3D ioread32(md->intrStatusAddr);=0A=
=0A=
    if ((rd & md->intrMask) =3D=3D 0) return IRQ_NONE;=0A=
=0A=
    if ((md->iPtrLow - md->iPtrHi) < MALIBU_INTR_MAX-1) {=0A=
            md->iQueue[md->iPtrLow % MALIBU_INTR_MAX] =3D rd;=0A=
            md->iPtrLow++;=0A=
=0A=
            wake_up_interruptible(&md->intrWait);=0A=
            if (md->async_queue && md->mySig) =
kill_fasync(&md->async_queue, md->mySig, POLL_IN);=0A=
    }=0A=
    if (md->intrWriteback) iowrite32(rd, md->intrStatusAddr);=0A=
=0A=
    return IRQ_HANDLED;=0A=
}=0A=
=0A=
static void vma_open(struct vm_area_struct* vma) { }=0A=
static void vma_close(struct vm_area_struct* vma) { }=0A=
=0A=
static struct vm_operations_struct remap_vm_ops =3D {=0A=
    .open =3D vma_open,=0A=
    .close =3D vma_close,=0A=
};=0A=
=0A=
int MyMmap(struct file *filep, struct vm_area_struct *vma)=0A=
{=0A=
    MY_PRINT("start");=0A=
=0A=
    MyData*		md =3D (MyData*) filep->private_data;=0A=
    unsigned long	off =3D vma->vm_pgoff << PAGE_SHIFT;=0A=
    unsigned long	vsize =3D vma->vm_end - vma->vm_start;=0A=
    unsigned long	seg =3D off / MALIBU_MMAP_SIZE;=0A=
    unsigned long	seg_off =3D off % MALIBU_MMAP_SIZE;=0A=
    unsigned long	psize, pfn;=0A=
=0A=
    if (seg >=3D 0 && seg < MALIBU_BAR_MAX) {=0A=
            if (md->bars[seg].size =3D=3D 0) return -EINVAL;=0A=
            pfn =3D (md->bars[seg].start + seg_off) >> PAGE_SHIFT;=0A=
            psize =3D md->bars[seg].size - seg_off;=0A=
    }=0A=
    else if (seg >=3D MALIBU_BAR_MAX && seg < MALIBU_BAR_MAX + =
MALIBU_BUF_MAX) {=0A=
            seg -=3D MALIBU_BAR_MAX;=0A=
            if (md->bufs[seg].size =3D=3D 0) return -EINVAL;=0A=
            pfn =3D __pa(md->bufs[seg].kAddr + seg_off) >> PAGE_SHIFT;=0A=
            psize =3D md->bufs[seg].size - seg_off;=0A=
    }=0A=
    else return -EINVAL;=0A=
=0A=
    if (vsize > psize) return -EINVAL;=0A=
    if (remap_pfn_range(vma, vma->vm_start, pfn, vsize, =
vma->vm_page_prot)) return -EAGAIN;=0A=
=0A=
    vma->vm_ops =3D &remap_vm_ops;=0A=
    vma_open(vma);=0A=
=0A=
    MY_PRINT("end");=0A=
=0A=
    return 0;=0A=
}=0A=
=0A=
static int fasync(int fd, struct file *filep, int mode)=0A=
{=0A=
    MyData*		md =3D (MyData*) filep->private_data;=0A=
    return fasync_helper(fd, filep, mode, &md->async_queue);=0A=
}=0A=
=0A=
=0A=
=0A=
=0A=
static ssize_t showDevInfo(struct device *dev, struct device_attribute* =
attr, char *buf)=0A=
{=0A=
    MyData* md =3D (MyData*)dev->driver_data;=0A=
    return snprintf(buf, PAGE_SIZE,=0A=
            "vendor=3D0x%x\n"=0A=
            "device=3D0x%x\n"=0A=
            "subsystem_vendor=3D0x%x\n"=0A=
            "subsystem_device=3D0x%x\n"=0A=
            "revision=3D0x%x\n"=0A=
            "bus=3D0x%x\n"=0A=
            "slot=3D0x%x\n"=0A=
            "func=3D0x%x\n"=0A=
            "numBars=3D%d\n",=0A=
            md->pdev->vendor,=0A=
            md->pdev->device,=0A=
            md->pdev->subsystem_vendor,=0A=
            md->pdev->subsystem_device,=0A=
            md->pdev->revision,=0A=
            md->pdev->bus->number,=0A=
            PCI_SLOT(md->pdev->devfn),=0A=
            PCI_FUNC(md->pdev->devfn),=0A=
            md->numBars);=0A=
}=0A=
static DEVICE_ATTR(devInfo, 0444, showDevInfo, NULL);=0A=
=0A=
=0A=
/**=0A=
* This structure describe the malibu RTDM device=0A=
*=0A=
*/=0A=
static struct rtdm_device malibu_rtdm_device =3D {=0A=
    .struct_version =3D RTDM_DEVICE_STRUCT_VER,=0A=
=0A=
    .device_flags =3D RTDM_NAMED_DEVICE,=0A=
    .context_size =3D sizeof(MyData),=0A=
    .device_name =3D DRV_NAME,=0A=
=0A=
    .open_rt =3D  malibu_rtdm_open,=0A=
    .open_nrt =3D malibu_rtdm_open,=0A=
=0A=
    .ops =3D {=0A=
            .close_rt =3D malibu_rtdm_close,=0A=
            .close_nrt =3D malibu_rtdm_close,=0A=
            .ioctl_rt =3D  malibu_rtdm_ioctl,=0A=
            .ioctl_nrt =3D malibu_rtdm_ioctl,=0A=
            //.read_nrt =3D NULL,=0A=
            //.write_nrt =3D NULL,=0A=
    },=0A=
=0A=
=0A=
    .device_class =3D RTDM_CLASS_EXPERIMENTAL,=0A=
    .device_sub_class =3D SOME_SUB_CLASS,=0A=
    .profile_version =3D 1,=0A=
    .driver_name =3D DRV_NAME,=0A=
    .driver_version =3D RTDM_DRIVER_VER(0, 1, 0),=0A=
    .peripheral_name =3D "Malibu RT driver",=0A=
    .provider_name =3D "Innovative Integration",=0A=
    .proc_name =3D DRV_NAME,=0A=
};=0A=
=0A=
static int allocEachDev(struct pci_dev *pdev, const struct pci_device_id =
*id)=0A=
{=0A=
    struct rtdm_device  *rtdm_dev;=0A=
    int    ret_val =3D 0;=0A=
    MyData *md, *lPtr;=0A=
    int	i, bCntr, error, b;=0A=
=0A=
    MY_PRINT("start");=0A=
=0A=
    if(id->vendor !=3D VENDOR_ID) {=0A=
            MY_ERR("");=0A=
            return -ENODEV;=0A=
    }=0A=
=0A=
    md =3D (MyData*) kzalloc(sizeof(MyData), GFP_KERNEL);=0A=
=0A=
    md->pdev =3D pdev;=0A=
=0A=
    sprintf(msgbuf, "pdev->irq=3D%d", pdev->irq);=0A=
    MY_PRINT(msgbuf);=0A=
=0A=
    if (pci_enable_device(pdev)) {=0A=
            MY_ERR("");=0A=
            kfree(md);=0A=
            return -ENODEV;=0A=
    }=0A=
=0A=
    pci_set_master(pdev);=0A=
=0A=
    b =3D 0;=0A=
    for (i =3D 0; i < MALIBU_BAR_MAX; i++) {=0A=
            md->bars[b].start	=3D pci_resource_start(pdev, i);=0A=
            md->bars[b].end	=3D pci_resource_end(pdev, i);=0A=
            md->bars[b].size	=3D pci_resource_len(pdev, i);=0A=
            printk(KERN_ERR "bar=3D%d start=3D%llx end=3D%llx =
len=3D%llx\n", i,=0A=
                    md->bars[b].start,=0A=
                    md->bars[b].end,=0A=
                    md->bars[b].size);=0A=
            if (md->bars[b].size =3D=3D 0) continue;=0A=
            md->bars[b].kAddr	=3D (void*) ioremap(md->bars[i].start, =
md->bars[i].end - md->bars[i].start);=0A=
            b++;=0A=
    }=0A=
    md->numBars =3D i;=0A=
=0A=
    init_waitqueue_head(&md->intrWait);=0A=
=0A=
    cdev_init(&md->cdev, &myFileOps);=0A=
    md->cdev.owner =3D THIS_MODULE;=0A=
    md->myDevT =3D MKDEV(MAJOR(baseDevT), MINOR(baseDevT)+devCnt);=0A=
    if (cdev_add(&md->cdev, md->myDevT, 1)) {=0A=
            MY_ERR("");=0A=
            pci_disable_device(md->pdev);=0A=
            kfree(md);=0A=
            return -ENODEV;=0A=
    }=0A=
=0A=
    bCntr =3D 0;=0A=
    list_for_each_entry(lPtr, &devList, list) {=0A=
            if (lPtr->pdev->device =3D=3D pdev->device) bCntr++;=0A=
    }=0A=
=0A=
    md->sysdev =3D device_create(devClass, &md->pdev->dev, md->myDevT, =
NULL, MALIBU_DEV_NAME, pdev->device, bCntr);=0A=
    if (IS_ERR(md->sysdev)) {=0A=
            MY_ERR("");=0A=
            cdev_del(&md->cdev);=0A=
            pci_disable_device(md->pdev);=0A=
            kfree(md);=0A=
            return -ENODEV;=0A=
    }=0A=
    md->sysdev->driver_data =3D (void*)md;=0A=
=0A=
    error =3D device_create_file(md->sysdev, &dev_attr_devInfo);=0A=
    if (error) {=0A=
            MY_ERR("");=0A=
            device_destroy(devClass, md->myDevT);=0A=
            cdev_del(&md->cdev);=0A=
            for (i =3D 0; i < MALIBU_BAR_MAX; i++) {=0A=
                    if (md->bars[i].size) {=0A=
                            iounmap(md->bars[i].kAddr);=0A=
                            md->bars[i].size =3D 0;=0A=
                    }=0A=
            }=0A=
            pci_disable_device(md->pdev);=0A=
            kfree(md);=0A=
            return error;=0A=
    }=0A=
=0A=
    md->dev_id =3D devCnt;=0A=
=0A=
=0A=
    //alloc mem for rtdm structure=0A=
    rtdm_dev =3D kmalloc(sizeof(struct rtdm_device), GFP_KERNEL);=0A=
    if(!rtdm_dev){=0A=
      MY_ERR("rtdm_device kmalloc failed\n");=0A=
      ret_val =3D -ENOMEM; //Insufficient storage space is available.=0A=
      return ret_val;=0A=
    }=0A=
=0A=
    //copy the structure to the new memory=0A=
    memcpy(rtdm_dev, &malibu_rtdm_device, sizeof(struct rtdm_device));=0A=
=0A=
    //create filename=0A=
    snprintf(rtdm_dev->device_name,=0A=
             RTDM_MAX_DEVNAME_LEN,=0A=
             MALIBU_DEV_NAME,=0A=
             pdev->device, bCntr);=0A=
             //"malibu_%d", devCnt);=0A=
=0A=
    rtdm_dev->device_id =3D devCnt;=0A=
=0A=
    //define two other members of the rtdm_device structure=0A=
    rtdm_dev->proc_name =3D rtdm_dev->device_name;=0A=
=0A=
    ret_val =3D rtdm_dev_register(rtdm_dev);=0A=
=0A=
    if(ret_val < 0){=0A=
      MY_ERR("failed to register device with RTDM\n");=0A=
      ret_val =3D -ENODEV;=0A=
      return ret_val;=0A=
    }=0A=
=0A=
    md->xen_rtdm_device =3D rtdm_dev;=0A=
=0A=
    list_add_tail(&md->list, &devList);=0A=
=0A=
    //always do this last=0A=
    devCnt++;=0A=
=0A=
    MY_PRINT("end OK");=0A=
    return 0;=0A=
}=0A=
=0A=
static void removeAllDev(struct pci_dev *pdev)=0A=
{=0A=
    MyData *md, *tmp;=0A=
=0A=
    MY_PRINT("start");=0A=
=0A=
    list_for_each_entry_safe(md, tmp, &devList, list)=0A=
    {=0A=
        if (md =3D=3D NULL)=0A=
        {=0A=
            MY_PRINT("md is NULL");=0A=
            return;=0A=
        }=0A=
=0A=
        int	i;=0A=
=0A=
        list_del(&md->list);=0A=
=0A=
=0A=
        device_remove_file(md->sysdev, &dev_attr_devInfo);=0A=
        device_destroy(devClass, md->myDevT);=0A=
        cdev_del(&md->cdev);=0A=
=0A=
        for (i =3D 0; i < MALIBU_BUF_MAX; i++) freeBuffer(md, i);=0A=
=0A=
        for (i =3D 0; i < MALIBU_BAR_MAX; i++) {=0A=
            if (md->bars[i].size) {=0A=
                iounmap(md->bars[i].kAddr);=0A=
                md->bars[i].size =3D 0;=0A=
            }=0A=
        }=0A=
=0A=
        pci_disable_device(md->pdev);=0A=
=0A=
        //remove char device from the system=0A=
        //unregister RTdriver=0A=
        rtdm_dev_unregister(md->xen_rtdm_device, 1000);=0A=
=0A=
        kfree(md->xen_rtdm_device);=0A=
        kfree(md);=0A=
=0A=
        devCnt--;=0A=
}=0A=
=0A=
    MY_PRINT("end");=0A=
}=0A=
=0A=
=0A=
static struct pci_device_id ids[] =3D {=0A=
    { PCI_DEVICE(VENDOR_ID, PCI_ANY_ID) },=0A=
    { 0 },=0A=
};=0A=
=0A=
static struct pci_driver pci_driver =3D {=0A=
    .name	=3D DRV_NAME,=0A=
    .id_table	=3D ids,=0A=
    .probe	=3D allocEachDev,=0A=
    .remove	=3D removeAllDev,=0A=
};=0A=
=0A=
=0A=
//MODULE_DEVICE_TABLE(pci, ids);=0A=
=0A=
static ssize_t showDevCount(struct class *cls, char *buf)=0A=
{=0A=
    return sprintf(buf, "%d\n", devCnt);=0A=
}=0A=
=0A=
static CLASS_ATTR(devCount, 0444, showDevCount, NULL);=0A=
=0A=
/**=0A=
* This function is called when the module is loaded=0A=
*=0A=
* It simply registers the RTDM device.=0A=
*=0A=
*/=0A=
static int __init mod_init(void)=0A=
{=0A=
    int 	error;=0A=
=0A=
    MY_PRINT("initializing MalibuDrv_RT module");=0A=
=0A=
    devClass =3D class_create(THIS_MODULE, DRV_NAME);=0A=
    if (IS_ERR(devClass)) {=0A=
            MY_ERR("");=0A=
            return PTR_ERR(devClass);=0A=
    }=0A=
=0A=
    error =3D class_create_file(devClass, &class_attr_devCount);=0A=
    if (error) {=0A=
            MY_ERR("");=0A=
            class_destroy(devClass);=0A=
            return error;=0A=
    }=0A=
=0A=
    error =3D alloc_chrdev_region(&baseDevT, 0, MALIBU_MAX_DEVS, =
DRV_NAME);=0A=
    if (error) {=0A=
            MY_ERR("");=0A=
            class_remove_file(devClass, &class_attr_devCount);=0A=
            class_destroy(devClass);=0A=
            return error;=0A=
    }=0A=
=0A=
    error =3D pci_register_driver(&pci_driver);=0A=
    if (error) {=0A=
        MY_ERR("");=0A=
        unregister_chrdev_region(baseDevT, MALIBU_MAX_DEVS);=0A=
        class_remove_file(devClass, &class_attr_devCount);=0A=
        class_destroy(devClass);=0A=
        return error;=0A=
    }=0A=
=0A=
    return error;=0A=
}=0A=
=0A=
/**=0A=
* This function is called when the module is unloaded=0A=
*=0A=
* It unregister the RTDM device, polling at 1000 ms for pending users.=0A=
*=0A=
*/=0A=
static void __exit mod_exit(void)=0A=
{=0A=
    MY_PRINT("unregistering MalibuDrv_RT module");=0A=
=0A=
    pci_unregister_driver(&pci_driver);=0A=
    unregister_chrdev_region(baseDevT, MALIBU_MAX_DEVS);=0A=
    class_remove_file(devClass, &class_attr_devCount);=0A=
    class_destroy(devClass);=0A=
}=0A=
=0A=
=0A=
module_init(mod_init);=0A=
module_exit(mod_exit);=0A=
MODULE_LICENSE("GPL");=0A=

------=_NextPart_000_007A_01CBB624.CD4414A0
Content-Type: text/plain;
	name="malibu.h"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="malibu.h"

#ifndef	_MALIBU_H_=0A=
#define	_MALIBU_H_=0A=
=0A=
#include <linux/ioctl.h>=0A=
=0A=
//#include <sys/time.h>=0A=
=0A=
#ifndef __KERNEL__=0A=
#include <stdint.h>=0A=
#endif=0A=
=0A=
#include <rtdm/rtdm.h>=0A=
=0A=
typedef struct {=0A=
	uint32_t	vendorId;=0A=
	uint32_t	deviceId;=0A=
	uint32_t	subVendorId;=0A=
	uint32_t	subDeviceId;=0A=
	uint32_t	bus;=0A=
	uint32_t	slot;=0A=
	uint32_t	func;=0A=
	uint8_t		revision;=0A=
	uint8_t		numBars;=0A=
} MalibuDrv_INFO;=0A=
=0A=
typedef struct {=0A=
	uint64_t	physAddr;=0A=
	uint64_t	fileOffset;=0A=
	uint32_t	size;=0A=
	uint8_t		bufNum;=0A=
} MalibuDrv_Buffer;=0A=
=0A=
typedef struct {=0A=
	uint32_t	type;=0A=
	uint32_t	byteOffset;=0A=
	uint32_t	bar;=0A=
	uint32_t	mask;=0A=
	void		(*cntxtFunc)(void*);=0A=
	void		*cntxtArg;=0A=
} MalibuDrv_IntCtrl;=0A=
=0A=
#define	MALIBU_INTR_MAX		128	// how many isrs can be queued in the kernel=0A=
=0A=
typedef struct {=0A=
	struct timeval	timeout;=0A=
	int		errno;=0A=
	void		(*cntxtFunc)(void*);=0A=
	void		*cntxtArg;=0A=
	uint32_t	depth;=0A=
	uint32_t	data[MALIBU_INTR_MAX];=0A=
} MalibuDrv_DequeueISR;=0A=
=0A=
typedef struct {=0A=
	uint32_t	depth;=0A=
	uint32_t	data[MALIBU_INTR_MAX];=0A=
} MalibuDrv_FakeISR;=0A=
=0A=
/**=0A=
 * IOCTL stuff=0A=
 */=0A=
struct ioc_param{=0A=
  uint32_t bv;      /* 32bit vector to write to register, */=0A=
                    /* when reading from register,        */=0A=
                    /* the value will be stored there     */=0A=
  uint8_t offset;   /* offset address of the register we  */=0A=
                    /* want to read from or write to      */=0A=
};=0A=
=0A=
typedef struct {=0A=
    void	*userAddr;   /*user mode addr*/=0A=
    uint64_t	size;    =0A=
    uint8_t     barnum;=0A=
    void        *kernAddr;=0A=
}MalibuDrv_MmapArg;=0A=
=0A=
typedef struct ioc_param ioc_param_struct;=0A=
=0A=
#define	MALIBU_IOC_MAGIC	'm'=0A=
#define	MALIBU_GET_INFO		_IOR(MALIBU_IOC_MAGIC, 0, MalibuDrv_INFO)=0A=
#define	MALIBU_GET_BAR_SIZE	_IO(MALIBU_IOC_MAGIC, 1)=0A=
#define	MALIBU_ALLOC_BUFFER	_IOWR(MALIBU_IOC_MAGIC, 2, MalibuDrv_Buffer)=0A=
#define	MALIBU_FREE_BUFFER	_IOW(MALIBU_IOC_MAGIC, 3, MalibuDrv_Buffer)=0A=
#define	MALIBU_ISR_ENABLE	_IO(MALIBU_IOC_MAGIC, 4)=0A=
#define	MALIBU_ISR_DISABLE	_IO(MALIBU_IOC_MAGIC, 5)=0A=
#define	MALIBU_GET_ISR_ENABLED	_IO(MALIBU_IOC_MAGIC, 6)=0A=
#define	MALIBU_GET_ISR_DEPTH	_IO(MALIBU_IOC_MAGIC, 7)=0A=
#define	MALIBU_ISR_CLEAR_ALL	_IO(MALIBU_IOC_MAGIC, 8)=0A=
#define	MALIBU_DEQUEUE_ISR	_IOWR(MALIBU_IOC_MAGIC, 9, =
MalibuDrv_DequeueISR)=0A=
#define	MALIBU_SET_ISR_CTRL	_IOW(MALIBU_IOC_MAGIC, 10, MalibuDrv_IntCtrl)=0A=
#define	MALIBU_SET_SIG		_IO(MALIBU_IOC_MAGIC, 11)=0A=
#define	MALIBU_FAKE_SIG		_IOW(MALIBU_IOC_MAGIC, 12, MalibuDrv_FakeISR)=0A=
#define MALIBU_MMAP_BAR         _IOWR(MALIBU_IOC_MAGIC, 13, =
MalibuDrv_MmapArg)=0A=
#define MALIBU_MMAP_BLOCK       _IOWR(MALIBU_IOC_MAGIC, 14, =
MalibuDrv_MmapArg)=0A=
=0A=
#define	MALIBU_MAX_DEVS		256=0A=
#define	MALIBU_MMAP_SIZE	(16 * 1024 * 1024)=0A=
#define	MALIBU_BAR_MAX		6=0A=
#define	MALIBU_BUF_MAX		2=0A=
=0A=
#define MALIBU_DEV_NAME         "malibu%04x_%d"=0A=
=0A=
#define MALIBU_BUF_MAP_NR 9=0A=
#define MALIBU_BUF_MAP (1 << MALIBU_BUF_MAP_NR)=0A=
=0A=
#endif=0A=

------=_NextPart_000_007A_01CBB624.CD4414A0
Content-Type: text/plain;
	name="malibuApp.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="malibuApp.c"

#include <stdio.h>=0A=
#include <stdlib.h>=0A=
#include <string.h>=0A=
#include <sys/types.h>=0A=
#include <sys/stat.h>=0A=
#include <sys/mman.h>=0A=
#include <sys/time.h>=0A=
#include <sys/ioctl.h>=0A=
#define __USE_GNU=0A=
#include <fcntl.h>=0A=
#include <unistd.h>=0A=
#include <pthread.h>=0A=
#include <signal.h>=0A=
#include "malibu.h"=0A=
=0A=
struct timeval	startTime;=0A=
=0A=
void hello_world(char* data)=0A=
{=0A=
        printf("hello frm hello_world\n");=0A=
        printf("data=3D%x", data);=0A=
}=0A=
=0A=
int checkFd(int fd, int secs)=0A=
{=0A=
        int			ret;=0A=
        MalibuDrv_DequeueISR	isr;=0A=
        struct timeval		now;=0A=
        double			diff;=0A=
        int			i;=0A=
=0A=
        isr.timeout.tv_sec =3D secs;=0A=
        isr.timeout.tv_usec =3D 0;=0A=
        if (rt_dev_ioctl(fd, MALIBU_DEQUEUE_ISR, &isr) < 0) {=0A=
                perror("rt_dev_ioctl");=0A=
        }=0A=
        else {=0A=
                gettimeofday(&now, 0);=0A=
                diff =3D now.tv_sec - startTime.tv_sec + (now.tv_usec - =
startTime.tv_usec) / 1e6;=0A=
                if (isr.errno) {=0A=
                        char	buf[256];=0A=
                        strerror_r(isr.errno, buf, sizeof(buf));=0A=
                        printf("%15.f: fd=3D%d error=3D%s\n", diff, fd, =
buf);=0A=
                }=0A=
                else {=0A=
                        printf("%15.6f: fd=3D%d got depth=3D%d",=0A=
                                        diff,=0A=
                                        fd,=0A=
                                        isr.depth);=0A=
                        if (secs !=3D 0) printf(" time remaining=3D%f", =
isr.timeout.tv_sec + isr.timeout.tv_usec / 1e6);=0A=
                        printf("\n");=0A=
                        for (i =3D 0; i < isr.depth; i++) {=0A=
                                printf("\tdata[%d] =3D %08x\n", i, =
isr.data[i]);=0A=
                        }=0A=
                        if (isr.cntxtFunc) =
(*isr.cntxtFunc)(isr.cntxtArg);=0A=
                }=0A=
        }=0A=
=0A=
        return ret;=0A=
}=0A=
=0A=
int doExit =3D 0;=0A=
=0A=
void* backgroundThr(void* arg)=0A=
{=0A=
        while (1) {=0A=
                if (checkFd((long)arg, 2) < 0) break;=0A=
                if (doExit) break;=0A=
        }=0A=
        printf("thread fd=3D%d exiting\n", (long) arg);=0A=
}=0A=
=0A=
=0A=
void myHandler(int sig, siginfo_t* info, void* arg)=0A=
{=0A=
        int	i;=0A=
=0A=
        if (sig =3D=3D SIGPOLL && info->si_code =3D=3D POLL_IN) {=0A=
                checkFd(info->si_fd, 0);=0A=
        }=0A=
}=0A=
=0A=
int main(int argc, char * argv[])=0A=
{=0A=
        struct sigaction	act[8];=0A=
        pthread_t		tid[8];=0A=
        int			numBoards =3D 0;=0A=
        int			fds[8];=0A=
        int			i, j, boardCnt;=0A=
        char			*bars[8][MALIBU_BAR_MAX];=0A=
        int			barSize[8][MALIBU_BAR_MAX];=0A=
        int			barCnt[8];=0A=
        char			*bufPtrs[8][MALIBU_BUF_MAX];=0A=
        MalibuDrv_Buffer	bufs[8][MALIBU_BUF_MAX];=0A=
=0A=
        for (i =3D 0; i < 8; i++) {=0A=
                struct	stat	sbuf;=0A=
                char		buf[128];=0A=
=0A=
                sprintf(buf, "/dev/malibu%04x_%d", 0x30, i);=0A=
                if (stat(buf, &sbuf) < 0) {=0A=
                        break;=0A=
                }=0A=
                else {=0A=
                        printf("file \"%s\" exists\n", buf);=0A=
                }=0A=
        }=0A=
=0A=
        numBoards =3D i;=0A=
        printf("numBoards =3D %d\n", numBoards);=0A=
=0A=
        for (i =3D 0; i < numBoards; i++)=0A=
        {=0A=
                char		buf[128];=0A=
                MalibuDrv_INFO	info;=0A=
=0A=
                //sprintf(buf, "malibu_%d", i);=0A=
                sprintf(buf, MALIBU_DEV_NAME, 0x30, i);=0A=
                fds[i] =3D rt_dev_open(buf, O_RDWR);=0A=
=0A=
                if (fds[i] < 0)=0A=
                {=0A=
                   sprintf(buf, "%s open failed", buf,i);=0A=
                   perror(buf);=0A=
                  return -1;=0A=
                } else=0A=
                    printf("%s open OK, fds[%d]=3D%d\n", buf, i, fds[i]);=0A=
=0A=
                printf("calling rt_dev_ioctl::MALIBU_GET_INFO\n");=0A=
=0A=
                if (rt_dev_ioctl(fds[i], MALIBU_GET_INFO, &info) < 0)=0A=
                {=0A=
                        perror("ioctl MALIBU_GET_INFO");=0A=
                        exit(-1);=0A=
                }=0A=
=0A=
=0A=
                printf("%d: vendorId=3D%x, deviceId=3D%x, =
subVendorId=3D%x, subDeviceId=3D%x, bus=3D%x, slot=3D%x, func=3D%x =
revision=3D%d numBars=3D%d\n",=0A=
                                i, info.vendorId, info.deviceId, =
info.subVendorId, info.subDeviceId,=0A=
                                info.bus, info.slot, info.func,=0A=
                                info.revision,=0A=
                                info.numBars);=0A=
=0A=
=0A=
=0A=
                bufs[i][0].size =3D 4 * 1024 * 1024;=0A=
                bufs[i][0].bufNum =3D 0;=0A=
=0A=
                if (rt_dev_ioctl(fds[i], MALIBU_ALLOC_BUFFER, =
&bufs[i][0]) < 0) {=0A=
                        perror("rt_dev_ioctl MALIBU_ALLOC_BUFFER");=0A=
                        exit(-1);=0A=
                }=0A=
=0A=
=0A=
                printf("MALIBU_ALLOC_BUFFER: bufs.physAddr=3D%p\n", =
bufs[i][0].physAddr);=0A=
=0A=
                bufs[i][1].size =3D 1024 * 1024;=0A=
                bufs[i][1].bufNum =3D 1;=0A=
                if (rt_dev_ioctl(fds[i], MALIBU_ALLOC_BUFFER, =
&bufs[i][1]) < 0) {=0A=
                        perror("rt_dev_ioctl MALIBU_ALLOC_BUFFER");=0A=
                        exit(-1);=0A=
                }=0A=
=0A=
                printf("MALIBU_ALLOC_BUFFER: bufs.physAddr=3D%p\n", =
bufs[i][1].physAddr);=0A=
=0A=
                printf("calling rt_dev_ioctl::MALIBU_GET_BAR_SIZE\n");=0A=
                int bar=3D0;=0A=
                int barSize =3D rt_dev_ioctl(fds[i], =
MALIBU_GET_BAR_SIZE, &bar);=0A=
                printf("bar=3D%d, barSize =3D %d", bar, barSize);=0A=
=0A=
                printf("calling rt_dev_ioctl::MALIBU_FREE_BUFFER\n");=0A=
                rt_dev_ioctl(fds[i], MALIBU_GET_BAR_SIZE, &bufs[i][0]);=0A=
                rt_dev_ioctl(fds[i], MALIBU_GET_BAR_SIZE, &bufs[i][1]);=0A=
 #if 0=0A=
                for (barCnt[i] =3D 0; barCnt[i] < MALIBU_BAR_MAX; =
barCnt[i]++) {=0A=
                        barSize[i][barCnt[i]] =3D rt_dev_ioctl(fds[i], =
MALIBU_GET_BAR_SIZE, barCnt[i]);=0A=
=0A=
                        if (barSize[i][barCnt[i]] < 0) {=0A=
                                perror("rt_dev_ioctl =
MALIBU_BAR_GET_SIZE");=0A=
                                exit(-1);=0A=
                        }=0A=
                        if (barSize[i][barCnt[i]] =3D=3D 0) break;=0A=
                        printf("\tbarSize[%d][%d]=3D0x%x\n", i, =
barCnt[i], barSize[i][barCnt[i]]);=0A=
                }=0A=
=0A=
=0A=
=0A=
                for (j =3D 0; j < barCnt[i]; j++) {=0A=
                        bars[i][j] =3D (char*)mmap(0, barSize[i][j], =
PROT_READ|PROT_WRITE, MAP_SHARED, fds[i], j * MALIBU_MMAP_SIZE);=0A=
                        if ((void*)bars[i][j] =3D=3D MAP_FAILED) {=0A=
                                perror("mmap");=0A=
                                exit(-1);=0A=
                        }=0A=
                        printf("\tbar[%d][%d] =3D %p\n", i, j, =
bars[i][j]);=0A=
                }=0A=
=0A=
                for (j =3D 0; j < 2; j++) {=0A=
                        bufPtrs[i][j] =3D (char*)mmap(0, =
bufs[i][j].size, PROT_READ|PROT_WRITE, MAP_SHARED, fds[i], (j + =
MALIBU_BAR_MAX) * MALIBU_MMAP_SIZE);=0A=
                        if ((void*)bufPtrs[i][j] =3D=3D MAP_FAILED) {=0A=
                                perror("mmap");=0A=
                                exit(-1);=0A=
                        }=0A=
                        printf("\tbufPtrs[%d][%d] =3D %p, =
physAddr=3D%llx\n", i, j, bufPtrs[i][j], bufs[i][j].physAddr);=0A=
                }=0A=
=0A=
#endif=0A=
        }=0A=
#if 0=0A=
        boardCnt =3D i;=0A=
=0A=
        for (i =3D 0; i < boardCnt; i++) {=0A=
                for (j =3D 0; j < boardCnt; j++) {=0A=
                        printf("board %d buf %d =3D %08x %08x %08x\n", =
i, j,=0A=
                                        ((uint32_t*)bufPtrs[i][j])[0],=0A=
                                        ((uint32_t*)bufPtrs[i][j])[1],=0A=
                                        ((uint32_t*)bufPtrs[i][j])[2]);=0A=
                }=0A=
        }=0A=
=0A=
        gettimeofday(&startTime, 0);=0A=
        for (i =3D 0; i < boardCnt; i++) {=0A=
                pthread_create(&tid[i], NULL, backgroundThr, =
(void*)fds[i]);=0A=
        }=0A=
=0A=
        printf("calling rt_dev_ioctl::MALIBU_FAKE_SIG\n");=0A=
        for (i =3D 0; i < 10; i++) {=0A=
                int			j;=0A=
                MalibuDrv_FakeISR	x;=0A=
                sleep(1);=0A=
                x.depth =3D i + 1;=0A=
                for (j =3D 0; j < x.depth; j++) x.data[j] =3D 16 * i + j;=0A=
                if (i & 1) rt_dev_ioctl(fds[0], MALIBU_FAKE_SIG, &x);=0A=
                else rt_dev_ioctl(fds[1], MALIBU_FAKE_SIG, &x);=0A=
        }=0A=
=0A=
        doExit =3D 1;=0A=
        sleep(4);=0A=
        printf("threads killed\n");=0A=
=0A=
        printf("calling rt_dev_ioctl::MALIBU_SET_ISR_CTRL\n");=0A=
        for (i =3D 0; i < numBoards; i++) {=0A=
                MalibuDrv_IntCtrl	isrCtrl;=0A=
=0A=
                isrCtrl.bar =3D 0;=0A=
                isrCtrl.byteOffset =3D 0;=0A=
                isrCtrl.cntxtFunc =3D (void (*)(void*)) hello_world;=0A=
                isrCtrl.cntxtArg =3D (void*) malloc(128);=0A=
                sprintf((char*)isrCtrl.cntxtArg, "hello from %d\n", i);=0A=
                if (rt_dev_ioctl(fds[i], MALIBU_SET_ISR_CTRL, &isrCtrl) =
< 0) {=0A=
                        perror("new rt_dev_ioctl\n");=0A=
                        exit(-1);=0A=
                }=0A=
                act[i].sa_sigaction =3D myHandler;=0A=
                act[i].sa_flags =3D SA_SIGINFO;=0A=
                sigemptyset(&act[i].sa_mask);=0A=
                sigaction(SIGIO, act+i, 0);=0A=
                // rt_dev_ioctl(fds[i], MALIBU_SET_SIG, SIGIO);=0A=
                fcntl(fds[i], F_SETFL, O_ASYNC);=0A=
                fcntl(fds[i], F_SETOWN, getpid());=0A=
                fcntl(fds[i], F_SETSIG, SIGIO);=0A=
        }=0A=
=0A=
        printf("MALIBU_FAKE_SIG\n");=0A=
        for (i =3D 0; i < 10; i++) {=0A=
                int			j;=0A=
                MalibuDrv_FakeISR	x;=0A=
                sleep(1);=0A=
                x.depth =3D i + 1;=0A=
                for (j =3D 0; j < x.depth; j++) x.data[j] =3D 16 * i + j;=0A=
                if (i & 1) rt_dev_ioctl(fds[0], MALIBU_FAKE_SIG, &x);=0A=
                else rt_dev_ioctl(fds[1], MALIBU_FAKE_SIG, &x);=0A=
        }=0A=
=0A=
=0A=
        for (i =3D 0; i < boardCnt; i++) {=0A=
                for (j =3D 0; j < barCnt[i]; j++) {=0A=
                        if (munmap(bars[i][j], barSize[i][j]) < 0) {=0A=
                                perror("munmap");=0A=
                                exit(-1);=0A=
                        }=0A=
                }=0A=
                for (j =3D 0; j < 2; j++) {=0A=
                        if (munmap(bufPtrs[i][j], bufs[i][j].size) < 0) {=0A=
                                perror("munmap");=0A=
                                exit(-1);=0A=
                        }=0A=
                }=0A=
        }=0A=
#endif=0A=
        sleep(3);=0A=
        exit(0);=0A=
}=0A=

------=_NextPart_000_007A_01CBB624.CD4414A0--


