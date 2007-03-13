MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17910.63947.624116.867944@domain.hid>
Date: Tue, 13 Mar 2007 20:21:47 +0100
Subject: Re: [Xenomai-help] Howto catch SEGV signals in Xenomai
In-Reply-To: <1173801179.16997.56.camel@domain.hid>
References: <11906791.1173797505269.JavaMail.ngmail@domain.hid>
	<45F6C278.4040709@domain.hid> <1173801179.16997.56.camel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
 > On Tue, 2007-03-13 at 16:25 +0100, Gilles Chanteperdrix wrote:
 > > M. Koehrer wrote:
 > > > Hi all,
 > > > 
 > > > I have a problem to catch segment violations with Xenomai:
 > > > For demonstration I use the following program:
 > > > ------------------------------------------
 > > > #include <stdio.h>
 > > > #include <sys/mman.h>
 > > > 
 > > > #include <native/task.h>
 > > > #include <native/sem.h>
 > > > RT_TASK taska_desc;
 > > > volatile int *pointer = 0;
 > > > 
 > > > void mytaska(void *cookie)
 > > > {
 > > >     int i;
 > > >     for (i=0; i < 50; i++)
 > > >     {
 > > >         rt_task_sleep(50000000);
 > > >         if (i > 20)
 > > >         {
 > > >             *pointer = 123;
 > > >         }
 > > >         printf("Hello %i\n", i);
 > > >     }
 > > >     printf("Hi, this is task A\n");
 > > > }
 > > > 
 > > > int main(void)
 > > > {
 > > >     mlockall(MCL_CURRENT|MCL_FUTURE);
 > > > 
 > > >     rt_task_create(&taska_desc, "mytaska", 0, 81, T_JOINABLE);
 > > >     rt_task_start(&taska_desc, &mytaska, NULL);
 > > > 
 > > >     rt_task_join(&taska_desc);
 > > >     printf("Main: A joined\n");
 > > > 
 > > >     return 0;
 > > > }
 > > > ---------------------------------------
 > > > Whenever i is greater than 20 a segment violation occurs, as I must not write
 > > > to address 0 (the pointer is always NULL).
 > > > However, what happens is, that my system freezes after printing out 18 or 19.
 > > > I have to reset the PC to continue.
 > > > When I write a printf() directly before the invalid assignment I get the usual linux
 > > > "segmentation fault" error message.
 > > > 
 > > > How can I catch a signal in a Xenomai real time task?
 > > > 
 > > > I am running Xenomai 2.3.0 + NOCOW patch.
 > > > 
 > > > I have enclosed the .c file and a Makefile in a .tgz file.
 > > > 
 > > > Thanks for any feedback on that issue
 > > 
 > > It looks like the "relaxing a kicked thread" issue again. Could you try
 > > the attached patch ?
 > > 
 > 
 > Gasp. This patch would contradict what's going on into
 > do_sigwake_event(); well, if you are right, we would have entered the
 > twilight zone with full ignition of the auxiliary boosters.
 > 
 > Btw, XNRELAX is a state bit, not an information one. i.e.
 > 
 > -               if (xnthread_test_info(thread, XNKICKED)) {
 > +               if (xnthread_test_info(thread, XNKICKED) && !xnthread_test_state(thread, XNRELAX)) {

The code in do_sigwake_event() prevents a relaxed thread from being
kicked, but not the other way around. Who knows in what order
things get done on an SMP system ?

-- 


					    Gilles Chanteperdrix.

