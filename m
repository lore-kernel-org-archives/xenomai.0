Message-ID: <459B6DAD.4030406@domain.hid>
Date: Wed, 03 Jan 2007 09:47:41 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010006000704020107080609"
Subject: [Xenomai-help] parallelport module for measuring external interrupt
	latency
Reply-To: Markus.Franke@domain.hid
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

This is a multi-part message in MIME format.
--------------010006000704020107080609
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Dear Xenomai-Users / Developers,

I have finished my work on a parallelport module for measuring external
interrupt latencies. It is based on another kernel-module working on
plain linux. Interrupt latencies are measured via triggering an
interrupt over a connection between data pin 7 and the ACK-pin.

The kernel module loads fine without any problems. When starting the
User-space task the system freezes without any output in the kernel log.
 I was trying to solve the problem for several days now without any
success. I would appreciate, if somebody would have a short look on it.
Maybe its just a small problem which can be fixed easily.

The kernel-module as well as the user-space task are attached.

Thanks in advance and regards,
Markus Franke

PS.: I am aware of the fact that there is already a testcase in the
testsuite for measuring external interrupt latencies. Nevertheless, I
would like to gain experiences in developing with Xenomai and I want to
know why the attached code doesn't work. I will also work with the
testcases in the testsuite soon.

--------------010006000704020107080609
Content-Type: text/x-csrc;
 name="parport_interrupt_latency.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="parport_interrupt_latency.c"

/* This kernel module is strongly based on Thomas Wedemann's module working on top of plain linux */

#include <linux/module.h>
#include <native/intr.h>
#include <native/sem.h>
#include <native/timer.h>
#include <asm/io.h>
#include <asm/timex.h> // cpu_khz
#include "../include/intlat_ioctl.h"

/* parameters for the parallel port... */
#define SPPDATAPORT         0x378
#define SPPSTATUSPORT       (SPPDATAPORT + 1)
#define SPPCONTROLPORT      (SPPDATAPORT + 2)
#define SSPINTERRUPTENABLE  0x10
#define INTR_NR	7

/* the character device */
#define INTLAT_DEV_MAJOR    241
#define INTLAT_DEV_NAME     "parport_lat"

// write some debug messages in /var/log/kern.log
#define DEBUG

#ifndef CONFIG_X86_TSC
# error This module relies on the Time Stamp Counter! Please enable CONFIG_X86_TSC.
#endif

/* we have our own rdtsc... */
#undef rdtsc
/* read the timestamp counter's low 32 bits into <low> */
#define rdtsc(low)    \
	__asm__ __volatile__(           \
		"xorl %%eax,%%eax\n"        \
		"cpuid\n"                   \
		"rdtsc\n"                   \
		"mov %%eax, %0\n"           \
		: "=m"(low)                 \
		:                           \
		: "eax","ebx","ecx","edx"   \
	)

RT_INTR intr;

static atomic_t is_avail = ATOMIC_INIT(1);

// -1, because when installing the module an interrupt is fired which we don't want to take into account
static atomic_t interruptcount = ATOMIC_INIT(-1); 


static unsigned long rdtscoverhead=0,outboverhead=0;
static unsigned long t_start,t_end;
static DECLARE_WAIT_QUEUE_HEAD(intlatpar_queue);

/* semaphore to guarantee that only one process interrupts at a time */
DECLARE_MUTEX(sem);

/* measure the time of outb() */
unsigned long getoutboverhead(void) {
    unsigned long t1,t2;
    
    local_irq_disable();
    rdtsc(t1);
    outb(0x00,SPPDATAPORT);
    outb(0xff,SPPDATAPORT);
    outb(0x00,SPPDATAPORT);
    outb(0xff,SPPDATAPORT);
    outb(0x00,SPPDATAPORT);
    rdtsc(t2);
    local_irq_enable();
    
    return (t2-t1-rdtscoverhead)/5;
}
    
