Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8B9B9.29A22BF0"
Date: Mon, 19 May 2008 09:59:41 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E646FAB@afsexc01.aurora.aero>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F7E@afsexc01.aurora.aero><4821E5BF.4040101@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F83@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F86@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F94@domain.hid>
	<482F4D8D.6050004@domain.hid>
From: "Karch, Joshua" <jkarch@domain.hid>
Subject: Re: [Xenomai-help] rt_task_send / receive bug from last week and
	use of rt_task_inquire
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8B9B9.29A22BF0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Phillipe, =20

so essentially rt_task_reply is an essential and required part of =
synchronous messaging, and TM_NONBLOCK only returns immediately if the =
listening task is not active.  In this case, since a reply is always =
necessary.  It's probably better for now to use synchronous tasks.  I =
was able to get the timeout down to 1msec because the servo controller =
always responds within 500nsec, so I could set the timeout threshold =
much more aggressively and therefore have approximately 18 msec and =
change to do control law work.

Sounds good--

Cheers,

Josh



-----Original Message-----
From: Philippe Gerum on behalf of Philippe Gerum
Sent: Sat 5/17/2008 5:26 PM
To: Karch, Joshua
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] rt_task_send / receive bug from last week =
and use of rt_task_inquire
=20
Karch, Joshua wrote:
> Phillipe,
>=20
> I was wondering if you had any progress with the rt_task_send/receive
> bug?  I was able to get the synchronized serial chain to work from
> sensor task through an rt_task_send at 50 Hz with a timeout to the
> control task, which then synchronously sends an rt_task_send with
> timeout to the motor driver on the second serial port.  When I set the
> motor driver's timeout to be 100 msec and I unplug the motor driver's
> serial interface to cause this timeout, I immediately get rt_task_send
> errors, some bad enough to cause a system crash if and only if the
> rt_task_send looks for a reply, otherwise, with the reply MCB field =
set
> to NULL, rt_task_send fails indefinitely until the program is killed =
and
> a segfault occurs.  Clearly, with a 100 msec timeout, this means that =
up
> to five rt_task send commands will come from the control law which is
> chain-linked to the sensor task before a single reply is sent back =
from
> the servo controller.
>=20
> What is the expected behavior of repeatedly issuing rt_task_send when
> the other task has not replied within a timeout specified by
> rt_task_send?  The 100 msec timeout is akin to having 3 cars on a
> highway, with the front one (the servo motor) slamming on the brakes =
and
> causing a major collision.  Basically, the servo controller must =
always
> respond within 20 msec- the time of execution for the control task in
> order to prevent the xenomai equivalent of a traffic jam.  Can and
> should this be avoided by using a function like rt_task_inquire to see
> if the servo serial driver is blocking on serial read, and if so, not
> issue an rt_task_send command?  In this way, the synchronous
> relationship between the serial sensor and the control law will never =
be
> broken.
>=20
> Regardless, bringing the serial port timeout down to 10msec, which is
> reasonable, resolves this problem for now, though it limits the =
control
> law's ability to process while the servo motor serial task has timed =
out.
>=20
> That's basically my update.  I'd still much prefer to be able to send =
a
> non-blocking trigger message without a reply for all rt_task_send =
calls

It's ok unless you end up implementing some kind of asynchronous =
protocol using
that message passing interface: this won't work. =
rt_task_send/receive/reply are
meant to implement synchronous message passing. Just to make sure the
implementation is well understood:

- passing mcb_r =3D=3D NULL to rt_task_send() does not mean that you =
won't wait for
any answer from the remote task, you will wait for rt_task_reply() to be =
called;
that answer will just be discarded before rt_task_send() returns.

- passing timeout =3D=3D TM_NONBLOCK to rt_task_send() does NOT mean not =
to wait for
a reply, but it means to wait for a reply indefinitely UNLESS no server =
is
listening to the sender before it issues the request, in which case
rt_task_send() should return immediately.

In other word, it's purely synchronous stuff. If you need asynchronous =
message
passing, then you should use another IPC.

