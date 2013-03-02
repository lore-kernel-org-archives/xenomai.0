Message-ID: <51318FAE.4010500@xenomai.org>
Date: Sat, 02 Mar 2013 06:35:42 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAJjOJyZWM-73DoTOAT4Xoiw3dk-yUw7Gu4ZOU9D9_b4qe5N-QQ@mail.gmail.com>
In-Reply-To: <CAJjOJyZWM-73DoTOAT4Xoiw3dk-yUw7Gu4ZOU9D9_b4qe5N-QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problem Handling GPIO interrupts
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jonathan Wallace <jonmon6691@gmail.com>
Cc: xenomai@xenomai.org

On 03/02/2013 05:47 AM, Jonathan Wallace wrote:

> Hi all,
> 
> I'm trying to get a small variation of the usr_irq.c example working,
> but rt_intr_wait keeps returning -38 without blocking and perror
> prints success. If I don't let it print anything (so it will run
> faster) it seg faults after about 4 or 5 seconds, calling rt_intr_wait
> in an infinite loop during that time.
> 
> I'm also having an issue where if I run the program from an SSH
> session, rt_task_create returns EPERM, but will return a success if I
> run the program from the serial console. I can only assume there's
> some difference in the shell processes at the kernel level, but if
> there's a way to get around this, I would love to know too.
> 
> A little background about the IRQ, because I could have this all wrong
> too... I exported a gpio pin and echoed "falling" into the edge file
> in sysfs. This added an entry in /procs/interrupts "205:         42
>   GPIO  gpiolib" The number 42, increments every time I press my
> button to cause an physical interrupt on the pin so I know its at
> least working up to that point. I used this number 205 as the argument
> to rt_intr_create, but I'm not sure that was the right thing to do.
> 
> Here's the complete source code, its not complicated at all.
> 
> #include <sys/mman.h>
> #include <errno.h>
> #include <signal.h>
> #include <native/task.h>
> #include <native/intr.h>
> #define IRQ_NUMBER 205          /* GPIOLIB interrupt */
> #define TASK_PRIO  99           /* Highest RT priority */
> #define TASK_MODE  0            /* No flags */
> #define TASK_STKSZ 0            /* Stack size (use default one) */
> 
> RT_INTR intr_desc;
> RT_TASK server_desc;
> 
> void irq_server(void *cookie)
> {
>         int err;
>         for (;;) {
>                 /* Wait for the next interrupt */
> 
>                 /* Always returns -38 instantly*/
>                 err = rt_intr_wait(&intr_desc, TM_INFINITE);
> 
>                 if (err > 0) {
>                         printf("Interrupt rcvd! %d events\n", err);
>                 } else switch (err) {
>                 case -ETIMEDOUT:
>                         printf("Timed out waiting\n");
>                         break;
>                 case -EINVAL:
>                         printf("Inavlid argument\n");
>                         break;
>                 case -EIDRM:
>                         printf("Deleted object\n");
>                         break;
>                 case -EINTR:
>                         printf("unblocked\n");
>                         break;
>                 case 0:
>                         break;
>                 default:
>                         printf("%d\n",err);
>                         perror("irq_server");
>                         break;
>                 }
>         }
> }
> 
> void catch_signal(int sig)
> {
> }
> 
> int main(int argc, char *argv[])
> {
>         signal(SIGTERM, catch_signal);
>         signal(SIGINT, catch_signal);
>         int err;
> 
>         mlockall(MCL_CURRENT | MCL_FUTURE);
> 
>         printf("Registering interrupt...\n");
>         err = rt_intr_create(&intr_desc, "MyIrq", IRQ_NUMBER, 0);
>         switch (err) {
>         case -ENOMEM:
>                 printf("No mem!\n");
>                 goto fail1;
>                 break;
>         case -EBUSY:
>                 printf("Busy!\n");
>                 goto fail1;
>                 break;
>         default:
>                 break;
>         }
> 
>         printf("Creating task...\n");
>         err = rt_task_create(&server_desc,
>                              "MyIrqServer",
>                              TASK_STKSZ, TASK_PRIO, TASK_MODE);
>         switch (err) {
>         case -ENOMEM:
>                 printf("No mem!\n");
>                 goto fail2;
>                 break;
>         case -EEXIST:
>                 printf("Name is already in use\n");
>                 goto fail2;
>                 break;
>         case -EPERM:
>                 printf("EPERM, called from async context!\n");
>                 goto fail2;
>                 break;
>         case 0: /* No error */
>                 printf("Starting task...\n");
>                 rt_task_start(&server_desc, &irq_server, NULL);
>                 break;
>         }
>         pause();
> fail2:
>         rt_task_delete(&server_desc);
> fail1:
>         rt_intr_delete(&intr_desc);
> }
> 
> 
> -Jon Wallace
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
> 



-- 
                                                                Gilles.

