Date: Fri, 19 Jan 2007 07:24:57 -0800 (PST)
From: mani bhatti <imranbashirbhatti@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-417035208-1169220297=:20673"
Content-Transfer-Encoding: 8bit
Message-ID: <910933.20673.qm@domain.hid>
Subject: [Xenomai-help] problem inserting a kernel module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--0-417035208-1169220297=:20673
Content-Type: multipart/alternative; boundary="0-1186855092-1169220297=:20673"

--0-1186855092-1169220297=:20673
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all
i have a problem inserting the realtimedriver.ko module from captain.at 
actually everything works well module is made with out any error from make file and user.c also compiles but when i try to insert  following error appears 

insmod: error inserting './realtimedriver.ko': -1 Unknown symbol in module

Is there any error inside module.Thanks.
i have attached all files.thanks


 

 
---------------------------------
Everyone is raving about the all-new Yahoo! Mail beta.
--0-1186855092-1169220297=:20673
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all<br>i have a problem inserting the realtimedriver.ko module from captain.at <br>actually everything works well module is made with out any error from make file and user.c also compiles but when i try to insert&nbsp; following error appears <br><br>insmod: error inserting './realtimedriver.ko': -1 Unknown symbol in module<br><br>Is there any error inside module.Thanks.<br>i have attached all files.thanks<br><br><br> <br><p>&#32;


<hr size=1>Everyone is raving about <a href="http://us.rd.yahoo.com/evt=42297/*http://advision.webevents.yahoo.com/mailbeta">the all-new Yahoo! Mail beta.</a>
--0-1186855092-1169220297=:20673--

--0-417035208-1169220297=:20673
Content-Type: text/x-csrc; name="realtimedriver.c"
Content-Description: 211431340-realtimedriver.c
Content-Disposition: inline; filename="realtimedriver.c"

#include <linux/mman.h>
#include <rtdm/rtdm_driver.h>
#include "inc.h"

char dummy_buffer[BUFSIZE];
int  events;
int  ioctlvalue;

// our driver context struct: used for storing various information
struct demodrv_context {
    rtdm_irq_t              irq_handle;
    rtdm_lock_t             lock;
    int                     dev_id;
    u64                     last_timestamp;
    rtdm_event_t            irq_event;
    volatile unsigned long  irq_event_lock;
    volatile int            irq_events;
    int64_t                 timeout;
    void                    *buf;
    rtdm_user_info_t        *mapped_user_info;
    void                    *mapped_user_addr;
};

#ifdef USEMMAP
static void demo_vm_open(struct vm_area_struct *vma)
{
    printk("opening %p, private_data = %p\n", vma, 
vma->vm_private_data);
}
static void demo_vm_close(struct vm_area_struct *vma)
{
    printk("releasing %p, private_data = %p\n", vma, 
vma->vm_private_data);
}
static struct vm_operations_struct mmap_ops = {
    .open = demo_vm_open,
    .close = demo_vm_close,
};
#endif

/**********************************************************/
/*            INTERRUPT HANDLING                          */
/**********************************************************/
static int demo_interrupt(rtdm_irq_t *irq_context)
{
    struct demodrv_context *ctx;
    int           dev_id;
//    timestamp, if needed, can be obtained list this:
//    u64           timestamp = rtdm_clock_read();
    int           ret = RTDM_IRQ_HANDLED; // usual return value

    ctx = rtdm_irq_get_arg(irq_context, struct demodrv_context);
    dev_id    = ctx->dev_id;

    rtdm_lock_get(&ctx->lock);

    // do stuff
#ifdef TIMERINT
    if (events > 100) {
        rtdm_event_signal(&ctx->irq_event);
        events = 0;
    }
#else
    rtdm_event_signal(&ctx->irq_event);
#endif
    events++;
        
    rtdm_lock_put(&ctx->lock);
    // those return values were dropped from the RTDM
    // ret = RTDM_IRQ_ENABLE | RTDM_IRQ_PROPAGATE;

#ifdef TIMERINT
    // Only propagate the timer interrupt, so that linux sees it.
    // Forwarding interrupts to the non-realtime domain is not a common
    //     use-case of realtime device drivers, so usually DON'T DO THIS.
    // But here we grab the important timer interrupt, so we need to propagate it.
    return XN_ISR_PROPAGATE;
#else
    // signal interrupt is handled and don't propagate the interrupt to linux
    return RTDM_IRQ_HANDLED;
#endif
}

