Message-ID: <4AE7E36D.7040307@domain.hid>
Date: Wed, 28 Oct 2009 07:23:41 +0100
From: Francois Touchard <francois.touchard@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060305060804000300090304"
Subject: [Xenomai-help] PC freezes on call to driver functions
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
--------------060305060804000300090304
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Hello,<br>
for teaching purposes, I have a very simple driver built with RTDM to
catch interrupts generated on the parallel port via a pulse generator.
On receipt of a command passed by ioctl, the driver measures the time
interval between two interrupts and stores the result (in fact, the sum
of n time intervals, n being passed as parameter of ioctl). The result
is returned to the user by a read command.<br>
If I call ioctl immediatly after the open command, the machine freezes
and only the reset button is effective. If I insert a print command
between open and ioctl, everything works fine.<br>
I use Xenomai 2.4.9.1 and Linux 2.6.29.5. The processor is a Pentium 4.
I attach the sources of the driver and the user application.<br>
Any hint ? TIA<br>
Francois<br>
<div class="moz-signature">-- <br>
<meta http-equiv="CONTENT-TYPE" content="text/html; ">
<title></title>
<meta name="GENERATOR" content="StarOffice 7  (Linux)">
<meta name="CREATED" content="20040220;23305400">
<meta name="CHANGEDBY" content="Francois Touchard">
<meta name="CHANGED" content="20050323;22195800">
<table style="page-break-before: always;" border="1"
 bordercolor="#000000" cellpadding="4" cellspacing="0" rules="none"
 width="100%">
  <tbody>
    <tr>
      <td>
      <p>Fran&ccedil;ois TOUCHARD</p>
      </td>
      <td>
      <p><a href="mailto:francois.touchard@domain.hid">mailto:francois.touchard@domain.hid</a></p>
      </td>
    </tr>
    <tr>
      <td width="230">
      <p>ESIL/CPPM</p>
      </td>
      <td valign="top" width="316">
      <p><a href="http://pages-perso.esil.univmed.fr/%7Etouchard">http://pages-perso.esil.univmed.fr/~touchard</a></p>
      </td>
    </tr>
  </tbody>
</table>
<p><br>
<br>
</p>
</div>
<br>
<div class="moz-signature">-- <br>
<meta http-equiv="CONTENT-TYPE" content="text/html; ">
<title></title>
<meta name="GENERATOR" content="StarOffice 7  (Linux)">
<meta name="CREATED" content="20040220;23305400">
<meta name="CHANGEDBY" content="Francois Touchard">
<meta name="CHANGED" content="20050323;22195800">
<table style="page-break-before: always;" border="1"
 bordercolor="#000000" cellpadding="4" cellspacing="0" rules="none"
 width="100%">
  <tbody>
    <tr>
      <td>
      <p>Fran&ccedil;ois TOUCHARD</p>
      </td>
      <td>
      <p><a href="mailto:francois.touchard@domain.hid">mailto:francois.touchard@domain.hid</a></p>
      </td>
    </tr>
    <tr>
      <td width="230">
      <p>ESIL/CPPM</p>
      </td>
      <td valign="top" width="316">
      <p><a href="http://pages-perso.esil.univmed.fr/%7Etouchard">http://pages-perso.esil.univmed.fr/~touchard</a></p>
      </td>
    </tr>
  </tbody>
</table>
<p><br>
<br>
</p>
</div>
</body>
</html>

--------------060305060804000300090304
Content-Type: text/x-csrc;
 name="pulse_drv.c"
Content-Disposition: inline;
 filename="pulse_drv.c"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by ccsrelay01.in2p3.fr id n9S6OHBB012277

/************************************************************************=
****************
* pulseDrv.c V6
* oct 2009 (c) Fran=C3=A7ois Touchard
*************************************************************************=
***************/

#include <linux/module.h>
#include <rtdm/rtdm_driver.h>
#include <semaphore.h>
#include <pthread.h>
#include <time.h>
#include <errno.h>

#define DEBUG
#define VERSION "V6.0.2"

#include "pulse.h"


/**
* global buffer
*/

rtStat_t RtStat;

MODULE_LICENSE("GPL");
MODULE_AUTHOR("francois.touchard@domain.hid");

rtdm_irq_t irq;
rtdm_task_t meas_thr;

int IRQ_ON=3D0;


rtdm_sem_t sem;

/************************************************************************=
*************/
/*         measurement thread                                            =
            */
