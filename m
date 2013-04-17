MIME-Version: 1.0
From: Ross Williamson <rwilliamson@astro.caltech.edu>
Date: Wed, 17 Apr 2013 13:12:22 -0700
Message-ID: <CAG5EsAGn8oNQkH-OkEpS6NHjW7y1vZfp5HjV3+FTGi-eh667pg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] rtdm and rasberry-pi GPIO
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I'm trying to get a simple rtdm module to toggle the GPIO pins on
a raspberry pi on and off.  I've currently reverted back to writing a
none-realtime module but with the Xenemoai kernel booted.  The problem is
that I have  kernel hangs intermittently   It usually does but sometimes is
fine and only on write operation not read (and the read value seems ok).
I'm pretty new to this so suspect it's something dumb.  Code is below:

#include <linux/module.h>
#include <linux/ioport.h>
#include <asm/io.h>

MODULE_LICENSE("GPL");

#define BCM2708_PERI_BASE_VIRT 0x20000000
#define GPIO_BASE_VIRT (BCM2708_PERI_BASE_VIRT + 0x200000) /* GPIO
controller */

//Offsets of registers
#define GPFSEL0 (0x00) /*GPIO Function Select 0*/
#define GPFSEL1 (0x04) /*GPIO Function Select 1*/
#define GPFSEL2 (0x08) /*GPIO Function Select 2*/
#define GPFSEL3 (0x0C) /*GPIO Function Select 3*/
#define GPFSEL4 (0x10) /*GPIO Function Select 4*/
#define GPFSEL5 (0x14) /*GPIO Function Select 5*/

#define GPSET0 (0x1C) /*GPIO pin Output Set 0*/
#define GPSET1 (0x20) /*GPIO pin Output Set 1*/

#define GPCLR0 (0x28) /*GPIO pin Output Clear 0*/
#define GPCLR1 (0x2C) /*GPIO pin Output Clear 1*/

/*There are any more but these should be enough*/

#define HEARTBEAT_PERIOD 1000000 /* 100 ms */

static __iomem *gpio = NULL;

int __init init_heartbeat(void)
{
  unsigned int data;
  struct resource *mem = NULL;
  int err = 0;

  mem = request_mem_region(GPIO_BASE_VIRT,4096,"gpio");
  if (mem == NULL) {
    printk("Could not request mem region\n");
    err = -ENOMEM;
    goto err;
  }  else {
    printk("Have access to mem region\n");
  }

  gpio = ioremap_nocache(GPIO_BASE_VIRT, 4096);
  if (gpio == NULL) {
    printk("Could not request gpio region\n");
    err = -ENOMEM;
    goto err;
  }  else {
    printk("Have access to gpio region\n");
  }

  //Setup GPIO 7 as output
  //Need to set bit 21 to 1 on GPFSEL0
  //Need write - the set for some reason and this is
  //obvously screwing up the other settings
  //  iowrite32((u32)0, gpio+GPFSEL0); //Hangs most of the time but not all
  data = ioread32(gpio+GPFSEL0);
  //iowrite32(0x200000,gpio+GPFSEL0);
  printk("finished with GPIO setup\n");

  //And set high as a test - Just bit 7 on GPSET0
  //iowrite32(data,gpio+GPSET0);
  data = ioread32(gpio + GPFSEL0);
  printk("Should now be high %x\n", data);
  return 0;
 err:
  return 1;
  //  return rtdm_task_init(&heartbeat_task, "heartbeat", heartbeat, NULL,
  // 99, HEARTBEAT_PERIOD);
}

void __exit cleanup_heartbeat(void)
{
  // end = 1;
  // rtdm_task_join_nrt(&heartbeat_task, 100);
  iounmap(gpio);
  printk("Unliading modklskdksdf\n");
  release_mem_region(GPIO_BASE_VIRT, 4096);
}

module_init(init_heartbeat);
module_exit(cleanup_heartbeat);
-- 
Ross Williamson
Research Scientist - Sub-mm Group
California Institute of Technology
626-395-2647 (office)
312-504-3051 (Cell)