/**********************************************************/
/*            DRIVER OPEN                                 */
/**********************************************************/
int demo_open_rt(struct rtdm_dev_context    *context,
                 rtdm_user_info_t           *user_info,
                 int                        oflags)
{
    struct demodrv_context  *my_context;
#ifdef USEMMAP
    unsigned long vaddr;
#endif
    int dev_id = context->device->device_id;
    int ret;
    
    // get the context for our driver - used to store driver info
    my_context = (struct demodrv_context *)context->dev_private;

#ifdef USEMMAP
    // allocate and prepare memory for our buffer
    my_context->buf = kmalloc(BUFFER_SIZE, 0);
    /* mark pages reserved so that remap_pfn_range works */
    for (vaddr = (unsigned long)my_context->buf;
         vaddr < (unsigned long)my_context->buf + BUFFER_SIZE;
         vaddr += PAGE_SIZE)
        SetPageReserved(virt_to_page(vaddr));
    // write some test value to the start of our buffer
    *(int *)my_context->buf = 1234;

    my_context->mapped_user_addr = NULL;
#endif

    // we also have an interrupt handler:
#ifdef TIMERINT
    ret = rtdm_irq_request(&my_context->irq_handle, TIMER_INT, 
demo_interrupt,
                 0, context->device->proc_name, my_context);
#else
    ret = rtdm_irq_request(&my_context->irq_handle, PAR_INT, 
demo_interrupt,
                 0, context->device->proc_name, my_context);
#endif
    if (ret < 0)
        return ret;

    /* IPC initialisation - cannot fail with used parameters */
    rtdm_lock_init(&my_context->lock);
    rtdm_event_init(&my_context->irq_event, 0);
    my_context->dev_id         = dev_id;

    my_context->irq_events     = 0;
    my_context->irq_event_lock = 0;
    my_context->timeout = 0; // wait INFINITE

#ifndef TIMERINT
    //set port to interrupt mode; pins are output
    outb_p(0x10, BASEPORT + 2);
#endif
    // enable interrupt in RTDM
    rtdm_irq_enable(&my_context->irq_handle);
    return 0;
}

/**********************************************************/
/*            DRIVER CLOSE                                */
/**********************************************************/
int demo_close_rt(struct rtdm_dev_context   *context,
                  rtdm_user_info_t          *user_info)
{
    struct demodrv_context  *my_context;
    rtdm_lockctx_t          lock_ctx;
#ifdef USEMMAP
    unsigned long vaddr;
#endif
    // get the context
    my_context = (struct demodrv_context *)context->dev_private;

#ifdef USEMMAP
    // printk some test value
    printk("%d\n", *((int *)my_context->buf + 10));

    // munmap our buffer
    if (my_context->mapped_user_addr) {
        int ret = rtdm_munmap(my_context->mapped_user_info,
                              my_context->mapped_user_addr, 
BUFFER_SIZE);
        printk("rtdm_munmap = %p, %d\n", my_context->mapped_user_info, 
ret);
    }

    /* clear pages reserved */
    for (vaddr = (unsigned long)my_context->buf;
         vaddr < (unsigned long)my_context->buf + BUFFER_SIZE;
         vaddr += PAGE_SIZE)
        ClearPageReserved(virt_to_page(vaddr));

    kfree(my_context->buf);
#endif

    // if we need to do some stuff with preemption disabled:
    rtdm_lock_get_irqsave(&my_context->lock, lock_ctx);
    // other stuff here
    rtdm_lock_put_irqrestore(&my_context->lock, lock_ctx);

    // free irq in RTDM
    rtdm_irq_free(&my_context->irq_handle);
    // destroy our interrupt signal/event
    rtdm_event_destroy(&my_context->irq_event);
    return 0;
}

