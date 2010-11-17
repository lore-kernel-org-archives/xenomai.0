MIME-Version: 1.0
In-Reply-To: <1290002506.1933.436.camel@domain.hid>
References: <AANLkTinuEh+5J4Osq895PN92VXNc1OgNF8HD526f--dA@mail.gmail.com>
	<1289813422.1933.79.camel@domain.hid>
	<AANLkTikUtDSZiU4T0XpUvXk9x8VtjFyFftePvxZHxuot@domain.hid>
	<1290002506.1933.436.camel@domain.hid>
Date: Wed, 17 Nov 2010 16:00:18 +0100
Message-ID: <AANLkTim+MjP8DHJq-uxidwYzp2yvXQToTdc+XJnV2DQ5@domain.hid>
From: ronny meeus <ronny.meeus@domain.hid>
Content-Type: multipart/alternative; boundary=0016364c743b77c462049540eecf
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai-help@domain.hid

--0016364c743b77c462049540eecf
Content-Type: text/plain; charset=ISO-8859-1

Hello Phillippe,
thanks for the instant reply.

Here is the output of your test code:

# while `true`
> do
> ./simple_test
> done

t_create(tid=54) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=54) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
t_create(tid=57) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=57) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
t_create(tid=60) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=60) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
t_create(tid=63) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=63) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
t_create(tid=66) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=66) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
t_create(tid=69) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=69) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
t_create(tid=72) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=72) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
t_create(tid=75) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 0, ev=0x3
t_start(tid=75) = 0
t_create(tid=78) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=78) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
t_create(tid=81) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=81) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
t_create(tid=84) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=84) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
t_create(tid=87) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=87) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
t_create(tid=90) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=90) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
t_create(tid=93) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=93) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
t_create(tid=96) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=96) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
t_create(tid=99) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=99) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
t_create(tid=102) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=102) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
t_create(tid=105) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=105) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
t_create(tid=108) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=108) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
t_create(tid=111) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=111) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
t_create(tid=114) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=114) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
t_create(tid=117) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 0, ev=0x3
t_start(tid=117) = 0
t_create(tid=120) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=120) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
t_create(tid=123) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 0, ev=0x3
t_start(tid=123) = 0
t_create(tid=126) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=126) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
t_create(tid=129) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=129) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
t_create(tid=132) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=132) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
t_create(tid=135) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=135) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
t_create(tid=138) = 0
Started... (1, 2, 3, 4)
tm_evevery(4, 3, &tmid) => 0
tm_cancel(&tmid) => 0
t_start(tid=138) = 0
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0

As you can see, in some cases the event is received, even it the timeout
value is 4.
This is the same observation as I did in my code. I also see the event being
received with timeout values of 1 AND 2.

This is the testcode I have used. It is almost identical with the code you
have send me, I needed to change 2 things to make it work:
- "ret = ev_receive(4, EV_ANY|EV_WAIT, 10, &ev)" replaced by "ret =
ev_receive(3, EV_ANY|EV_WAIT, 10, &ev);"
- added a sleep at the end of main and foo to make the output printed on the
screen. If the sleep is not there, the last printf statement is not visible.

#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/mman.h>
#include <psos+/psos.h>

void foo (u_long a0, u_long a1, u_long a2, u_long a3)
{
        u_long ret, ev = 0, tmid;

        printf("Started... (%lu, %lu, %lu, %lu)\n", a0, a1, a2, a3);
        ret = tm_evevery(4, 3, &tmid);
        printf("tm_evevery(4, 3, &tmid) => %lu\n", ret);

        ret = tm_cancel(tmid);
        printf("tm_cancel(&tmid) => %lu\n", ret);

        ret = ev_receive(3, EV_ANY|EV_WAIT, 10, &ev);
        printf("ev_receive(3, EV_ANY|EV_WAIT, 10, &ev) => %lu, ev=0x%lx\n",
ret, ev);
        tm_wkafter(100);

}

int main (int ac, char **av)
{
        u_long ret, tid = 0, args[4];

        mlockall(MCL_CURRENT | MCL_FUTURE);

        ret = t_create("TEST", 1, 0, 0, 0, &tid);
        printf("t_create(tid=%lu) = %lu\n", tid, ret);
        args[0] = 1;
        args[1] = 2;
        args[2] = 3;
        args[3] = 4;
        ret = t_start(tid, 0, foo, args);
        printf("t_start(tid=%lu) = %lu\n", tid, ret);

        tm_wkafter(100);
        return 0;
}


About the pending question: I indeed recieve error code 60 (ERR_NOEVS) in
case no event is pending.

Best regards,
Ronny

On Wed, Nov 17, 2010 at 3:01 PM, Philippe Gerum <rpm@xenomai.org> wrote:

> On Wed, 2010-11-17 at 14:49 +0100, ronny meeus wrote:
> > Hello
> >
> > I did some more tests on QEMU since the behavior on Simics is
> > identical to the behavior I see on QEMU.
> > This is the testcode I have used:
> >
> > void test_timer_cancel(void)
> > {
> >         unsigned long tmr_id,ev,ret,i;
> >         unsigned long failed = 0;
> >
> >         for (i=1;i<3;i++)
> >         {
> >                 ret = tm_evevery(i,1,&tmr_id);
> >                 ut_printf("tm_evevery(%lu,1,&tmr_id) => %lu\n",
> > i,ret);
> >
> >                 ret = tm_cancel(tmr_id);
> >                 ut_printf("tm_cancel(&tmid) => %lu\n", ret);
> >
> >                 ev = 0;
> >                 ret = ev_receive(1, EV_ANY|EV_WAIT, 200, &ev);
> >                 ut_printf("ev_receive(1, EV_ANY|EV_WAIT, 10, &ev) => %
> > lu, ev=0x%lx\n", ret, ev);
> >
> >                 tm_wkafter(2);
> >
> >                 if (ret == 0)
> >                         failed++;
> >         }
> >         ut_printf("#events received after cancel %lu (loopcount=%lu)\n
> > \n",failed,i);
> > }
> >
> > void run_test(void)
> > {
> >         test_timer_cancel();
> > }
> >
> > static void task_body_wrapper(unsigned long func,unsigned long
> > count,unsigned long smid,unsigned long d)
> > {
> >     unsigned long i;
> >     ut_printf("In task_body_wrapper\n");
> >     test_function test = (test_function)func;
> >     for (i=0;i<count;i++)
> >         test();
> >     sm_v(smid);
> > }
> >
> > static void task_wrapper(test_function f,unsigned long count)
> > {
> >         unsigned long tid,smid;
> >         unsigned long args[4] = {(unsigned long)f,count,0,0};
> >
> >         sm_create("BLOC",0,SM_PRIOR,&smid);
> >         args[2] = smid;
> >
> >         t_create("TEST",25,16000,16000,0,&tid);
> >         t_start(tid,0,task_body_wrapper,args);
> >
> >        sm_p(smid,SM_WAIT,0);
> >        sm_delete(smid);
> >
> >        t_delete(tid);
> > }
> >
> > int main(int argc, char **argv)
> > {
> >     unsigned long rnid,rsize,i;
> >
> >     mlockall(MCL_CURRENT|MCL_FUTURE);
> >     rt_print_auto_init(1);
> >
> >     /* Body of the test goes here */
> >     while (1)
> >     {
> >         task_wrapper(run_test,1);
> >
> >         for (i=0;i<1;i++)
> >             run_test();
> >
> >         task_wrapper(run_test,1);
> >     }
> > }
> >
> > (The ut_printf function is mapped on rt_printf.)
> > So this test is identical to the test you proposed.
>
> No, the reason I sent you this frag, is because we are currently
> assuming that no tick will happen between tm_evevery() and ev_receive(),
> which is wrong, at least in theory. So this small frag is actually
> reducing the complexity to the bare minimum, so that we don't chase wild
> gooses uselessly.
>
> The clock is not synchronized with your application in periodic mode, so
> you can't be sure that a pending tick won't hit the kernel - and thus
> deliver the event - prior to entering ev_receive(). The odds of being
> preempted by ev_send() on behalf of the tick handler before entering
> ev_receive() is even higher with a period set to one tick, like in your
> example, which is therefore wrong once again. Slowing down the code with
> trace output may introduce variations if timing is involved.
>
> Besides, you did not answer to the question regarding ERR_NOEVS, which
> might be useful to assess where the problem might be.
>
> > The function "test_timer_cancel" is called both from the context of
> > the main thread and a TEST thread.
> >
> > This is the output I get when running the test:
> >
> > In task_body_wrapper
> > tm_evevery(1,1,&tmr_id) => 0
> > tm_cancel(&tmid) => 0
> > ev_receive(1, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
> > tm_evevery(2,1,&tmr_id) => 0
> > tm_cancel(&tmid) => 0
> > ev_receive(1, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
> > #events received after cancel 0 (loopcount=3)
> >
> > tm_evevery(1,1,&tmr_id) => 0
> > tm_cancel(&tmid) => 0
> > ev_receive(1, EV_ANY|EV_WAIT, 10, &ev) => 0, ev=0x1
> > tm_evevery(2,1,&tmr_id) => 0
> > tm_cancel(&tmid) => 0
> > ev_receive(1, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
> > #events received after cancel 1 (loopcount=3)
> >
> > In task_body_wrapper
> > tm_evevery(1,1,&tmr_id) => 0
> > tm_cancel(&tmid) => 0
> > ev_receive(1, EV_ANY|EV_WAIT, 10, &ev) => 0, ev=0x1
> > tm_evevery(2,1,&tmr_id) => 0
> > tm_cancel(&tmid) => 0
> > ev_receive(1, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
> > #events received after cancel 1 (loopcount=3)
> >
> > In task_body_wrapper
> > tm_evevery(1,1,&tmr_id) => 0
> > tm_cancel(&tmid) => 0
> > ev_receive(1, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
> > tm_evevery(2,1,&tmr_id) => 0
> > tm_cancel(&tmid) => 0
> >
> > As you can see in most of the cases the system behaves correctly.
> > In some cases, the event is received. This is the case both from the
> > context of the main thread and the special thread.
> > I just copy-pasted a part of the output. In most cases, the event is
> > not received. I think something like 1 times out of 50 I see the event
> > being received.
> >
> > It looks like, if it happens, it is always the first iteration of the
> > loop (the one with a timeout of 1 tick). Even if I change the initial
> > timeout value to 2, the event is also received sporadically.
> >
> > [ Phillippe, please note that in your test code, you have also swapped
> > the parameters. You send event 3 and lateron check whether you have
> > received event 4. :-) ]
> >
> > Another observation is that after removing the ut_printf statements, I
> > do not see the issue anymore.
> > It looks like the printf/rt_printf has an impact on the system
> > behavior.
> >
> > I had a quick look to the LTTng as well, but I need to fix the patches
> > before I will be able to integrate.
> > I think this will be my next step.
> >
> > Best regards,
> > Ronny
> >
> >
> > On Mon, Nov 15, 2010 at 10:30 AM, Philippe Gerum <rpm@xenomai.org>
> > wrote:
> >         On Sun, 2010-11-14 at 01:24 +0100, ronny meeus wrote:
> >         > Hello
> >         >
> >         > I'm currently fighting with a problem in the pSOS+ skin.
> >         > This my system information:
> >         >
> >         > [    2.314676] pci 0000:00:01.0: Activating ISA DMA hang
> >         workarounds
> >         > [    2.416025] I-pipe: Domain Xenomai registered.
> >         > [    2.418183] Xenomai: hal/i386 started.
> >         > [    2.422780] Xenomai: scheduling class idle registered.
> >         > [    2.424116] Xenomai: scheduling class rt registered.
> >         > [    2.566737] Xenomai: real-time nucleus v2.5.4 (Sleep
> >         Walk) loaded.
> >         > [    2.590628] Xenomai: starting native API services.
> >         > [    2.604491] Xenomai: starting pSOS+ services.
> >         > [    2.619941] HugeTLB registered 4 MB page size,
> >         pre-allocated 0
> >         > pages
> >         >
> >         > This is a piece of testcode I have created:
> >         >
> >         >         check("tm_evevery",tm_evevery(4,3,&tmr_id),0);
> >         >         check("tm_cancel",tm_cancel(tmr_id),0);
> >         >         ev_rcvd = 0;
> >         >         ret = ev_receive(4,EV_ANY|EV_WAIT,10,&ev_rcvd);
> >         >         check("ev_receive",ret,ERR_TIMEOUT);
> >         >
> >         > I just start a periodic timer that expires every 3 ticks and
> >         at expiry
> >         > sends event 4 to my task.
> >
> >
> >         You test rather arms a timer for sending event_list=0x3 each 4
> >         ticks.
> >
> >         > I want to check the cancel of the timer, so I cancel it and
> >         I would
> >         > expect not to receive any event.
> >         >
> >         > What I observe is that this code is not working: I
> >         immediately receive
> >         > the event after starting the timer.
> >
> >
> >         Please try this test code as well:
> >
> >         #include <stdio.h>
> >         #include <unistd.h>
> >         #include <sys/types.h>
> >         #include <sys/mman.h>
> >         #include <psos+/psos.h>
> >
> >         void foo (u_long a0, u_long a1, u_long a2, u_long a3)
> >         {
> >                u_long ret, ev = 0, tmid;
> >
> >                printf("Started... (%lu, %lu, %lu, %lu)\n", a0, a1, a2,
> >         a3);
> >                ret = tm_evevery(4, 3, &tmid);
> >                printf("tm_evevery(4, 3, &tmid) => %lu\n", ret);
> >
> >                ret = tm_cancel(tmid);
> >                printf("tm_cancel(&tmid) => %lu\n", ret);
> >
> >                ret = ev_receive(4, EV_ANY|EV_WAIT, 10, &ev);
> >                printf("ev_receive(4, EV_ANY|EV_WAIT, 10, &ev) => %lu,
> >         ev=0x%lx\n", ret, ev);
> >         }
> >
> >         int main (int ac, char **av)
> >         {
> >                u_long ret, tid = 0, args[4];
> >
> >                mlockall(MCL_CURRENT | MCL_FUTURE);
> >
> >                ret = t_create("TEST", 1, 0, 0, 0, &tid);
> >                printf("t_create(tid=%lu) = %lu\n", tid, ret);
> >                args[0] = 1;
> >                args[1] = 2;
> >                args[2] = 3;
> >                args[3] = 4;
> >                ret = t_start(tid, 0, foo, args);
> >                printf("t_start(tid=%lu) = %lu\n", tid, ret);
> >
> >                return 0;
> >         }
> >
> >         > If I change the code like shown below (I added the
> >         ev_receive with the
> >         > NO_WAIT option after starting the timer), the code works
> >         fine.
> >         >
> >         >         check("tm_evevery",tm_evevery(4,3,&tmr_id),0);
> >         >         ret = ev_receive(4,EV_ANY|EV_NOWAIT,0,&ev_rcvd);
> >
> >
> >         Do you receive ERR_NOEVS as expected here?
> >
> >         >         check("tm_cancel",tm_cancel(tmr_id),0);
> >         >         ev_rcvd = 0;
> >         >         ret = ev_receive(4,EV_ANY|EV_WAIT,10,&ev_rcvd);
> >         >         check("ev_receive",ret,ERR_TIMEOUT);
> >         >
> >
> >
> >         > Now my question is: how do I investigate an issue like this?
> >         In other
> >         > words, which are the best tools since this code involves
> >         both user and
> >         > kernel space debugging.
> >         > Are there some trace tools available that are able to
> >         generate a kind
> >         > of sequence / trace of what is happing over time.
> >         >
> >         > I also have other issues that are not consistently
> >         reproducible. For
> >         > this kind of problems trace tools would also be useful.
> >         >
> >
> >
> >         If you want to validate the pSOS emulation core, the best tool
> >         is the
> >         simulator. Unfortunately, this tools still requires to be
> >         built with an
> >         antiquated C++ toolchain, so the only sane way to enable it
> >         nowadays is
> >         via qemu. You would need ~2 hours to set this up.
> >
> >         If you want to try this, I can help. Otherwise, other
> >         suggestions you
> >         already got on this list will do.
> >
> >         > Thanks
> >         > Ronny
> >         > _______________________________________________
> >         > Xenomai-help mailing list
> >         > Xenomai-help@domain.hid
> >         > https://mail.gna.org/listinfo/xenomai-help
> >
> >
> >         --
> >         Philippe.
> >
> >
> >
>
> --
> Philippe.
>
>
>

--0016364c743b77c462049540eecf
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Phillippe, <br>thanks for the instant reply.<br><br>Here is the outpu=
t of your test code:<br><br># while `true` <br>&gt; do <br>&gt; ./simple_te=
st<br>&gt; done<br><br>t_create(tid=3D54) =3D 0<br>Started... (1, 2, 3, 4)<=
br>
tm_evevery(4, 3, &amp;tmid) =3D&gt; 0<br>tm_cancel(&amp;tmid) =3D&gt; 0<br>=
t_start(tid=3D54) =3D 0<br>ev_receive(3, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&g=
t; 1, ev=3D0x0<br>t_create(tid=3D57) =3D 0<br>Started... (1, 2, 3, 4)<br>tm=
_evevery(4, 3, &amp;tmid) =3D&gt; 0<br>
tm_cancel(&amp;tmid) =3D&gt; 0<br>t_start(tid=3D57) =3D 0<br>ev_receive(3, =
EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>t_create(tid=3D60) =3D =
0<br>Started... (1, 2, 3, 4)<br>tm_evevery(4, 3, &amp;tmid) =3D&gt; 0<br>tm=
_cancel(&amp;tmid) =3D&gt; 0<br>
t_start(tid=3D60) =3D 0<br>ev_receive(3, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&g=
t; 1, ev=3D0x0<br>t_create(tid=3D63) =3D 0<br>Started... (1, 2, 3, 4)<br>tm=
_evevery(4, 3, &amp;tmid) =3D&gt; 0<br>tm_cancel(&amp;tmid) =3D&gt; 0<br>t_=
start(tid=3D63) =3D 0<br>
ev_receive(3, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>t_create(=
tid=3D66) =3D 0<br>Started... (1, 2, 3, 4)<br>tm_evevery(4, 3, &amp;tmid) =
=3D&gt; 0<br>tm_cancel(&amp;tmid) =3D&gt; 0<br>t_start(tid=3D66) =3D 0<br>e=
v_receive(3, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>
t_create(tid=3D69) =3D 0<br>Started... (1, 2, 3, 4)<br>tm_evevery(4, 3, &am=
p;tmid) =3D&gt; 0<br>tm_cancel(&amp;tmid) =3D&gt; 0<br>t_start(tid=3D69) =
=3D 0<br>ev_receive(3, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>=
t_create(tid=3D72) =3D 0<br>
Started... (1, 2, 3, 4)<br>tm_evevery(4, 3, &amp;tmid) =3D&gt; 0<br>tm_canc=
el(&amp;tmid) =3D&gt; 0<br>t_start(tid=3D72) =3D 0<br>ev_receive(3, EV_ANY|=
EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>t_create(tid=3D75) =3D 0<br>St=
arted... (1, 2, 3, 4)<br>
tm_evevery(4, 3, &amp;tmid) =3D&gt; 0<br>tm_cancel(&amp;tmid) =3D&gt; 0<br>=
ev_receive(3, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 0, ev=3D0x3<br>t_start(t=
id=3D75) =3D 0<br>t_create(tid=3D78) =3D 0<br>Started... (1, 2, 3, 4)<br>tm=
_evevery(4, 3, &amp;tmid) =3D&gt; 0<br>
tm_cancel(&amp;tmid) =3D&gt; 0<br>t_start(tid=3D78) =3D 0<br>ev_receive(3, =
EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>t_create(tid=3D81) =3D =
0<br>Started... (1, 2, 3, 4)<br>tm_evevery(4, 3, &amp;tmid) =3D&gt; 0<br>tm=
_cancel(&amp;tmid) =3D&gt; 0<br>
t_start(tid=3D81) =3D 0<br>ev_receive(3, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&g=
t; 1, ev=3D0x0<br>t_create(tid=3D84) =3D 0<br>Started... (1, 2, 3, 4)<br>tm=
_evevery(4, 3, &amp;tmid) =3D&gt; 0<br>tm_cancel(&amp;tmid) =3D&gt; 0<br>t_=
start(tid=3D84) =3D 0<br>
ev_receive(3, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>t_create(=
tid=3D87) =3D 0<br>Started... (1, 2, 3, 4)<br>tm_evevery(4, 3, &amp;tmid) =
=3D&gt; 0<br>tm_cancel(&amp;tmid) =3D&gt; 0<br>t_start(tid=3D87) =3D 0<br>e=
v_receive(3, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>
t_create(tid=3D90) =3D 0<br>Started... (1, 2, 3, 4)<br>tm_evevery(4, 3, &am=
p;tmid) =3D&gt; 0<br>tm_cancel(&amp;tmid) =3D&gt; 0<br>t_start(tid=3D90) =
=3D 0<br>ev_receive(3, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>=
t_create(tid=3D93) =3D 0<br>
Started... (1, 2, 3, 4)<br>tm_evevery(4, 3, &amp;tmid) =3D&gt; 0<br>tm_canc=
el(&amp;tmid) =3D&gt; 0<br>t_start(tid=3D93) =3D 0<br>ev_receive(3, EV_ANY|=
EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>t_create(tid=3D96) =3D 0<br>St=
arted... (1, 2, 3, 4)<br>
tm_evevery(4, 3, &amp;tmid) =3D&gt; 0<br>tm_cancel(&amp;tmid) =3D&gt; 0<br>=
t_start(tid=3D96) =3D 0<br>ev_receive(3, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&g=
t; 1, ev=3D0x0<br>t_create(tid=3D99) =3D 0<br>Started... (1, 2, 3, 4)<br>tm=
_evevery(4, 3, &amp;tmid) =3D&gt; 0<br>
tm_cancel(&amp;tmid) =3D&gt; 0<br>t_start(tid=3D99) =3D 0<br>ev_receive(3, =
EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>t_create(tid=3D102) =3D=
 0<br>Started... (1, 2, 3, 4)<br>tm_evevery(4, 3, &amp;tmid) =3D&gt; 0<br>t=
m_cancel(&amp;tmid) =3D&gt; 0<br>
t_start(tid=3D102) =3D 0<br>ev_receive(3, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&=
gt; 1, ev=3D0x0<br>t_create(tid=3D105) =3D 0<br>Started... (1, 2, 3, 4)<br>=
tm_evevery(4, 3, &amp;tmid) =3D&gt; 0<br>tm_cancel(&amp;tmid) =3D&gt; 0<br>=
t_start(tid=3D105) =3D 0<br>
ev_receive(3, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>t_create(=
tid=3D108) =3D 0<br>Started... (1, 2, 3, 4)<br>tm_evevery(4, 3, &amp;tmid) =
=3D&gt; 0<br>tm_cancel(&amp;tmid) =3D&gt; 0<br>t_start(tid=3D108) =3D 0<br>=
ev_receive(3, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>
t_create(tid=3D111) =3D 0<br>Started... (1, 2, 3, 4)<br>tm_evevery(4, 3, &a=
mp;tmid) =3D&gt; 0<br>tm_cancel(&amp;tmid) =3D&gt; 0<br>t_start(tid=3D111) =
=3D 0<br>ev_receive(3, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>=
t_create(tid=3D114) =3D 0<br>
Started... (1, 2, 3, 4)<br>tm_evevery(4, 3, &amp;tmid) =3D&gt; 0<br>tm_canc=
el(&amp;tmid) =3D&gt; 0<br>t_start(tid=3D114) =3D 0<br>ev_receive(3, EV_ANY=
|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>t_create(tid=3D117) =3D 0<br>=
Started... (1, 2, 3, 4)<br>
tm_evevery(4, 3, &amp;tmid) =3D&gt; 0<br>tm_cancel(&amp;tmid) =3D&gt; 0<br>=
ev_receive(3, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 0, ev=3D0x3<br>t_start(t=
id=3D117) =3D 0<br>t_create(tid=3D120) =3D 0<br>Started... (1, 2, 3, 4)<br>=
tm_evevery(4, 3, &amp;tmid) =3D&gt; 0<br>
tm_cancel(&amp;tmid) =3D&gt; 0<br>t_start(tid=3D120) =3D 0<br>ev_receive(3,=
 EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>t_create(tid=3D123) =
=3D 0<br>Started... (1, 2, 3, 4)<br>tm_evevery(4, 3, &amp;tmid) =3D&gt; 0<b=
r>tm_cancel(&amp;tmid) =3D&gt; 0<br>
ev_receive(3, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 0, ev=3D0x3<br>t_start(t=
id=3D123) =3D 0<br>t_create(tid=3D126) =3D 0<br>Started... (1, 2, 3, 4)<br>=
tm_evevery(4, 3, &amp;tmid) =3D&gt; 0<br>tm_cancel(&amp;tmid) =3D&gt; 0<br>=
t_start(tid=3D126) =3D 0<br>
ev_receive(3, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>t_create(=
tid=3D129) =3D 0<br>Started... (1, 2, 3, 4)<br>tm_evevery(4, 3, &amp;tmid) =
=3D&gt; 0<br>tm_cancel(&amp;tmid) =3D&gt; 0<br>t_start(tid=3D129) =3D 0<br>=
ev_receive(3, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>
t_create(tid=3D132) =3D 0<br>Started... (1, 2, 3, 4)<br>tm_evevery(4, 3, &a=
mp;tmid) =3D&gt; 0<br>tm_cancel(&amp;tmid) =3D&gt; 0<br>t_start(tid=3D132) =
=3D 0<br>ev_receive(3, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>=
t_create(tid=3D135) =3D 0<br>
Started... (1, 2, 3, 4)<br>tm_evevery(4, 3, &amp;tmid) =3D&gt; 0<br>tm_canc=
el(&amp;tmid) =3D&gt; 0<br>t_start(tid=3D135) =3D 0<br>ev_receive(3, EV_ANY=
|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>t_create(tid=3D138) =3D 0<br>=
Started... (1, 2, 3, 4)<br>
tm_evevery(4, 3, &amp;tmid) =3D&gt; 0<br>tm_cancel(&amp;tmid) =3D&gt; 0<br>=
t_start(tid=3D138) =3D 0<br>ev_receive(3, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&=
gt; 1, ev=3D0x0<br><br>As you can see, in some cases the event is received,=
 even it the timeout value is 4.<br>
This is the same observation as I did in my code. I also see the event bein=
g received with timeout values of 1 AND 2.<br><br>This is the testcode I ha=
ve used. It is almost identical with the code you have send me, I needed to=
 change 2 things to make it work:<br>
 - &quot;ret =3D ev_receive(4, EV_ANY|EV_WAIT, 10, &amp;ev)&quot; replaced =
by &quot;ret =3D ev_receive(3, EV_ANY|EV_WAIT, 10, &amp;ev);&quot;<br>- add=
ed a sleep at the end of main and foo to make the output printed on the scr=
een. If the sleep is not there, the last printf statement is not visible.<b=
r>
<br>#include &lt;stdio.h&gt;<br>#include &lt;unistd.h&gt;<br>#include &lt;s=
ys/types.h&gt;<br>#include &lt;sys/mman.h&gt;<br>#include &lt;psos+/psos.h&=
gt;<br><br>void foo (u_long a0, u_long a1, u_long a2, u_long a3)<br>{<br>
=A0=A0=A0=A0=A0=A0=A0 u_long ret, ev =3D 0, tmid;<br><br>=A0=A0=A0=A0=A0=A0=
=A0 printf(&quot;Started... (%lu, %lu, %lu, %lu)\n&quot;, a0, a1, a2, a3);<=
br>=A0=A0=A0=A0=A0=A0=A0 ret =3D tm_evevery(4, 3, &amp;tmid);<br>=A0=A0=A0=
=A0=A0=A0=A0 printf(&quot;tm_evevery(4, 3, &amp;tmid) =3D&gt; %lu\n&quot;, =
ret);<br>
<br>=A0=A0=A0=A0=A0=A0=A0 ret =3D tm_cancel(tmid);<br>=A0=A0=A0=A0=A0=A0=A0=
 printf(&quot;tm_cancel(&amp;tmid) =3D&gt; %lu\n&quot;, ret);<br><br>=A0=A0=
=A0=A0=A0=A0=A0 ret =3D ev_receive(3, EV_ANY|EV_WAIT, 10, &amp;ev);<br>=A0=
=A0=A0=A0=A0=A0=A0 printf(&quot;ev_receive(3, EV_ANY|EV_WAIT, 10, &amp;ev) =
=3D&gt; %lu, ev=3D0x%lx\n&quot;, ret, ev);<br>
=A0=A0=A0=A0=A0=A0=A0 tm_wkafter(100);<br><br>}<br><br>int main (int ac, ch=
ar **av)<br>{<br>=A0=A0=A0=A0=A0=A0=A0 u_long ret, tid =3D 0, args[4];<br><=
br>=A0=A0=A0=A0=A0=A0=A0 mlockall(MCL_CURRENT | MCL_FUTURE);<br><br>=A0=A0=
=A0=A0=A0=A0=A0 ret =3D t_create(&quot;TEST&quot;, 1, 0, 0, 0, &amp;tid);<b=
r>
=A0=A0=A0=A0=A0=A0=A0 printf(&quot;t_create(tid=3D%lu) =3D %lu\n&quot;, tid=
, ret);<br>=A0=A0=A0=A0=A0=A0=A0 args[0] =3D 1;<br>=A0=A0=A0=A0=A0=A0=A0 ar=
gs[1] =3D 2;<br>=A0=A0=A0=A0=A0=A0=A0 args[2] =3D 3;<br>=A0=A0=A0=A0=A0=A0=
=A0 args[3] =3D 4;<br>=A0=A0=A0=A0=A0=A0=A0 ret =3D t_start(tid, 0, foo, ar=
gs);<br>=A0=A0=A0=A0=A0=A0=A0 printf(&quot;t_start(tid=3D%lu) =3D %lu\n&quo=
t;, tid, ret);<br>
<br>=A0=A0=A0=A0=A0=A0=A0 tm_wkafter(100);<br>=A0=A0=A0=A0=A0=A0=A0 return =
0;<br>}<br><br><br>About the pending question: I indeed recieve error code =
60 (ERR_NOEVS) in case no event is pending.<br><br>Best regards,<br>Ronny<b=
r><br><div class=3D"gmail_quote">
On Wed, Nov 17, 2010 at 3:01 PM, Philippe Gerum <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:rpm@xenomai.org">rpm@xenomai.org</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-le=
ft: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">On Wed, 2010-11-17 at 14:49 +0100, ronny meeus wrote:<br>
&gt; Hello<br>
&gt;<br>
</div><div><div></div><div class=3D"h5">&gt; I did some more tests on QEMU =
since the behavior on Simics is<br>
&gt; identical to the behavior I see on QEMU.<br>
&gt; This is the testcode I have used:<br>
&gt;<br>
&gt; void test_timer_cancel(void)<br>
&gt; {<br>
&gt; =A0 =A0 =A0 =A0 unsigned long tmr_id,ev,ret,i;<br>
&gt; =A0 =A0 =A0 =A0 unsigned long failed =3D 0;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 for (i=3D1;i&lt;3;i++)<br>
&gt; =A0 =A0 =A0 =A0 {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D tm_evevery(i,1,&amp;tmr_id);<b=
r>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ut_printf(&quot;tm_evevery(%lu,1,&amp;=
tmr_id) =3D&gt; %lu\n&quot;,<br>
&gt; i,ret);<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D tm_cancel(tmr_id);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ut_printf(&quot;tm_cancel(&amp;tmid) =
=3D&gt; %lu\n&quot;, ret);<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ev =3D 0;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ev_receive(1, EV_ANY|EV_WAIT, =
200, &amp;ev);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ut_printf(&quot;ev_receive(1, EV_ANY|E=
V_WAIT, 10, &amp;ev) =3D&gt; %<br>
&gt; lu, ev=3D0x%lx\n&quot;, ret, ev);<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tm_wkafter(2);<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret =3D=3D 0)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 failed++;<br>
&gt; =A0 =A0 =A0 =A0 }<br>
&gt; =A0 =A0 =A0 =A0 ut_printf(&quot;#events received after cancel %lu (loo=
pcount=3D%lu)\n<br>
&gt; \n&quot;,failed,i);<br>
&gt; }<br>
&gt;<br>
&gt; void run_test(void)<br>
&gt; {<br>
&gt; =A0 =A0 =A0 =A0 test_timer_cancel();<br>
&gt; }<br>
&gt;<br>
&gt; static void task_body_wrapper(unsigned long func,unsigned long<br>
&gt; count,unsigned long smid,unsigned long d)<br>
&gt; {<br>
&gt; =A0 =A0 unsigned long i;<br>
&gt; =A0 =A0 ut_printf(&quot;In task_body_wrapper\n&quot;);<br>
&gt; =A0 =A0 test_function test =3D (test_function)func;<br>
&gt; =A0 =A0 for (i=3D0;i&lt;count;i++)<br>
&gt; =A0 =A0 =A0 =A0 test();<br>
&gt; =A0 =A0 sm_v(smid);<br>
&gt; }<br>
&gt;<br>
&gt; static void task_wrapper(test_function f,unsigned long count)<br>
&gt; {<br>
&gt; =A0 =A0 =A0 =A0 unsigned long tid,smid;<br>
&gt; =A0 =A0 =A0 =A0 unsigned long args[4] =3D {(unsigned long)f,count,0,0}=
;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 sm_create(&quot;BLOC&quot;,0,SM_PRIOR,&amp;smid);<br>
&gt; =A0 =A0 =A0 =A0 args[2] =3D smid;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 t_create(&quot;TEST&quot;,25,16000,16000,0,&amp;tid);<=
br>
&gt; =A0 =A0 =A0 =A0 t_start(tid,0,task_body_wrapper,args);<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0sm_p(smid,SM_WAIT,0);<br>
&gt; =A0 =A0 =A0 =A0sm_delete(smid);<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0t_delete(tid);<br>
&gt; }<br>
&gt;<br>
&gt; int main(int argc, char **argv)<br>
&gt; {<br>
&gt; =A0 =A0 unsigned long rnid,rsize,i;<br>
&gt;<br>
&gt; =A0 =A0 mlockall(MCL_CURRENT|MCL_FUTURE);<br>
&gt; =A0 =A0 rt_print_auto_init(1);<br>
&gt;<br>
&gt; =A0 =A0 /* Body of the test goes here */<br>
&gt; =A0 =A0 while (1)<br>
&gt; =A0 =A0 {<br>
&gt; =A0 =A0 =A0 =A0 task_wrapper(run_test,1);<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 for (i=3D0;i&lt;1;i++)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 run_test();<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 task_wrapper(run_test,1);<br>
&gt; =A0 =A0 }<br>
&gt; }<br>
&gt;<br>
&gt; (The ut_printf function is mapped on rt_printf.)<br>
&gt; So this test is identical to the test you proposed.<br>
<br>
</div></div>No, the reason I sent you this frag, is because we are currentl=
y<br>
assuming that no tick will happen between tm_evevery() and ev_receive(),<br=
>
which is wrong, at least in theory. So this small frag is actually<br>
reducing the complexity to the bare minimum, so that we don&#39;t chase wil=
d<br>
gooses uselessly.<br>
<br>
The clock is not synchronized with your application in periodic mode, so<br=
>
you can&#39;t be sure that a pending tick won&#39;t hit the kernel - and th=
us<br>
deliver the event - prior to entering ev_receive(). The odds of being<br>
preempted by ev_send() on behalf of the tick handler before entering<br>
ev_receive() is even higher with a period set to one tick, like in your<br>
example, which is therefore wrong once again. Slowing down the code with<br=
>
trace output may introduce variations if timing is involved.<br>
<br>
Besides, you did not answer to the question regarding ERR_NOEVS, which<br>
might be useful to assess where the problem might be.<br>
<div><div></div><div class=3D"h5"><br>
&gt; The function &quot;test_timer_cancel&quot; is called both from the con=
text of<br>
&gt; the main thread and a TEST thread.<br>
&gt;<br>
&gt; This is the output I get when running the test:<br>
&gt;<br>
&gt; In task_body_wrapper<br>
&gt; tm_evevery(1,1,&amp;tmr_id) =3D&gt; 0<br>
&gt; tm_cancel(&amp;tmid) =3D&gt; 0<br>
&gt; ev_receive(1, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>
&gt; tm_evevery(2,1,&amp;tmr_id) =3D&gt; 0<br>
&gt; tm_cancel(&amp;tmid) =3D&gt; 0<br>
&gt; ev_receive(1, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>
&gt; #events received after cancel 0 (loopcount=3D3)<br>
&gt;<br>
&gt; tm_evevery(1,1,&amp;tmr_id) =3D&gt; 0<br>
&gt; tm_cancel(&amp;tmid) =3D&gt; 0<br>
&gt; ev_receive(1, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 0, ev=3D0x1<br>
&gt; tm_evevery(2,1,&amp;tmr_id) =3D&gt; 0<br>
&gt; tm_cancel(&amp;tmid) =3D&gt; 0<br>
&gt; ev_receive(1, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>
&gt; #events received after cancel 1 (loopcount=3D3)<br>
&gt;<br>
&gt; In task_body_wrapper<br>
&gt; tm_evevery(1,1,&amp;tmr_id) =3D&gt; 0<br>
&gt; tm_cancel(&amp;tmid) =3D&gt; 0<br>
&gt; ev_receive(1, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 0, ev=3D0x1<br>
&gt; tm_evevery(2,1,&amp;tmr_id) =3D&gt; 0<br>
&gt; tm_cancel(&amp;tmid) =3D&gt; 0<br>
&gt; ev_receive(1, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>
&gt; #events received after cancel 1 (loopcount=3D3)<br>
&gt;<br>
&gt; In task_body_wrapper<br>
&gt; tm_evevery(1,1,&amp;tmr_id) =3D&gt; 0<br>
&gt; tm_cancel(&amp;tmid) =3D&gt; 0<br>
&gt; ev_receive(1, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>
&gt; tm_evevery(2,1,&amp;tmr_id) =3D&gt; 0<br>
&gt; tm_cancel(&amp;tmid) =3D&gt; 0<br>
&gt;<br>
&gt; As you can see in most of the cases the system behaves correctly.<br>
&gt; In some cases, the event is received. This is the case both from the<b=
r>
&gt; context of the main thread and the special thread.<br>
&gt; I just copy-pasted a part of the output. In most cases, the event is<b=
r>
&gt; not received. I think something like 1 times out of 50 I see the event=
<br>
&gt; being received.<br>
&gt;<br>
&gt; It looks like, if it happens, it is always the first iteration of the<=
br>
&gt; loop (the one with a timeout of 1 tick). Even if I change the initial<=
br>
&gt; timeout value to 2, the event is also received sporadically.<br>
&gt;<br>
&gt; [ Phillippe, please note that in your test code, you have also swapped=
<br>
&gt; the parameters. You send event 3 and lateron check whether you have<br=
>
&gt; received event 4. :-) ]<br>
&gt;<br>
&gt; Another observation is that after removing the ut_printf statements, I=
<br>
&gt; do not see the issue anymore.<br>
&gt; It looks like the printf/rt_printf has an impact on the system<br>
&gt; behavior.<br>
&gt;<br>
&gt; I had a quick look to the LTTng as well, but I need to fix the patches=
<br>
&gt; before I will be able to integrate.<br>
&gt; I think this will be my next step.<br>
&gt;<br>
&gt; Best regards,<br>
&gt; Ronny<br>
&gt;<br>
&gt;<br>
&gt; On Mon, Nov 15, 2010 at 10:30 AM, Philippe Gerum &lt;<a href=3D"mailto=
:rpm@xenomai.org">rpm@xenomai.org</a>&gt;<br>
&gt; wrote:<br>
&gt; =A0 =A0 =A0 =A0 On Sun, 2010-11-14 at 01:24 +0100, ronny meeus wrote:<=
br>
&gt; =A0 =A0 =A0 =A0 &gt; Hello<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; I&#39;m currently fighting with a problem in the =
pSOS+ skin.<br>
&gt; =A0 =A0 =A0 =A0 &gt; This my system information:<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; [ =A0 =A02.314676] pci 0000:00:01.0: Activating I=
SA DMA hang<br>
&gt; =A0 =A0 =A0 =A0 workarounds<br>
&gt; =A0 =A0 =A0 =A0 &gt; [ =A0 =A02.416025] I-pipe: Domain Xenomai registe=
red.<br>
&gt; =A0 =A0 =A0 =A0 &gt; [ =A0 =A02.418183] Xenomai: hal/i386 started.<br>
&gt; =A0 =A0 =A0 =A0 &gt; [ =A0 =A02.422780] Xenomai: scheduling class idle=
 registered.<br>
&gt; =A0 =A0 =A0 =A0 &gt; [ =A0 =A02.424116] Xenomai: scheduling class rt r=
egistered.<br>
&gt; =A0 =A0 =A0 =A0 &gt; [ =A0 =A02.566737] Xenomai: real-time nucleus v2.=
5.4 (Sleep<br>
&gt; =A0 =A0 =A0 =A0 Walk) loaded.<br>
&gt; =A0 =A0 =A0 =A0 &gt; [ =A0 =A02.590628] Xenomai: starting native API s=
ervices.<br>
&gt; =A0 =A0 =A0 =A0 &gt; [ =A0 =A02.604491] Xenomai: starting pSOS+ servic=
es.<br>
&gt; =A0 =A0 =A0 =A0 &gt; [ =A0 =A02.619941] HugeTLB registered 4 MB page s=
ize,<br>
&gt; =A0 =A0 =A0 =A0 pre-allocated 0<br>
&gt; =A0 =A0 =A0 =A0 &gt; pages<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; This is a piece of testcode I have created:<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 check(&quot;tm_evevery&quot;,tm_e=
vevery(4,3,&amp;tmr_id),0);<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 check(&quot;tm_cancel&quot;,tm_ca=
ncel(tmr_id),0);<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 ev_rcvd =3D 0;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 ret =3D ev_receive(4,EV_ANY|EV_WA=
IT,10,&amp;ev_rcvd);<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 check(&quot;ev_receive&quot;,ret,=
ERR_TIMEOUT);<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; I just start a periodic timer that expires every =
3 ticks and<br>
&gt; =A0 =A0 =A0 =A0 at expiry<br>
&gt; =A0 =A0 =A0 =A0 &gt; sends event 4 to my task.<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 You test rather arms a timer for sending event_list=3D=
0x3 each 4<br>
&gt; =A0 =A0 =A0 =A0 ticks.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; I want to check the cancel of the timer, so I can=
cel it and<br>
&gt; =A0 =A0 =A0 =A0 I would<br>
&gt; =A0 =A0 =A0 =A0 &gt; expect not to receive any event.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; What I observe is that this code is not working: =
I<br>
&gt; =A0 =A0 =A0 =A0 immediately receive<br>
&gt; =A0 =A0 =A0 =A0 &gt; the event after starting the timer.<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Please try this test code as well:<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 #include &lt;stdio.h&gt;<br>
&gt; =A0 =A0 =A0 =A0 #include &lt;unistd.h&gt;<br>
&gt; =A0 =A0 =A0 =A0 #include &lt;sys/types.h&gt;<br>
&gt; =A0 =A0 =A0 =A0 #include &lt;sys/mman.h&gt;<br>
&gt; =A0 =A0 =A0 =A0 #include &lt;psos+/psos.h&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 void foo (u_long a0, u_long a1, u_long a2, u_long a3)<=
br>
&gt; =A0 =A0 =A0 =A0 {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u_long ret, ev =3D 0, tmid;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf(&quot;Started... (%lu, %lu, %lu,=
 %lu)\n&quot;, a0, a1, a2,<br>
&gt; =A0 =A0 =A0 =A0 a3);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D tm_evevery(4, 3, &amp;tmid);<br=
>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf(&quot;tm_evevery(4, 3, &amp;tmid=
) =3D&gt; %lu\n&quot;, ret);<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D tm_cancel(tmid);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf(&quot;tm_cancel(&amp;tmid) =3D&g=
t; %lu\n&quot;, ret);<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D ev_receive(4, EV_ANY|EV_WAIT, 1=
0, &amp;ev);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf(&quot;ev_receive(4, EV_ANY|EV_WA=
IT, 10, &amp;ev) =3D&gt; %lu,<br>
&gt; =A0 =A0 =A0 =A0 ev=3D0x%lx\n&quot;, ret, ev);<br>
&gt; =A0 =A0 =A0 =A0 }<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 int main (int ac, char **av)<br>
&gt; =A0 =A0 =A0 =A0 {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u_long ret, tid =3D 0, args[4];<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mlockall(MCL_CURRENT | MCL_FUTURE);<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D t_create(&quot;TEST&quot;, 1, 0=
, 0, 0, &amp;tid);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf(&quot;t_create(tid=3D%lu) =3D %l=
u\n&quot;, tid, ret);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0args[0] =3D 1;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0args[1] =3D 2;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0args[2] =3D 3;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0args[3] =3D 4;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D t_start(tid, 0, foo, args);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf(&quot;t_start(tid=3D%lu) =3D %lu=
\n&quot;, tid, ret);<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;<br>
&gt; =A0 =A0 =A0 =A0 }<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; If I change the code like shown below (I added th=
e<br>
&gt; =A0 =A0 =A0 =A0 ev_receive with the<br>
&gt; =A0 =A0 =A0 =A0 &gt; NO_WAIT option after starting the timer), the cod=
e works<br>
&gt; =A0 =A0 =A0 =A0 fine.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 check(&quot;tm_evevery&quot;,tm_e=
vevery(4,3,&amp;tmr_id),0);<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 ret =3D ev_receive(4,EV_ANY|EV_NO=
WAIT,0,&amp;ev_rcvd);<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Do you receive ERR_NOEVS as expected here?<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 check(&quot;tm_cancel&quot;,tm_ca=
ncel(tmr_id),0);<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 ev_rcvd =3D 0;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 ret =3D ev_receive(4,EV_ANY|EV_WA=
IT,10,&amp;ev_rcvd);<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 check(&quot;ev_receive&quot;,ret,=
ERR_TIMEOUT);<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; Now my question is: how do I investigate an issue=
 like this?<br>
&gt; =A0 =A0 =A0 =A0 In other<br>
&gt; =A0 =A0 =A0 =A0 &gt; words, which are the best tools since this code i=
nvolves<br>
&gt; =A0 =A0 =A0 =A0 both user and<br>
&gt; =A0 =A0 =A0 =A0 &gt; kernel space debugging.<br>
&gt; =A0 =A0 =A0 =A0 &gt; Are there some trace tools available that are abl=
e to<br>
&gt; =A0 =A0 =A0 =A0 generate a kind<br>
&gt; =A0 =A0 =A0 =A0 &gt; of sequence / trace of what is happing over time.=
<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; I also have other issues that are not consistentl=
y<br>
&gt; =A0 =A0 =A0 =A0 reproducible. For<br>
&gt; =A0 =A0 =A0 =A0 &gt; this kind of problems trace tools would also be u=
seful.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 If you want to validate the pSOS emulation core, the b=
est tool<br>
&gt; =A0 =A0 =A0 =A0 is the<br>
&gt; =A0 =A0 =A0 =A0 simulator. Unfortunately, this tools still requires to=
 be<br>
&gt; =A0 =A0 =A0 =A0 built with an<br>
&gt; =A0 =A0 =A0 =A0 antiquated C++ toolchain, so the only sane way to enab=
le it<br>
&gt; =A0 =A0 =A0 =A0 nowadays is<br>
&gt; =A0 =A0 =A0 =A0 via qemu. You would need ~2 hours to set this up.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 If you want to try this, I can help. Otherwise, other<=
br>
&gt; =A0 =A0 =A0 =A0 suggestions you<br>
&gt; =A0 =A0 =A0 =A0 already got on this list will do.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; Thanks<br>
&gt; =A0 =A0 =A0 =A0 &gt; Ronny<br>
&gt; =A0 =A0 =A0 =A0 &gt; _______________________________________________<b=
r>
&gt; =A0 =A0 =A0 =A0 &gt; Xenomai-help mailing list<br>
&gt; =A0 =A0 =A0 =A0 &gt; <a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-h=
elp@domain.hid</a><br>
&gt; =A0 =A0 =A0 =A0 &gt; <a href=3D"https://mail.gna.org/listinfo/xenomai-=
help" target=3D"_blank">https://mail.gna.org/listinfo/xenomai-help</a><br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 --<br>
&gt; =A0 =A0 =A0 =A0 Philippe.<br>
&gt;<br>
&gt;<br>
&gt;<br>
<br>
</div></div>--<br>
<font color=3D"#888888">Philippe.<br>
<br>
<br>
</font></blockquote></div><br>

--0016364c743b77c462049540eecf--