/************************************************************************=
*************/
void measurement_thread(void *cookie)
{
	struct timespec tc;
	unsigned int deltatmus;
	nanosecs_abs_t tcns, tpns, deltatns;
	int count=3D0;
#ifdef DEBUG
	rtdm_printk("thread launched. Maxcount : %d\n", RtStat.maxcount);
#endif

	while (1) {
		rtdm_sem_down(&sem);

		tcns =3D rtdm_clock_read();	=09
		if (count > 0) {
			deltatns =3D tcns - tpns;
			deltatmus =3D ((long int) deltatns)/1000;
			RtStat.sum =3D RtStat.sum + deltatmus;
			if (count =3D=3D 1) {
				RtStat.min =3D deltatmus;
				RtStat.max =3D deltatmus;
			} else {
				if (deltatmus < RtStat.min) RtStat.min =3D deltatmus;
				if (deltatmus > RtStat.max) RtStat.max =3D deltatmus;
			}
		} else {
			RtStat.sum =3D 0;
			deltatmus =3D 0;
			tpns=3D0;
		}
#ifdef DEBUG
		rtdm_printk("%s : got IRQ %d : %d mus (sum : %d, min : %d, max %d)\n",=20
				DEVICE_NAME, count, deltatmus, RtStat.sum,
				RtStat.min, RtStat.max);
#endif
		tpns =3D tcns;
		count ++;

		if (count > RtStat.maxcount) {
#ifdef DEBUG
			rtdm_printk("thread exit\n");
#endif
			rtdm_task_destroy(&meas_thr);
		}
	}
}

/************************************************************************=
*************/
/*         Interrupt routine                                             =
            */
/************************************************************************=
*************/
static int pulse_isr(rtdm_irq_t *irq)
{
	rtdm_sem_up(&sem);
	return 0;
}

/**
* open the device
* statistical data is reset to 0
*/
/************************************************************************=
*************/
/*          Driver open                                                  =
            */
/************************************************************************=
*************/
static  int PulseOpen_nrt(	struct rtdm_dev_context *context,=20
				rtdm_user_info_t 	*user_info,=20
				int 			oflags)=20
{
	RtStat.sum =3D 0;
#ifdef DEBUG
	rtdm_printk("%s : device opened in nrt context\n", DEVICE_NAME);
#endif
	return 0;
}

static  int PulseOpen_rt(	struct rtdm_dev_context *context,=20
				rtdm_user_info_t 	*user_info,=20
				int 			oflags)=20
{
	RtStat.sum =3D 0;
#ifdef DEBUG
	rtdm_printk("%s : device opened in rt context\n", DEVICE_NAME);
#endif
	return 0;
}

/************************************************************************=
*************/
/*          Driver close                                                 =
            */
/************************************************************************=
*************/

static int PulseClose_nrt(	struct rtdm_dev_context *context,=20
				rtdm_user_info_t 	*user_info)=20
{
	if (IRQ_ON) {
		rtdm_irq_free(&irq);
	}
#ifdef DEBUG
	rtdm_printk("%s : device closed in nrt context\n", DEVICE_NAME);
#endif
	return 0;
}


static int PulseClose_rt(	struct rtdm_dev_context *context,=20
				rtdm_user_info_t 	*user_info)=20
{
	if (IRQ_ON) {
		rtdm_irq_free(&irq);
	}
#ifdef DEBUG
	rtdm_printk("%s : device closed in rt context\n", DEVICE_NAME);
#endif
	return 0;
}

/************************************************************************=
************/
/*          Driver ioctl                                                 =
           */
/************************************************************************=
************/