/**********************************************************/
/*            DRIVER IOCTL                                */
/**********************************************************/
int demo_ioctl_rt(struct rtdm_dev_context   *context,
                  rtdm_user_info_t          *user_info,
                  int                       request,
                  void                      *arg)
{
    struct demodrv_context  *my_context;
#ifdef USEMMAP
    int err;
#endif
    int ret = 0;
    my_context = (struct demodrv_context *)context->dev_private;

    switch (request) {
        case MMAP: // set mmap pointer
#ifdef USEMMAP
          printk("buf = %p:%x\n", my_context->buf, *(int*)my_context->buf);
      
          err = rtdm_mmap_to_user(user_info, my_context->buf,BUFFER_SIZE, PROT_READ|PROT_WRITE, (void **)arg,&mmap_ops,(void *)0x12345678);
          if (!err) {
              my_context->mapped_user_info = user_info;
              my_context->mapped_user_addr = *(void **)arg;
          }
          printk("rtdm_mmap = %p %d\n", my_context->mapped_user_info,err);
#else
          return -EPERM;
#endif
          break;
        case GETVALUE: // write "ioctlvalue" to user
            if (user_info) {
                if (!rtdm_rw_user_ok(user_info, arg, sizeof(int)) ||
                    rtdm_copy_to_user(user_info, arg, &ioctlvalue,
                                      sizeof(int)))
                    return -EFAULT;
            } else
                memcpy(arg, &ioctlvalue, sizeof(int));
            break;
        case SETVALUE: // read "ioctlvalue" from user
            if (user_info) {
                if (!rtdm_read_user_ok(user_info, arg, sizeof(int)) ||
                    rtdm_copy_from_user(user_info, &ioctlvalue, arg,
                                        sizeof(int)))
                    return -EFAULT;
            }
            break;
        default:
            ret = -ENOTTY;
    }
    return ret;
}

/**********************************************************/
/*            DRIVER READ                                 */
/**********************************************************/
int demo_read_rt(struct rtdm_dev_context *context,
                  rtdm_user_info_t *user_info, void *buf, size_t nbyte)
{
    struct demodrv_context *ctx;
    int                     dev_id;
//    rtdm_lockctx_t          lock_ctx;
    char                    *out_pos = (char *)buf;
    rtdm_toseq_t            timeout_seq;
    int                     ret;

    // zero bytes requested ? return!
    if (nbyte == 0)
        return 0;

    // check if R/W actions to user-space are allowed
    if (user_info && !rtdm_rw_user_ok(user_info, buf, nbyte))
        return -EFAULT;

    ctx    = (struct demodrv_context *)context->dev_private;
    dev_id = ctx->dev_id;

    // in case we need to check if reading is allowed (locking)
/*    if (test_and_set_bit(0, &ctx->in_lock))
        return -EBUSY;
*/
/*  // if we need to do some stuff with preemption disabled:
    rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);
    // stuff here
    rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
*/

    // wait: if ctx->timeout = 0, it will block infintely until
    //       rtdm_event_signal(&ctx->irq_event); is called from our
    //       interrupt routine
    ret = rtdm_event_timedwait(&ctx->irq_event, ctx->timeout, 
&timeout_seq);

    // now write the requested stuff to user-space
    if (rtdm_copy_to_user(user_info, out_pos,
                dummy_buffer, BUFSIZE) != 0) {
        ret = -EFAULT;
    } else {
        ret = BUFSIZE;
    }
    return ret;
}

/**********************************************************/
/*            DRIVER WRITE                                */
/**********************************************************/
int demo_write_rt(struct rtdm_dev_context *context,
                   rtdm_user_info_t *user_info,
                   const void *buf, size_t nbyte)
{
    struct demodrv_context *ctx;
    int                     dev_id;
    char                    *in_pos = (char *)buf;
    int                     ret;

    if (nbyte == 0)
        return 0;
    if (user_info && !rtdm_read_user_ok(user_info, buf, nbyte))
        return -EFAULT;

    ctx    = (struct demodrv_context *)context->dev_private;
    dev_id = ctx->dev_id;

    // make write operation atomic
/*  ret = rtdm_mutex_timedlock(&ctx->out_lock,
              ctx->config.rx_timeout, &timeout_seq);
    if (ret)
        return ret; */

/*  // if we need to do some stuff with preemption disabled:
    rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);
    // stuff here
    rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
*/

    // now copy the stuff from user-space to our kernel dummy_buffer
    if (rtdm_copy_from_user(user_info, dummy_buffer,in_pos, BUFSIZE) != 0) 
   {
        ret = -EFAULT;
    } else {
       ret = BUFSIZE;
    }

    // used when it is atomic
//   rtdm_mutex_unlock(&ctx->out_lock);
    return ret;
}