> from the sensor to the control law to regulate the control law's loop
> rate, and perhaps also do the same for the motor controller, which
> currently places its response in shared memory.
>=20
> Thank you,
>=20
> Josh
>=20
>=20
> -----Original Message-----
> From: Karch, Joshua
> Sent: Wed 5/7/2008 3:35 PM
> To: Karch, Joshua; rpm@xenomai.org
> Cc: xenomai@xenomai.org
> Subject: RE: [Xenomai-help] rt_task_send / receive problems various
> issuesand   bug trace
>=20
> Phillipe: small clarification: the following example has replies =
enabled
> and TM_NONBLOCK on rt_task_send.  I tried the code two different ways:
> len =3D rt_task_send(listen_task,&talk_send,&talk_reply,TM_NONBLOCK);
> len =3D rt_task_send(listen_task,&talk_send,NULL,TM_NONBLOCK);// also
> deleted rt_task_reply from listen_task and commented out all =
appropriate
> RT_TASK_MCB reply structs
>=20
> both have the same bug in the end.
>=20
> Josh
>=20
>=20
> -----Original Message-----
> From: xenomai-help-bounces@domain.hid on behalf of Karch, Joshua
> Sent: Wed 5/7/2008 3:33 PM
> To: rpm@xenomai.org
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] rt_task_send / receive problems various
> issuesand   bug trace
>=20
> Phillipe,
>=20
> here is a disassembly of __rt_task_receive and the source code used to
> generate the error.  The error happens if I use TM_NONBLOCK, =
regardless
> of whether or not I enable a reply.  In the following example, I use
> rt_send_task with no reply requested (NULL), and all replies commented =
out.
>=20
> I got three errors this time, -22, -11, -110, and then finally
> BUG: unable to handle kernel NULL pointer dereference at virtual =
address
> 0000020c
> printing eip: c014f014 *pde =3D 00000000
> I hand typed the above in since I didn't capture it through a serial
> terminal.
>=20
>>From what I can see here, there's no place for a local loop to form in
> the talker task. I have the wait period set to the main rate, defined =
as
> a 20 msec for this example.  Calling rt_task_send with or without a
> RT_TASK_MCB receive struct and without a reply from the listener task
> still results in the bug occurring.  My platform is a Geode, and I'm
> running 2.6.24-4 with Xenomai 2.4.3
>=20
> Thank you,
>=20
> Josh
>=20
>=20
>=20
>=20
> c0151501 <__rt_task_receive>:
> c0151501:       55                      push   %ebp
> c0151502:       89 e5                   mov    %esp,%ebp
> c0151504:       57                      push   %edi
> c0151505:       89 d7                   mov    %edx,%edi
> c0151507:       56                      push   %esi
> c0151508:       89 c6                   mov    %eax,%esi
> c015150a:       53                      push   %ebx
> c015150b:       83 ec 5c                sub    $0x5c,%esp
> c015150e:       8b 1a                   mov    (%edx),%ebx
> c0151510:       8b 40 04                mov    0x4(%eax),%eax
> c0151513:       89 da                   mov    %ebx,%edx
> c0151515:       83 c2 10                add    $0x10,%edx
> c0151518:       19 c9                   sbb    %ecx,%ecx
> c015151a:       39 50 18                cmp    %edx,0x18(%eax)
> c015151d:       83 d9 00                sbb    $0x0,%ecx
> c0151520:       85 c9                   test   %ecx,%ecx
> c0151522:       0f 85 dd 00 00 00       jne    c0151605
> <__rt_task_receive+0x104>
> c0151528:       b9 10 00 00 00          mov    $0x10,%ecx
> c015152d:       89 da                   mov    %ebx,%edx
> c015152f:       8d 45 dc                lea    0xffffffdc(%ebp),%eax
> c0151532:       e8 29 a2 08 00          call   c01db760
> <__copy_from_user_ll_nozero>
> c0151537:       8b 4d e8                mov    0xffffffe8(%ebp),%ecx
> c015153a:       85 c9                   test   %ecx,%ecx
> c015153c:       74 18                   je     c0151556
> <__rt_task_receive+0x55>
> c015153e:       8b 55 e4                mov    0xffffffe4(%ebp),%edx
> c0151541:       8b 46 04                mov    0x4(%esi),%eax
> c0151544:       01 ca                   add    %ecx,%edx
> c0151546:       19 db                   sbb    %ebx,%ebx
> c0151548:       39 50 18                cmp    %edx,0x18(%eax)
> c015154b:       83 db 00                sbb    $0x0,%ebx
> c015154e:       85 db                   test   %ebx,%ebx
> c0151550:       0f 85 af 00 00 00       jne    c0151605
> <__rt_task_receive+0x104>
> c0151556:       8b 5f 04                mov    0x4(%edi),%ebx
> c0151559:       8b 46 04                mov    0x4(%esi),%eax
> c015155c:       89 da                   mov    %ebx,%edx
> c015155e:       83 c2 08                add    $0x8,%edx
> c0151561:       19 c9                   sbb    %ecx,%ecx
> c0151563:       39 50 18                cmp    %edx,0x18(%eax)
> c0151566:       83 d9 00                sbb    $0x0,%ecx
> c0151569:       85 c9                   test   %ecx,%ecx
> c015156b:       0f 85 94 00 00 00       jne    c0151605
> <__rt_task_receive+0x104>
> c0151571:       89 da                   mov    %ebx,%edx
> c0151573:       b9 08 00 00 00          mov    $0x8,%ecx
> c0151578:       8d 45 ec                lea    0xffffffec(%ebp),%eax
> c015157b:       e8 e0 a1 08 00          call   c01db760
> <__copy_from_user_ll_nozero>
> c0151580:       8b 5d e4                mov    0xffffffe4(%ebp),%ebx
> c0151583:       8b 55 e8                mov    0xffffffe8(%ebp),%edx
> c0151586:       89 5d 98                mov    %ebx,0xffffff98(%ebp)
> c0151589:       31 db                   xor    %ebx,%ebx
> c015158b:       85 d2                   test   %edx,%edx
> c015158d:       74 22                   je     c01515b1
> <__rt_task_receive+0xb0>
> c015158f:       83 fa 40                cmp    $0x40,%edx
> c0151592:       77 05                   ja     c0151599
> <__rt_task_receive+0x98>
> c0151594:       8d 5d 9c                lea    0xffffff9c(%ebp),%ebx
> c0151597:       eb 15                   jmp    c01515ae
> <__rt_task_receive+0xad>
> c0151599:       b8 60 b9 3c c0          mov    $0xc03cb960,%eax
> c015159e:       be f4 ff ff ff          mov    $0xfffffff4,%esi
> c01515a3:       e8 25 f2 fe ff          call   c01407cd <xnheap_alloc>
> c01515a8:       85 c0                   test   %eax,%eax
> c01515aa:       74 5e                   je     c015160a
> <__rt_task_receive+0x109>
> c01515ac:       89 c3                   mov    %eax,%ebx
> c01515ae:       89 5d e4                mov    %ebx,0xffffffe4(%ebp)
> c01515b1:       8b 55 ec                mov    0xffffffec(%ebp),%edx
> c01515b4:       8d 45 dc                lea    0xffffffdc(%ebp),%eax
> c01515b7:       8b 4d f0                mov    0xfffffff0(%ebp),%ecx
> c01515ba:       e8 42 d9 ff ff          call   c014ef01 =
<rt_task_receive>
> c01515bf:       85 c0                   test   %eax,%eax
> c01515c1:       89 c6                   mov    %eax,%esi
> c01515c3:       7e 12                   jle    c01515d7
> <__rt_task_receive+0xd6>
> c01515c5:       8b 4d e8                mov    0xffffffe8(%ebp),%ecx
> c01515c8:       85 c9                   test   %ecx,%ecx
> c01515ca:       74 0b                   je     c01515d7
> <__rt_task_receive+0xd6>
> c01515cc:       8b 55 e4                mov    0xffffffe4(%ebp),%edx
> c01515cf:       8b 45 98                mov    0xffffff98(%ebp),%eax
> c01515d2:       e8 e9 9f 08 00          call   c01db5c0 =
<__copy_to_user_ll>
> c01515d7:       8b 45 98                mov    0xffffff98(%ebp),%eax
> c01515da:       8d 55 dc                lea    0xffffffdc(%ebp),%edx
> c01515dd:       b9 10 00 00 00          mov    $0x10,%ecx
> c01515e2:       89 45 e4                mov    %eax,0xffffffe4(%ebp)
> c01515e5:       8b 07                   mov    (%edi),%eax
> c01515e7:       e8 d4 9f 08 00          call   c01db5c0 =
<__copy_to_user_ll>
> c01515ec:       85 db                   test   %ebx,%ebx
> c01515ee:       74 1a                   je     c015160a
> <__rt_task_receive+0x109>
> c01515f0:       8d 45 9c                lea    0xffffff9c(%ebp),%eax
> c01515f3:       39 c3                   cmp    %eax,%ebx
> c01515f5:       74 13                   je     c015160a
> <__rt_task_receive+0x109>
> c01515f7:       89 da                   mov    %ebx,%edx
> c01515f9:       b8 60 b9 3c c0          mov    $0xc03cb960,%eax
> c01515fe:       e8 a4 f0 fe ff          call   c01406a7 <xnheap_free>
> c0151603:       eb 05                   jmp    c015160a
> <__rt_task_receive+0x109>
> c0151605:       be f2 ff ff ff          mov    $0xfffffff2,%esi
> c015160a:       83 c4 5c                add    $0x5c,%esp
> c015160d:       89 f0                   mov    %esi,%eax
> c015160f:       5b                      pop    %ebx
> c0151610:       5e                      pop    %esi
> c0151611:       5f                      pop    %edi
> c0151612:       5d                      pop    %ebp
> c0151613:       c3                      ret  =20
>=20
>=20
>=20
>=20
> Associated source code:
>=20
>=20
> //main.cpp
> #include "talker.h"
> #include "listener.h"
> #include <sys/mman.h>
> #include <native/task.h>
> #include <signal.h>
>=20
> volatile int exitprogram;
> RT_TASK talk_task, listen_task;
>=20
>=20
> void catch_signal(int sig)
> {
>         exitprogram=3D1;
> }
>=20
> int main(int argc, char *argv[])
> {
>         exitprogram=3D0;
>       =20
>         mlockall(MCL_CURRENT | MCL_FUTURE);
>         //wait for ctrl-c
>         signal(SIGTERM, catch_signal);
>         signal(SIGINT, catch_signal);
>         talker *talk =3D new talker();
>         listener *listen =3D new listener();
>         talk->startup(&talk_task, &listen_task);
>         sleep(1);
>         listen->startup(&talk_task, &listen_task);
>         pause();
>         sleep(2);
>         rt_task_join(&talk_task);
>         rt_task_join(&listen_task);
>         rt_task_delete(&talk_task);
>         rt_task_delete(&listen_task);
>         return 0;
> }
>=20
> //talker.h
> #ifndef TALKER_H_
> #define TALKER_H_
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/time.h>
> #include <unistd.h>
> #include <sys/mman.h>
> #include <native/task.h>
> #include <native/timer.h>
> #define TIMEOUT (100000000)
> #define MAIN_RATE_NS 20000000
>=20
>=20
> extern volatile int exitprogram;
>=20
> class talker {
> public:
>         talker();
>         virtual ~talker();
>         void mainloop();
>         int startup(RT_TASK *talktask, RT_TASK *listentask);
>=20
> private:
>         RT_TASK *talk_task, *listen_task;
>         void shutdown();
>         int iret;
>=20
> protected:
>         static void thunk(void * param);
> };
>=20
>=20
>=20
> #endif /*TALKER_H_*/
>=20
>=20
>=20
> //talker.cpp
> #include "talker.h"
>=20
> talker::talker()
> {
> }
> talker::~talker()
> {
> }
>=20
> int talker::startup(RT_TASK *talktask, RT_TASK *listentask)
> {
>         talk_task=3Dtalktask;
>         listen_task=3Dlistentask;
>         rt_task_create(talk_task, "talk_task", 0, 51, 0);
>         iret=3D rt_task_start(talk_task,thunk,(void*)(this));
>         return(0);
>=20
>=20
> }
> void talker::thunk(void * param)
> {
>         talker *instance =3D (talker *) param;
>         instance->mainloop();
> }
> void talker::mainloop()
> {
>         printf("talker task started\n");
>         int len;
>         RT_TASK_MCB talk_send, talk_reply;
>=20
>         rt_task_set_periodic(NULL,TM_NOW,MAIN_RATE_NS);
>         while (1)
>         {
>                 if(exitprogram)
>                         break;
>                 rt_task_wait_period(NULL);
>                 talk_send.opcode =3D 0x01;
>                 talk_send.data =3D NULL;
>                 talk_send.size =3D 0;
>                 talk_reply.size =3D 0;
>                 talk_reply.data =3D NULL;
>                 len =3D
> rt_task_send(listen_task,&talk_send,&talk_reply,TM_NONBLOCK);
>                 if (len < 0) printf("rt_task_send error\n");
>                 if (talk_reply.opcode !=3D 4)
>                 printf("len=3D%d, opcode=3D%d\n", len, =
talk_reply.opcode);
>         }
>         shutdown();
> }
>=20
> void talker::shutdown()
> {
>     printf("Talker exits with return %d\n",iret);
> }
>=20
>=20
> //listener.h
> #ifndef LISTENER_H_
> #define LISTENER_H_
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/time.h>
> #include <unistd.h>
> #include <sys/mman.h>
> #include <native/task.h>
> #include <native/timer.h>
>=20
>=20
>=20
> extern volatile int exitprogram;
>=20
> class listener {
> public:
>         listener();
>         virtual ~listener();
>         void mainloop();
>         int startup(RT_TASK *talktask, RT_TASK *listentask);
>=20
> private:
>         RT_TASK *talk_task, *listen_task;
>         void shutdown();
>         int iret;
>=20
> protected:
>         static void thunk(void * param);
> };
>=20
>=20
>=20
> #endif /*LISTENER_H_*/
>=20
>=20
> //listener.cpp
>=20
> #include "listener.h"
>=20
> listener::listener()
> {
> }
>=20
> listener::~listener()
> {
> }
>=20
> int listener::startup(RT_TASK *talktask, RT_TASK *listentask)
> {
>         talk_task=3Dtalktask;
>         listen_task=3Dlistentask;
>         rt_task_create(listen_task, "listen_task", 0, 50, 0);
>         iret=3D rt_task_start(listen_task,thunk,(void*)(this));
>         return(0);
>=20
>=20
> }
>=20
> void listener::thunk(void * param)
> {
>         listener *instance =3D (listener *) param;
>         instance->mainloop();
> }
>=20
> void listener::mainloop()
> {
>         printf("listener task started\n");
>         unsigned char buf[10];
>         RT_TASK_MCB listen_rcv, listen_reply;
>       =20
>         while (1)
>         {
>                 int taskid;
>                 if(exitprogram)
>                         break;
>                 listen_rcv.data =3D (caddr_t)buf;
>                 listen_rcv.size =3D sizeof(buf);
>                 taskid =3D rt_task_receive(&listen_rcv,TM_INFINITE);
>                 printf("received data with opcode
> %d\n",listen_rcv.opcode);   =20
>                 listen_reply.opcode =3D 4;
>                 listen_reply.size =3D 0;
>                 listen_reply.data =3D NULL;
>                 rt_task_reply(taskid, &listen_reply);
>         }
>         shutdown();
> }
>=20
> void listener::shutdown()
> {
>     printf("listener exits with return %d\n",iret);
> }
>=20
>=20
>=20
>=20
>=20
>=20
> -----Original Message-----
> From: Philippe Gerum on behalf of Philippe Gerum
> Sent: Wed 5/7/2008 1:24 PM
> To: Karch, Joshua
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] rt_task_send / receive problems various
> issues and  bug trace
>=20
> Karch, Joshua wrote:
>>
>> Hello,
>>
>> I'm using rt_task_send from a talker task and rt_task_receive/reply =
from
>> a listener task.  When I launch the two tasks in the following order:
>> listener task,  talker task,  everything runs normally.
>>
>> However, when I launch the talker task first, and then the listener =
task
>> second, I receive rt_task_send error -22 and after a bit of time the
>> listener task starts up.
>=20
> -EINVAL is not on the error list for rt_task_send(). Could you confirm
> this result?
>=20
>  I know this is logical and to be expected,
>=20
> No, it's not. rt_task_send() does wait for the receiver to listen to,
> unless you
>  asked for a non blocking call using TM_NONBLOCK as a timeout.
>=20
>> however, it appears that issuing the rt_task_send command to a task =
that
>> hasn't been started occasionally locks up sufficient resources to
>> prevent the listener task from starting.
>=20
> Any chance your code enters a tight loop due to rt_task_send() failing
> repeatedly?
>=20
>  By controlling task startup
>> order, I was able to circumvent this issue.  Both tasks have similar
>> priorities (50, 51).
>>
>> Additionally, I am unable to use rt_task_send with TM_NONBLOCK
>> len =3D rt_task_send(listen_task,&talk_send,&talk_reply,TM_NONBLOCK);
>>
>> I get a bug failure and have to reset the machine-- see below:
>>
>=20
> Please disassemble your "vmlinux" kernel image, the exact one that
> causes a bug:
> $ objdump -d vmlinux > foo.txt.
> In that large file, search for the "__rt_task_receive" symbol (notice
> the double
> underscore prefix, we also have the "rt_task_receive" symbol, but we
> don't need
> this code at the moment), then paste&copy the disassembly code for =
that
> function. I'll have a look.
>=20
> Step #2 is to send a simple piece of code that exhibits the problem.
> This will
> speed up the debugging and fixing process.
>=20
>> The reason I want to use TM_NONBLOCK is so that I can send a trigger
>> message from the producer task to the consumer task without requiring =
a
>> reply to trigger the consumer task to act on the data received. I am
>> using the rt_task_send trigger message to gate and synchronize the
>> consumer task. Is a reply required for all rt_task_send?
>>
>> It seems if I don't send a reply when rt_task_send has a timeout
>> specified the sending task locks up and the listening task runs =
rampant,
>> i.e. rt_task_receive no longer blocks and the loop runs with no delay
>> and essentially locks up the machine, since I don't use
>> rt_set_task_periodic on the listening task.
>>
>> Here is the trace, and it requires a reboot.  I also can attach the
>> code- it is written in c++ with two separate classes as a model of =
the
>> application I am building.
>>
>> Thank you,
>>
>> Joshua Karch
>>
>> talker task started
>> rt_task_send error
>> len=3D-22, opcode=3D0
>> listener task stBUG: unable to handle kernel NULL pointer =
dereferencearted
>> rt_task_s at virtual address 0000020c
>> end error
>> len=3D-printing eip: c014f014 110, opcode=3D0
>> *pde =3D 00000000
>> Oops: 0000 [#1] PREEMPT
>> Modules linked in: xeno_timerbench nfs ipv6 nfsd lockd nfs_acl sunrpc
>> exportfs dm_snapshot dm_mirror dm_mod loop pcmcia firmware_class
>> serio_raw psmouse yenta_socket rsrc_nonstatic pcmcia_core cs5535_gpio
>> joydev evdev ext3 jbd mbcache usbhid ide_disk generic ohci_hcd =
ehci_hcd
>> amd74xx usbcore ide_core e100 mii
>>
>> Pid: 1973, comm: listen_task Not tainted (2.6.24.4 #12)
>> EIP: 0060:[<c014f014>] EFLAGS: 00010093 CPU: 0
>> EIP is at rt_task_receive+0x113/0x18b
>> EAX: cdc71f28 EBX: fffffd98 ECX: c03c5500 EDX: cd820acc
>> ESI: ffffff97 EDI: cd820610 EBP: cdc71edc ESP: cdc71ec4
>>  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
>> Process listen_task (pid: 1973, ti=3Dcdc70000 task=3Dcdc6d320
>> task.ti=3Dcdc70000)<0>
>> I-pipe domain Linux
>> Stack: 00000000 cdc71f28 00000000 cdc71ee8 cdc6d320 cdc71fb8 cdc71f4c
>> c01515bf
>>        b7d083ea cdc71f00 c0102cb1 ce46bc70 c03c7e90 cd820620 cdc6d620
>> cd80ff44
>>        c029f55b cdc71f34 00000082 b91264ee 0000002e cdc6d320 b9127ee2
>> 0000002e
>> Call Trace:
>>  [<c01045f1>] show_trace_log_lvl+0x1a/0x2f
>>  [<c01046a3>] show_stack_log_lvl+0x9d/0xa5
>>  [<c0104769>] show_registers+0xbe/0x1fd
>>  [<c01049c1>] die+0x119/0x20a
>>  [<c010ef52>] do_page_fault+0x480/0x57e
>>  [<c010ca34>] __ipipe_handle_exception+0x11e/0x166
>>  [<c02a0e7f>] error_code+0x6f/0x80
>>  [<c01515bf>] __rt_task_receive+0xbe/0x113
>>  [<c0149b0d>] losyscall_event+0x99/0x13d
>>  [<c013f05b>] __ipipe_dispatch_event+0xac/0x16c
>>  [<c010c8b1>] __ipipe_syscall_root+0x6a/0xcf
>>  [<c0103e89>] system_call+0x29/0x4a
>>  =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> Code: 00 00 8d 87 bc 04 00 00 39 c2 0f 95 c0 0f b6 c0 f7 d8 21 d0 31 =
db
>> 3d 58 02 00 00 74 06 8d 98 98 fd ff ff 8b 45 ec be 97 ff ff ff <8b> =
93
>> 74 04 00 00 3b 50 0c 77 23 85 d2 74 19 89 d1 8b b3 70 04
>> EIP: [<c014f014>] rt_task_receive+0x113/0x18b SS:ESP 0068:cdc71ec4
>> ---[ end trace 523bcd2b73b75979 ]---
>>
>>
>>
>>
>>
>> =
------------------------------------------------------------------------
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>=20
>=20
> --
> Philippe.
>=20
>=20
>=20
>=20
>=20


--=20
Philippe.


------_=_NextPart_001_01C8B9B9.29A22BF0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE>RE: [Xenomai-help] rt_task_send / receive bug from last week and =
use of rt_task_inquire</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Phillipe,&nbsp;<BR>
<BR>
so essentially rt_task_reply is an essential and required part of =
synchronous messaging, and TM_NONBLOCK only returns immediately if the =
listening task is not active.&nbsp; In this case, since a reply is =
always necessary.&nbsp; It's probably better for now to use synchronous =
tasks.&nbsp; I was able to get the timeout down to 1msec because the =
servo controller always responds within 500nsec, so I could set the =
timeout threshold much more aggressively and therefore have =
approximately 18 msec and change to do control law work.<BR>
<BR>
Sounds good--<BR>
<BR>
Cheers,<BR>
<BR>
Josh<BR>
<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Philippe Gerum on behalf of Philippe Gerum<BR>
Sent: Sat 5/17/2008 5:26 PM<BR>
To: Karch, Joshua<BR>
Cc: xenomai@xenomai.org<BR>
Subject: Re: [Xenomai-help] rt_task_send / receive bug from last week =
and use of rt_task_inquire<BR>
<BR>
Karch, Joshua wrote:<BR>
&gt; Phillipe,<BR>
&gt;<BR>
&gt; I was wondering if you had any progress with the =
rt_task_send/receive<BR>
&gt; bug?&nbsp; I was able to get the synchronized serial chain to work =
from<BR>
&gt; sensor task through an rt_task_send at 50 Hz with a timeout to =
the<BR>
&gt; control task, which then synchronously sends an rt_task_send =
with<BR>
&gt; timeout to the motor driver on the second serial port.&nbsp; When I =
set the<BR>
&gt; motor driver's timeout to be 100 msec and I unplug the motor =
driver's<BR>
&gt; serial interface to cause this timeout, I immediately get =
rt_task_send<BR>
&gt; errors, some bad enough to cause a system crash if and only if =
the<BR>
&gt; rt_task_send looks for a reply, otherwise, with the reply MCB field =
set<BR>
&gt; to NULL, rt_task_send fails indefinitely until the program is =
killed and<BR>
&gt; a segfault occurs.&nbsp; Clearly, with a 100 msec timeout, this =
means that up<BR>
&gt; to five rt_task send commands will come from the control law which =
is<BR>
&gt; chain-linked to the sensor task before a single reply is sent back =
from<BR>
&gt; the servo controller.<BR>
&gt;<BR>
&gt; What is the expected behavior of repeatedly issuing rt_task_send =
when<BR>
&gt; the other task has not replied within a timeout specified by<BR>
&gt; rt_task_send?&nbsp; The 100 msec timeout is akin to having 3 cars =
on a<BR>
&gt; highway, with the front one (the servo motor) slamming on the =
brakes and<BR>
&gt; causing a major collision.&nbsp; Basically, the servo controller =
must always<BR>
&gt; respond within 20 msec- the time of execution for the control task =
in<BR>
&gt; order to prevent the xenomai equivalent of a traffic jam.&nbsp; Can =
and<BR>
&gt; should this be avoided by using a function like rt_task_inquire to =
see<BR>
&gt; if the servo serial driver is blocking on serial read, and if so, =
not<BR>
&gt; issue an rt_task_send command?&nbsp; In this way, the =
synchronous<BR>
&gt; relationship between the serial sensor and the control law will =
never be<BR>
&gt; broken.<BR>
&gt;<BR>
&gt; Regardless, bringing the serial port timeout down to 10msec, which =
is<BR>
&gt; reasonable, resolves this problem for now, though it limits the =
control<BR>
&gt; law's ability to process while the servo motor serial task has =
timed out.<BR>
&gt;<BR>
&gt; That's basically my update.&nbsp; I'd still much prefer to be able =
to send a<BR>
&gt; non-blocking trigger message without a reply for all rt_task_send =
calls<BR>
<BR>
It's ok unless you end up implementing some kind of asynchronous =
protocol using<BR>
that message passing interface: this won't work. =
rt_task_send/receive/reply are<BR>
meant to implement synchronous message passing. Just to make sure =
the<BR>
implementation is well understood:<BR>
<BR>
- passing mcb_r =3D=3D NULL to rt_task_send() does not mean that you =
won't wait for<BR>
any answer from the remote task, you will wait for rt_task_reply() to be =
called;<BR>
that answer will just be discarded before rt_task_send() returns.<BR>
<BR>
- passing timeout =3D=3D TM_NONBLOCK to rt_task_send() does NOT mean not =
to wait for<BR>
a reply, but it means to wait for a reply indefinitely UNLESS no server =
is<BR>
listening to the sender before it issues the request, in which case<BR>
rt_task_send() should return immediately.<BR>
<BR>
In other word, it's purely synchronous stuff. If you need asynchronous =
message<BR>
passing, then you should use another IPC.<BR>
<BR>
&gt; from the sensor to the control law to regulate the control law's =
loop<BR>
&gt; rate, and perhaps also do the same for the motor controller, =
which<BR>
&gt; currently places its response in shared memory.<BR>
&gt;<BR>
&gt; Thank you,<BR>
&gt;<BR>
&gt; Josh<BR>
&gt;<BR>
&gt;<BR>
&gt; -----Original Message-----<BR>
&gt; From: Karch, Joshua<BR>
&gt; Sent: Wed 5/7/2008 3:35 PM<BR>
&gt; To: Karch, Joshua; rpm@xenomai.org<BR>
&gt; Cc: xenomai@xenomai.org<BR>
&gt; Subject: RE: [Xenomai-help] rt_task_send / receive problems =
various<BR>
&gt; issuesand&nbsp;&nbsp; bug trace<BR>
&gt;<BR>
&gt; Phillipe: small clarification: the following example has replies =
enabled<BR>
&gt; and TM_NONBLOCK on rt_task_send.&nbsp; I tried the code two =
different ways:<BR>
&gt; len =3D =
rt_task_send(listen_task,&amp;talk_send,&amp;talk_reply,TM_NONBLOCK);<BR>=

&gt; len =3D =
rt_task_send(listen_task,&amp;talk_send,NULL,TM_NONBLOCK);// also<BR>
&gt; deleted rt_task_reply from listen_task and commented out all =
appropriate<BR>
&gt; RT_TASK_MCB reply structs<BR>
&gt;<BR>
&gt; both have the same bug in the end.<BR>
&gt;<BR>
&gt; Josh<BR>
&gt;<BR>
&gt;<BR>
&gt; -----Original Message-----<BR>
&gt; From: xenomai-help-bounces@domain.hid on behalf of Karch, Joshua<BR>
&gt; Sent: Wed 5/7/2008 3:33 PM<BR>
&gt; To: rpm@xenomai.org<BR>
&gt; Cc: xenomai@xenomai.org<BR>
&gt; Subject: Re: [Xenomai-help] rt_task_send / receive problems =
various<BR>
&gt; issuesand&nbsp;&nbsp; bug trace<BR>
&gt;<BR>
&gt; Phillipe,<BR>
&gt;<BR>
&gt; here is a disassembly of __rt_task_receive and the source code used =
to<BR>
&gt; generate the error.&nbsp; The error happens if I use TM_NONBLOCK, =
regardless<BR>
&gt; of whether or not I enable a reply.&nbsp; In the following example, =
I use<BR>
&gt; rt_send_task with no reply requested (NULL), and all replies =
commented out.<BR>
&gt;<BR>
&gt; I got three errors this time, -22, -11, -110, and then finally<BR>
&gt; BUG: unable to handle kernel NULL pointer dereference at virtual =
address<BR>
&gt; 0000020c<BR>
&gt; printing eip: c014f014 *pde =3D 00000000<BR>
&gt; I hand typed the above in since I didn't capture it through a =
serial<BR>
&gt; terminal.<BR>
&gt;<BR>
&gt;&gt;From what I can see here, there's no place for a local loop to =
form in<BR>
&gt; the talker task. I have the wait period set to the main rate, =
defined as<BR>
&gt; a 20 msec for this example.&nbsp; Calling rt_task_send with or =
without a<BR>
&gt; RT_TASK_MCB receive struct and without a reply from the listener =
task<BR>
&gt; still results in the bug occurring.&nbsp; My platform is a Geode, =
and I'm<BR>
&gt; running 2.6.24-4 with Xenomai 2.4.3<BR>
&gt;<BR>
&gt; Thank you,<BR>
&gt;<BR>
&gt; Josh<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt; c0151501 &lt;__rt_task_receive&gt;:<BR>
&gt; c0151501:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
55&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; push&nbsp;&nbsp; =
%ebp<BR>
&gt; c0151502:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 =
e5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; =
%esp,%ebp<BR>
&gt; c0151504:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
57&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; push&nbsp;&nbsp; =
%edi<BR>
&gt; c0151505:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 =
d7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; =
%edx,%edi<BR>
&gt; c0151507:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
56&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; push&nbsp;&nbsp; =
%esi<BR>
&gt; c0151508:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 =
c6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; =
%eax,%esi<BR>
&gt; c015150a:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
53&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; push&nbsp;&nbsp; =
%ebx<BR>
&gt; c015150b:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 83 ec =
5c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; sub&nbsp;&nbsp;&nbsp; $0x5c,%esp<BR>
&gt; c015150e:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b =
1a&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; =
(%edx),%ebx<BR>
&gt; c0151510:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 40 =
04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0x4(%eax),%eax<BR>
&gt; c0151513:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 =
da&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; =
%ebx,%edx<BR>
&gt; c0151515:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 83 c2 =
10&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; add&nbsp;&nbsp;&nbsp; $0x10,%edx<BR>
&gt; c0151518:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19 =
c9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sbb&nbsp;&nbsp;&nbsp; =
%ecx,%ecx<BR>
&gt; c015151a:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 39 50 =
18&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; cmp&nbsp;&nbsp;&nbsp; %edx,0x18(%eax)<BR>
&gt; c015151d:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 83 d9 =
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; sbb&nbsp;&nbsp;&nbsp; $0x0,%ecx<BR>
&gt; c0151520:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 85 =
c9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test&nbsp;&nbsp; %ecx,%ecx<BR>
&gt; c0151522:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0f 85 dd 00 00 =
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; jne&nbsp;&nbsp;&nbsp; =
c0151605<BR>
&gt; &lt;__rt_task_receive+0x104&gt;<BR>
&gt; c0151528:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b9 10 00 00 =
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mov&nbsp;&nbsp;&nbsp; $0x10,%ecx<BR>
&gt; c015152d:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 =
da&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; =
%ebx,%edx<BR>
&gt; c015152f:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8d 45 =
dc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; lea&nbsp;&nbsp;&nbsp; 0xffffffdc(%ebp),%eax<BR>
&gt; c0151532:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e8 29 a2 08 =
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
call&nbsp;&nbsp; c01db760<BR>
&gt; &lt;__copy_from_user_ll_nozero&gt;<BR>
&gt; c0151537:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 4d =
e8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0xffffffe8(%ebp),%ecx<BR>
&gt; c015153a:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 85 =
c9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test&nbsp;&nbsp; %ecx,%ecx<BR>
&gt; c015153c:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 74 =
18&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; je&nbsp;&nbsp;&nbsp;&nbsp; =
c0151556<BR>
&gt; &lt;__rt_task_receive+0x55&gt;<BR>
&gt; c015153e:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 55 =
e4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0xffffffe4(%ebp),%edx<BR>
&gt; c0151541:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 46 =
04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0x4(%esi),%eax<BR>
&gt; c0151544:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01 =
ca&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; add&nbsp;&nbsp;&nbsp; =
%ecx,%edx<BR>
&gt; c0151546:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19 =
db&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sbb&nbsp;&nbsp;&nbsp; =
%ebx,%ebx<BR>
&gt; c0151548:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 39 50 =
18&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; cmp&nbsp;&nbsp;&nbsp; %edx,0x18(%eax)<BR>
&gt; c015154b:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 83 db =
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; sbb&nbsp;&nbsp;&nbsp; $0x0,%ebx<BR>
&gt; c015154e:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 85 =
db&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test&nbsp;&nbsp; %ebx,%ebx<BR>
&gt; c0151550:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0f 85 af 00 00 =
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; jne&nbsp;&nbsp;&nbsp; =
c0151605<BR>
&gt; &lt;__rt_task_receive+0x104&gt;<BR>
&gt; c0151556:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 5f =
04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0x4(%edi),%ebx<BR>
&gt; c0151559:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 46 =
04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0x4(%esi),%eax<BR>
&gt; c015155c:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 =
da&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; =
%ebx,%edx<BR>
&gt; c015155e:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 83 c2 =
08&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; add&nbsp;&nbsp;&nbsp; $0x8,%edx<BR>
&gt; c0151561:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19 =
c9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sbb&nbsp;&nbsp;&nbsp; =
%ecx,%ecx<BR>
&gt; c0151563:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 39 50 =
18&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; cmp&nbsp;&nbsp;&nbsp; %edx,0x18(%eax)<BR>
&gt; c0151566:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 83 d9 =
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; sbb&nbsp;&nbsp;&nbsp; $0x0,%ecx<BR>
&gt; c0151569:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 85 =
c9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test&nbsp;&nbsp; %ecx,%ecx<BR>
&gt; c015156b:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0f 85 94 00 00 =
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; jne&nbsp;&nbsp;&nbsp; =
c0151605<BR>
&gt; &lt;__rt_task_receive+0x104&gt;<BR>
&gt; c0151571:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 =
da&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; =
%ebx,%edx<BR>
&gt; c0151573:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b9 08 00 00 =
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mov&nbsp;&nbsp;&nbsp; $0x8,%ecx<BR>
&gt; c0151578:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8d 45 =
ec&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; lea&nbsp;&nbsp;&nbsp; 0xffffffec(%ebp),%eax<BR>
&gt; c015157b:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e8 e0 a1 08 =
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
call&nbsp;&nbsp; c01db760<BR>
&gt; &lt;__copy_from_user_ll_nozero&gt;<BR>
&gt; c0151580:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 5d =
e4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0xffffffe4(%ebp),%ebx<BR>
&gt; c0151583:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 55 =
e8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0xffffffe8(%ebp),%edx<BR>
&gt; c0151586:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 5d =
98&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; %ebx,0xffffff98(%ebp)<BR>
&gt; c0151589:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 31 =
db&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xor&nbsp;&nbsp;&nbsp; =
%ebx,%ebx<BR>
&gt; c015158b:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 85 =
d2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test&nbsp;&nbsp; %edx,%edx<BR>
&gt; c015158d:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 74 =
22&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; je&nbsp;&nbsp;&nbsp;&nbsp; =
c01515b1<BR>
&gt; &lt;__rt_task_receive+0xb0&gt;<BR>
&gt; c015158f:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 83 fa =
40&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; cmp&nbsp;&nbsp;&nbsp; $0x40,%edx<BR>
&gt; c0151592:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 77 =
05&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ja&nbsp;&nbsp;&nbsp;&nbsp; =
c0151599<BR>
&gt; &lt;__rt_task_receive+0x98&gt;<BR>
&gt; c0151594:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8d 5d =
9c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; lea&nbsp;&nbsp;&nbsp; 0xffffff9c(%ebp),%ebx<BR>
&gt; c0151597:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eb =
15&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; jmp&nbsp;&nbsp;&nbsp; c01515ae<BR>
&gt; &lt;__rt_task_receive+0xad&gt;<BR>
&gt; c0151599:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b8 60 b9 3c =
c0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mov&nbsp;&nbsp;&nbsp; $0xc03cb960,%eax<BR>
&gt; c015159e:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; be f4 ff ff =
ff&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mov&nbsp;&nbsp;&nbsp; $0xfffffff4,%esi<BR>
&gt; c01515a3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e8 25 f2 fe =
ff&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
call&nbsp;&nbsp; c01407cd &lt;xnheap_alloc&gt;<BR>
&gt; c01515a8:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 85 =
c0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test&nbsp;&nbsp; %eax,%eax<BR>
&gt; c01515aa:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 74 =
5e&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; je&nbsp;&nbsp;&nbsp;&nbsp; =
c015160a<BR>
&gt; &lt;__rt_task_receive+0x109&gt;<BR>
&gt; c01515ac:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 =
c3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; =
%eax,%ebx<BR>
&gt; c01515ae:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 5d =
e4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; %ebx,0xffffffe4(%ebp)<BR>
&gt; c01515b1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 55 =
ec&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0xffffffec(%ebp),%edx<BR>
&gt; c01515b4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8d 45 =
dc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; lea&nbsp;&nbsp;&nbsp; 0xffffffdc(%ebp),%eax<BR>
&gt; c01515b7:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 4d =
f0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0xfffffff0(%ebp),%ecx<BR>
&gt; c01515ba:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e8 42 d9 ff =
ff&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
call&nbsp;&nbsp; c014ef01 &lt;rt_task_receive&gt;<BR>
&gt; c01515bf:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 85 =
c0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test&nbsp;&nbsp; %eax,%eax<BR>
&gt; c01515c1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 =
c6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; =
%eax,%esi<BR>
&gt; c01515c3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7e =
12&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; jle&nbsp;&nbsp;&nbsp; c01515d7<BR>
&gt; &lt;__rt_task_receive+0xd6&gt;<BR>
&gt; c01515c5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 4d =
e8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0xffffffe8(%ebp),%ecx<BR>
&gt; c01515c8:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 85 =
c9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test&nbsp;&nbsp; %ecx,%ecx<BR>
&gt; c01515ca:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 74 =
0b&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; je&nbsp;&nbsp;&nbsp;&nbsp; =
c01515d7<BR>
&gt; &lt;__rt_task_receive+0xd6&gt;<BR>
&gt; c01515cc:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 55 =
e4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0xffffffe4(%ebp),%edx<BR>
&gt; c01515cf:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 45 =
98&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0xffffff98(%ebp),%eax<BR>
&gt; c01515d2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e8 e9 9f 08 =
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
call&nbsp;&nbsp; c01db5c0 &lt;__copy_to_user_ll&gt;<BR>
&gt; c01515d7:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 45 =
98&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0xffffff98(%ebp),%eax<BR>
&gt; c01515da:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8d 55 =
dc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; lea&nbsp;&nbsp;&nbsp; 0xffffffdc(%ebp),%edx<BR>
&gt; c01515dd:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b9 10 00 00 =
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mov&nbsp;&nbsp;&nbsp; $0x10,%ecx<BR>
&gt; c01515e2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 45 =
e4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; %eax,0xffffffe4(%ebp)<BR>
&gt; c01515e5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b =
07&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; =
(%edi),%eax<BR>
&gt; c01515e7:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e8 d4 9f 08 =
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
call&nbsp;&nbsp; c01db5c0 &lt;__copy_to_user_ll&gt;<BR>
&gt; c01515ec:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 85 =
db&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test&nbsp;&nbsp; %ebx,%ebx<BR>
&gt; c01515ee:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 74 =
1a&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; je&nbsp;&nbsp;&nbsp;&nbsp; =
c015160a<BR>
&gt; &lt;__rt_task_receive+0x109&gt;<BR>
&gt; c01515f0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8d 45 =
9c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; lea&nbsp;&nbsp;&nbsp; 0xffffff9c(%ebp),%eax<BR>
&gt; c01515f3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 39 =
c3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmp&nbsp;&nbsp;&nbsp; =
%eax,%ebx<BR>
&gt; c01515f5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 74 =
13&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; je&nbsp;&nbsp;&nbsp;&nbsp; =
c015160a<BR>
&gt; &lt;__rt_task_receive+0x109&gt;<BR>
&gt; c01515f7:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 =
da&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; =
%ebx,%edx<BR>
&gt; c01515f9:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b8 60 b9 3c =
c0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mov&nbsp;&nbsp;&nbsp; $0xc03cb960,%eax<BR>
&gt; c01515fe:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e8 a4 f0 fe =
ff&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
call&nbsp;&nbsp; c01406a7 &lt;xnheap_free&gt;<BR>
&gt; c0151603:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eb =
05&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; jmp&nbsp;&nbsp;&nbsp; c015160a<BR>
&gt; &lt;__rt_task_receive+0x109&gt;<BR>
&gt; c0151605:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; be f2 ff ff =
ff&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mov&nbsp;&nbsp;&nbsp; $0xfffffff2,%esi<BR>
&gt; c015160a:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 83 c4 =
5c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; add&nbsp;&nbsp;&nbsp; $0x5c,%esp<BR>
&gt; c015160d:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 =
f0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; =
%esi,%eax<BR>
&gt; c015160f:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
5b&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
pop&nbsp;&nbsp;&nbsp; %ebx<BR>
&gt; c0151610:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
5e&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
pop&nbsp;&nbsp;&nbsp; %esi<BR>
&gt; c0151611:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
5f&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
pop&nbsp;&nbsp;&nbsp; %edi<BR>
&gt; c0151612:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
5d&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
pop&nbsp;&nbsp;&nbsp; %ebp<BR>
&gt; c0151613:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
c3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ret&nbsp;&nbsp;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt; Associated source code:<BR>
&gt;<BR>
&gt;<BR>
&gt; //main.cpp<BR>
&gt; #include &quot;talker.h&quot;<BR>
&gt; #include &quot;listener.h&quot;<BR>
&gt; #include &lt;sys/mman.h&gt;<BR>
&gt; #include &lt;native/task.h&gt;<BR>
&gt; #include &lt;signal.h&gt;<BR>
&gt;<BR>
&gt; volatile int exitprogram;<BR>
&gt; RT_TASK talk_task, listen_task;<BR>
&gt;<BR>
&gt;<BR>
&gt; void catch_signal(int sig)<BR>
&gt; {<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
exitprogram=3D1;<BR>
&gt; }<BR>
&gt;<BR>
&gt; int main(int argc, char *argv[])<BR>
&gt; {<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
exitprogram=3D0;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mlockall(MCL_CURRENT | MCL_FUTURE);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //wait for =
ctrl-c<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signal(SIGTERM, =
catch_signal);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signal(SIGINT, =
catch_signal);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; talker *talk =3D =
new talker();<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; listener *listen =
=3D new listener();<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
talk-&gt;startup(&amp;talk_task, &amp;listen_task);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sleep(1);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
listen-&gt;startup(&amp;talk_task, &amp;listen_task);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pause();<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sleep(2);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_task_join(&amp;talk_task);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_task_join(&amp;listen_task);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_task_delete(&amp;talk_task);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_task_delete(&amp;listen_task);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>
&gt; }<BR>
&gt;<BR>
&gt; //talker.h<BR>
&gt; #ifndef TALKER_H_<BR>
&gt; #define TALKER_H_<BR>
&gt; #include &lt;stdio.h&gt;<BR>
&gt; #include &lt;stdlib.h&gt;<BR>
&gt; #include &lt;sys/time.h&gt;<BR>
&gt; #include &lt;unistd.h&gt;<BR>
&gt; #include &lt;sys/mman.h&gt;<BR>
&gt; #include &lt;native/task.h&gt;<BR>
&gt; #include &lt;native/timer.h&gt;<BR>
&gt; #define TIMEOUT (100000000)<BR>
&gt; #define MAIN_RATE_NS 20000000<BR>
&gt;<BR>
&gt;<BR>
&gt; extern volatile int exitprogram;<BR>
&gt;<BR>
&gt; class talker {<BR>
&gt; public:<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; talker();<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; virtual =
~talker();<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void =
mainloop();<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int startup(RT_TASK =
*talktask, RT_TASK *listentask);<BR>
&gt;<BR>
&gt; private:<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RT_TASK *talk_task, =
*listen_task;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void =
shutdown();<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int iret;<BR>
&gt;<BR>
&gt; protected:<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static void =
thunk(void * param);<BR>
&gt; };<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt; #endif /*TALKER_H_*/<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt; //talker.cpp<BR>
&gt; #include &quot;talker.h&quot;<BR>
&gt;<BR>
&gt; talker::talker()<BR>
&gt; {<BR>
&gt; }<BR>
&gt; talker::~talker()<BR>
&gt; {<BR>
&gt; }<BR>
&gt;<BR>
&gt; int talker::startup(RT_TASK *talktask, RT_TASK *listentask)<BR>
&gt; {<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
talk_task=3Dtalktask;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
listen_task=3Dlistentask;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_task_create(talk_task, &quot;talk_task&quot;, 0, 51, 0);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iret=3D =
rt_task_start(talk_task,thunk,(void*)(this));<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return(0);<BR>
&gt;<BR>
&gt;<BR>
&gt; }<BR>
&gt; void talker::thunk(void * param)<BR>
&gt; {<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; talker *instance =
=3D (talker *) param;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
instance-&gt;mainloop();<BR>
&gt; }<BR>
&gt; void talker::mainloop()<BR>
&gt; {<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;talker =
task started\n&quot;);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int len;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RT_TASK_MCB =
talk_send, talk_reply;<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_task_set_periodic(NULL,TM_NOW,MAIN_RATE_NS);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (1)<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if(exitprogram)<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; break;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_wait_period(NULL);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; talk_send.opcode =3D 0x01;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; talk_send.data =3D NULL;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; talk_send.size =3D 0;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; talk_reply.size =3D 0;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; talk_reply.data =3D NULL;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; len =3D<BR>
&gt; =
rt_task_send(listen_task,&amp;talk_send,&amp;talk_reply,TM_NONBLOCK);<BR>=

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (len &lt; 0) printf(&quot;rt_task_send =
error\n&quot;);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (talk_reply.opcode !=3D 4)<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;len=3D%d, opcode=3D%d\n&quot;, =
len, talk_reply.opcode);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; shutdown();<BR>
&gt; }<BR>
&gt;<BR>
&gt; void talker::shutdown()<BR>
&gt; {<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;Talker exits with return =
%d\n&quot;,iret);<BR>
&gt; }<BR>
&gt;<BR>
&gt;<BR>
&gt; //listener.h<BR>
&gt; #ifndef LISTENER_H_<BR>
&gt; #define LISTENER_H_<BR>
&gt; #include &lt;stdio.h&gt;<BR>
&gt; #include &lt;stdlib.h&gt;<BR>
&gt; #include &lt;sys/time.h&gt;<BR>
&gt; #include &lt;unistd.h&gt;<BR>
&gt; #include &lt;sys/mman.h&gt;<BR>
&gt; #include &lt;native/task.h&gt;<BR>
&gt; #include &lt;native/timer.h&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt; extern volatile int exitprogram;<BR>
&gt;<BR>
&gt; class listener {<BR>
&gt; public:<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; listener();<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; virtual =
~listener();<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void =
mainloop();<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int startup(RT_TASK =
*talktask, RT_TASK *listentask);<BR>
&gt;<BR>
&gt; private:<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RT_TASK *talk_task, =
*listen_task;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void =
shutdown();<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int iret;<BR>
&gt;<BR>
&gt; protected:<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static void =
thunk(void * param);<BR>
&gt; };<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt; #endif /*LISTENER_H_*/<BR>
&gt;<BR>
&gt;<BR>
&gt; //listener.cpp<BR>
&gt;<BR>
&gt; #include &quot;listener.h&quot;<BR>
&gt;<BR>
&gt; listener::listener()<BR>
&gt; {<BR>
&gt; }<BR>
&gt;<BR>
&gt; listener::~listener()<BR>
&gt; {<BR>
&gt; }<BR>
&gt;<BR>
&gt; int listener::startup(RT_TASK *talktask, RT_TASK *listentask)<BR>
&gt; {<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
talk_task=3Dtalktask;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
listen_task=3Dlistentask;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_task_create(listen_task, &quot;listen_task&quot;, 0, 50, 0);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iret=3D =
rt_task_start(listen_task,thunk,(void*)(this));<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return(0);<BR>
&gt;<BR>
&gt;<BR>
&gt; }<BR>
&gt;<BR>
&gt; void listener::thunk(void * param)<BR>
&gt; {<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; listener *instance =
=3D (listener *) param;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
instance-&gt;mainloop();<BR>
&gt; }<BR>
&gt;<BR>
&gt; void listener::mainloop()<BR>
&gt; {<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
printf(&quot;listener task started\n&quot;);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned char =
buf[10];<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RT_TASK_MCB =
listen_rcv, listen_reply;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (1)<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; int taskid;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if(exitprogram)<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; break;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; listen_rcv.data =3D (caddr_t)buf;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; listen_rcv.size =3D sizeof(buf);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; taskid =3D =
rt_task_receive(&amp;listen_rcv,TM_INFINITE);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;received data with opcode<BR>
&gt; %d\n&quot;,listen_rcv.opcode);&nbsp;&nbsp;&nbsp;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; listen_reply.opcode =3D 4;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; listen_reply.size =3D 0;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; listen_reply.data =3D NULL;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_reply(taskid, =
&amp;listen_reply);<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; shutdown();<BR>
&gt; }<BR>
&gt;<BR>
&gt; void listener::shutdown()<BR>
&gt; {<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;listener exits with return =
%d\n&quot;,iret);<BR>
&gt; }<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt; -----Original Message-----<BR>
&gt; From: Philippe Gerum on behalf of Philippe Gerum<BR>
&gt; Sent: Wed 5/7/2008 1:24 PM<BR>
&gt; To: Karch, Joshua<BR>
&gt; Cc: xenomai@xenomai.org<BR>
&gt; Subject: Re: [Xenomai-help] rt_task_send / receive problems =
various<BR>
&gt; issues and&nbsp; bug trace<BR>
&gt;<BR>
&gt; Karch, Joshua wrote:<BR>
&gt;&gt;<BR>
&gt;&gt; Hello,<BR>
&gt;&gt;<BR>
&gt;&gt; I'm using rt_task_send from a talker task and =
rt_task_receive/reply from<BR>
&gt;&gt; a listener task.&nbsp; When I launch the two tasks in the =
following order:<BR>
&gt;&gt; listener task,&nbsp; talker task,&nbsp; everything runs =
normally.<BR>
&gt;&gt;<BR>
&gt;&gt; However, when I launch the talker task first, and then the =
listener task<BR>
&gt;&gt; second, I receive rt_task_send error -22 and after a bit of =
time the<BR>
&gt;&gt; listener task starts up.<BR>
&gt;<BR>
&gt; -EINVAL is not on the error list for rt_task_send(). Could you =
confirm<BR>
&gt; this result?<BR>
&gt;<BR>
&gt;&nbsp; I know this is logical and to be expected,<BR>
&gt;<BR>
&gt; No, it's not. rt_task_send() does wait for the receiver to listen =
to,<BR>
&gt; unless you<BR>
&gt;&nbsp; asked for a non blocking call using TM_NONBLOCK as a =
timeout.<BR>
&gt;<BR>
&gt;&gt; however, it appears that issuing the rt_task_send command to a =
task that<BR>
&gt;&gt; hasn't been started occasionally locks up sufficient resources =
to<BR>
&gt;&gt; prevent the listener task from starting.<BR>
&gt;<BR>
&gt; Any chance your code enters a tight loop due to rt_task_send() =
failing<BR>
&gt; repeatedly?<BR>
&gt;<BR>
&gt;&nbsp; By controlling task startup<BR>
&gt;&gt; order, I was able to circumvent this issue.&nbsp; Both tasks =
have similar<BR>
&gt;&gt; priorities (50, 51).<BR>
&gt;&gt;<BR>
&gt;&gt; Additionally, I am unable to use rt_task_send with =
TM_NONBLOCK<BR>
&gt;&gt; len =3D =
rt_task_send(listen_task,&amp;talk_send,&amp;talk_reply,TM_NONBLOCK);<BR>=

