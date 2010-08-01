MIME-Version: 1.0
Sender: murlou@domain.hid
Date: Sun, 1 Aug 2010 04:03:30 -0300
Message-ID: <AANLkTimuiAP=dGQSKG2PYJUnGw--1iXBzPJ1325czz-_@domain.hid>
From: Murilo Marinho <murilomarinho@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] Problems with user_irq.c Native example
Reply-To: murilomarinho@domain.hid
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

I tried running the user_irq.c example as described in the section
7.14 in the native PDF, which is written in the end of this mail.
At first, it froze my system every time I tried running it. I did some
changes in the code, trying to find out what was wrong with it.

>From what I understood this should work (I'm new to xenomai
programming), the rt_intr_wait function should pause the running task
until the interrupt comes, but after inserting some flow controls, I
found it to be freezing due to excessive processing of the irq_server,
which at first seemed to be receiving endless interruption signals.

In the next step, I added error handling, but the return value of the
function was -38, which didn't mean it worked ( as it wasn't a
positive
value), nor it was any of the errors described in the function documentation.

I also tried changing from TM_INFINITE to many numerical values to no
avail, got the same return value.

Have I misunderstood the way this function works? Does this error
means something?

I'm using ubuntu 9.10, xenomai 2.5.3 and kernel 2.6.34

7.14 user_irq.c
#include <sys/mman.h>
#include <native/task.h>
#include <native/intr.h>
#define IRQ_NUMBER 7 /* Intercept interrupt #7 */
#define TASK_PRIO 99 /* Highest RT priority */
#define TASK_MODE 0 /* No flags */
#define TASK_STKSZ 0 /* Stack size (use default one) */
RT_INTR intr_desc;
RT_TASK server_desc;
void irq_server (void *cookie)
{
for (;;) {
/* Wait for the next interrupt on channel #7. */
err = rt_intr_wait(&intr_desc,TM_INFINITE);
if (!err) {
/* Process interrupt. */
}
}
}
int main (int argc, char *argv[])
{
int err;
mlockall(MCL_CURRENT|MCL_FUTURE);
/* ... */
err = rt_intr_create(&intr_desc,"MyIrq",IRQ_NUMBER,0);
/* ... */
err = rt_task_create(&server_desc,
"MyIrqServer",
TASK_STKSZ,
TASK_PRIO,
TASK_MODE);
if (!err)
rt_task_start(&server_desc,&irq_server,NULL);
/* ... */
}
void cleanup (void)
{
rt_intr_delete(&intr_desc);
rt_task_delete(&server_desc);
}