/* get the overhead from a call to "cpuid" before a rdtsc */
unsigned long getrdtscoverhead(void) {
    unsigned long t[4],overhead_3rd,overhead_4th;

    local_irq_disable();
    /* see "Using the RDTSC Instruction for Performance Monitoring" for more... */
    asm (
	 "xorl %%eax,%%eax\n"	    /* run #1 */
         "cpuid\n"
	 "rdtsc\n"
	 "mov %%eax, %0\n"
	 "xorl %%eax,%%eax\n"
	 "cpuid\n"
	 "rdtsc\n"

	 "xorl %%eax,%%eax\n"	    /* run #2 */
	 "cpuid\n"
	 "rdtsc\n"
	 "mov %%eax, %0\n"
	 "xorl %%eax,%%eax\n"
	 "cpuid\n"
	 "rdtsc\n"

	 "xorl %%eax,%%eax\n"	    /* run #3 */
	 "cpuid\n"
	 "rdtsc\n"
	 "mov %%eax, %0\n"
	 "xorl %%eax,%%eax\n"
	 "cpuid\n"
	 "rdtsc\n"
	 "mov %%eax, %1\n"
	 
	 "xorl %%eax,%%eax\n"	    /* run #4 */
	 "cpuid\n"
	 "rdtsc\n"
	 "mov %%eax, %2\n"
	 "xorl %%eax,%%eax\n"
	 "cpuid\n"
	 "rdtsc\n"
	 "mov %%eax, %3\n"
	:   "=m"(t[0]),"=m"(t[1]),"=m"(t[2]),"=m"(t[3])	/* output */
	:						/* no input */
	:   "eax","ebx","ecx","edx"		 	/* clobbered registers */
    );
    local_irq_enable();

    overhead_3rd=t[1]-t[0];
    overhead_4th=t[3]-t[2];

    /* return minimum of both */
    return (overhead_3rd < overhead_4th ? overhead_3rd : overhead_4th);
}

/* called when a process tries to open the device file */
static int latdev_open(struct inode *inode, struct file *file) 
{
	if(!atomic_dec_and_test(&is_avail))
		return -EBUSY;
	try_module_get(THIS_MODULE);
	return 0;
}

/* called when a process closes the device file. */
static int latdev_release(struct inode *inode, struct file *file) 
{
	atomic_inc(&is_avail);
	module_put(THIS_MODULE);
	return 0;
}

/* character dev read() handler */
static ssize_t latdev_read(struct file *filep, char *buf, size_t count, loff_t *ppos) 
{	
	unsigned long lat = 0;
	unsigned long err;
	static volatile int lastint = 0;
	
#ifdef DEBUG
	printk(KERN_INFO "parport_latency: callback read\n");
#endif

	// some value checking
	if(!count)
		return 0;
	if(count < sizeof(unsigned long))
		return -EINVAL;

#ifdef DEBUG
	// sanity check: if the irq line is still high (=> the interrupt handler has not been called)
	if(inb(SPPDATAPORT)==0x80) {
		printk(KERN_WARNING "parport_latency: latdev_read(): data line is still high!\n");
	}
#endif
	
#ifdef DEBUG	
	printk(KERN_INFO "parport_latency: before interrupt generation\n");
#endif
	
	// generate interrupt
	local_irq_disable();
	outb(0x80,SPPDATAPORT);
	rdtsc(t_start);
	local_irq_enable();

#ifdef DEBUG
	printk(KERN_INFO "parport_latency: after interrupt generation\n");
#endif
	
	// wait for isr to produce t_end
	err = wait_event_interruptible(intlatpar_queue, lastint == atomic_read(&interruptcount) - 1 );

#ifdef DEBUG
	if(err == 0)
		
		printk(KERN_INFO "parport_latency: woken up after isr() has fired\n");
	else
	{
		printk(KERN_INFO "parport_latency: wait_event_interruptible has been interrupted\n");
		return err;
	}
#else
	if(err != 0)
	{
		printk(KERN_INFO "parport_latency: wait_event_interruptible has been interrupted\n");
		return err;
	}
#endif

	lastint++;
	 
	lat = t_end - t_start - rdtscoverhead - outboverhead;
	
#ifdef DEBUG
	printk(KERN_INFO "parport_latency: diff = %lu\n", lat);
#endif
	
	err = put_user(lat,(unsigned long *)buf);
	if(err != 0)
	{
		printk(KERN_INFO "Error when copying data to user-space, error = %lu\n", err);
		outb(0x00,SPPDATAPORT);
		return err;
	}

	return 0;
}

int latdev_ioctl(struct inode *inode, struct file *filep, unsigned int cmd, unsigned long arg) 
{
	unsigned long i;
	switch(cmd) {
		case INTLAT_GETFREQ:
		    	i=(unsigned long)cpu_khz * 1000;    /* khz to hz, integer -> ~4GHz max, sufficent for now. */
		    	return (copy_to_user((unsigned long __user *)arg,&i,sizeof(unsigned long))) ? -EFAULT : 0;
		default:
			return -EINVAL;
			break;
	 }
	return 0;
}


