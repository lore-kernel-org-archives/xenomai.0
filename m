Date: Wed, 19 Dec 2007 16:06:22 +0100
From: Juan Antonio Garcia Redondo <juan-antonio.garcia@domain.hid>
Message-ID: <20071219150622.GA15974@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
Subject: [Xenomai-help] PIOX irq problems with at91sam9260
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
Cc: jagarcia@domain.hid


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello list,

I'm testing xenomai 2.4.0 (kernel 2.6.20, adeos-ipipe-2.6.20-arm-1.8-02) 
over a at91sam9260 based board. The initial tests runs OK but I've problems 
with the PIOX interrupts. It seems that, to work properly with the
interrupt, I need to install first the interrupt on the linux side.

Environment:
	o A sligtly modified user_irq.c from the xenomai
	documentation.
	o A normal linux kernel module which does nothing except 
	catching the irq received as parameter.
	o PIB_11 y PIOB_10 in short circuit.
 

Test 1:
	o External gpio programming as input(PIOB_11)
	# test_irq 75
		Waiting for irq 75 ...
	
	o Nothing occurs although I've set and reset the PIOB_10. The
	first thing I see is that the PIOB_IMR is 0x000000 when I'll expect
	0x00000800.

Test 2:
	o External gpio programming as input(PIOB_11)
	# insmod irqena.ko gpio_in=75
	0 Now the PIOB_IMR is 0x00000800
	# rmmod irqena
	# test_irq 75
	    Waiting for irq 75
	o External gpio PIOB_10 set and reset.
	#  ..........
	   Waiting for irq 75
           Arrives irq -> 1
	   Arrives irq -> 1
	   ..................

I've attached the tests programs.

Any hints ?

Regards,
	Juan Antonio
	
	


--/04w6evG8XlLl3ft
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="test_irq.c"

#include <sys/mman.h>
#include <native/task.h>
#include <native/intr.h>

#define IRQ_NUMBER 89  /* Intercept interrupt #7 */
#define TASK_PRIO  99  /* Highest RT priority */
#define TASK_MODE  0   /* No flags */
#define TASK_STKSZ 0   /* Stack size (use default one) */

RT_INTR intr_desc;

RT_TASK server_desc;

static int irq_number = IRQ_NUMBER;

void irq_server (void *cookie)

{
    int ret;
    printf("Waiting for irq %d\n", irq_number);

    for (;;) {

       /* Wait for the next interrupt. */
       ret = rt_intr_wait(&intr_desc,TM_INFINITE);

       if (ret > 0) {
           /* Process interrupt. */
           printf("Arrives irq ->%d\n", ret);
       } else {
           printf("Error %d\n", ret);
       }
    }
}

int main (int argc, char *argv[])

{
    int err;

    if (argc > 1)
        irq_number = atoi(argv[1]);

    mlockall(MCL_CURRENT|MCL_FUTURE);

    err = rt_intr_create(&intr_desc,"MyIrq",irq_number,0);

    err = rt_task_create(&server_desc,
                         "MyIrqServer",
                         TASK_STKSZ,
                         TASK_PRIO,
                         TASK_MODE);
    if (!err)
        rt_task_start(&server_desc,&irq_server,NULL);

    pause();

}

void cleanup (void)

{
    rt_intr_delete(&intr_desc);
    rt_task_delete(&server_desc);
}


--/04w6evG8XlLl3ft
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="irqena.c"

#include <linux/module.h>
#include <linux/version.h>
#include <linux/module.h>
#include <linux/interrupt.h>
#include <asm/arch/gpio.h>

#define MODULE_NAME "irqena"

static uint gpio_in = 0;
static uint irq;

irqreturn_t
irqtest_irq_handler(int irq, void *dev_id)
{
        return IRQ_HANDLED;
}


static int __init irqtest_init(void)
{
        irq = irq_canonicalize(gpio_in);

        if (request_irq(irq,
                        irqtest_irq_handler, IRQF_DISABLED, MODULE_NAME, NULL))
        {
                printk(KERN_ERR "I can't use irq %d\n", irq);
                return -EINVAL;
        }
        return 0;
}

module_init(irqtest_init);

static void __exit irqtest_exit(void)
{
        free_irq(irq, NULL);
}
module_exit(irqtest_exit);

module_param(gpio_in, uint, 0444);
MODULE_PARM_DESC(gpio_in, "Input pin");


MODULE_DESCRIPTION("Irq Enable");
MODULE_LICENSE("GPL");

--/04w6evG8XlLl3ft--