static int PulseIoctl_nrt(	struct rtdm_dev_context *context,=20
				rtdm_user_info_t 	*user_info,=20
				int 			cmd,=20
				void 			*arg)
{
	int ret;

	switch (cmd) {
		case RPP_ISR:
			IRQ_ON=3D1;

#ifdef DEBUG
			rtdm_printk("ISR measurement\n");
#endif
			rtdm_irq_free(&irq);

// Stores maximum number of captured interrupts (passed in ioctl argument=
) in kernel space
			ret =3D rtdm_safe_copy_from_user(user_info,=20
					&RtStat.maxcount, arg, sizeof(int));
			if (ret) {
				rtdm_printk("%s : error on rtdm_safe_copy_from_user %d\n",
					 DEVICE_NAME, ret);
				rtdm_irq_free(&irq);
				return ret;
			}

#ifdef DEBUG
			rtdm_printk("%s : maxcount %d copied from user to kernel\n",
				 DEVICE_NAME, RtStat.maxcount);
#endif
// Semaphore initialisation
			rtdm_sem_init(&sem, 0);

			RtStat.sum =3D 0;

// Measurement task initialisation. No argument passed, priority : 30, no=
n cyclic task
			ret =3D rtdm_task_init(&meas_thr, "AcqPulse", measurement_thread,
					NULL, 30, 0);
			if (ret) {
				rtdm_printk("%s : error on rtdm_task_init %d\n"
					,DEVICE_NAME, ret);
			}
// irq handler initialisation
			ret =3D rtdm_irq_request(&irq, PulseInt_Irq,=20
						pulse_isr, 0, "pulse", 0);
			if (ret) {
				rtdm_printk("%s : error on rtdm_irq_request %d\n"
					,DEVICE_NAME, ret);
				return ret;
			}
#ifdef DEBUG
			rtdm_printk("%s : IRQ enabled\n", DEVICE_NAME);
#endif

// enable interrupts on parallel port interface
			outb(PulseCtr_Enable, PulseInt_Ctrl);

// wait for the end of measurement. Polling every 100 ms
			rtdm_task_join_nrt(&meas_thr, 100);

			rtdm_sem_destroy(&sem);
			rtdm_irq_free(&irq);
// Disable interrupts on parallel port interface
			outb(PulseCtr_Disable, PulseInt_Ctrl);


			return 0;
		case RPP_POLL:
#ifdef DEBUG
			rtdm_printk("POLL measurement, arg %d\n", (int) arg);
#endif
			return -1;
		default:
			rtdm_printk("invalid ioctl\n");
			return -1;
	}
}

/************************************************************************=
************/
/*          Driver read                                                  =
          */
/************************************************************************=
************/

static ssize_t PulseRead_rt(	struct rtdm_dev_context *context,=20
				rtdm_user_info_t 	*user_info,=20
				void 			*buf,=20
				size_t 			nbyte)
{=09
	int ret;
	char *out_pos =3D (char *) buf;

#ifdef DEBUG
	rtdm_printk("%s : read device\n", DEVICE_NAME);
#endif
	ret =3D rtdm_safe_copy_to_user(user_info, out_pos, &RtStat, sizeof(rtSta=
t_t));
	if (ret) {
		rtdm_printk("%s : error on rtdm_copy_to_user %d\n", DEVICE_NAME, ret);
		return ret;
	}
#ifdef DEBUG
	rtdm_printk("%s : copied from kernel to user\n", DEVICE_NAME);
#endif=09
	return sizeof(rtStat_t);;
}


/************************************************************************=
*********/
/*    	Structure describing the device                                   =
       */
/************************************************************************=
*********/

static struct rtdm_device device =3D {
	struct_version : RTDM_DEVICE_STRUCT_VER,
	device_flags : RTDM_NAMED_DEVICE,
	context_size : sizeof(rtStat_t),
	device_name : DEVICE_NAME,
=09
	open_nrt : PulseOpen_nrt,
	open_rt : PulseOpen_rt,
	ops : {
		close_nrt :	 PulseClose_nrt,
		close_rt :	 PulseClose_rt,
		ioctl_nrt :	 PulseIoctl_nrt,
		ioctl_rt :	 PulseIoctl_nrt,
		read_nrt :	 PulseRead_rt,
		read_rt :	 PulseRead_rt,
		write_nrt :	 NULL,
		write_rt :	 NULL,
		recvmsg_rt:	 NULL,
		recvmsg_nrt:	 NULL,
		sendmsg_rt:	 NULL,
		sendmsg_nrt:	 NULL,
	},

	device_class : RTDM_CLASS_EXPERIMENTAL,
	device_sub_class : 4711,
	profile_version : 1,
	driver_name : DRIVER_NAME,
	driver_version : RTDM_DRIVER_VER(0,1,2),
	peripheral_name : "Pulse",
	provider_name : "esil_info",
	proc_name : device.device_name,
};

int __init pulse_init(void) {
	rtdm_dev_register (&device);
	rtdm_printk("PulseDrv %s loaded. ", VERSION);
#ifdef DEBUG
	rtdm_printk("DEBUG mode\n");
#else
	rtdm_printk("NODEBUG mode\n");
#endif
	return 0;
}

void __exit pulse_exit(void) {
	rtdm_dev_unregister(&device, 1000);
	rtdm_printk("PulseDrv %s unloaded\n", VERSION);
}

module_init(pulse_init);
module_exit(pulse_exit);



--------------060305060804000300090304
Content-Type: text/x-csrc;
 name="user.c"