// ISR
int parport_isr(xnintr_t* cookie)
{
	rdtsc(t_end);
	
	outb(0x00,SPPDATAPORT);
	
#ifdef DEBUG
	printk(KERN_INFO "parport_latency: Interrupt fired!!!\n");
	printk(KERN_INFO "parport_latency: interruptcount before = %d!!!\n",atomic_read(&interruptcount));
#endif
	
	atomic_inc(&interruptcount);

#ifdef DEBUG
	printk(KERN_INFO "parport_latency: interruptcount after= %d!!!\n",atomic_read(&interruptcount));
#endif

	wake_up_interruptible(&intlatpar_queue);

#ifdef DEBUG
	printk(KERN_INFO "parport_latency: exit parport_isr()!!!\n");
#endif

	return 0;
}

/* the struct of fileoperations */
static struct file_operations intlat_fops = {
	.read = latdev_read,
	.open = latdev_open,
	.release = latdev_release,
	.ioctl = latdev_ioctl
};


// Initialise module
int parport_init(void)
{
	int err = 0;
	
	printk(KERN_INFO "parport_latency: Initialisation started\n");
	
	/* enable parallel port interrupt generation, probably not needed */
        outb(SSPINTERRUPTENABLE,SPPCONTROLPORT);
	
	err = rt_intr_create(&intr, "parport_latency", INTR_NR, &parport_isr, NULL, 0);
	if(err != 0)
	{
		printk(KERN_INFO "parport_latency: Error while requesting Interrupt %d, error %d\n", INTR_NR, err);
		return -1;
	}

	err = rt_intr_enable(&intr);
	if(err != 0)
	{
		printk(KERN_INFO "parport_latency: Error while enabling Interrupt %d, error %d\n", INTR_NR, err);
		return -1;
	}

	if(register_chrdev(INTLAT_DEV_MAJOR,INTLAT_DEV_NAME,&intlat_fops) < 0) 
	{
		printk(KERN_WARNING "intlat: parport_latency(): register_chrdev() failed.\n");
		rt_intr_disable(&intr);
		return -1;
	}
	
	// get rdtsc() overhead
	rdtscoverhead = getrdtscoverhead();
	
	// get outb() overhead
	outboverhead = getoutboverhead();

	/* the type of cpu_khz has changed */
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,13)
	/* kernel 2.6.12.1 */
	printk(KERN_INFO "parport_latency: initialized (cpu_khz=%lu,rdtsc+cpuid: %lu clktk,"
	   "outb(): %lu clktk / %lu us)\n", cpu_khz, rdtscoverhead,outboverhead,
	   ((100000*outboverhead)/cpu_khz)*10);
#else
	/* works at least with 2.6.14 */
	printk(KERN_INFO "parport_latency: initialized (cpu_khz=%u,rdtsc+cpuid: %lu clktk,"
	   "outb(): %lu clktk / %lu ns)\n", cpu_khz, rdtscoverhead,outboverhead,
	   ((100000*outboverhead)/cpu_khz)*10);            /* (prevent int overflow) */
#endif
		
	return 0;
}

// Cleanup module
void parport_exit(void)
{
	int err = 0;
	
	outb(0x00,SPPDATAPORT); // reset output port

	unregister_chrdev(INTLAT_DEV_MAJOR, INTLAT_DEV_NAME);
	if(err != 0)
		printk(KERN_INFO "parport_latency: Error while unregistering the char-device\n");
	
	err = rt_intr_disable(&intr);
	if(err != 0)
		printk(KERN_INFO "parport_latency: Error while disabling Interrupt %d, error %d\n", INTR_NR, err);

	err = rt_intr_delete(&intr);
	if(err != 0)
		printk(KERN_INFO "parport_latency: Error while deleting Interrupt %d, error %d\n", INTR_NR, err);
	
	printk(KERN_INFO "parport_latency: Module uninstalled\n");
}