/**********************************************************/
/*            DRIVER OPERATIONS                           */
/**********************************************************/
static struct rtdm_device demo_device = {
    struct_version:     RTDM_DEVICE_STRUCT_VER,

    device_flags:       RTDM_NAMED_DEVICE,
    context_size:       sizeof(struct demodrv_context),
    device_name:        DEV_FILE,

/* open and close functions are not real-time safe due kmalloc
   and kfree. If you do not use kmalloc and kfree, and you made
   sure that there is no syscall in the open/close handler, you
   can declare the open_rt and close_rt handler.
*/
    open_rt:            NULL,
    open_nrt:           demo_open_rt,

    ops: {
        close_rt:       NULL,
        close_nrt:      demo_close_rt,

        ioctl_rt:       NULL,
        ioctl_nrt:      demo_ioctl_rt, // rtdm_mmap_to_user is not RT safe

        read_rt:        demo_read_rt,
        read_nrt:       NULL,

        write_rt:       demo_write_rt,
        write_nrt:      NULL,

        recvmsg_rt:     NULL,
        recvmsg_nrt:    NULL,

        sendmsg_rt:     NULL,
        sendmsg_nrt:    NULL,
    },

    device_class:       RTDM_CLASS_EXPERIMENTAL,
    device_sub_class:   222,
    driver_name:        DRV_NAME,
    peripheral_name:    DEV_FILE_NAME,
    provider_name:      "-",
    proc_name:          demo_device.device_name,
};

/**********************************************************/
/*            INIT DRIVER                                 */
/**********************************************************/
int init_module(void)
{
    return rtdm_dev_register(&demo_device);
}

/**********************************************************/
/*            CLEANUP DRIVER                              */
/**********************************************************/
void cleanup_module(void)
{
    rtdm_dev_unregister(&demo_device, 1000);
}

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("RTDM Real Time Driver Example");

--0-417035208-1169220297=:20673
Content-Type: application/octet-stream; name=Makefile
Content-Transfer-Encoding: base64
Content-Description: 402397780-Makefile
Content-Disposition: attachment; filename=Makefile

IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKIyBNQUtFRklMRSBURU1QTEFURSBG
T1IgS0VSTkVMIE1PRFVMRVMgQU5EIFVTRVIgU1BBQ0UgQVBQTElDQVRJT05T
ICMKIyBWMC4zIChDKSAyMDA2IHd3dy5jYXB0YWluLmF0ICMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMKCiMjIyBOYW1lcyBvZiB0aGUga2VybmVsIG1vZHVsZShzKSBhbmQg
dXNlciBzcGFjZSBhcHBsaWNhdGlvbihzKSAjIyMjCiMjIyAgIHNlcGFyYXRl
ZCBieSBzcGFjZXMgIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjCiMjIyAob21pdCBuYW1lcyBpZiBubyBtb2R1bGUocykgb3Ig
YXBwbGljYXRpb24ocykgaXMoYXJlKSBidWlsdCkgIyMjCktFUk5FTE1PRFVM
RVMgICAgID89IHJlYWx0aW1lZHJpdmVyClVTRVJBUFBTICAgICAgICAgID89
IHVzZXIKIyMjIFNLSU4gPSB4ZW5vLCBwb3NpeCBldGMuClNLSU4gICAgICAg
ICAgICAgID89IHhlbm8KVU5BTUUgICAgICAgICAgICAgOj0gJChzaGVsbCB1
bmFtZSAtcikKS0VSTkVMU09VUkNFRElSICAgPz0gL2xpYi9tb2R1bGVzLyQo
VU5BTUUpL2J1aWxkCgojIyMgWGVub21haSBkaXJlY3RvcnksIHhlbm8tY29u
ZmlnIGFuZCBsaWJyYXJ5IGRpcmVjdG9yeSAjIyMjIyMjIyMjIwpYRU5PX0RJ
UiAgICAgICAgICA/PSAvdXNyL3hlbm9tYWkKWEVOT19DT05GSUcgICAgICAg
Pz0gJChYRU5PX0RJUikvYmluL3hlbm8tY29uZmlnClhFTk9fTElCX0RJUiAg
ICAgID89ICQoc2hlbGwgJChYRU5PX0NPTkZJRykgLS1saWJyYXJ5LWRpcikK
CiMjIyBVc2VyIHNwYWNlIGFwcGxpY2F0aW9uIGNvbXBpbGUgb3B0aW9ucyAj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClVTRVJBUFBfTElCUyAgICAgID89
IC1sbmF0aXZlIC1scnRkbQpVU0VSQVBQX0xERkxBR1MgICA/PSAkKHNoZWxs
ICQoWEVOT19DT05GSUcpIC0tJChTS0lOKS1sZGZsYWdzKQpVU0VSQVBQX0NG
TEFHUyAgICA/PSAkKHNoZWxsICQoWEVOT19DT05GSUcpIC0tJChTS0lOKS1j
ZmxhZ3MpCgojIyMgR2VuZXJhbCBjb25maWd1cmF0aW9uIHN0dWZmICMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpDQyAgICAgICAgICAg
ICAgICA9ICAkKHNoZWxsICQoWEVOT19DT05GSUcpIC0tY2MpCgoKIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMKIyMjIyBVc3VhbGx5IHlvdSBkb24ndCBuZWVk
IHRvIG1vZGlmeSB0aGlzIGZpbGUgYmVsb3cgdGhpcyBsaW5lICMjIyMKIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMKCgojIyMjIyMjIyMjIyMjIyMjIEtFUk5F
TCBNT0RVTEUgU1RBUlQgIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IwpPQkpTICAgICAgOj0gJHtwYXRzdWJzdCAlLCAlLm8sICQoS0VSTkVMTU9E
VUxFUyl9CkNMRUFOVEhJUyA6PSAke3BhdHN1YnN0ICUsIC4lKiwgJChLRVJO
RUxNT0RVTEVTKX0KCmlmbmVxICgkKEtFUk5FTE1PRFVMRVMpLCkKaWZlcSAo
JChmaW5kc3RyaW5nIDIuNiwkKEtFUk5FTFNPVVJDRURJUikpLDIuNikKIyMj
IEtFUk5FTCAyLjYgIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMKCm9iai1tCSAgICAgICA6PSAkKE9CSlMp
CkVYVFJBX0NGTEFHUyA6PSAtSSQoWEVOT19ESVIpL2luY2x1ZGUKUFdEICAg
ICAgICAgIDo9ICQoc2hlbGwgcHdkKQphbGw6OiAkKFVTRVJBUFBTKQoJJChN
QUtFKSAtQyAkKEtFUk5FTFNPVVJDRURJUikgU1VCRElSUz0kKFBXRCkgbW9k
dWxlcwoKZWxzZSAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKIyMjIEtFUk5FTCAyLjQg
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMKCkhFTFAgOj0gLUkkKEtFUk5FTFNPVVJDRURJUikvaW5jbHVk
ZS94ZW5vbWFpL2NvbXBhdCAtSSQoWEVOT19ESVIpL2luY2x1ZGUKSU5DTFVE
RQk6PSAtSSQoS0VSTkVMU09VUkNFRElSKS9pbmNsdWRlICQoSEVMUCkKQ0ZM
QUdTCTo9IC1PMiAtV2FsbCAtRE1PRFVMRSAtRF9fS0VSTkVMX18gLURMSU5V
WCAkKElOQ0xVREUpCmFsbDo6ICQoT0JKUykgJChVU0VSQVBQUykKCQplbmRp
ZgplbmRpZgoKY2xlYW46OgoJJChSTSkgJChDTEVBTlRISVMpICouY21kICou
byAqLmtvICoubW9kLmMKCSQoUk0pIC1SIC50bXAqCiMjIyMjIyMjIyMjIyMj
IyMgS0VSTkVMIE1PRFVMRSBFTkQgIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjCgoKIyMjIyMjIyMjIyMjIyMjIyBVU0VSIEFQUExJQ0FUSU9O
UyBTVEFSVCAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKaWZuZXEgKCQo
VVNFUkFQUFMpLCkKVVNFUlNQIDo9ICR7cGF0c3Vic3QgJSwgJS5jLCAkKFVT
RVJBUFBTKX0KJChVU0VSQVBQUyk6ICQoVVNFUlNQKQoJJChDQykgLW8gJEAg
JDwgJChVU0VSQVBQX0NGTEFHUykgJChVU0VSQVBQX0xERkxBR1MpICQoVVNF
UkFQUF9MSUJTKQplbmRpZgoKY2xlYW46OgoJJChSTSkgJChVU0VSQVBQUykK
IyMjIyMjIyMjIyMjIyMjIyMgVVNFUiBBUFBMSUNBVElPTlMgRU5EICMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKCi5QSE9OWTogY2xlYW4KCg==

