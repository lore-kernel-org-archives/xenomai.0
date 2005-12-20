Message-ID: <42781.128.93.15.41.1135063080.squirrel@domain.hid>
Date: Tue, 20 Dec 2005 08:18:00 +0100 (CET)
From: <smannori@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] Interrupt Shield (III)
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
Cc: wjasper@domain.hid

The code:

/*

The raw batch file that I'm using to compile this program.

Please, forgive my iGNUrance of Makefile

mio:

gcc m.c -o m -static -g -Wall -I. -I/usr/xenomai/include -O2
-I/lib/modules/2.6.14.3-ipipe/build/include -D_GNU_SOURCE -D_REENTRANT
-D__XENO__ -pipe -fstrict-aliasing -Wno-strict-aliasing -lmccusb -lm
-lnative -L/usr/xenomai/lib -lpthread


*/


#include <sys/mman.h>
#include <sys/time.h>
#include <unistd.h>
#include <stdlib.h>
#include <math.h>
#include <stdio.h>
#include <string.h>
#include <signal.h>
#include <getopt.h>
#include <time.h>
#include <native/task.h>
#include <native/timer.h>
#include <native/sem.h>

/* USB */

#include <unistd.h>
#include <fcntl.h>
#include <ctype.h>
#include <sys/types.h>
#include <asm/types.h>

#include "pmd.h"
#include "usb-1208FS.h"

/* definizioni standard */

#define TASK_PRIO 99    /* Highest RT priority */
#define TASK_MODE 0     /* No flags */
#define TASK_STKSZ 0    /* Stack size (use default one) */
#define TASK_PERIOD   20000000 /* 20 ms period: time expressed in
nanosecond */#define TASK_PERIOD_U 20000    /* 20 ms delay - for the usleep() - in
microseconds */
//**                .**.**.**
RT_TASK task_desc; // descrittore

 int fd[4]; //** USB datastucture
 int flag;

  signed short svalue;
                __u8 input, channel, gain, options;
                __u16 value;
                __u16 out_data[1024]; //** 1 kS OUTPUT FIFO buffer

  signed short in_data[1024];  //** 1Ks INPUT FIFO buffer

  int count;

  int temp, i, j;
  int ch;
  int nInterfaces = 0;
  float freq;

// --------



int ao_0_value = 0, ao_1_value = 0 ;

//-----------------------------------------------------------------------------
/* questo task manda un campione e aspetta il suo periodo*/

void sampling_task (void *cookie)
{
   int err; // Local variable

   /* The task will undergo a 0.1 s  periodic timeline. */
   err = rt_task_set_periodic(NULL,TM_NOW,TASK_PERIOD);

   for (;;) // Run forever
      {
         // analog output channel zero
         usbAOut_USB1208FS(fd[0], 0, ao_0_value);

         if (ao_0_value == 0 )   // square wave generator
               ao_0_value = 0xFFF ;
         else
               ao_0_value = 0x000 ;

         err = rt_task_wait_period(); // wait (sleep) until time expired

	 if (err)
	   {
             printf("Something goes wrong");
	     break;
	   }

	 /* Work for the current period */
      //   fprintf(stderr, "."); /* Immediate print of a single dot */
      }
}

//------------------------------------------------------------------------------
//** Main Routine

int main (int argc, char *argv[])
{
  int err;

  nInterfaces = PMD_Find(MCC_VID, USB1208FS_PID, fd); // check the presence
of the interface

  if ( nInterfaces <= 0 ) {
        fprintf(stderr, "USB 1208FS not found.\n");
        exit(1);
  } else
        printf("USB 1208FS Device is found! Number of Interfaces = %d\n",
nInterfaces);

  /* config mask 0x01 means all inputs */

  usbDConfigPort_USB1208FS(fd[0], DIO_PORTA, DIO_DIR_OUT); // configure PORT
A as OUTPUT
  usbDConfigPort_USB1208FS(fd[0], DIO_PORTB, DIO_DIR_IN);  // configure PORT
B as INPUT

  usbDOut_USB1208FS(fd[0], DIO_PORTA, 0); // put all output bit to zero
  usbDOut_USB1208FS(fd[0], DIO_PORTA, 0);

// -----

    /* Disable paging for this program's memory. */
    mlockall(MCL_CURRENT|MCL_FUTURE);

    /* Start the timer in oneshot mode */
    err = rt_timer_start(TM_ONESHOT);
    if (err)
      printf("I'm not able to start the oneshot timer \n");

    /* Create an empty "task_desc" ; real-time task program structure  */
    err =
rt_task_create(&task_desc,"SquareWave",TASK_STKSZ,TASK_PRIO,TASK_MODE);
    if (!err)
      {
    /* If successfully created, start the desired task. */
    /*               rt_descriptor, real_task_function_name, atrr    */
         rt_task_start(&task_desc,&sampling_task,NULL);
         printf("Realtime Task Started... : \n ");
      }

/* Soft real time square wave */

  while (1) {

         // analog output channel one
         usbAOut_USB1208FS(fd[0], 1, ao_1_value);

         if (ao_1_value == 0 )   // square wave generator
               ao_1_value = 0xFFF ;
         else
               ao_1_value = 0x000 ;

        // usleep ( TASK_PERIOD_U ) ;


  }




// pause(); // Wait a CTRL-C to exit

  return 0 ;
}




