From: "Terry Fryar" <terry.fryar@domain.hid>
References: <C3860BCA25804175ABD53E2F2B1A942A@TerryHP>
	<4EFCFF53.7040508@domain.hid> <4EFD910F.3080404@domain.hid>
In-Reply-To: <4EFD910F.3080404@domain.hid>
Date: Mon, 2 Jan 2012 08:27:37 -0600
Message-ID: <3DFE8CE1F70D48ECB3CDD7F7795FCE8B@TerryHP>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Mode switches??
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles, here's the test code.  The rt stats are printed in the module exit
function....

//==========================================================================
==
//
//
//==========================================================================
==
#include <linux/module.h>
#include <linux/gpio.h>
#include <linux/timer.h>
#include <linux/delay.h>
#include <linux/fs.h>
#include <linux/ctype.h>
#include <linux/device.h>
#include <linux/spi/spidev.h>
#include <native/task.h>
#include <native/timer.h>
#include <native/misc.h>
#include <native/queue.h>
#include <native/intr.h>
#include <native/cond.h>
#include <native/mutex.h>
#include <asm/uaccess.h>

MODULE_LICENSE("Dual BSD/GPL");

#define IRQDRV_NAME "irqdrv"
#define TASK_PRIO 	50 /* 99-Highest RT priority */
#define TASK_MODE   0 /* No flags */
#define TASK_STKSZ  0 /* Stack size (use default one) */
#define GPIO_PIN	132
#define GPIO132_IRQ 33
#define BASEIO_CONF1 		0x48000000
#define BASEIO_CONF2 		0x49050000
#define BASEIO_DATA  		0x49050000
#define GPIO_OE				0x6034
#define GPIO_CLEARDATA 		0x6090
#define GPIO_SETDATA		0x6094
#define GPIO_DATAIN			0x6038
#define GPIO_SETIRQENABLE1	0x6064
#define GPIO_FALLINGDETECT	0x604C
#define GPIO132_MASK		0x00000010
#define GPIO134_MASK		0x00000040

#define DEBUG_PRINTK

static struct class *irqdrv_class;
static int irqdrv_major = 0;
static int irqdrv_devID = 0;
static RT_TASK irqdrv_taskDesc1;
static RT_INTR irqdrv_isrDesc1;
static bool irqdrv_terminated = true;
static bool irqdrv_task_finished = false;
static bool irqdrv_hi = false;
static ulong* irqdrv_map;
static RT_COND irqdrv_cond;
static RT_MUTEX irqdrv_mutex;

int irqdrv_open(struct inode *inode, struct file *filp);
int irqdrv_release(struct inode *inode, struct file *filp);
ssize_t irqdrv_read(struct file *filp, char *buf, size_t count, loff_t
*f_pos);
ssize_t irqdrv_write(struct file *filp, const char *buf, size_t count,
loff_t *f_pos);

