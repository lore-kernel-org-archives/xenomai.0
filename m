From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTikUtDSZiU4T0XpUvXk9x8VtjFyFftePvxZHxuot@domain.hid>
References: <AANLkTinuEh+5J4Osq895PN92VXNc1OgNF8HD526f--dA@mail.gmail.com>
	<1289813422.1933.79.camel@domain.hid>
	<AANLkTikUtDSZiU4T0XpUvXk9x8VtjFyFftePvxZHxuot@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 17 Nov 2010 15:01:46 +0100
Message-ID: <1290002506.1933.436.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Debug/trace tools for xenomai applications.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ronny meeus <ronny.meeus@domain.hid>
Cc: Xenomai-help@domain.hid

On Wed, 2010-11-17 at 14:49 +0100, ronny meeus wrote:
> Hello
> 
> I did some more tests on QEMU since the behavior on Simics is
> identical to the behavior I see on QEMU.
> This is the testcode I have used:
> 
> void test_timer_cancel(void)
> {
>         unsigned long tmr_id,ev,ret,i;
>         unsigned long failed = 0;
> 
>         for (i=1;i<3;i++)
>         {
>                 ret = tm_evevery(i,1,&tmr_id);
>                 ut_printf("tm_evevery(%lu,1,&tmr_id) => %lu\n",
> i,ret);
> 
>                 ret = tm_cancel(tmr_id);
>                 ut_printf("tm_cancel(&tmid) => %lu\n", ret);
> 
>                 ev = 0;
>                 ret = ev_receive(1, EV_ANY|EV_WAIT, 200, &ev);
>                 ut_printf("ev_receive(1, EV_ANY|EV_WAIT, 10, &ev) => %
> lu, ev=0x%lx\n", ret, ev);
> 
>                 tm_wkafter(2);
> 
>                 if (ret == 0)
>                         failed++;
>         }
>         ut_printf("#events received after cancel %lu (loopcount=%lu)\n
> \n",failed,i);
> }
> 
> void run_test(void)
> {
>         test_timer_cancel();
> }
> 
> static void task_body_wrapper(unsigned long func,unsigned long
> count,unsigned long smid,unsigned long d)
> {
>     unsigned long i;
>     ut_printf("In task_body_wrapper\n");
>     test_function test = (test_function)func;
>     for (i=0;i<count;i++)
>         test();
>     sm_v(smid);
> }
> 
> static void task_wrapper(test_function f,unsigned long count)
> {
>         unsigned long tid,smid;
>         unsigned long args[4] = {(unsigned long)f,count,0,0};
> 
>         sm_create("BLOC",0,SM_PRIOR,&smid);
>         args[2] = smid;
> 
>         t_create("TEST",25,16000,16000,0,&tid);
>         t_start(tid,0,task_body_wrapper,args);
> 
>        sm_p(smid,SM_WAIT,0);
>        sm_delete(smid);
> 
>        t_delete(tid);
> }
> 
> int main(int argc, char **argv)
> { 
>     unsigned long rnid,rsize,i;
> 
>     mlockall(MCL_CURRENT|MCL_FUTURE);
>     rt_print_auto_init(1);
> 
>     /* Body of the test goes here */
>     while (1)
>     {
>         task_wrapper(run_test,1);
>         
>         for (i=0;i<1;i++)
>             run_test();
> 
>         task_wrapper(run_test,1);
>     }
> }
> 
> (The ut_printf function is mapped on rt_printf.)
> So this test is identical to the test you proposed.

No, the reason I sent you this frag, is because we are currently
assuming that no tick will happen between tm_evevery() and ev_receive(),
which is wrong, at least in theory. So this small frag is actually
reducing the complexity to the bare minimum, so that we don't chase wild
gooses uselessly.

The clock is not synchronized with your application in periodic mode, so
you can't be sure that a pending tick won't hit the kernel - and thus
deliver the event - prior to entering ev_receive(). The odds of being
preempted by ev_send() on behalf of the tick handler before entering
ev_receive() is even higher with a period set to one tick, like in your
example, which is therefore wrong once again. Slowing down the code with
trace output may introduce variations if timing is involved.

Besides, you did not answer to the question regarding ERR_NOEVS, which
might be useful to assess where the problem might be.

> The function "test_timer_cancel" is called both from the context of
> the main thread and a TEST thread.
> 
> This is the output I get when running the test:
> 
> In task_body_wrapper
> tm_evevery(1,1,&tmr_id) => 0
> tm_cancel(&tmid) => 0
> ev_receive(1, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
> tm_evevery(2,1,&tmr_id) => 0
> tm_cancel(&tmid) => 0
> ev_receive(1, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
> #events received after cancel 0 (loopcount=3)
> 
> tm_evevery(1,1,&tmr_id) => 0
> tm_cancel(&tmid) => 0
> ev_receive(1, EV_ANY|EV_WAIT, 10, &ev) => 0, ev=0x1
> tm_evevery(2,1,&tmr_id) => 0
> tm_cancel(&tmid) => 0
> ev_receive(1, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
> #events received after cancel 1 (loopcount=3)
> 
> In task_body_wrapper
> tm_evevery(1,1,&tmr_id) => 0
> tm_cancel(&tmid) => 0
> ev_receive(1, EV_ANY|EV_WAIT, 10, &ev) => 0, ev=0x1
> tm_evevery(2,1,&tmr_id) => 0
> tm_cancel(&tmid) => 0
> ev_receive(1, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
> #events received after cancel 1 (loopcount=3)
> 
> In task_body_wrapper
> tm_evevery(1,1,&tmr_id) => 0
> tm_cancel(&tmid) => 0
> ev_receive(1, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
> tm_evevery(2,1,&tmr_id) => 0
> tm_cancel(&tmid) => 0
>  
> As you can see in most of the cases the system behaves correctly.
> In some cases, the event is received. This is the case both from the
> context of the main thread and the special thread.
> I just copy-pasted a part of the output. In most cases, the event is
> not received. I think something like 1 times out of 50 I see the event
> being received.
> 
> It looks like, if it happens, it is always the first iteration of the
> loop (the one with a timeout of 1 tick). Even if I change the initial
> timeout value to 2, the event is also received sporadically.
> 
> [ Phillippe, please note that in your test code, you have also swapped
> the parameters. You send event 3 and lateron check whether you have
> received event 4. :-) ]
> 
> Another observation is that after removing the ut_printf statements, I
> do not see the issue anymore.
> It looks like the printf/rt_printf has an impact on the system
> behavior.
> 
> I had a quick look to the LTTng as well, but I need to fix the patches
> before I will be able to integrate.
> I think this will be my next step.
> 
> Best regards,
> Ronny
> 
> 
> On Mon, Nov 15, 2010 at 10:30 AM, Philippe Gerum <rpm@xenomai.org>
> wrote:
>         On Sun, 2010-11-14 at 01:24 +0100, ronny meeus wrote:
>         > Hello
>         >
>         > I'm currently fighting with a problem in the pSOS+ skin.
>         > This my system information:
>         >
>         > [    2.314676] pci 0000:00:01.0: Activating ISA DMA hang
>         workarounds
>         > [    2.416025] I-pipe: Domain Xenomai registered.
>         > [    2.418183] Xenomai: hal/i386 started.
>         > [    2.422780] Xenomai: scheduling class idle registered.
>         > [    2.424116] Xenomai: scheduling class rt registered.
>         > [    2.566737] Xenomai: real-time nucleus v2.5.4 (Sleep
>         Walk) loaded.
>         > [    2.590628] Xenomai: starting native API services.
>         > [    2.604491] Xenomai: starting pSOS+ services.
>         > [    2.619941] HugeTLB registered 4 MB page size,
>         pre-allocated 0
>         > pages
>         >
>         > This is a piece of testcode I have created:
>         >
>         >         check("tm_evevery",tm_evevery(4,3,&tmr_id),0);
>         >         check("tm_cancel",tm_cancel(tmr_id),0);
>         >         ev_rcvd = 0;
>         >         ret = ev_receive(4,EV_ANY|EV_WAIT,10,&ev_rcvd);
>         >         check("ev_receive",ret,ERR_TIMEOUT);
>         >
>         > I just start a periodic timer that expires every 3 ticks and
>         at expiry
>         > sends event 4 to my task.
>         
>         
>         You test rather arms a timer for sending event_list=0x3 each 4
>         ticks.
>         
>         > I want to check the cancel of the timer, so I cancel it and
>         I would
>         > expect not to receive any event.
>         >
>         > What I observe is that this code is not working: I
>         immediately receive
>         > the event after starting the timer.
>         
>         
>         Please try this test code as well:
>         
>         #include <stdio.h>
>         #include <unistd.h>
>         #include <sys/types.h>
>         #include <sys/mman.h>
>         #include <psos+/psos.h>
>         
>         void foo (u_long a0, u_long a1, u_long a2, u_long a3)
>         {
>                u_long ret, ev = 0, tmid;
>         
>                printf("Started... (%lu, %lu, %lu, %lu)\n", a0, a1, a2,
>         a3);
>                ret = tm_evevery(4, 3, &tmid);
>                printf("tm_evevery(4, 3, &tmid) => %lu\n", ret);
>         
>                ret = tm_cancel(tmid);
>                printf("tm_cancel(&tmid) => %lu\n", ret);
>         
>                ret = ev_receive(4, EV_ANY|EV_WAIT, 10, &ev);
>                printf("ev_receive(4, EV_ANY|EV_WAIT, 10, &ev) => %lu,
>         ev=0x%lx\n", ret, ev);
>         }
>         
>         int main (int ac, char **av)
>         {
>                u_long ret, tid = 0, args[4];
>         
>                mlockall(MCL_CURRENT | MCL_FUTURE);
>         
>                ret = t_create("TEST", 1, 0, 0, 0, &tid);
>                printf("t_create(tid=%lu) = %lu\n", tid, ret);
>                args[0] = 1;
>                args[1] = 2;
>                args[2] = 3;
>                args[3] = 4;
>                ret = t_start(tid, 0, foo, args);
>                printf("t_start(tid=%lu) = %lu\n", tid, ret);
>         
>                return 0;
>         }
>         
>         > If I change the code like shown below (I added the
>         ev_receive with the
>         > NO_WAIT option after starting the timer), the code works
>         fine.
>         >
>         >         check("tm_evevery",tm_evevery(4,3,&tmr_id),0);
>         >         ret = ev_receive(4,EV_ANY|EV_NOWAIT,0,&ev_rcvd);
>         
>         
>         Do you receive ERR_NOEVS as expected here?
>         
>         >         check("tm_cancel",tm_cancel(tmr_id),0);
>         >         ev_rcvd = 0;
>         >         ret = ev_receive(4,EV_ANY|EV_WAIT,10,&ev_rcvd);
>         >         check("ev_receive",ret,ERR_TIMEOUT);
>         >
>         
>         
>         > Now my question is: how do I investigate an issue like this?
>         In other
>         > words, which are the best tools since this code involves
>         both user and
>         > kernel space debugging.
>         > Are there some trace tools available that are able to
>         generate a kind
>         > of sequence / trace of what is happing over time.
>         >
>         > I also have other issues that are not consistently
>         reproducible. For
>         > this kind of problems trace tools would also be useful.
>         >
>         
>         
>         If you want to validate the pSOS emulation core, the best tool
>         is the
>         simulator. Unfortunately, this tools still requires to be
>         built with an
>         antiquated C++ toolchain, so the only sane way to enable it
>         nowadays is
>         via qemu. You would need ~2 hours to set this up.
>         
>         If you want to try this, I can help. Otherwise, other
>         suggestions you
>         already got on this list will do.
>         
>         > Thanks
>         > Ronny
>         > _______________________________________________
>         > Xenomai-help mailing list
>         > Xenomai-help@domain.hid
>         > https://mail.gna.org/listinfo/xenomai-help
>         
>         
>         --
>         Philippe.
>         
>         
> 

-- 
Philippe.