--0-417035208-1169220297=:20673
Content-Type: text/x-csrc; name="user.c"
Content-Description: 1570998766-user.c
Content-Disposition: inline; filename="user.c"

#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <sys/mman.h>

#include <native/task.h>
#include <native/timer.h>
#include <rtdm/rtdm.h>
#include "inc.h"

unsigned int my_state = 0;
int timer_started = 0;
int my_fd = -1;
int shutdownnow = 0;
RT_TASK my_task;
//                        --s-ms-us-ns
RTIME my_task_period_ns =   1000000000llu;

#ifdef USEMMAP
void *mmappointer;
#endif

/**********************************************************/
/*            CLOSE RT DRIVER                             */
/**********************************************************/
static int close_file( int fd, unsigned char *name) {
  int ret,i=0;
  do {
    i++;
    ret = rt_dev_close(fd);
    switch(-ret){
      case EBADF:   printf("%s -> invalid fd or context\n",name);
                    break;
      case EAGAIN:  printf("%s -> EAGAIN (%d times)\n",name,i);
                    rt_task_sleep(50000); // wait 50us
                    break;
      case 0:       printf("%s -> closed\n",name);
                    break;
      default:      printf("%s -> ???\n",name);
                    break;
    }
  } while (ret == -EAGAIN && i < 10);
  return ret;
}

/**********************************************************/
/*            CLEANING UP                                 */
/**********************************************************/
void cleanup_all(void) {
  if (my_state & STATE_FILE_OPENED) {
    close_file( my_fd, DEV_FILE " (user)");
    my_state &= ~STATE_FILE_OPENED;
  }
  if (my_state & STATE_TASK_CREATED) {
    printf("delete my_task\n");
    rt_task_delete(&my_task);
    my_state &= ~STATE_TASK_CREATED;
  }
  if (timer_started) {
    printf("stop timer\n");
    rt_timer_stop();
  }
}

void catch_signal(int sig) {
  shutdownnow = 1;
  cleanup_all();
  printf("exit\n");
  return;
}

