From: Nitin Kulkarni <nitink@kth.se>
Date: Mon, 29 May 2017 20:27:41 +0000
Message-ID: <1496089661516.77105@kth.se>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] GPIO Interrupt is registered in Xenomai but handler is
 not invoked when triggered
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello all,

I am new to Xenomai and I am trying to run a simple interrupt handler set u=
p for a GPIO .

I have successfully set up and ran without ipipe and Xenomai patched.

But when I use the RTDM interfaces rtdm_irq_request() to set up a handler, =
it is registered and shows when I do cat /proc/xenomai/irq

but the handler is not invoked when I trigger the gpio pin.


Other thing I have observed is, after patching ipipe & Xenomai when I set u=
p a usual linux irq handler using request_irq() ,

the handler is invoked continuously and the interrupt doesn't seem to be cl=
eared after executing the handler once although I

am using an edge triggered interrupt.


I have seen similar issues posted but most of the solutions I found are spe=
cific to HW (usually ARM).

I am using an Intel Joule running Linux 4.4.43 kernel.. Did anyone face sim=
ilar issues on x86 arch ?


Please suggest what I might be missing. Find my code below since I couldn't=
 attach the file because my mail exchange server complained :/


Regards ,

Nitin?




#include <linux/gpio.h>
#include <linux/module.h>
#include <rtdm/driver.h>
#include <rtdm/rtdm.h>
#include <linux/interrupt.h>


MODULE_DESCRIPTION("RTDM driver for Intel Joule GPIO");
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Nitin Kulkarni");
MODULE_VERSION("1.0");

static unsigned int irq_num;
static unsigned int gpioLED =3D 340;
static unsigned int gpioButton =3D 343;
static bool value =3D false;
static rtdm_irq_t irq_handle;
static int num_of_intr =3D 0;

static int gpio_irq_handler(rtdm_irq_t * irq)
{
value =3D !value;
gpio_set_value(gpioLED, value); // toggle the led everytime irq handler is =
invoked
        printk("GPIO interrupt \n");
num_of_intr++;
return RTDM_IRQ_HANDLED;
}


static int __init rtdm_init (void)
{
int err;
if ((err =3D gpio_request(gpioButton, THIS_MODULE->name)) !=3D 0) {
printk(" gpio_request gpioButton failed ! \n");
return err;
}

if ((err =3D gpio_direction_input(gpioButton)) !=3D 0) {

printk(" gpio_direction_input gpioButton failed ! \n");
gpio_free(gpioButton);
                return err;
}

irq_num =3D gpio_to_irq(gpioButton);

printk(" IRQ number %d !  \n",irq_num);

if ((err =3D gpio_request(gpioLED, THIS_MODULE->name)) !=3D 0) {

printk(" gpio_request gpioLED failed ! \n");
gpio_free(gpioButton);
return err;
}

if ((err =3D gpio_direction_output(gpioLED, 0)) !=3D 0) {

printk(" gpio_direction_input gpioLED failed ! \n");
gpio_free(gpioLED);
gpio_free(gpioButton);
return err;
}

err =3D irq_set_irq_type(irq_num,  IRQF_TRIGGER_RISING);

if(err)
{
gpio_free(gpioLED);
gpio_free(gpioButton);
printk(" irq_set_irq_type failed ! \n");
return err;
}

err =3D rtdm_irq_request(&irq_handle,irq_num,(rtdm_irq_handler_t)gpio_irq_h=
andler, RTDM_IRQTYPE_EDGE,THIS_MODULE->name, NULL);

printk("after request irq =3D %d \n",irq_handle.irq);

if(err)
{
gpio_free(gpioLED);
gpio_free(gpioButton);?
printk(" rtdm_irq_request failed ! \n");
return err;
}

err =3D rtdm_irq_enable(&irq_handle);

if (err < 0) {
printk("rtdm_irq_enable failed \n");
return err;
}
return 0;
}



static void __exit rtdm_exit (void)
{
rtdm_irq_free(&irq_handle);
gpio_free(gpioLED);
gpio_free(gpioButton);

printk("The number of intr is %d \n",num_of_intr);
}


module_init(rtdm_init);
module_exit(rtdm_exit);
MODULE_LICENSE("GPL");



