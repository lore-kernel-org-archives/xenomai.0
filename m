From: "Wayne Call" <wcall@domain.hid>
References: <mailman.22410.1240852662.3004.xenomai@xenomai.org>
In-Reply-To: <mailman.22410.1240852662.3004.xenomai@xenomai.org>
Date: Mon, 27 Apr 2009 16:12:49 -0600
Message-ID: <000601c9c785$4d60b110$e8221330$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
Subject: [Xenomai-help] rt_intr_wait
Reply-To: wcall@domain.hid
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

I was able to get the IRQ 26 working.  The interrupt needs to be re-enabled
by writing to a register in the processor.  By writing to this register, the
interrupt is re-enabled and the rt_intr_wait detects the next interrupt.

Wayne


-----Original Message-----
From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] On
Behalf Of xenomai-help-request@domain.hid
Sent: Monday, April 27, 2009 11:18 AM
To: xenomai@xenomai.org
Subject: Xenomai-help Digest, Vol 43, Issue 37

Send Xenomai-help mailing list submissions to
	xenomai@xenomai.org

To subscribe or unsubscribe via the World Wide Web, visit
	https://mail.gna.org/listinfo/xenomai-help
or, via email, send a message with subject or body 'help' to
	xenomai-help-request@domain.hid

You can reach the person managing the list at
	xenomai-help-owner@domain.hid

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Xenomai-help digest..."


Today's Topics:

   1. rt_intr_wait (Wayne Call)


----------------------------------------------------------------------

Message: 1
Date: Mon, 27 Apr 2009 11:16:31 -0600
From: "Wayne Call" <wcall@domain.hid>
Subject: [Xenomai-help] rt_intr_wait
To: <xenomai@xenomai.org>
Message-ID: <000001c9c75b$e8f288d0$bad79a70$@com>
Content-Type: text/plain; charset="us-ascii"

The code below attempts to process an interrupt in user space.  The IRQ is
set at 26, and this interrupt fires at once per second.  If the
rt_intr_create sets the mode to I_NOAUTOENA, the rt_intr_wait detects one
interrupt, and then no other interrupts are detected.  Likewise for if the
mode is set to I_PROPAGATE.  If the mode is set to 0, it appears that the
rt_intr_wait detects interrupts at a very high rate, possible thousands per
second.  It appears that the code is detecting some other interrupt, and not
the IRQ at 26.

 

Below is the irq file and stat file for when the mode is set to I_NOAUTOENA
or I_PROPAGATE.

 



 



 

Is there a step that I'm missing to get the rt_intr_wait to recognize the
correct IRQ?

 

Wayne

 

 

 

//

// pwm_precon.c

// 

 

#include <sys/mman.h>

#include <signal.h>

#include <native/task.h>

#include <native/intr.h>

#include <stdio.h>

#define COMPILE_LPL_DEBUG           1

#include "../lplLib/lplDebug.h"

 

#define LPL_PWM_PRECON_IRQ_NUMBER   26

#define LPL_PWM_PRECON_TASK_PRIO    99

#define LPL_PWM_PRECON_TASK_MODE    0

#define LPL_PWM_PRECON_TASK_STKSZ   0

 

 

RT_INTR     m_interruptDescriptor;

RT_TASK     m_serverDescriptor;

 

long int    m_isrCounter = 0;

 

 

void cleanup(int sig);

 

 

void lpl_pwm_precon_irq_server(void *cookie)

{

    int err;

 

    for (;;) 

    {

        // Wait for next interrupt

        err = rt_intr_wait(&m_interruptDescriptor, TM_INFINITE);

        if (err > 0) 

        {

            LPL_DEBUG("process interrupt", m_isrCounter, %d); 

        }

        m_isrCounter++;

        LPL_DEBUG("isr real-time interrupt", err, %d); 

    }

}

 

 

int main (int argc, char *argv[])

{

    int err = 0;

    int bfinTimerStatus;

 

    mlockall(MCL_CURRENT | MCL_FUTURE);

    err = rt_intr_create(&m_interruptDescriptor, "PWM_PRECON_IRQ",
LPL_PWM_PRECON_IRQ_NUMBER, I_NOAUTOENA);

//    err = rt_intr_create(&m_interruptDescriptor, "PWM_PRECON_IRQ",
LPL_PWM_PRECON_IRQ_NUMBER, I_PROPAGATE);

//    err = rt_intr_create(&m_interruptDescriptor, "PWM_PRECON_IRQ",
LPL_PWM_PRECON_IRQ_NUMBER, 0);

    LPL_DEBUG("create real-time interrupt", err, %d); 

    err = rt_task_create(&m_serverDescriptor, "PWM_PRECON_IRQ_SERVER",
LPL_PWM_PRECON_TASK_STKSZ, 

                         LPL_PWM_PRECON_TASK_PRIO,
LPL_PWM_PRECON_TASK_MODE);

    LPL_DEBUG("create real-time task", err, %d); 

    if (!err) 

    {

        rt_task_start(&m_serverDescriptor, &lpl_pwm_precon_irq_server,
NULL);

        LPL_DEBUG("start real-time task", err, %d);

        rt_intr_enable(&m_interruptDescriptor); 

        LPL_DEBUG("enable real-time interrupt", err, %d);

    }

 

    signal(SIGTERM, cleanup);

    signal(SIGINT, cleanup);

 

    pause();

 

    fflush(NULL);

}

 

 

void cleanup(int sig)

{

    int err = 0;

 

    rt_intr_disable(&m_interruptDescriptor); 

    LPL_DEBUG("disable real-time interrupt", err, %d); 

    rt_intr_delete(&m_interruptDescriptor);

    LPL_DEBUG("delete real-time interrupt", err, %d); 

    rt_task_delete(&m_serverDescriptor);

    LPL_DEBUG("delete real-time task", err, %d); 

}

 

 

-------------- next part --------------
An HTML attachment was scrubbed...
URL: /public/xenomai-help/attachments/20090427/114a9381/attachment.htm 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: image/png
Size: 6864 bytes
Desc: not available
Url : /public/xenomai-help/attachments/20090427/114a9381/attachment.png 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: image/png
Size: 8923 bytes
Desc: not available
Url : /public/xenomai-help/attachments/20090427/114a9381/attachment-0001.png


------------------------------

_______________________________________________
Xenomai-help mailing list
Xenomai-help@domain.hid
https://mail.gna.org/listinfo/xenomai-help


End of Xenomai-help Digest, Vol 43, Issue 37
********************************************