/**********************************************************/
/*            REAL TIME TASK                              */
/**********************************************************/
void my_task_proc(void *arg) {
  int ret;
  ssize_t sz = sizeof(RTIME);
  ssize_t written = 0;
  ssize_t read = 0;
  int counter = 0;
  int readbackcounter;
  unsigned char buf[17] = "CAPTAIN WAS HERE\0";
  unsigned char buf2[17] = "XXXXXXXXXXXXXXXX\0";
/* no periodic task, due blocking read from the RT driver (see below 
too)
  ret = rt_task_set_periodic(NULL, TM_NOW, 
rt_timer_ns2ticks(my_task_period_ns));
  if (ret) {
    printf("error while set periodic, code %d\n",ret);
    goto exit_my_task;
  }
*/

#ifdef USEMMAP
  printf("ioctl = %d\n", rt_dev_ioctl(my_fd, MMAP, &mmappointer));
  printf("*p = %d, p = %p\n", *((int *)mmappointer), mmappointer);
#endif

  while (1) {
    sprintf(buf, "CAPTAIN %d", counter);
    counter++;
    if (counter > 100) counter = 0;
    /* switch to primary mode */
    ret = rt_task_set_mode(0, T_PRIMARY, NULL);
    if (ret) {
      printf("error while rt_task_set_mode, code %d\n",ret);
      goto exit_my_task;
    }
    
/*  // rt_dev_read blocks, so we can't use rt_task_wait_period here,
    //   otherwise we get a ETIMEDOUT 110 = Connection timed out
    //   after the next rt_task_wait_period
    ret = rt_task_wait_period(NULL);
    if (ret) {
      printf("error while rt_task_wait_period, code %d\n",ret);
      goto exit_my_task;
    }
*/
    sz = sizeof(buf);
    written = rt_dev_write(my_fd, &buf, sizeof(buf));
    printf("WRITE: written=%d sz=%d\n", written, sz);
    if (written != sz ) {
      if (written < 0 ) {
        printf("error while rt_dev_write, code %d\n",written);
      } else {
        printf("only %d / %d byte transmitted\n",written, sz);
      }
      goto exit_my_task;
    }

    sz = sizeof(buf2);
    read = rt_dev_read(my_fd, &buf2, sizeof(buf2));
    if (read == sz ) {
		printf("READ: read=%s\n",buf2);
    } else {
      if (read < 0 ) {
        printf("error while rt_dev_read, code %d\n",read);
      } else {
        printf("only %d / %d byte received \n",read,sz);
      }
    }

    // read blocks, so check if user hit CTRL-C meanwhile
    //   otherwise we segfault when mmap'ing
    if (shutdownnow == 1) break;
    
#ifdef USEMMAP
    *((int *)mmappointer + 10) = counter + 1000;
    printf("MMAP: *((int *)mmappointer + 10) = %d\n", 
                         *((int *)mmappointer + 10));
#endif

    rt_dev_ioctl(my_fd, SETVALUE, &counter);
    rt_dev_ioctl(my_fd, GETVALUE, &readbackcounter);
    printf("IOCTL: readbackcounter=%d\n", readbackcounter);
    
    
  }
exit_my_task:
  if (my_state & STATE_FILE_OPENED) {
    if (!close_file( my_fd, DEV_FILE " (write)")) {
      my_state &= ~STATE_FILE_OPENED;
    }
  }
  printf("exit\n");
}

/**********************************************************/
/*            MAIN: mainly RT task initialization         */
/**********************************************************/
int main(int argc, char* argv[]) {
  int ret = 0;
  signal(SIGTERM, catch_signal);
  signal(SIGINT, catch_signal);

  printf("PRESS CTRL-C to EXIT\n");
  /* no memory-swapping for this programm */
  mlockall(MCL_CURRENT | MCL_FUTURE);


  /* open DEV_FILE */
  my_fd = rt_dev_open( DEV_FILE, 0);
  if (my_fd < 0) {
    printf("can't open %s\n", DEV_FILE);
    goto error;
  }
  my_state |= STATE_FILE_OPENED;
  printf("%s opened\n", DEV_FILE);

  /* create my_task */
  ret = rt_task_create(&my_task,"my_task",0,50,0);
  if (ret) {
    printf("failed to create my_task, code %d\n",ret);
    goto error;
  }
  my_state |= STATE_TASK_CREATED;
  printf("my_task created\n");

  /* start my_task */
  printf("starting my_task\n");
  ret = rt_task_start(&my_task,&my_task_proc,NULL);
  if (ret) {
    printf("failed to start my_task, code %d\n",ret);
    goto error;
  }

  pause();
  return 0;

error:
  cleanup_all();
  return ret;
}

--0-417035208-1169220297=:20673
Content-Type: text/x-chdr; name="inc.h"
Content-Description: 1672826649-inc.h
Content-Disposition: inline; filename="inc.h"

// if TIMERINT is defined, the linux timer interrupt is used
//   otherwise the parallel port interrupt is used
#define TIMERINT

// if USEMMAP IS defined, also MMAP operations will be made
#define USEMMAP

#define DEV_FILE                  "demodev0"
#define DEV_FILE_NAME             "demodev"
#define DRV_NAME                  "demodrv"

#define BUFFER_SIZE     100000
#define BUFSIZE         17
#define PAR_INT         7
#define TIMER_INT       0
#define BASEPORT        0x378
#define MMAP            0
#define GETVALUE        1
#define SETVALUE        2

#define STATE_FILE_OPENED         1
#define STATE_TASK_CREATED        2

--0-417035208-1169220297=:20673--

