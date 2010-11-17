MIME-Version: 1.0
In-Reply-To: <1289813422.1933.79.camel@domain.hid>
References: <AANLkTinuEh+5J4Osq895PN92VXNc1OgNF8HD526f--dA@mail.gmail.com>
	<1289813422.1933.79.camel@domain.hid>
Date: Wed, 17 Nov 2010 14:49:59 +0100
Message-ID: <AANLkTikUtDSZiU4T0XpUvXk9x8VtjFyFftePvxZHxuot@domain.hid>
From: ronny meeus <ronny.meeus@domain.hid>
Content-Type: multipart/alternative; boundary=00163646da6c0b7b7d04953ff35b
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

--00163646da6c0b7b7d04953ff35b
Content-Type: text/plain; charset=ISO-8859-1

Hello

I did some more tests on QEMU since the behavior on Simics is identical to
the behavior I see on QEMU.
This is the testcode I have used:

void test_timer_cancel(void)
{
        unsigned long tmr_id,ev,ret,i;
        unsigned long failed = 0;

        for (i=1;i<3;i++)
        {
                ret = tm_evevery(i,1,&tmr_id);
                ut_printf("tm_evevery(%lu,1,&tmr_id) => %lu\n", i,ret);

                ret = tm_cancel(tmr_id);
                ut_printf("tm_cancel(&tmid) => %lu\n", ret);

                ev = 0;
                ret = ev_receive(1, EV_ANY|EV_WAIT, 200, &ev);
                ut_printf("ev_receive(1, EV_ANY|EV_WAIT, 10, &ev) => %lu,
ev=0x%lx\n", ret, ev);

                tm_wkafter(2);

                if (ret == 0)
                        failed++;
        }
        ut_printf("#events received after cancel %lu
(loopcount=%lu)\n\n",failed,i);
}

void run_test(void)
{
        test_timer_cancel();
}

static void task_body_wrapper(unsigned long func,unsigned long
count,unsigned long smid,unsigned long d)
{
    unsigned long i;
    ut_printf("In task_body_wrapper\n");
    test_function test = (test_function)func;
    for (i=0;i<count;i++)
        test();
    sm_v(smid);
}

static void task_wrapper(test_function f,unsigned long count)
{
        unsigned long tid,smid;
        unsigned long args[4] = {(unsigned long)f,count,0,0};

        sm_create("BLOC",0,SM_PRIOR,&smid);
        args[2] = smid;

        t_create("TEST",25,16000,16000,0,&tid);
        t_start(tid,0,task_body_wrapper,args);

       sm_p(smid,SM_WAIT,0);
       sm_delete(smid);

       t_delete(tid);
}

int main(int argc, char **argv)
{
    unsigned long rnid,rsize,i;

    mlockall(MCL_CURRENT|MCL_FUTURE);
    rt_print_auto_init(1);

    /* Body of the test goes here */
    while (1)
    {
        task_wrapper(run_test,1);

        for (i=0;i<1;i++)
            run_test();

        task_wrapper(run_test,1);
    }
}

(The ut_printf function is mapped on rt_printf.)
So this test is identical to the test you proposed.
The function "test_timer_cancel" is called both from the context of the main
thread and a TEST thread.

This is the output I get when running the test:

In task_body_wrapper
tm_evevery(1,1,&tmr_id) => 0
tm_cancel(&tmid) => 0
ev_receive(1, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
tm_evevery(2,1,&tmr_id) => 0
tm_cancel(&tmid) => 0
ev_receive(1, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
#events received after cancel 0 (loopcount=3)

tm_evevery(1,1,&tmr_id) => 0
tm_cancel(&tmid) => 0
ev_receive(1, EV_ANY|EV_WAIT, 10, &ev) => 0, ev=0x1
tm_evevery(2,1,&tmr_id) => 0
tm_cancel(&tmid) => 0
ev_receive(1, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
#events received after cancel 1 (loopcount=3)

In task_body_wrapper
tm_evevery(1,1,&tmr_id) => 0
tm_cancel(&tmid) => 0
ev_receive(1, EV_ANY|EV_WAIT, 10, &ev) => 0, ev=0x1
tm_evevery(2,1,&tmr_id) => 0
tm_cancel(&tmid) => 0
ev_receive(1, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
#events received after cancel 1 (loopcount=3)

In task_body_wrapper
tm_evevery(1,1,&tmr_id) => 0
tm_cancel(&tmid) => 0
ev_receive(1, EV_ANY|EV_WAIT, 10, &ev) => 1, ev=0x0
tm_evevery(2,1,&tmr_id) => 0
tm_cancel(&tmid) => 0

As you can see in most of the cases the system behaves correctly.
In some cases, the event is received. This is the case both from the context
of the main thread and the special thread.
I just copy-pasted a part of the output. In most cases, the event is not
received. I think something like 1 times out of 50 I see the event being
received.

It looks like, if it happens, it is always the first iteration of the loop
(the one with a timeout of 1 tick). Even if I change the initial timeout
value to 2, the event is also received sporadically.

[ Phillippe, please note that in your test code, you have also swapped the
parameters. You send event 3 and lateron check whether you have received
event 4. :-) ]

Another observation is that after removing the ut_printf statements, I do
not see the issue anymore.
It looks like the printf/rt_printf has an impact on the system behavior.

I had a quick look to the LTTng as well, but I need to fix the patches
before I will be able to integrate.
I think this will be my next step.

Best regards,
Ronny


On Mon, Nov 15, 2010 at 10:30 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On Sun, 2010-11-14 at 01:24 +0100, ronny meeus wrote:
> > Hello
> >
> > I'm currently fighting with a problem in the pSOS+ skin.
> > This my system information:
> >
> > [    2.314676] pci 0000:00:01.0: Activating ISA DMA hang workarounds
> > [    2.416025] I-pipe: Domain Xenomai registered.
> > [    2.418183] Xenomai: hal/i386 started.
> > [    2.422780] Xenomai: scheduling class idle registered.
> > [    2.424116] Xenomai: scheduling class rt registered.
> > [    2.566737] Xenomai: real-time nucleus v2.5.4 (Sleep Walk) loaded.
> > [    2.590628] Xenomai: starting native API services.
> > [    2.604491] Xenomai: starting pSOS+ services.
> > [    2.619941] HugeTLB registered 4 MB page size, pre-allocated 0
> > pages
> >
> > This is a piece of testcode I have created:
> >
> >         check("tm_evevery",tm_evevery(4,3,&tmr_id),0);
> >         check("tm_cancel",tm_cancel(tmr_id),0);
> >         ev_rcvd = 0;
> >         ret = ev_receive(4,EV_ANY|EV_WAIT,10,&ev_rcvd);
> >         check("ev_receive",ret,ERR_TIMEOUT);
> >
> > I just start a periodic timer that expires every 3 ticks and at expiry
> > sends event 4 to my task.
>
> You test rather arms a timer for sending event_list=0x3 each 4 ticks.
>
> > I want to check the cancel of the timer, so I cancel it and I would
> > expect not to receive any event.
> >
> > What I observe is that this code is not working: I immediately receive
> > the event after starting the timer.
>
> Please try this test code as well:
>
> #include <stdio.h>
> #include <unistd.h>
> #include <sys/types.h>
> #include <sys/mman.h>
> #include <psos+/psos.h>
>
> void foo (u_long a0, u_long a1, u_long a2, u_long a3)
> {
>        u_long ret, ev = 0, tmid;
>
>        printf("Started... (%lu, %lu, %lu, %lu)\n", a0, a1, a2, a3);
>        ret = tm_evevery(4, 3, &tmid);
>        printf("tm_evevery(4, 3, &tmid) => %lu\n", ret);
>
>        ret = tm_cancel(tmid);
>        printf("tm_cancel(&tmid) => %lu\n", ret);
>
>        ret = ev_receive(4, EV_ANY|EV_WAIT, 10, &ev);
>        printf("ev_receive(4, EV_ANY|EV_WAIT, 10, &ev) => %lu, ev=0x%lx\n",
> ret, ev);
> }
>
> int main (int ac, char **av)
> {
>        u_long ret, tid = 0, args[4];
>
>        mlockall(MCL_CURRENT | MCL_FUTURE);
>
>        ret = t_create("TEST", 1, 0, 0, 0, &tid);
>        printf("t_create(tid=%lu) = %lu\n", tid, ret);
>        args[0] = 1;
>        args[1] = 2;
>        args[2] = 3;
>        args[3] = 4;
>        ret = t_start(tid, 0, foo, args);
>        printf("t_start(tid=%lu) = %lu\n", tid, ret);
>
>        return 0;
> }
>
> > If I change the code like shown below (I added the ev_receive with the
> > NO_WAIT option after starting the timer), the code works fine.
> >
> >         check("tm_evevery",tm_evevery(4,3,&tmr_id),0);
> >         ret = ev_receive(4,EV_ANY|EV_NOWAIT,0,&ev_rcvd);
>
> Do you receive ERR_NOEVS as expected here?
>
> >         check("tm_cancel",tm_cancel(tmr_id),0);
> >         ev_rcvd = 0;
> >         ret = ev_receive(4,EV_ANY|EV_WAIT,10,&ev_rcvd);
> >         check("ev_receive",ret,ERR_TIMEOUT);
> >
>
>
> > Now my question is: how do I investigate an issue like this? In other
> > words, which are the best tools since this code involves both user and
> > kernel space debugging.
> > Are there some trace tools available that are able to generate a kind
> > of sequence / trace of what is happing over time.
> >
> > I also have other issues that are not consistently reproducible. For
> > this kind of problems trace tools would also be useful.
> >
>
> If you want to validate the pSOS emulation core, the best tool is the
> simulator. Unfortunately, this tools still requires to be built with an
> antiquated C++ toolchain, so the only sane way to enable it nowadays is
> via qemu. You would need ~2 hours to set this up.
>
> If you want to try this, I can help. Otherwise, other suggestions you
> already got on this list will do.
>
> > Thanks
> > Ronny
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
>
> --
> Philippe.
>
>
>

--00163646da6c0b7b7d04953ff35b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello<br><br>I did some more tests on QEMU since the behavior on Simics is =
identical to the behavior I see on QEMU.<br>This is the testcode I have use=
d:<br><br>void test_timer_cancel(void)<br>{<br>=A0=A0=A0=A0=A0=A0=A0 unsign=
ed long tmr_id,ev,ret,i;<br>
=A0=A0=A0=A0=A0=A0=A0 unsigned long failed =3D 0;<br><br>=A0=A0=A0=A0=A0=A0=
=A0 for (i=3D1;i&lt;3;i++)<br>=A0=A0=A0=A0=A0=A0=A0 {<br>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D tm_evevery(i,1,&amp;tmr_id);<br>=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ut_printf(&quot;tm_evevery(%lu,1,&a=
mp;tmr_id) =3D&gt; %lu\n&quot;, i,ret);<br>
<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D tm_cancel(tmr_id)=
;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ut_printf(&quot;tm_cance=
l(&amp;tmid) =3D&gt; %lu\n&quot;, ret);<br><br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 ev =3D 0;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 ret =3D ev_receive(1, EV_ANY|EV_WAIT, 200, &amp;ev);<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ut_printf(&quot;ev_receive(1,=
 EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; %lu, ev=3D0x%lx\n&quot;, ret, ev);<br=
><br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tm_wkafter(2);<br><br>=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret =3D=3D 0)<br>=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 failed++;<b=
r>
=A0=A0=A0=A0=A0=A0=A0 }<br>=A0=A0=A0=A0=A0=A0=A0 ut_printf(&quot;#events re=
ceived after cancel %lu (loopcount=3D%lu)\n\n&quot;,failed,i);<br>}<br><br>=
void run_test(void)<br>{<br>=A0=A0=A0=A0=A0=A0=A0 test_timer_cancel();<br>}=
<br><br>static void task_body_wrapper(unsigned long func,unsigned long coun=
t,unsigned long smid,unsigned long d)<br>
{<br>=A0=A0=A0 unsigned long i;<br>=A0=A0=A0 ut_printf(&quot;In task_body_w=
rapper\n&quot;);<br>=A0=A0=A0 test_function test =3D (test_function)func;<b=
r>=A0=A0=A0 for (i=3D0;i&lt;count;i++)<br>=A0=A0=A0 =A0=A0=A0 test();<br>=
=A0=A0=A0 sm_v(smid);<br>}<br><br>static void task_wrapper(test_function f,=
unsigned long count)<br>
{<br>=A0=A0=A0=A0=A0=A0=A0 unsigned long tid,smid;<br>=A0=A0=A0=A0=A0=A0=A0=
 unsigned long args[4] =3D {(unsigned long)f,count,0,0};<br><br>=A0=A0=A0=
=A0=A0=A0=A0 sm_create(&quot;BLOC&quot;,0,SM_PRIOR,&amp;smid);<br>=A0=A0 =
=A0 =A0=A0 args[2] =3D smid;<br><br>=A0=A0 =A0 =A0=A0 t_create(&quot;TEST&q=
uot;,25,16000,16000,0,&amp;tid);<br>
=A0=A0=A0=A0=A0=A0=A0 t_start(tid,0,task_body_wrapper,args);<br><br>=A0=A0 =
=A0 =A0 sm_p(smid,SM_WAIT,0);<br>=A0=A0=A0=A0=A0=A0 sm_delete(smid);<br><br=
>=A0=A0=A0=A0=A0=A0 t_delete(tid);<br>}<br><br>int main(int argc, char **ar=
gv)<br>{ <br>=A0=A0=A0 unsigned long rnid,rsize,i;<br>
<br>=A0=A0=A0 mlockall(MCL_CURRENT|MCL_FUTURE);<br>=A0=A0=A0 rt_print_auto_=
init(1);<br><br>=A0=A0=A0 /* Body of the test goes here */<br>=A0=A0=A0 whi=
le (1)<br>=A0=A0=A0 {<br>=A0=A0=A0 =A0=A0=A0 task_wrapper(run_test,1);<br>=
=A0=A0=A0 =A0=A0=A0 <br>=A0=A0=A0 =A0=A0=A0 for (i=3D0;i&lt;1;i++)<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 run_test();<br><br>=A0=A0=A0 =A0=A0=A0 task_w=
rapper(run_test,1);<br>=A0=A0=A0 }<br>}<br><br>(The ut_printf function is m=
apped on rt_printf.)<br>So this test is identical to the test you proposed.=
<br>The function &quot;test_timer_cancel&quot; is called both from the cont=
ext of the main thread and a TEST thread.<br>
<br>This is the output I get when running the test:<br><br>In task_body_wra=
pper<br>tm_evevery(1,1,&amp;tmr_id) =3D&gt; 0<br>tm_cancel(&amp;tmid) =3D&g=
t; 0<br>ev_receive(1, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>t=
m_evevery(2,1,&amp;tmr_id) =3D&gt; 0<br>
tm_cancel(&amp;tmid) =3D&gt; 0<br>ev_receive(1, EV_ANY|EV_WAIT, 10, &amp;ev=
) =3D&gt; 1, ev=3D0x0<br>#events received after cancel 0 (loopcount=3D3)<br=
><br>tm_evevery(1,1,&amp;tmr_id) =3D&gt; 0<br>tm_cancel(&amp;tmid) =3D&gt; =
0<br>ev_receive(1, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 0, ev=3D0x1<br>
tm_evevery(2,1,&amp;tmr_id) =3D&gt; 0<br>tm_cancel(&amp;tmid) =3D&gt; 0<br>=
ev_receive(1, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>#events r=
eceived after cancel 1 (loopcount=3D3)<br><br>In task_body_wrapper<br>tm_ev=
every(1,1,&amp;tmr_id) =3D&gt; 0<br>
tm_cancel(&amp;tmid) =3D&gt; 0<br>ev_receive(1, EV_ANY|EV_WAIT, 10, &amp;ev=
) =3D&gt; 0, ev=3D0x1<br>tm_evevery(2,1,&amp;tmr_id) =3D&gt; 0<br>tm_cancel=
(&amp;tmid) =3D&gt; 0<br>ev_receive(1, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt;=
 1, ev=3D0x0<br>
#events received after cancel 1 (loopcount=3D3)<br><br>In task_body_wrapper=
<br>tm_evevery(1,1,&amp;tmr_id) =3D&gt; 0<br>tm_cancel(&amp;tmid) =3D&gt; 0=
<br>ev_receive(1, EV_ANY|EV_WAIT, 10, &amp;ev) =3D&gt; 1, ev=3D0x0<br>tm_ev=
every(2,1,&amp;tmr_id) =3D&gt; 0<br>
tm_cancel(&amp;tmid) =3D&gt; 0<br>=A0<br>As you can see in most of the case=
s the system behaves correctly.<br>In some cases, the event is received. Th=
is is the case both from the context of the main thread and the special thr=
ead.<br>
I just copy-pasted a part of the output. In most cases, the event is not re=
ceived. I think something like 1 times out of 50 I see the event being rece=
ived.<br><br>It looks like, if it happens, it is always the first iteration=
 of the loop (the one with a timeout of 1 tick). Even if I change the initi=
al timeout value to 2, the event is also received sporadically.<br>
<br>[ Phillippe, please note that in your test code, you have also swapped =
the parameters. You send event 3 and lateron check whether you have receive=
d event 4. :-) ]<br><br>Another observation is that after removing the ut_p=
rintf statements, I do not see the issue anymore.<br>
It looks like the printf/rt_printf has an impact on the system behavior.<br=
><br>I had a quick look to the LTTng as well, but I need to fix the patches=
 before I will be able to integrate.<br>I think this will be my next step.<=
br>
<br>Best regards,<br>Ronny<br><br><br><div class=3D"gmail_quote">On Mon, No=
v 15, 2010 at 10:30 AM, Philippe Gerum <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:rpm@xenomai.org">rpm@xenomai.org</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px s=
olid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">On Sun, 2010-11-14 at 01:24 +0100, ronny meeus wrote:<br>
&gt; Hello<br>
&gt;<br>
&gt; I&#39;m currently fighting with a problem in the pSOS+ skin.<br>
&gt; This my system information:<br>
&gt;<br>
&gt; [ =A0 =A02.314676] pci 0000:00:01.0: Activating ISA DMA hang workaroun=
ds<br>
&gt; [ =A0 =A02.416025] I-pipe: Domain Xenomai registered.<br>
&gt; [ =A0 =A02.418183] Xenomai: hal/i386 started.<br>
&gt; [ =A0 =A02.422780] Xenomai: scheduling class idle registered.<br>
&gt; [ =A0 =A02.424116] Xenomai: scheduling class rt registered.<br>
&gt; [ =A0 =A02.566737] Xenomai: real-time nucleus v2.5.4 (Sleep Walk) load=
ed.<br>
&gt; [ =A0 =A02.590628] Xenomai: starting native API services.<br>
&gt; [ =A0 =A02.604491] Xenomai: starting pSOS+ services.<br>
&gt; [ =A0 =A02.619941] HugeTLB registered 4 MB page size, pre-allocated 0<=
br>
&gt; pages<br>
&gt;<br>
&gt; This is a piece of testcode I have created:<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 check(&quot;tm_evevery&quot;,tm_evevery(4,3,&amp;tmr_i=
d),0);<br>
&gt; =A0 =A0 =A0 =A0 check(&quot;tm_cancel&quot;,tm_cancel(tmr_id),0);<br>
&gt; =A0 =A0 =A0 =A0 ev_rcvd =3D 0;<br>
&gt; =A0 =A0 =A0 =A0 ret =3D ev_receive(4,EV_ANY|EV_WAIT,10,&amp;ev_rcvd);<=
br>
&gt; =A0 =A0 =A0 =A0 check(&quot;ev_receive&quot;,ret,ERR_TIMEOUT);<br>
&gt;<br>
&gt; I just start a periodic timer that expires every 3 ticks and at expiry=
<br>
&gt; sends event 4 to my task.<br>
<br>
</div>You test rather arms a timer for sending event_list=3D0x3 each 4 tick=
s.<br>
<div class=3D"im"><br>
&gt; I want to check the cancel of the timer, so I cancel it and I would<br=
>
&gt; expect not to receive any event.<br>
&gt;<br>
&gt; What I observe is that this code is not working: I immediately receive=
<br>
&gt; the event after starting the timer.<br>
<br>
</div>Please try this test code as well:<br>
<br>
#include &lt;stdio.h&gt;<br>
#include &lt;unistd.h&gt;<br>
#include &lt;sys/types.h&gt;<br>
#include &lt;sys/mman.h&gt;<br>
#include &lt;psos+/psos.h&gt;<br>
<br>
void foo (u_long a0, u_long a1, u_long a2, u_long a3)<br>
{<br>
 =A0 =A0 =A0 =A0u_long ret, ev =3D 0, tmid;<br>
<br>
 =A0 =A0 =A0 =A0printf(&quot;Started... (%lu, %lu, %lu, %lu)\n&quot;, a0, a=
1, a2, a3);<br>
 =A0 =A0 =A0 =A0ret =3D tm_evevery(4, 3, &amp;tmid);<br>
 =A0 =A0 =A0 =A0printf(&quot;tm_evevery(4, 3, &amp;tmid) =3D&gt; %lu\n&quot=
;, ret);<br>
<br>
 =A0 =A0 =A0 =A0ret =3D tm_cancel(tmid);<br>
 =A0 =A0 =A0 =A0printf(&quot;tm_cancel(&amp;tmid) =3D&gt; %lu\n&quot;, ret)=
;<br>
<br>
 =A0 =A0 =A0 =A0ret =3D ev_receive(4, EV_ANY|EV_WAIT, 10, &amp;ev);<br>
 =A0 =A0 =A0 =A0printf(&quot;ev_receive(4, EV_ANY|EV_WAIT, 10, &amp;ev) =3D=
&gt; %lu, ev=3D0x%lx\n&quot;, ret, ev);<br>
}<br>
<br>
int main (int ac, char **av)<br>
{<br>
 =A0 =A0 =A0 =A0u_long ret, tid =3D 0, args[4];<br>
<br>
 =A0 =A0 =A0 =A0mlockall(MCL_CURRENT | MCL_FUTURE);<br>
<br>
 =A0 =A0 =A0 =A0ret =3D t_create(&quot;TEST&quot;, 1, 0, 0, 0, &amp;tid);<b=
r>
 =A0 =A0 =A0 =A0printf(&quot;t_create(tid=3D%lu) =3D %lu\n&quot;, tid, ret)=
;<br>
 =A0 =A0 =A0 =A0args[0] =3D 1;<br>
 =A0 =A0 =A0 =A0args[1] =3D 2;<br>
 =A0 =A0 =A0 =A0args[2] =3D 3;<br>
 =A0 =A0 =A0 =A0args[3] =3D 4;<br>
 =A0 =A0 =A0 =A0ret =3D t_start(tid, 0, foo, args);<br>
 =A0 =A0 =A0 =A0printf(&quot;t_start(tid=3D%lu) =3D %lu\n&quot;, tid, ret);=
<br>
<br>
 =A0 =A0 =A0 =A0return 0;<br>
<div class=3D"im">}<br>
<br>
&gt; If I change the code like shown below (I added the ev_receive with the=
<br>
&gt; NO_WAIT option after starting the timer), the code works fine.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 check(&quot;tm_evevery&quot;,tm_evevery(4,3,&amp;tmr_i=
d),0);<br>
&gt; =A0 =A0 =A0 =A0 ret =3D ev_receive(4,EV_ANY|EV_NOWAIT,0,&amp;ev_rcvd);=
<br>
<br>
</div>Do you receive ERR_NOEVS as expected here?<br>
<div class=3D"im"><br>
&gt; =A0 =A0 =A0 =A0 check(&quot;tm_cancel&quot;,tm_cancel(tmr_id),0);<br>
&gt; =A0 =A0 =A0 =A0 ev_rcvd =3D 0;<br>
&gt; =A0 =A0 =A0 =A0 ret =3D ev_receive(4,EV_ANY|EV_WAIT,10,&amp;ev_rcvd);<=
br>
&gt; =A0 =A0 =A0 =A0 check(&quot;ev_receive&quot;,ret,ERR_TIMEOUT);<br>
&gt;<br>
<br>
<br>
&gt; Now my question is: how do I investigate an issue like this? In other<=
br>
&gt; words, which are the best tools since this code involves both user and=
<br>
&gt; kernel space debugging.<br>
&gt; Are there some trace tools available that are able to generate a kind<=
br>
&gt; of sequence / trace of what is happing over time.<br>
&gt;<br>
&gt; I also have other issues that are not consistently reproducible. For<b=
r>
&gt; this kind of problems trace tools would also be useful.<br>
&gt;<br>
<br>
</div>If you want to validate the pSOS emulation core, the best tool is the=
<br>
simulator. Unfortunately, this tools still requires to be built with an<br>
antiquated C++ toolchain, so the only sane way to enable it nowadays is<br>
via qemu. You would need ~2 hours to set this up.<br>
<br>
If you want to try this, I can help. Otherwise, other suggestions you<br>
already got on this list will do.<br>
<br>
&gt; Thanks<br>
&gt; Ronny<br>
<div class=3D"im">&gt; _______________________________________________<br>
&gt; Xenomai-help mailing list<br>
&gt; <a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
&gt; <a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blan=
k">https://mail.gna.org/listinfo/xenomai-help</a><br>
<br>
</div>--<br>
<font color=3D"#888888">Philippe.<br>
<br>
<br>
</font></blockquote></div><br>

--00163646da6c0b7b7d04953ff35b--