struct file_operations irqdrv_funcs = {
    read: irqdrv_read,
    write: irqdrv_write,
    open: irqdrv_open,
    release: irqdrv_release
};
//==========================================================================
==
int irqdrv_isr(struct xnintr *intr)
{
	int retval = RT_INTR_HANDLED;
	int err;

	//rt_mutex_acquire(&irqdrv_mutex,100000000);
	if ((err = rt_cond_signal(&irqdrv_cond)) != 0)
    	printk("<1>irqdrv: rt_cond_signal error: %d\n", err);

	//rt_mutex_release(&irqdrv_mutex);
	return(retval);
}
//==========================================================================
==
void irqdrv_task(void *args)
{
	while (!irqdrv_terminated)
	{
		rt_task_sleep(100000000);
		printk("<1>irqdrv: test\n");
	}
	irqdrv_task_finished = true;
}
//==========================================================================
==
void init_gpio()
{
	irqdrv_map = ioremap(BASEIO_CONF1, SZ_16K);
	if (!irqdrv_map)
	{
		printk("<1>irqdrv: ioremap failed!\n");
		return;
	}
	irqdrv_map[0x215C/4] = 0x01040104; // set gpio 132/133 to input with
no pullups (xlator causes builtin pullups to not work!)
	irqdrv_map[0x2164/4] = 0x00040004; // set gpio 136/137 to output
(used to control lvl xlator direction)
	irqdrv_map[0x2160/4] = 0x00040004; // set gpio 134/135 to output
(used for PWM output)

	iounmap(irqdrv_map);

	irqdrv_map = ioremap(BASEIO_CONF2, SZ_16K);
	if (!irqdrv_map)
	{
		printk("<1>irqdrv: ioremap failed!\n");
		return;
	}

	irqdrv_map[GPIO_OE/4] = irqdrv_map[GPIO_OE/4] | 0x00000030; // set
as input
	irqdrv_map[GPIO_OE/4] = irqdrv_map[GPIO_OE/4] & 0xFFFFFC3F; //
134,135,136,137 set as output
	irqdrv_map[GPIO_FALLINGDETECT/4] = irqdrv_map[GPIO_FALLINGDETECT/4]
| 0x00000030; // enable falling edge detect for irq generation
	irqdrv_map[GPIO_SETIRQENABLE1/4] = 0x00000030; // enable interrupt
generation
	irqdrv_map[GPIO_CLEARDATA/4] = 0x00000200; // 137 set low so B->A
for 132,133 on xlator
	irqdrv_map[GPIO_SETDATA/4] = 0x00000100; // 136 set high so A->B for
134,135 on xlator

	iounmap(irqdrv_map);
}
//==========================================================================
==
static int irqdrv_init(void) {
	int err;

    // create the device
    if ((irqdrv_major = register_chrdev(irqdrv_major, IRQDRV_NAME,
&irqdrv_funcs)) < 0)
    {
        printk("<l>irqdrv: register_chrdev error: %i\n", irqdrv_major);
        return irqdrv_major;
    }
    irqdrv_class = class_create(THIS_MODULE, IRQDRV_NAME);
    device_create(irqdrv_class, NULL, MKDEV(irqdrv_major, irqdrv_devID),
NULL, IRQDRV_NAME "%d", irqdrv_devID);

    init_gpio();

    irqdrv_map = ioremap(BASEIO_DATA, SZ_16K);
	if (!irqdrv_map)
	{
		printk("<1>irqdrv: ioremap failed!\n");
		irqdrv_terminated = true;;
	}

	if ((err = rt_mutex_create(&irqdrv_mutex,"irqdrv_mutex")) != 0)
    {
    	printk("<1>irqdrv: rt_cond_create error: %d\n", err);
    	return err;
    }

	if ((err = rt_cond_create(&irqdrv_cond,"irqdrv_cond")) != 0)
    {
    	printk("<1>irqdrv: rt_cond_create error: %d\n", err);
    	return err;
    }

    int irq = gpio_to_irq(GPIO_PIN);
    if ((err = rt_intr_create(&irqdrv_isrDesc1, "irqdrv_isr", irq,
irqdrv_isr, NULL, 0)) != 0)
    {
    	printk("<1>irqdrv: rt_intr_create error: %d\n", err);
    	return err;
    }

    if ((err = rt_intr_enable(&irqdrv_isrDesc1)) != 0)
    {
    	printk("<1>irqdrv: rt_intr_enable error: %d\n", err);
    	return err;
    }

    // start the RT task
    if ((err =
rt_task_create(&irqdrv_taskDesc1,"irqdrvTask",TASK_STKSZ,TASK_PRIO,0)) == 0)
    {
    	irqdrv_terminated = false;
    	rt_task_start(&irqdrv_taskDesc1,&irqdrv_task,NULL);
    }
    else
    {
    	printk("<1>irqdrv: rt_task_create error: %i\n", err);
    	return err;
    }
    return 0;
}
//==========================================================================
==
int irqdrv_open(struct inode *inode, struct file *filp) {
#ifdef DEBUG_PRINTK
    printk("<1>irqdrv: open!\n");
#endif
    return 0;
}
//==========================================================================
==
ssize_t irqdrv_read(struct file *filp, char *buf, size_t count, loff_t
*f_pos) {
#ifdef DEBUG_PRINTK
	printk("<1>irqdrv: read!\n");
#endif
    return 0;
}
//==========================================================================
==
ssize_t irqdrv_write(struct file *filp, const char *buf, size_t count,
loff_t *f_pos) {
#ifdef DEBUG_PRINTK
	printk("<1>irqdrv: write!\n");
#endif
    return 0;
}
//==========================================================================
==
int irqdrv_release(struct inode *inode, struct file *filp) {
    return 0;
}
//==========================================================================
==
static void irqdrv_exit(void) {

    RT_TASK_INFO info;
    rt_task_inquire(&irqdrv_taskDesc1, &info);
    printk("<1>irqdrv: BASEPRIOR: %d  CURPRIOR: %d  EXECTIME: %ld  MODESW:
%d  CTXSW:
%d",info.bprio,info.cprio,info.exectime,info.modeswitches,info.ctxswitches);

    irqdrv_terminated = true;
    while (!irqdrv_task_finished) rt_task_sleep(500000);

    rt_intr_delete(&irqdrv_isrDesc1);
    rt_task_delete(&irqdrv_taskDesc1);
    rt_cond_delete(&irqdrv_cond);
    rt_mutex_delete(&irqdrv_mutex);
	iounmap(irqdrv_map);

    device_destroy(irqdrv_class, MKDEV(irqdrv_major, irqdrv_devID));
    class_destroy(irqdrv_class);
    unregister_chrdev(irqdrv_major, IRQDRV_NAME);
}
//==========================================================================
==
module_init(irqdrv_init);
module_exit(irqdrv_exit);





 

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org] 
Sent: Friday, December 30, 2011 4:23 AM
To: Terry Fryar
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Mode switches??

On 12/30/2011 01:01 AM, Gilles Chanteperdrix wrote:
> On 12/29/2011 10:43 PM, Terry Fryar wrote:
>> Using 2.6.0, I am have trouble understanding the results of the
>> rt_task_info() call?
>>  
>> Have a very simple kernel module that fires off an ISR routine and a 
>> xenomai task.  The IRQ is not firing for these tests, so it's not doing
anything.
>> Here's the xenomai rt task created using rt_create_task():
>>  
>> void irqdrv_task(void *args)
>> {
>>     while (!irqdrv_terminated)
>>      {
>>           rt_task_sleep(10000000);
>>      }
>> }
>>  
>> So, in the driver "exit" code, right before I delete this task I do a
>> rt_task_info() and I see no context switches and very little exec 
>> time for this task.  However, it's showing 1,000,000 mode switches in 
>> just 5 or 10 seconds of exec time??
>>  
>> The info.modeswitches is the number of times the task switches 
>> between primary and secondary mode, yes??  Why in the world are there 
>> so many for a small task doing nothing but call a xenomai function, 
>> and in a kernel driver to boot!!
>>  
>> Am I missing something here....shouldn't mode switches be zero???  
>> I'm not calling any linux kernel functions...it shouldn't have switched
ever??
> 
> mode switches do not exist for kernel-space tasks. So, reading the 
> modeswitch member of the task info structure for a kernel space task 
> does not really make sense. Which is why probably nobody else noticed 
> (that, and the fact that the native API in kernel-space is not very 
> much in use, these days).
> 
the mode switches count should still be zero. Could you show us the full
test code?

-- 
                                                                Gilles.


