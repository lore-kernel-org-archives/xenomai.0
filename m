Date: Fri, 8 Oct 2010 09:01:48 +0200
From: Pavel Machek <pma@domain.hid>
Message-ID: <20101008070148.GB2255@domain.hid>
References: <20101007115728.GA24500@domain.hid>
	<4CADBDC2.8080600@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CADBDC2.8080600@domain.hid>
Subject: Re: [Xenomai-help] kernel oopses when killing realtime task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hi!

> > I have... quite an interesting setup here.
> > 
> > SMP machine, with special PCI card; that card has GPIOs and serial
> > ports. Unfortunately, there's only one interrupt, shared between
> > serials and GPIO pins, and serials are way too complex to be handled
> > by realtime layer.
> > 
> > So I ended up with
> > 
> >         // we also have an interrupt handler:                                                                                                                 
> >         ret = rtdm_irq_request(&my_context->irq_handle,
> >         gpio_rt_config.irq, demo_interrupt,
> >                                RTDM_IRQTYPE_SHARED,
> >         context->device->proc_name, my_context);
> > 
> > and 
> > 
> > static int demo_interrupt(rtdm_irq_t *irq_context)
> > {
> >         struct demodrv_context *ctx;
> >         int           dev_id;
> >         int           ret = RTDM_IRQ_HANDLED; // usual return value                                                                                           
> >         unsigned pending, output;
> > 
> >         ctx = rtdm_irq_get_arg(irq_context, struct demodrv_context);
> >         dev_id    = ctx->dev_id;
> > 
> >         if (!ctx->ready) {
> >                 printk(KERN_CRIT "Unexpected interrupt\n");
> >                 return XN_ISR_PROPAGATE;
> 
> Who sets ready and when? Looks racy.

Debugging aid; yes, this one is racy.

> >         rtdm_lock_put(&ctx->lock);
> >  
> >         /* We need to propagate the interrupt, so that PMC-6L serials                                                                                         
> >            work. Result is that interrupt latencies can't be                                                                                                  
> >            guaranteed when serials are in use.  */
> > 
> >          return RTDM_IRQ_HANDLED;
> > }
> > 
> > Unregistration is:
> >         my_context->ready = 0;
> >         rtdm_irq_disable(&my_context->irq_handle);
> 
> Where is rtdm_irq_free? Again, this ready flag looks racy.

Aha, sorry, I quoted wrong snippet. rtdm_irq_free() follows
immediately, like this:

int demo_close_rt(struct rtdm_dev_context   *context,
                  rtdm_user_info_t          *user_info)
{
        struct demodrv_context  *my_context;
        rtdm_lockctx_t          lock_ctx;
        // get the context                                                                                                                                    
        my_context = (struct demodrv_context *)context->dev_private;

        // if we need to do some stuff with preemption disabled:                                                                                              
        rtdm_lock_get_irqsave(&my_context->lock, lock_ctx);

        my_context->ready = 0;
        rtdm_irq_disable(&my_context->irq_handle);


        // free irq in RTDM                                                                                                                                   
        rtdm_irq_free(&my_context->irq_handle);

        // destroy our interrupt signal/event                                                                                                                 
        rtdm_event_destroy(&my_context->irq_event);

        // other stuff here                                                                                                                                   
        rtdm_lock_put_irqrestore(&my_context->lock, lock_ctx);

        return 0;
}

Now... I'm aware that lock_get/put around irq_free should be
unneccessary, as should be irq_disable and my ->ready flag. Those were
my attempts to work around the problem. I'll attach the full source at
the end.

> > Unfortunately, when the userspace app is ran and killed repeatedly (so
> > that interrupt is registered/unregistered all the time), I get
> > oopses in __ipipe_dispatch_wired() -- it seems to call into the NULL
> > pointer.
> > 
> > I decided that "wired" interrupt when the source is shared between
> > Linux and Xenomai, is wrong thing, so I disable "wired" interrupts
> > altogether, but that only moved oops to __virq_end. 
> 
> This is wrong. The only way to get a determistically shared IRQs across
> domains is via the wired path, either using the pattern Gilles cited or,
> in a slight variation, signaling down via a separate rtdm_nrtsig.

For now, I'm trying to get it not to oops; deterministic latencies are
the next topic :-(.

The hardware is little unusual that it generates interrupts at 1kHz,
whether realtime driver is loaded or not.

								Pavel

								
/**********************************************************/
/*    HARD REAL TIME RTDM Driver Skeleton V1.1            */
/*                                                        */
/*    Based on code of Jan Kiszka - thanks Jan!           */
/*    (C) 2006 Jan Kiszka, www.captain.at                 */
/*    (C) 2010 Pavel Machek, sysgo                        */
/*    License: GPL                                        */
/**********************************************************/

/* Note: Interrupt is shared between serial lines and GPIOs. That
   means that interrupt latencies can't be guaranteed when serials are
   in use.
*/

#include <linux/mman.h>
#include <rtdm/rtdm_driver.h>
#include "pmc6l-rt.h"

char dummy_buffer[BUFSIZE];
int  events;

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
	int			ready;
};

#define GPIO_CONF_LOW 0xb0
#define GPIO_CONF_HIGH 0xb2
#define GPIO_STATUS_IN 0xb4
#define GPIO_STATUS_OUT 0xb6
#define GPIO_IRQ_ID 0x2a

#define iowrite(bits, val, adr) iowrite##bits(cpu_to_be##bits(val), adr)
#define ioread(bits, adr) be##bits##_to_cpu(ioread##bits(adr))

#define pgwrite(dat, adr)	iowrite(16, (dat), gpio_rt_config.mmio+(adr))
#define pgread(adr)		ioread(16, gpio_rt_config.mmio+(adr))

/**********************************************************/
/*            INTERRUPT HANDLING                          */
/**********************************************************/

/*
 * Demo interrupt code; when GPIO #2 is changed, GPIO #4 is toggled.
 */
static int demo_interrupt(rtdm_irq_t *irq_context)
{
	struct demodrv_context *ctx;
	int           dev_id;
	int           ret = RTDM_IRQ_HANDLED; // usual return value
	unsigned pending, output;

	ctx = rtdm_irq_get_arg(irq_context, struct demodrv_context);
	dev_id    = ctx->dev_id;

	if (!ctx->ready) {
		printk(KERN_CRIT "Unexpected interrupt\n");
		return XN_ISR_PROPAGATE;
	}		

#if 0
	rtdm_lock_get(&ctx->lock);

	pending = pgread(GPIO_IRQ_ID);
	pgwrite(0, GPIO_IRQ_ID);
	output = pgread(GPIO_STATUS_OUT);
	output ^= (1<<3);
	pgwrite(output, GPIO_STATUS_OUT);

	// do stuff
	if (events > 1000) {
		rtdm_event_signal(&ctx->irq_event);
		events = 0;
	}
	events++;
        
	rtdm_lock_put(&ctx->lock);
	// those return values were dropped from the RTDM
	// ret = RTDM_IRQ_ENABLE | RTDM_IRQ_PROPAGATE;

	/* We need to propagate the interrupt, so that PMC-6L serials
	   work. Result is that interrupt latencies can't be
	   guaranteed when serials are in use.  */

	//	return XN_ISR_PROPAGATE;
	return RTDM_IRQ_HANDLED;
#else
	pending = pgread(GPIO_IRQ_ID);
	pgwrite(0, GPIO_IRQ_ID);
	output = pgread(GPIO_STATUS_OUT);
	output = output & (~(1<<3));
	if (pgread(GPIO_STATUS_IN) & (1<<1))
		output |= (1<<3);
	pgwrite(output, GPIO_STATUS_OUT);

	// those return values were dropped from the RTDM
	// ret = RTDM_IRQ_ENABLE | RTDM_IRQ_PROPAGATE;

	/* We need to propagate the interrupt, so that PMC-6L serials
	   work. Result is that interrupt latencies can't be
	   guaranteed when serials are in use.  */

	//	return XN_ISR_PROPAGATE;
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
	int dev_id = context->device->device_id;
	int ret;
    
	// get the context for our driver - used to store driver info
	my_context = (struct demodrv_context *)context->dev_private;

	// we also have an interrupt handler:
	ret = rtdm_irq_request(&my_context->irq_handle, gpio_rt_config.irq, demo_interrupt,
			       RTDM_IRQTYPE_SHARED, context->device->proc_name, my_context);

	if (ret < 0)
		return ret;

	/* IPC initialisation - cannot fail with used parameters */
 	rtdm_lock_init(&my_context->lock);
	rtdm_event_init(&my_context->irq_event, 0);
	my_context->dev_id         = dev_id;

	my_context->irq_events     = 0;
	my_context->irq_event_lock = 0;
	my_context->ready = 1;
	my_context->timeout = 0; // wait INFINITE

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
	// get the context
	my_context = (struct demodrv_context *)context->dev_private;

	// if we need to do some stuff with preemption disabled:
	rtdm_lock_get_irqsave(&my_context->lock, lock_ctx);

	my_context->ready = 0;
	rtdm_irq_disable(&my_context->irq_handle);


	// free irq in RTDM
	rtdm_irq_free(&my_context->irq_handle);

	// destroy our interrupt signal/event
	rtdm_event_destroy(&my_context->irq_event);

	// other stuff here
	rtdm_lock_put_irqrestore(&my_context->lock, lock_ctx);

	return 0;
}

/**********************************************************/
/*            DRIVER READ                                 */
/**********************************************************/
int demo_read_rt(struct rtdm_dev_context *context,
		 rtdm_user_info_t *user_info, void *buf, size_t nbyte)
{
	struct demodrv_context *ctx;
	int                     dev_id;
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

	// wait: if ctx->timeout = 0, it will block infintely until
	//       rtdm_event_signal(&ctx->irq_event); is called from our
	//       interrupt routine
	ret = rtdm_event_timedwait(&ctx->irq_event, ctx->timeout, &timeout_seq);

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
        ioctl_nrt:      NULL,

        read_rt:        demo_read_rt,
        read_nrt:       NULL,

        write_rt:       NULL,
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
	pmc_gpio_rt_config();
	printk("realtime driver at irq %d mmio %x\n", 
	       gpio_rt_config.irq, gpio_rt_config.mmio);
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

--- user app ----

/**********************************************************/
/*    HARD REAL TIME RTDM Driver User-Space Application   */
/*                                                        */
/*    Based on code of Jan Kiszka - thanks Jan!           */
/*    (C) 2006 Jan Kiszka, www.captain.at                 */
/*    (C) 2010 Pavel Machek, sysgo                        */
/*    License: GPL                                        */
/**********************************************************/

#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <sys/mman.h>

#include <native/task.h>
#include <native/timer.h>
#include <rtdm/rtdm.h>
#include "pmc6l-rt.h"

unsigned int my_state = 0;
int timer_started = 0;
int my_fd = -1;
int shutdownnow = 0;
RT_TASK my_task;
//                        --s-ms-us-ns
RTIME my_task_period_ns =   1000000000llu;


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
	/* no periodic task, due blocking read from the RT driver (see below too)
	   ret = rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(my_task_period_ns));
	   if (ret) {
	   printf("error while set periodic, code %d\n",ret);
	   goto exit_my_task;
	   }
	*/

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
	/* start timer */
	ret = rt_timer_start(TM_ONESHOT);
	switch (ret) {
	case 0:       printf("timer started\n");
		timer_started = 1;
		break;
	case -EBUSY:  printf("timer is running\n");
		timer_started = 0;
		break;
	case -ENOSYS: printf("can't start timer\n");
		return ret;
	}

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

