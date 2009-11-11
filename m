References: <200911111422.11402.anisha.kaul@domain.hid>
	<4AFA8197.7070005@domain.hid>
In-Reply-To: <4AFA8197.7070005@domain.hid>
MIME-Version: 1.0
Date: Wed, 11 Nov 2009 19:32:10 +0530
Message-ID: <200911111932.10783.anisha.kaul@domain.hid>
From: Anisha Kaul <anisha.kaul@domain.hid>
content-type: multipart/mixed; boundary="Boundary-00=_iPs+KNJ5wtSv+FB"
Subject: Re: [Xenomai-help] unable to open serial port from a kernel module
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

--Boundary-00=_iPs+KNJ5wtSv+FB
content-type: text/plain; charset=iso-8859-1
content-transfer-encoding: 7bit
content-disposition: inline

On Wednesday November 11 2009 14  : 49  : 19 you wrote:
> Anisha Kaul wrote:
> > hi,
> >
> > when i use rt_dev_open ("/dev/ttyS0", 0); from the function init_module
> > () of a self written kernel module, it returns -19 ! What must be the
> > reason, can't a file be opened from a kernel module ?
>
> Please read documentation and examples more carefully: "rtdev0" is the
> answer.
>
> Jan

Hi,

I forgot to attach the kernel module file as well as the user space file in 
the previous mail. Hereby I have included both of them !

kernel module file: serialPortISR.c
user space file   : userSpace.c

thanks,
anisha

--Boundary-00=_iPs+KNJ5wtSv+FB
content-type: text/x-csrc; charset=iso-8859-1; name="serialPortISR.c"
content-transfer-encoding: 7bit
content-disposition: attachment; filename="serialPortISR.c"

#include <native/task.h>
#include <native/heap.h>
#include <native/intr.h>
#include <linux/kernel.h>
#include <rtdm/rtdm_driver.h>

#define PORT 0x3F8

RT_INTR serialRT;
RT_HEAP heap_desc;
rtdm_task_t task;
char*   shmem;

static rtdm_task_t tasklet;

static int times;
rtdm_task_proc_t resetRegisters (void * f)
{
    outb (0x83, PORT + 3);
    outb (0x01, PORT + 0);
    outb (0x00, PORT + 1);
    outb (0x03, PORT + 3);
    outb (0x01, PORT + 1);
    outb (0x27, PORT + 2);
    outb (0x08, PORT + 4);

    return NULL;
}

rt_isr_t isrSerialPort (int irq, void *dev_id, struct pt_regs *regs)
{
    times++;
    printk (KERN_ALERT "\nisrSerialPort called %d ", times);

    *shmem = inb (PORT);

    printk ("\nsharedMem: %s", shmem);

    rtdm_task_init (&tasklet, "tasklet", resetRegisters, NULL, 1, 0);
    
    return (rt_isr_t) IRQ_HANDLED;
}

int init_module ()
{
    rt_intr_create (&serialRT, "softbrainISR", 4, isrSerialPort, NULL, I_SHARED);
    rt_intr_enable (&serialRT);

    outb (0x83, PORT + 3);
    outb (0x01, PORT + 0);
    outb (0x00, PORT + 1);
    outb (0x03, PORT + 3);
    outb (0x01, PORT + 1);
    outb (0x27, PORT + 2);
    outb (0x08, PORT + 4);

    rt_heap_create (&heap_desc, "MyHeap", 16384, H_SHARED);
    rt_heap_alloc (&heap_desc, 0, TM_NONBLOCK, (void*)&shmem);

    return result;
}

void cleanup_module ()
{
    rt_heap_free (&heap_desc, &shmem);
    rt_intr_delete (&serialRT);

    printk (KERN_ALERT "\ncleanup_module called\n");
}

MODULE_LICENSE ("GPL");

--Boundary-00=_iPs+KNJ5wtSv+FB
content-type: text/x-csrc; charset=iso-8859-1; name="userSpace.c"
content-transfer-encoding: 7bit
content-disposition: attachment; filename="userSpace.c"

#include <sys/mman.h>
#include <native/task.h>
#include <native/timer.h>
#include <native/heap.h>
#include <string.h>
#include <rtdm/rtdm.h>

RT_TASK task_desc;
RT_HEAP heap_desc;
void*   shmem;

int main ()
{
    mlockall (MCL_CURRENT|MCL_FUTURE);

    rt_heap_bind  (&heap_desc, "MyHeap", TM_NONBLOCK);
    rt_heap_alloc (&heap_desc, 1, TM_NONBLOCK, &shmem);

/***************************************/
    int result = rt_dev_open  ("rtdev0", 0);

    printf ("\n%d passed ", result);

    rt_dev_write (result, "abcd", 4);
/***************************************/
}

--Boundary-00=_iPs+KNJ5wtSv+FB
content-type: text/plain; charset=us-ascii
content-transfer-encoding: 7bit
content-disposition: inline



-------------------------------------
Hi-Tech Gears Limited, Gurgaon, India


--Boundary-00=_iPs+KNJ5wtSv+FB--