module_init(parport_init);
module_exit(parport_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Markus Franke (based on Thomas Wiedemann)");
MODULE_DESCRIPTION("interrupt_latency parport module for Xenomai native skin");

--------------010006000704020107080609
Content-Type: text/x-csrc;
 name="parport_user.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="parport_user.c"

#include <stdio.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <limits.h>
#include <native/task.h>
#include <native/timer.h>
#include "../include/intlat_ioctl.h"


#define TEST_TIME_S 5 // measuring interrupts for <x> seconds
#define TEST_INTERVALL_US 100000 // test intervall in us
#define HIST_MAX_LATENCY_NS 100000 // maximum latency in ns to show in histogramm

int finished = 0;
int fd;
unsigned long *hist = NULL;
unsigned int max = 0;
unsigned int min = UINT_MAX;

void sighand(int sig __attribute__ ((unused)))
{
	if (sig == SIGXCPU)
		printf("---!! uh oh, switched to secondary mode !!--\n");
	else
		finished = 1;
}

void parport_task(void* cookie)
{
	unsigned long ov, err, i, loops;
	unsigned long lat = 0;
	unsigned int lat_ns;
	
	err = rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(TEST_INTERVALL_US * 1000));
	if (err) {
		fprintf(stderr, "parport_user: failed to set periodic, code %d\n", err);
		return;
	}
	
	loops = (TEST_TIME_S * 1000000) / TEST_INTERVALL_US;

	for(i=0; i<loops; i++)
	{
		err = rt_task_wait_period(&ov);
		if(err) 
		{
			fprintf(stderr, "parport_user: failed to wait for next period, code %d\n", err);
			return;
		}	
	
		if((err = read(fd, &lat, sizeof(lat))) == -1) 
			perror("read");

		lat_ns = rt_timer_tsc2ns(lat);
		
		if(lat_ns > HIST_MAX_LATENCY_NS)
		{
			printf("parport_user: %lu ns is to big for histogramm\n",lat_ns);
			break;
		}
		else
			hist[lat_ns]++;
		
		if(lat_ns > max)
			max = lat_ns;
		if(lat_ns < min)
			min = lat_ns;
	}

	alarm(TM_NOW + 1);
}

int main()
{
	int err;
	unsigned int i;
	char* cdev = "/dev/intlat0";
	RT_TASK task;
	unsigned long freq_hz, histsize=0;
	
	if((fd=open(cdev, O_RDONLY))==-1) {
		perror("open");
		fprintf(stderr,"Use mknod to create the character device <%s> and make sure\n"
		               "the module is inserted and no other process is using this file.\n",cdev);
		exit(1);
	}
	
	signal(SIGINT, sighand);
	signal(SIGTERM, sighand);
	signal(SIGHUP, sighand);
	signal(SIGALRM, sighand);

	if(ioctl(fd,INTLAT_GETFREQ,&freq_hz)==-1) {
		perror("ioctl");
		fprintf(stderr,"Ioctl(INTLAT_GETFREQ) is not supported on the device, please make sure the\n"
			       "character device has been set up correctly and the module is up to date!\n");
		exit(1);
	}
	
	printf("frequency = %lu Hz\n",freq_hz);

	histsize = HIST_MAX_LATENCY_NS;
	printf("histsize = %lu\n",histsize);
	
	if((hist = calloc(histsize, sizeof(unsigned int))) == NULL) 
	{
		perror("calloc");
		fprintf(stderr,"Out of memory? Can't allocate <%lu> bytes!\n",histsize * sizeof(unsigned int));
		exit(1);
	}

	mlockall(MCL_CURRENT | MCL_FUTURE);
	
	err = rt_timer_set_mode(TM_ONESHOT);    /* Force aperiodic timing. */
	if (err) {
		fprintf(stderr, "parport_user: failed to start timer, code %d\n", err);
		return 0;
	}
			 

	err = rt_task_create(&task, "parport_user", 0, T_HIPRIO, T_FPU);
	if (err) {
		fprintf(stderr, "parport_user: failed to create parport user task, code %d\n", err);
                return 0;
        }
	
	err = rt_task_start(&task, &parport_task, NULL); 
	if (err) {
		fprintf(stderr, "parport_user: failed to create parport user task, code %d\n", err);
		return 0;
	}
	
	while(!finished)
		pause();

	for(i=min;i<=max;i++) {
		printf("%6lu  %6lu \n",i,hist[i]);
	}
	
	rt_task_delete(&task);
	free(hist);
	close(fd);

	return err;
}


--------------010006000704020107080609
Content-Type: text/x-vcard; charset=utf-8;
 name="Markus.Franke.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Markus.Franke.vcf"

begin:vcard
fn:Markus Franke
n:Franke;Markus
adr;quoted-printable:;;Vettersstra=C3=9Fe 64/722;Chemnitz;Saxony;09126;Germany
email;internet:Markus.Franke@domain.hid
x-mozilla-html:FALSE
url:http://www.tu-chemnitz.de/~franm
version:2.1
end:vcard


--------------010006000704020107080609--

