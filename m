MIME-Version: 1.0
In-Reply-To: <516F1510.3030608@xenomai.org>
References: <CAG5EsAGn8oNQkH-OkEpS6NHjW7y1vZfp5HjV3+FTGi-eh667pg@mail.gmail.com>
	<00DF7AD9-868B-4AFC-B385-8C47F8522E4B@mah.priv.at>
	<516F1510.3030608@xenomai.org>
From: Ross Williamson <rwilliamson@astro.caltech.edu>
Date: Wed, 17 Apr 2013 16:12:55 -0700
Message-ID: <CAG5EsAHjpA0JTKHGVsq2Egbq+r3Hx=xV_U3bp+zWxHa0dUTrzg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] rtdm and rasberry-pi GPIO
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

So I managed to get it working in kernel space - I'm not entirely sure what
I did to fix it - I did a full read/modify/write on the GPIO registers and
changed the gpio pointer to u8 but that's about it.  Works ok at outputting
a 10khz square wave with about a few us latency but doesn't look that much
better than the user-space however I haven't done any load tests yet so
I'm guessing that doesn't say much. Anyhow code is below - feel free to rip
it apart or tell me better ways of doing things.

#include <linux/module.h>
#include <linux/ioport.h>
#include <asm/io.h>
#include <rtdm/rtdm_driver.h>

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

#define HEARTBEAT_PERIOD 50000 /* 10khz */

static u8 *gpio = NULL;
static rtdm_task_t heartbeat_task;
static int end = 0;

/* NOTE this is all a hack to work on GPIO7 */

void heartbeat(void *cookie)
{
  int state = 0;

    while (!end) {
      rtdm_task_wait_period();
      if (state)
iowrite32((1<<7),(gpio+GPSET0));
      else
iowrite32((1<<7),(gpio+GPCLR0));
      state ^= 1;
    }
}

int __init init_heartbeat(void)
{
  unsigned int data;
  struct resource *mem = NULL;
  int err = 0;

  mem = request_mem_region(GPIO_BASE_VIRT,0xfff,"gpio");
  if (mem == NULL) {
    printk("Could not request mem region\n");
    err = -ENOMEM;
    goto err;
  }  else {
    printk("Have access to mem region\n");
  }


  gpio = ioremap_nocache(GPIO_BASE_VIRT, 0xfff);
  if (gpio == NULL) {
    printk("Could not request gpio region\n");
    err = -ENOMEM;
    goto err;
  }  else {
    printk("Have access to gpio region\n");
  }

  data = ioread32(gpio+GPFSEL0);
  data &= ~(7<<21);
  iowrite32(data,(gpio+GPFSEL0));

  data = ioread32(gpio+GPFSEL0);
  data |= (1<<21);
  iowrite32(data,(gpio+GPFSEL0));

  data = ioread32(gpio + GPFSEL0);
  printk("Should now be high %x\n", data);
  //return 0;
  return rtdm_task_init(&heartbeat_task, "heartbeat", heartbeat, NULL,
  99, HEARTBEAT_PERIOD);
 err:
  return err;
}

void __exit cleanup_heartbeat(void)
{
  end = 1;
  rtdm_task_join_nrt(&heartbeat_task, 100);
  iounmap(gpio);
  printk("Unliading modklskdksdf\n");
  release_mem_region(GPIO_BASE_VIRT, 0xfff);
}

module_init(init_heartbeat);
module_exit(cleanup_heartbeat);



On Wed, Apr 17, 2013 at 2:33 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 04/17/2013 10:59 PM, Michael Haberler wrote:
>
> > Ross,
> >
> > any reason not to use just userland memory mapped port I/O like with
> this library: http://www.airspayce.com/mikem/bcm2835 ?
> >
> > that worked fine for me with a userland RT thread, no drivers needed
>
>
> It is a bad idea to access GPIO registers in user-space via memory
> mapped I/O: you will not get the mutual exclusion the kernel driver
> gives you.
>
> --
>                                                                 Gilles.
>



-- 
Ross Williamson
Research Scientist - Sub-mm Group
California Institute of Technology
626-395-2647 (office)
312-504-3051 (Cell)
