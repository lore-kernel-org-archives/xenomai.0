MIME-Version: 1.0
In-Reply-To: <516BC4DF.3030302@xenomai.org>
References: <CAPpP=rPQa-Fa+1j7Lb11dUX8srkinCQQ2yS2gR5y9f9Pqf1jdg@mail.gmail.com>
	<516998B7.9090901@xenomai.org>
	<CAPpP=rOEjuy8w0x-_zRv_7vHDOmjU6n1Hi=jrE6UNEULL=zYcQ@mail.gmail.com>
	<5169C63B.1070406@xenomai.org>
	<CAPpP=rMOmOkd2Gwswu685zsPhxJDMj7GnRWA0yU+gRHmz=V2bw@mail.gmail.com>
	<5169EC2C.4000101@xenomai.org>
	<CAPpP=rNCBdcussSRzHN_Vpjj0afWZRGKRqPXxh7ps2-_GP7nBQ@mail.gmail.com>
	<516BC4DF.3030302@xenomai.org>
Date: Mon, 15 Apr 2013 12:25:41 +0200
Message-ID: <CAPpP=rMRx5CKj2uJv3wBSu=UUb88W2nXy73z1B6ewBgXEQNYiQ@mail.gmail.com>
From: alex alex <duch.alexandre@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] [QUESTION] thread creation and hook function
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

linux kernel : 3.2.21
xenomai version : 2.6.2.1
arch: x86

Thank, I add your code and now I have :

case 1 : ( without nanosleep(0) )

 6138.151187] TRD: 394830ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
[ 6138.159924] TRD: 9127501ns - NOM "hook" - CPU 0 - RT:0 - shadow
[ 6138.159953] TRD: 9163835ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
[ 6138.160014] TRD: 370242723ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
[ 6138.520008] TRD: 370429306ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
[ 6139.521009] TRD: 1370433173ns - NOM "hook" - CPU 0 - RT:1 - user-space
shadow in real-time mode
[ 6139.521014] TRD: 1370446122ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
[ 6139.521705] TRD: 1371147808ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
[ 6139.521723] TRD: 1371168314ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux

case 2 : ( with nanosleep(0) before the loop )

[ 6144.996779] TRD: 382277ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
[ 6145.005024] TRD: 8625148ns - NOM "hook" - CPU 0 - RT:0 - shadow
[ 6145.005054] TRD: 8659990ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
[ 6145.008013] TRD: 8730535ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
[ 6145.008013] TRD: 8734846ns - NOM "hook" - CPU 0 - RT:1 - user-space
shadow in real-time mode
[ 6145.008013] TRD: 367409427ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
[ 6145.363763] TRD: 367634768ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
[ 6146.363810] TRD: 1367637465ns - NOM "hook" - CPU 0 - RT:1 - user-space
shadow in real-time mode
[ 6146.363815] TRD: 1367646922ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
[ 6146.365055] TRD: 1368896836ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux
[ 6146.365073] TRD: 1368916343ns - NOM "ROOT/0" - CPU 0 - RT:1 - linux

If I follow these outputs, this means that the loop is made by a linux task
and if I add a nanosleep just before, the loop is done by the xenomai task.
Moreover, "hook " switch in primary mode only when it is destroyed unless we
force a primary switch with nanosleep(0) before the loop.

Is a xenomai thread shouldn't start in primary mode or maybe it wait for a
rt service to switch in primary mode?


2013/4/15 Philippe Gerum <rpm@xenomai.org>

> On 04/15/2013 10:47 AM, alex alex wrote:
>
>> There are simple ways in the application itself, you do not need a
>>> kernel module and a switch hook.
>>>
>>
>> The reason I use a switch hook is to retrieve informations about context
>> switches to produce a Gantt chart of the sechuleur. But maybe hook
>> functions are
>> not suitable for this?
>>
>
>
> Yes, they are, but you should have introduced you mail topic mentioning
> your goal first. The ipipe tracer won't help you in this case.
>
> You should be able to achieve this goal by interposing on the three hooks,
> possibly sending the collected data through a message pipe or XDDP socket
> to a userland app for post-processing.
>
> Hints, for Xenomai 2.6 (-forge works differently):
>
> - scheduler hooks are executed with core lock held, interrupts off: do not
> spend too much time there, or the timings would be affected too much.
>
> - in the SWITCH hook, the following code would tell you whether you are
> looking at a regular linux thread, at a relaxed shadow thread, or at a
> Xenomai thread running in real-time mode, either in userland or kernel
> space:
>
> struct xnthread *me, *t;
>
> me = xnpod_current_thread(); /* this is fine, we are nklock-ed, irqs off */
>
> if (xnthread_test_state(me, XNROOT)) {
>         t = xnshadow_thread(current);
>         if (t) {
>                 /* current is shadowed, t is Xenomai's mate, relaxed */
>         } else {
>                 /* current is a regular linux task, no Xenomai shadow */
>         }
> } else if (xnthread_test_state(me, XNSHADOW)) {
>         /* me is a user-space shadow in real-time mode. */
> } else {
>         /* me is a kernel-based Xenomai thread (always real-time). */
> }
>
> --
> Philippe.
>