Content-Disposition: inline;
 filename="user.c"
Content-Transfer-Encoding: 7bit

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/mman.h>
#include <pthread.h>
#include <sched.h>
#include <errno.h>

#include "pulse.h"

#define USER_NAME "pulse user"
#define DEBUG

int device;
int nmeas;

void *thread_code(void *cookie) {
	int ret;
	rtStat_t Stat;
	float freq, period;

//	device = rt_dev_open(DEVICE_NAME, 0);
	device = open(DEVICE_NAME, 0);
	if (device < 0) {
		printf("%s : Error open %s %s\n", USER_NAME, DEVICE_NAME, strerror(device));
		exit(1);
	}
#ifdef DEBUG
	printf("thread : opened\n");
#endif

//	ret = rt_dev_ioctl(device, RPP_ISR, &nmeas);
	ret = ioctl(device, RPP_ISR, &nmeas);
	if (ret < 0) {
		printf("%s : Error while ioctl : %s \n", USER_NAME, strerror(-ret));
		exit(1);
	}
#ifdef DEBUG
	printf("thread : ioctl\n");
#endif

//	ret = rt_dev_read(device, &Stat, sizeof(rtStat_t));
	ret = read(device, &Stat, sizeof(rtStat_t));
	if (ret < 0) {
		printf("%s : Error while read : %s \n", USER_NAME, strerror(-ret));
		exit(1);
	}

	period = ((float) Stat.sum/ (float)Stat.maxcount)/1.E6;
	freq = 1./period;
	printf ("period %f s   frequency %f Hz \n", period, freq);
	printf ("min : %f   max : %f   delta t : %f\n", 
			(float)Stat.min/1.E6, (float)Stat.max/1.E6,
			(float)(Stat.max-Stat.min)/1.E6);

	printf("thread : read\n");

//	ret = rt_dev_close(device);
	ret = close(device);
	if (ret < 0) {
		printf("Error while closing %s\n", USER_NAME);
		exit(1);
	}
	printf("thread : closed\n");
	pthread_exit(NULL);
}


int main(int argc, char *argv[]) {
	int device, ret;
	pthread_t tid;
	pthread_attr_t attr;
	struct sched_param sp;



	if (argc == 2) {
		nmeas = atoi(argv[1]);
	} else {
		nmeas = 5;
	}

	ret = mlockall(MCL_CURRENT | MCL_FUTURE);
	if (ret) {
		printf("error mlockall\n");
		exit(1);
	}

	ret = pthread_attr_init(&attr);
	if (ret) {
		printf("error pthread_attr_init\n");
		exit(1);
	}
	ret = pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
	if (ret) {
		printf("error pthread_attr_setinheritsched\n");
		exit(1);
	}
	ret = pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
	if (ret) {
		printf("error pthread_attr_setschedpolicy\n");
		exit(1);
	}
	sp.sched_priority = 1;
	ret = pthread_attr_setschedparam(&attr, &sp);
	if (ret) {
		printf("error pthread_attr_setschedparam\n");
		exit(1);
	}

	ret = pthread_create(&tid, &attr, thread_code, NULL);
		if (ret) {
		printf("error pthread_create\n");
		exit(1);
	}
	ret = pthread_join(tid, NULL);
	if (ret) {
		printf("error pthread_join\n");
		exit(1);
	}	
	printf("main : joined\n");
//	scanf("%c", &ret);
	return 0;

}



--------------060305060804000300090304
Content-Type: text/x-chdr;
 name="pulse.h"
Content-Disposition: inline;
 filename="pulse.h"
Content-Transfer-Encoding: 7bit

/************************************************* 
* Fichier pulse.h
*************************************************/

#define DEVICE_NAME "Pulse"
#define DRIVER_NAME "PulseDrv"

typedef enum {
	RPP_ISR,
	RPP_POLL,
} Ioctl_ops;

typedef enum {
	PulseInt_Port = 0x378,		/*------------------------Data access */
	PulseInt_Sts  = PulseInt_Port+1,	/*Status register */
	PulseInt_Ctrl = PulseInt_Port+2,	/*Control register */
	PulseInt_Irq  = 7,			/*Interrupt vector */
	PulseCtr_Enable  = 0x10,		/* Control register command */
	PulseCtr_Disable = 0x00,
	PulseSts_Ack = 0x40,
} PulseInt_t;

typedef struct RtStat_s {
	long int sum;
	int maxcount;
	long int min;
	long int max;
} rtStat_t;



--------------060305060804000300090304--

