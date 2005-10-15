Message-ID: <19101.193.52.24.125.1129355471.squirrel@domain.hid>
Date: Sat, 15 Oct 2005 07:51:11 +0200 (CEST)
From: <smannori@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] XenoPPC + Comedi
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

Hi:

with the help of Gilles now I have a working PowerBook with Xenomai.

USB-DUX works with Comedi-compiled-for-PPC BUT if I try to mix realtime
Xenomai with NON-realtime Comedi the application start, works for a while
the stop, exactly as the x86 version.

Any suggestions ?

     Simone



-------------------------------------------------------------------------
//** October 15th 2005
//** My  Xenomai application with Comedi Output for PPC (PowerBook 1.67)

//** Print a dot every 100 ms e.g. 10 dot/s an output to all 8 USB-DUX leds

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

#include <comedilib.h>

#define TASK_PRIO 99    /* Highest RT priority */
#define TASK_MODE 0     /* No flags */
#define TASK_STKSZ 0    /* Stack size (use default one) */
#define TASK_PERIOD 10000000 /*  period: time expressed in nanosecond*/

RT_TASK task_desc; // descrittore

void sampling_task (void *cookie)
{
   int err, bitmask;    // Local variable
   int counter = 0 ;

   // subdevice 2:
   //  type: 5 (digital I/O)
   //  number of channels: 8
   //  max data value: 1
   //  ranges:
   //    all chans: [0,5]

    unsigned int subdev = 2;    /* change this to your input subdevice */
    unsigned int chan = 0;      /* change this to your channel */
    unsigned int range = 0; /* more on this later */
    unsigned int aref = AREF_GROUND; /* more on this later */

    comedi_t *it ;
    lsampl_t data;

    it = comedi_open("/dev/comedi0"); // get the handler

    // configure the all the 8 bits as outputs
    for (chan=0; chan <= 7 ; chan++)
       {
          err = comedi_dio_config(it, subdev, chan, COMEDI_OUTPUT);
       }

              // clear output leds
    for (chan=0 ; chan <= 7 ; chan++)
	    { data = 0;
              err = comedi_data_write(it, subdev, chan, range, aref, data);
            }


   /* The task will undergo a 0.1 s  periodic timeline. */
   err = rt_task_set_periodic(NULL,TM_NOW,TASK_PERIOD);

   for (;;) // Run forever
      {
         err = rt_task_wait_period(); // wait (sleep) until time expired

	 if (err)
	   {
             printf("Something goes wrong");
	     break;
	   }

	 /* Work for the current period */

	 if ( (counter % 100) == 0 )
	        fprintf(stderr, ".") ; // print a dot every 100 x sampling time

      // 8 bit output
	 bitmask = 1 ;
	 for (chan=0 ; chan <= 0 ; chan++) // I limited to 1 bit: same result :(
	    {
	      data = counter & bitmask ;
	      if (data > 0) data = 1;
	      else          data = 0;

	      err = comedi_data_write(it, subdev, chan, range, aref, data); // led
output

	      bitmask = bitmask<<1  ; // bitmask for the next bit
            }

	 counter = counter + 1 ; // counter for the next period
      }
}

//** Main Routine

int main (int argc, char *argv[])
{
    int err;

    /* Disable paging for this program's memory. */
    mlockall(MCL_CURRENT|MCL_FUTURE);

    /* Start the timer in oneshot mode */
    err = rt_timer_start(TM_ONESHOT);
    if (err)
      printf("I'm not able to start the oneshot timer \n");

    /* Create a real-time task */
    err =
rt_task_create(&task_desc,"DotPrint",TASK_STKSZ,TASK_PRIO,TASK_MODE); if
(!err)      {
    /* If successfully created, start the task. */
       rt_task_start(&task_desc,&sampling_task,NULL);
       printf("Realtime Started... : \n ");
      }

  pause(); // Wait a CTRL-C to exit

  return 0 ;
}