&gt;&gt;<BR>
&gt;&gt; I get a bug failure and have to reset the machine-- see =
below:<BR>
&gt;&gt;<BR>
&gt;<BR>
&gt; Please disassemble your &quot;vmlinux&quot; kernel image, the exact =
one that<BR>
&gt; causes a bug:<BR>
&gt; $ objdump -d vmlinux &gt; foo.txt.<BR>
&gt; In that large file, search for the &quot;__rt_task_receive&quot; =
symbol (notice<BR>
&gt; the double<BR>
&gt; underscore prefix, we also have the &quot;rt_task_receive&quot; =
symbol, but we<BR>
&gt; don't need<BR>
&gt; this code at the moment), then paste&amp;copy the disassembly code =
for that<BR>
&gt; function. I'll have a look.<BR>
&gt;<BR>
&gt; Step #2 is to send a simple piece of code that exhibits the =
problem.<BR>
&gt; This will<BR>
&gt; speed up the debugging and fixing process.<BR>
&gt;<BR>
&gt;&gt; The reason I want to use TM_NONBLOCK is so that I can send a =
trigger<BR>
&gt;&gt; message from the producer task to the consumer task without =
requiring a<BR>
&gt;&gt; reply to trigger the consumer task to act on the data received. =
I am<BR>
&gt;&gt; using the rt_task_send trigger message to gate and synchronize =
the<BR>
&gt;&gt; consumer task. Is a reply required for all rt_task_send?<BR>
&gt;&gt;<BR>
&gt;&gt; It seems if I don't send a reply when rt_task_send has a =
timeout<BR>
&gt;&gt; specified the sending task locks up and the listening task runs =
rampant,<BR>
&gt;&gt; i.e. rt_task_receive no longer blocks and the loop runs with no =
delay<BR>
&gt;&gt; and essentially locks up the machine, since I don't use<BR>
&gt;&gt; rt_set_task_periodic on the listening task.<BR>
&gt;&gt;<BR>
&gt;&gt; Here is the trace, and it requires a reboot.&nbsp; I also can =
attach the<BR>
&gt;&gt; code- it is written in c++ with two separate classes as a model =
of the<BR>
&gt;&gt; application I am building.<BR>
&gt;&gt;<BR>
&gt;&gt; Thank you,<BR>
&gt;&gt;<BR>
&gt;&gt; Joshua Karch<BR>
&gt;&gt;<BR>
&gt;&gt; talker task started<BR>
&gt;&gt; rt_task_send error<BR>
&gt;&gt; len=3D-22, opcode=3D0<BR>
&gt;&gt; listener task stBUG: unable to handle kernel NULL pointer =
dereferencearted<BR>
&gt;&gt; rt_task_s at virtual address 0000020c<BR>
&gt;&gt; end error<BR>
&gt;&gt; len=3D-printing eip: c014f014 110, opcode=3D0<BR>
&gt;&gt; *pde =3D 00000000<BR>
&gt;&gt; Oops: 0000 [#1] PREEMPT<BR>
&gt;&gt; Modules linked in: xeno_timerbench nfs ipv6 nfsd lockd nfs_acl =
sunrpc<BR>
&gt;&gt; exportfs dm_snapshot dm_mirror dm_mod loop pcmcia =
firmware_class<BR>
&gt;&gt; serio_raw psmouse yenta_socket rsrc_nonstatic pcmcia_core =
cs5535_gpio<BR>
&gt;&gt; joydev evdev ext3 jbd mbcache usbhid ide_disk generic ohci_hcd =
ehci_hcd<BR>
&gt;&gt; amd74xx usbcore ide_core e100 mii<BR>
&gt;&gt;<BR>
&gt;&gt; Pid: 1973, comm: listen_task Not tainted (2.6.24.4 #12)<BR>
&gt;&gt; EIP: 0060:[&lt;c014f014&gt;] EFLAGS: 00010093 CPU: 0<BR>
&gt;&gt; EIP is at rt_task_receive+0x113/0x18b<BR>
&gt;&gt; EAX: cdc71f28 EBX: fffffd98 ECX: c03c5500 EDX: cd820acc<BR>
&gt;&gt; ESI: ffffff97 EDI: cd820610 EBP: cdc71edc ESP: cdc71ec4<BR>
&gt;&gt;&nbsp; DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068<BR>
&gt;&gt; Process listen_task (pid: 1973, ti=3Dcdc70000 =
task=3Dcdc6d320<BR>
&gt;&gt; task.ti=3Dcdc70000)&lt;0&gt;<BR>
&gt;&gt; I-pipe domain Linux<BR>
&gt;&gt; Stack: 00000000 cdc71f28 00000000 cdc71ee8 cdc6d320 cdc71fb8 =
cdc71f4c<BR>
&gt;&gt; c01515bf<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b7d083ea cdc71f00 =
c0102cb1 ce46bc70 c03c7e90 cd820620 cdc6d620<BR>
&gt;&gt; cd80ff44<BR>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c029f55b cdc71f34 =
00000082 b91264ee 0000002e cdc6d320 b9127ee2<BR>
&gt;&gt; 0000002e<BR>
&gt;&gt; Call Trace:<BR>
&gt;&gt;&nbsp; [&lt;c01045f1&gt;] show_trace_log_lvl+0x1a/0x2f<BR>
&gt;&gt;&nbsp; [&lt;c01046a3&gt;] show_stack_log_lvl+0x9d/0xa5<BR>
&gt;&gt;&nbsp; [&lt;c0104769&gt;] show_registers+0xbe/0x1fd<BR>
&gt;&gt;&nbsp; [&lt;c01049c1&gt;] die+0x119/0x20a<BR>
&gt;&gt;&nbsp; [&lt;c010ef52&gt;] do_page_fault+0x480/0x57e<BR>
&gt;&gt;&nbsp; [&lt;c010ca34&gt;] =
__ipipe_handle_exception+0x11e/0x166<BR>
&gt;&gt;&nbsp; [&lt;c02a0e7f&gt;] error_code+0x6f/0x80<BR>
&gt;&gt;&nbsp; [&lt;c01515bf&gt;] __rt_task_receive+0xbe/0x113<BR>
&gt;&gt;&nbsp; [&lt;c0149b0d&gt;] losyscall_event+0x99/0x13d<BR>
&gt;&gt;&nbsp; [&lt;c013f05b&gt;] __ipipe_dispatch_event+0xac/0x16c<BR>
&gt;&gt;&nbsp; [&lt;c010c8b1&gt;] __ipipe_syscall_root+0x6a/0xcf<BR>
&gt;&gt;&nbsp; [&lt;c0103e89&gt;] system_call+0x29/0x4a<BR>
&gt;&gt;&nbsp; =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<BR>=

&gt;&gt; Code: 00 00 8d 87 bc 04 00 00 39 c2 0f 95 c0 0f b6 c0 f7 d8 21 =
d0 31 db<BR>
&gt;&gt; 3d 58 02 00 00 74 06 8d 98 98 fd ff ff 8b 45 ec be 97 ff ff ff =
&lt;8b&gt; 93<BR>
&gt;&gt; 74 04 00 00 3b 50 0c 77 23 85 d2 74 19 89 d1 8b b3 70 04<BR>
&gt;&gt; EIP: [&lt;c014f014&gt;] rt_task_receive+0x113/0x18b SS:ESP =
0068:cdc71ec4<BR>
&gt;&gt; ---[ end trace 523bcd2b73b75979 ]---<BR>
&gt;&gt;<BR>
&gt;&gt;<BR>
&gt;&gt;<BR>
&gt;&gt;<BR>
&gt;&gt;<BR>
&gt;&gt; =
------------------------------------------------------------------------<=
BR>
&gt;&gt;<BR>
&gt;&gt; _______________________________________________<BR>
&gt;&gt; Xenomai-help mailing list<BR>
&gt;&gt; Xenomai-help@domain.hid<BR>
&gt;&gt; <A =
HREF=3D"https://mail.gna.org/listinfo/xenomai-help">https://mail.gna.org/=
listinfo/xenomai-help</A><BR>
&gt;<BR>
&gt;<BR>
&gt; --<BR>
&gt; Philippe.<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
<BR>
<BR>
--<BR>
Philippe.<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8B9B9.29A22BF0--

