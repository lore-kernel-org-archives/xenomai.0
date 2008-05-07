Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8B07A.0F1F51B9"
Date: Wed, 7 May 2008 15:35:25 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E646F86@domain.hid>
References: <51B669A8A7D2914E9AB2B3F40AC6553E646F7E@afsexc01.aurora.aero><4821E5BF.4040101@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F83@domain.hid>
From: "Karch, Joshua" <jkarch@domain.hid>
Subject: Re: [Xenomai-help] rt_task_send / receive problems various
	issuesand	bug trace
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Karch, Joshua" <jkarch@domain.hid>, rpm@xenomai.org
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8B07A.0F1F51B9
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Phillipe: small clarification: the following example has replies enabled =
and TM_NONBLOCK on rt_task_send.  I tried the code two different ways:
len =3D rt_task_send(listen_task,&talk_send,&talk_reply,TM_NONBLOCK);
len =3D rt_task_send(listen_task,&talk_send,NULL,TM_NONBLOCK);// also =
deleted rt_task_reply from listen_task and commented out all appropriate =
RT_TASK_MCB reply structs

both have the same bug in the end.

Josh


-----Original Message-----
From: xenomai-help-bounces@domain.hid on behalf of Karch, Joshua
Sent: Wed 5/7/2008 3:33 PM
To: rpm@xenomai.org
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] rt_task_send / receive problems various =
issuesand	bug trace
=20
Phillipe,

here is a disassembly of __rt_task_receive and the source code used to =
generate the error.  The error happens if I use TM_NONBLOCK, regardless =
of whether or not I enable a reply.  In the following example, I use =
rt_send_task with no reply requested (NULL), and all replies commented =
out.

I got three errors this time, -22, -11, -110, and then finally
BUG: unable to handle kernel NULL pointer dereference at virtual address =
0000020c
printing eip: c014f014 *pde =3D 00000000
I hand typed the above in since I didn't capture it through a serial =
terminal.

>From what I can see here, there's no place for a local loop to form in =
the talker task. I have the wait period set to the main rate, defined as =
a 20 msec for this example.  Calling rt_task_send with or without a =
RT_TASK_MCB receive struct and without a reply from the listener task =
still results in the bug occurring.  My platform is a Geode, and I'm =
running 2.6.24-4 with Xenomai 2.4.3

Thank you,

Josh




c0151501 <__rt_task_receive>:
c0151501:	55                   	push   %ebp
c0151502:	89 e5                	mov    %esp,%ebp
c0151504:	57                   	push   %edi
c0151505:	89 d7                	mov    %edx,%edi
c0151507:	56                   	push   %esi
c0151508:	89 c6                	mov    %eax,%esi
c015150a:	53                   	push   %ebx
c015150b:	83 ec 5c             	sub    $0x5c,%esp
c015150e:	8b 1a                	mov    (%edx),%ebx
c0151510:	8b 40 04             	mov    0x4(%eax),%eax
c0151513:	89 da                	mov    %ebx,%edx
c0151515:	83 c2 10             	add    $0x10,%edx
c0151518:	19 c9                	sbb    %ecx,%ecx
c015151a:	39 50 18             	cmp    %edx,0x18(%eax)
c015151d:	83 d9 00             	sbb    $0x0,%ecx
c0151520:	85 c9                	test   %ecx,%ecx
c0151522:	0f 85 dd 00 00 00    	jne    c0151605 =
<__rt_task_receive+0x104>
c0151528:	b9 10 00 00 00       	mov    $0x10,%ecx
c015152d:	89 da                	mov    %ebx,%edx
c015152f:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
c0151532:	e8 29 a2 08 00       	call   c01db760 =
<__copy_from_user_ll_nozero>
c0151537:	8b 4d e8             	mov    0xffffffe8(%ebp),%ecx
c015153a:	85 c9                	test   %ecx,%ecx
c015153c:	74 18                	je     c0151556 <__rt_task_receive+0x55>
c015153e:	8b 55 e4             	mov    0xffffffe4(%ebp),%edx
c0151541:	8b 46 04             	mov    0x4(%esi),%eax
c0151544:	01 ca                	add    %ecx,%edx
c0151546:	19 db                	sbb    %ebx,%ebx
c0151548:	39 50 18             	cmp    %edx,0x18(%eax)
c015154b:	83 db 00             	sbb    $0x0,%ebx
c015154e:	85 db                	test   %ebx,%ebx
c0151550:	0f 85 af 00 00 00    	jne    c0151605 =
<__rt_task_receive+0x104>
c0151556:	8b 5f 04             	mov    0x4(%edi),%ebx
c0151559:	8b 46 04             	mov    0x4(%esi),%eax
c015155c:	89 da                	mov    %ebx,%edx
c015155e:	83 c2 08             	add    $0x8,%edx
c0151561:	19 c9                	sbb    %ecx,%ecx
c0151563:	39 50 18             	cmp    %edx,0x18(%eax)
c0151566:	83 d9 00             	sbb    $0x0,%ecx
c0151569:	85 c9                	test   %ecx,%ecx
c015156b:	0f 85 94 00 00 00    	jne    c0151605 =
<__rt_task_receive+0x104>
c0151571:	89 da                	mov    %ebx,%edx
c0151573:	b9 08 00 00 00       	mov    $0x8,%ecx
c0151578:	8d 45 ec             	lea    0xffffffec(%ebp),%eax
c015157b:	e8 e0 a1 08 00       	call   c01db760 =
<__copy_from_user_ll_nozero>
c0151580:	8b 5d e4             	mov    0xffffffe4(%ebp),%ebx
c0151583:	8b 55 e8             	mov    0xffffffe8(%ebp),%edx
c0151586:	89 5d 98             	mov    %ebx,0xffffff98(%ebp)
c0151589:	31 db                	xor    %ebx,%ebx
c015158b:	85 d2                	test   %edx,%edx
c015158d:	74 22                	je     c01515b1 <__rt_task_receive+0xb0>
c015158f:	83 fa 40             	cmp    $0x40,%edx
c0151592:	77 05                	ja     c0151599 <__rt_task_receive+0x98>
c0151594:	8d 5d 9c             	lea    0xffffff9c(%ebp),%ebx
c0151597:	eb 15                	jmp    c01515ae <__rt_task_receive+0xad>
c0151599:	b8 60 b9 3c c0       	mov    $0xc03cb960,%eax
c015159e:	be f4 ff ff ff       	mov    $0xfffffff4,%esi
c01515a3:	e8 25 f2 fe ff       	call   c01407cd <xnheap_alloc>
c01515a8:	85 c0                	test   %eax,%eax
c01515aa:	74 5e                	je     c015160a =
<__rt_task_receive+0x109>
c01515ac:	89 c3                	mov    %eax,%ebx
c01515ae:	89 5d e4             	mov    %ebx,0xffffffe4(%ebp)
c01515b1:	8b 55 ec             	mov    0xffffffec(%ebp),%edx
c01515b4:	8d 45 dc             	lea    0xffffffdc(%ebp),%eax
c01515b7:	8b 4d f0             	mov    0xfffffff0(%ebp),%ecx
c01515ba:	e8 42 d9 ff ff       	call   c014ef01 <rt_task_receive>
c01515bf:	85 c0                	test   %eax,%eax
c01515c1:	89 c6                	mov    %eax,%esi
c01515c3:	7e 12                	jle    c01515d7 <__rt_task_receive+0xd6>
c01515c5:	8b 4d e8             	mov    0xffffffe8(%ebp),%ecx
c01515c8:	85 c9                	test   %ecx,%ecx
c01515ca:	74 0b                	je     c01515d7 <__rt_task_receive+0xd6>
c01515cc:	8b 55 e4             	mov    0xffffffe4(%ebp),%edx
c01515cf:	8b 45 98             	mov    0xffffff98(%ebp),%eax
c01515d2:	e8 e9 9f 08 00       	call   c01db5c0 <__copy_to_user_ll>
c01515d7:	8b 45 98             	mov    0xffffff98(%ebp),%eax
c01515da:	8d 55 dc             	lea    0xffffffdc(%ebp),%edx
c01515dd:	b9 10 00 00 00       	mov    $0x10,%ecx
c01515e2:	89 45 e4             	mov    %eax,0xffffffe4(%ebp)
c01515e5:	8b 07                	mov    (%edi),%eax
c01515e7:	e8 d4 9f 08 00       	call   c01db5c0 <__copy_to_user_ll>
c01515ec:	85 db                	test   %ebx,%ebx
c01515ee:	74 1a                	je     c015160a =
<__rt_task_receive+0x109>
c01515f0:	8d 45 9c             	lea    0xffffff9c(%ebp),%eax
c01515f3:	39 c3                	cmp    %eax,%ebx
c01515f5:	74 13                	je     c015160a =
<__rt_task_receive+0x109>
c01515f7:	89 da                	mov    %ebx,%edx
c01515f9:	b8 60 b9 3c c0       	mov    $0xc03cb960,%eax
c01515fe:	e8 a4 f0 fe ff       	call   c01406a7 <xnheap_free>
c0151603:	eb 05                	jmp    c015160a =
<__rt_task_receive+0x109>
c0151605:	be f2 ff ff ff       	mov    $0xfffffff2,%esi
c015160a:	83 c4 5c             	add    $0x5c,%esp
c015160d:	89 f0                	mov    %esi,%eax
c015160f:	5b                   	pop    %ebx
c0151610:	5e                   	pop    %esi
c0151611:	5f                   	pop    %edi
c0151612:	5d                   	pop    %ebp
c0151613:	c3                   	ret   =20




Associated source code:


//main.cpp
#include "talker.h"
#include "listener.h"
#include <sys/mman.h>
#include <native/task.h>
#include <signal.h>

volatile int exitprogram;
RT_TASK talk_task, listen_task;


void catch_signal(int sig)
{
	exitprogram=3D1;
}

int main(int argc, char *argv[])
{
	exitprogram=3D0;
=09
	mlockall(MCL_CURRENT | MCL_FUTURE);
	//wait for ctrl-c
	signal(SIGTERM, catch_signal);
	signal(SIGINT, catch_signal);
	talker *talk =3D new talker();
	listener *listen =3D new listener();
	talk->startup(&talk_task, &listen_task);
	sleep(1);
	listen->startup(&talk_task, &listen_task);
	pause();
	sleep(2);
	rt_task_join(&talk_task);
	rt_task_join(&listen_task);
	rt_task_delete(&talk_task);
	rt_task_delete(&listen_task);
	return 0;
}

//talker.h
#ifndef TALKER_H_
#define TALKER_H_
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <unistd.h>
#include <sys/mman.h>
#include <native/task.h>
#include <native/timer.h>
#define TIMEOUT (100000000)
#define MAIN_RATE_NS 20000000


extern volatile int exitprogram;

class talker {
public:
	talker();
	virtual ~talker();
	void mainloop();
	int startup(RT_TASK *talktask, RT_TASK *listentask);

private:
	RT_TASK *talk_task, *listen_task;
	void shutdown();
	int iret;

protected:
	static void thunk(void * param);
};



#endif /*TALKER_H_*/



//talker.cpp
#include "talker.h"

talker::talker()
{
}
talker::~talker()
{
}

int talker::startup(RT_TASK *talktask, RT_TASK *listentask)
{
	talk_task=3Dtalktask;
	listen_task=3Dlistentask;
	rt_task_create(talk_task, "talk_task", 0, 51, 0);
	iret=3D rt_task_start(talk_task,thunk,(void*)(this));
	return(0);


}
void talker::thunk(void * param)
{
	talker *instance =3D (talker *) param;
	instance->mainloop();
}
void talker::mainloop()
{
	printf("talker task started\n");
	int len;
	RT_TASK_MCB talk_send, talk_reply;

	rt_task_set_periodic(NULL,TM_NOW,MAIN_RATE_NS);
   	while (1)
	{
		if(exitprogram)
			break;
		rt_task_wait_period(NULL);
		talk_send.opcode =3D 0x01;
		talk_send.data =3D NULL;
		talk_send.size =3D 0;
		talk_reply.size =3D 0;
		talk_reply.data =3D NULL;
		len =3D rt_task_send(listen_task,&talk_send,&talk_reply,TM_NONBLOCK);
		if (len < 0) printf("rt_task_send error\n");
		if (talk_reply.opcode !=3D 4)
		printf("len=3D%d, opcode=3D%d\n", len, talk_reply.opcode);
	}
	shutdown();
}

void talker::shutdown()
{
    printf("Talker exits with return %d\n",iret);
}


//listener.h
#ifndef LISTENER_H_
#define LISTENER_H_
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <unistd.h>
#include <sys/mman.h>
#include <native/task.h>
#include <native/timer.h>



extern volatile int exitprogram;

class listener {
public:
	listener();
	virtual ~listener();
	void mainloop();
	int startup(RT_TASK *talktask, RT_TASK *listentask);

private:
	RT_TASK *talk_task, *listen_task;
	void shutdown();
	int iret;

protected:
	static void thunk(void * param);
};



#endif /*LISTENER_H_*/


//listener.cpp

#include "listener.h"

listener::listener()
{
}

listener::~listener()
{
}

int listener::startup(RT_TASK *talktask, RT_TASK *listentask)
{
	talk_task=3Dtalktask;
	listen_task=3Dlistentask;
	rt_task_create(listen_task, "listen_task", 0, 50, 0);
	iret=3D rt_task_start(listen_task,thunk,(void*)(this));
	return(0);


}

void listener::thunk(void * param)
{
	listener *instance =3D (listener *) param;
	instance->mainloop();
}

void listener::mainloop()
{
	printf("listener task started\n");
	unsigned char buf[10];
	RT_TASK_MCB listen_rcv, listen_reply;
=09
	while (1)
	{
		int taskid;
		if(exitprogram)
			break;
		listen_rcv.data =3D (caddr_t)buf;
		listen_rcv.size =3D sizeof(buf);
		taskid =3D rt_task_receive(&listen_rcv,TM_INFINITE);
		printf("received data with opcode %d\n",listen_rcv.opcode);=09
		listen_reply.opcode =3D 4;
	        listen_reply.size =3D 0;
	        listen_reply.data =3D NULL;
	        rt_task_reply(taskid, &listen_reply);
	}
	shutdown();
}

void listener::shutdown()
{
    printf("listener exits with return %d\n",iret);
}






-----Original Message-----
From: Philippe Gerum on behalf of Philippe Gerum
Sent: Wed 5/7/2008 1:24 PM
To: Karch, Joshua
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] rt_task_send / receive problems various =
issues and	bug trace
=20
Karch, Joshua wrote:
>=20
> Hello,
>=20
> I'm using rt_task_send from a talker task and rt_task_receive/reply =
from
> a listener task.  When I launch the two tasks in the following order:
> listener task,  talker task,  everything runs normally.
>=20
> However, when I launch the talker task first, and then the listener =
task
> second, I receive rt_task_send error -22 and after a bit of time the
> listener task starts up.

-EINVAL is not on the error list for rt_task_send(). Could you confirm =
this result?

 I know this is logical and to be expected,

No, it's not. rt_task_send() does wait for the receiver to listen to, =
unless you
 asked for a non blocking call using TM_NONBLOCK as a timeout.

> however, it appears that issuing the rt_task_send command to a task =
that
> hasn't been started occasionally locks up sufficient resources to
> prevent the listener task from starting.=20

Any chance your code enters a tight loop due to rt_task_send() failing =
repeatedly?

 By controlling task startup
> order, I was able to circumvent this issue.  Both tasks have similar
> priorities (50, 51).
>=20
> Additionally, I am unable to use rt_task_send with TM_NONBLOCK
> len =3D rt_task_send(listen_task,&talk_send,&talk_reply,TM_NONBLOCK);
>=20
> I get a bug failure and have to reset the machine-- see below:
>=20

Please disassemble your "vmlinux" kernel image, the exact one that =
causes a bug:
$ objdump -d vmlinux > foo.txt.
In that large file, search for the "__rt_task_receive" symbol (notice =
the double
underscore prefix, we also have the "rt_task_receive" symbol, but we =
don't need
this code at the moment), then paste&copy the disassembly code for that
function. I'll have a look.

Step #2 is to send a simple piece of code that exhibits the problem. =
This will
speed up the debugging and fixing process.

> The reason I want to use TM_NONBLOCK is so that I can send a trigger
> message from the producer task to the consumer task without requiring =
a
> reply to trigger the consumer task to act on the data received. I am
> using the rt_task_send trigger message to gate and synchronize the
> consumer task. Is a reply required for all rt_task_send?=20
>=20
> It seems if I don't send a reply when rt_task_send has a timeout
> specified the sending task locks up and the listening task runs =
rampant,
> i.e. rt_task_receive no longer blocks and the loop runs with no delay
> and essentially locks up the machine, since I don't use
> rt_set_task_periodic on the listening task.
>=20
> Here is the trace, and it requires a reboot.  I also can attach the
> code- it is written in c++ with two separate classes as a model of the
> application I am building.
>=20
> Thank you,
>=20
> Joshua Karch
>=20
> talker task started
> rt_task_send error
> len=3D-22, opcode=3D0
> listener task stBUG: unable to handle kernel NULL pointer =
dereferencearted
> rt_task_s at virtual address 0000020c
> end error
> len=3D-printing eip: c014f014 110, opcode=3D0
> *pde =3D 00000000
> Oops: 0000 [#1] PREEMPT
> Modules linked in: xeno_timerbench nfs ipv6 nfsd lockd nfs_acl sunrpc
> exportfs dm_snapshot dm_mirror dm_mod loop pcmcia firmware_class
> serio_raw psmouse yenta_socket rsrc_nonstatic pcmcia_core cs5535_gpio
> joydev evdev ext3 jbd mbcache usbhid ide_disk generic ohci_hcd =
ehci_hcd
> amd74xx usbcore ide_core e100 mii
>=20
> Pid: 1973, comm: listen_task Not tainted (2.6.24.4 #12)
> EIP: 0060:[<c014f014>] EFLAGS: 00010093 CPU: 0
> EIP is at rt_task_receive+0x113/0x18b
> EAX: cdc71f28 EBX: fffffd98 ECX: c03c5500 EDX: cd820acc
> ESI: ffffff97 EDI: cd820610 EBP: cdc71edc ESP: cdc71ec4
>  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
> Process listen_task (pid: 1973, ti=3Dcdc70000 task=3Dcdc6d320
> task.ti=3Dcdc70000)<0>
> I-pipe domain Linux
> Stack: 00000000 cdc71f28 00000000 cdc71ee8 cdc6d320 cdc71fb8 cdc71f4c
> c01515bf
>        b7d083ea cdc71f00 c0102cb1 ce46bc70 c03c7e90 cd820620 cdc6d620
> cd80ff44
>        c029f55b cdc71f34 00000082 b91264ee 0000002e cdc6d320 b9127ee2
> 0000002e
> Call Trace:
>  [<c01045f1>] show_trace_log_lvl+0x1a/0x2f
>  [<c01046a3>] show_stack_log_lvl+0x9d/0xa5
>  [<c0104769>] show_registers+0xbe/0x1fd
>  [<c01049c1>] die+0x119/0x20a
>  [<c010ef52>] do_page_fault+0x480/0x57e
>  [<c010ca34>] __ipipe_handle_exception+0x11e/0x166
>  [<c02a0e7f>] error_code+0x6f/0x80
>  [<c01515bf>] __rt_task_receive+0xbe/0x113
>  [<c0149b0d>] losyscall_event+0x99/0x13d
>  [<c013f05b>] __ipipe_dispatch_event+0xac/0x16c
>  [<c010c8b1>] __ipipe_syscall_root+0x6a/0xcf
>  [<c0103e89>] system_call+0x29/0x4a
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Code: 00 00 8d 87 bc 04 00 00 39 c2 0f 95 c0 0f b6 c0 f7 d8 21 d0 31 =
db
> 3d 58 02 00 00 74 06 8d 98 98 fd ff ff 8b 45 ec be 97 ff ff ff <8b> 93
> 74 04 00 00 3b 50 0c 77 23 85 d2 74 19 89 d1 8b b3 70 04
> EIP: [<c014f014>] rt_task_receive+0x113/0x18b SS:ESP 0068:cdc71ec4
> ---[ end trace 523bcd2b73b75979 ]---
>=20
>=20
>=20
>=20
>=20
> =
------------------------------------------------------------------------
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--=20
Philippe.



------_=_NextPart_001_01C8B07A.0F1F51B9
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
<TITLE>RE: [Xenomai-help] rt_task_send / receive problems various =
issuesand	bug trace</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Phillipe: small clarification: the following example =
has replies enabled and TM_NONBLOCK on rt_task_send.&nbsp; I tried the =
code two different ways:<BR>
len =3D =
rt_task_send(listen_task,&amp;talk_send,&amp;talk_reply,TM_NONBLOCK);<BR>=

len =3D rt_task_send(listen_task,&amp;talk_send,NULL,TM_NONBLOCK);// =
also deleted rt_task_reply from listen_task and commented out all =
appropriate RT_TASK_MCB reply structs<BR>
<BR>
both have the same bug in the end.<BR>
<BR>
Josh<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: xenomai-help-bounces@domain.hid on behalf of Karch, Joshua<BR>
Sent: Wed 5/7/2008 3:33 PM<BR>
To: rpm@xenomai.org<BR>
Cc: xenomai@xenomai.org<BR>
Subject: Re: [Xenomai-help] rt_task_send / receive problems various =
issuesand&nbsp;&nbsp; bug trace<BR>
<BR>
Phillipe,<BR>
<BR>
here is a disassembly of __rt_task_receive and the source code used to =
generate the error.&nbsp; The error happens if I use TM_NONBLOCK, =
regardless of whether or not I enable a reply.&nbsp; In the following =
example, I use rt_send_task with no reply requested (NULL), and all =
replies commented out.<BR>
<BR>
I got three errors this time, -22, -11, -110, and then finally<BR>
BUG: unable to handle kernel NULL pointer dereference at virtual address =
0000020c<BR>
printing eip: c014f014 *pde =3D 00000000<BR>
I hand typed the above in since I didn't capture it through a serial =
terminal.<BR>
<BR>
>From what I can see here, there's no place for a local loop to form in =
the talker task. I have the wait period set to the main rate, defined as =
a 20 msec for this example.&nbsp; Calling rt_task_send with or without a =
RT_TASK_MCB receive struct and without a reply from the listener task =
still results in the bug occurring.&nbsp; My platform is a Geode, and =
I'm running 2.6.24-4 with Xenomai 2.4.3<BR>
<BR>
Thank you,<BR>
<BR>
Josh<BR>
<BR>
<BR>
<BR>
<BR>
c0151501 &lt;__rt_task_receive&gt;:<BR>
c0151501:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
55&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; push&nbsp;&nbsp; =
%ebp<BR>
c0151502:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 =
e5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; %esp,%ebp<BR>
c0151504:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
57&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; push&nbsp;&nbsp; =
%edi<BR>
c0151505:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 =
d7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; %edx,%edi<BR>
c0151507:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
56&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; push&nbsp;&nbsp; =
%esi<BR>
c0151508:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 =
c6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; %eax,%esi<BR>
c015150a:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
53&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; push&nbsp;&nbsp; =
%ebx<BR>
c015150b:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 83 ec =
5c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; sub&nbsp;&nbsp;&nbsp; $0x5c,%esp<BR>
c015150e:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b =
1a&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; (%edx),%ebx<BR>
c0151510:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 40 =
04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0x4(%eax),%eax<BR>
c0151513:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 =
da&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; %ebx,%edx<BR>
c0151515:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 83 c2 =
10&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; add&nbsp;&nbsp;&nbsp; $0x10,%edx<BR>
c0151518:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19 =
c9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; sbb&nbsp;&nbsp;&nbsp; %ecx,%ecx<BR>
c015151a:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 39 50 =
18&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; cmp&nbsp;&nbsp;&nbsp; %edx,0x18(%eax)<BR>
c015151d:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 83 d9 =
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; sbb&nbsp;&nbsp;&nbsp; $0x0,%ecx<BR>
c0151520:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 85 =
c9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; test&nbsp;&nbsp; %ecx,%ecx<BR>
c0151522:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0f 85 dd 00 00 =
00&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; jne&nbsp;&nbsp;&nbsp; c0151605 =
&lt;__rt_task_receive+0x104&gt;<BR>
c0151528:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b9 10 00 00 =
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; =
mov&nbsp;&nbsp;&nbsp; $0x10,%ecx<BR>
c015152d:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 =
da&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; %ebx,%edx<BR>
c015152f:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8d 45 =
dc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; lea&nbsp;&nbsp;&nbsp; 0xffffffdc(%ebp),%eax<BR>
c0151532:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e8 29 a2 08 =
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; call&nbsp;&nbsp; =
c01db760 &lt;__copy_from_user_ll_nozero&gt;<BR>
c0151537:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 4d =
e8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0xffffffe8(%ebp),%ecx<BR>
c015153a:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 85 =
c9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; test&nbsp;&nbsp; %ecx,%ecx<BR>
c015153c:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 74 =
18&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; je&nbsp;&nbsp;&nbsp;&nbsp; c0151556 =
&lt;__rt_task_receive+0x55&gt;<BR>
c015153e:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 55 =
e4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0xffffffe4(%ebp),%edx<BR>
c0151541:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 46 =
04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0x4(%esi),%eax<BR>
c0151544:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01 =
ca&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; add&nbsp;&nbsp;&nbsp; %ecx,%edx<BR>
c0151546:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19 =
db&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; sbb&nbsp;&nbsp;&nbsp; %ebx,%ebx<BR>
c0151548:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 39 50 =
18&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; cmp&nbsp;&nbsp;&nbsp; %edx,0x18(%eax)<BR>
c015154b:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 83 db =
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; sbb&nbsp;&nbsp;&nbsp; $0x0,%ebx<BR>
c015154e:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 85 =
db&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; test&nbsp;&nbsp; %ebx,%ebx<BR>
c0151550:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0f 85 af 00 00 =
00&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; jne&nbsp;&nbsp;&nbsp; c0151605 =
&lt;__rt_task_receive+0x104&gt;<BR>
c0151556:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 5f =
04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0x4(%edi),%ebx<BR>
c0151559:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 46 =
04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0x4(%esi),%eax<BR>
c015155c:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 =
da&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; %ebx,%edx<BR>
c015155e:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 83 c2 =
08&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; add&nbsp;&nbsp;&nbsp; $0x8,%edx<BR>
c0151561:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19 =
c9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; sbb&nbsp;&nbsp;&nbsp; %ecx,%ecx<BR>
c0151563:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 39 50 =
18&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; cmp&nbsp;&nbsp;&nbsp; %edx,0x18(%eax)<BR>
c0151566:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 83 d9 =
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; sbb&nbsp;&nbsp;&nbsp; $0x0,%ecx<BR>
c0151569:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 85 =
c9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; test&nbsp;&nbsp; %ecx,%ecx<BR>
c015156b:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0f 85 94 00 00 =
00&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; jne&nbsp;&nbsp;&nbsp; c0151605 =
&lt;__rt_task_receive+0x104&gt;<BR>
c0151571:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 =
da&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; %ebx,%edx<BR>
c0151573:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b9 08 00 00 =
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; =
mov&nbsp;&nbsp;&nbsp; $0x8,%ecx<BR>
c0151578:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8d 45 =
ec&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; lea&nbsp;&nbsp;&nbsp; 0xffffffec(%ebp),%eax<BR>
c015157b:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e8 e0 a1 08 =
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; call&nbsp;&nbsp; =
c01db760 &lt;__copy_from_user_ll_nozero&gt;<BR>
c0151580:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 5d =
e4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0xffffffe4(%ebp),%ebx<BR>
c0151583:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 55 =
e8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0xffffffe8(%ebp),%edx<BR>
c0151586:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 5d =
98&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; %ebx,0xffffff98(%ebp)<BR>
c0151589:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 31 =
db&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; xor&nbsp;&nbsp;&nbsp; %ebx,%ebx<BR>
c015158b:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 85 =
d2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; test&nbsp;&nbsp; %edx,%edx<BR>
c015158d:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 74 =
22&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; je&nbsp;&nbsp;&nbsp;&nbsp; c01515b1 =
&lt;__rt_task_receive+0xb0&gt;<BR>
c015158f:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 83 fa =
40&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; cmp&nbsp;&nbsp;&nbsp; $0x40,%edx<BR>
c0151592:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 77 =
05&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; ja&nbsp;&nbsp;&nbsp;&nbsp; c0151599 =
&lt;__rt_task_receive+0x98&gt;<BR>
c0151594:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8d 5d =
9c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; lea&nbsp;&nbsp;&nbsp; 0xffffff9c(%ebp),%ebx<BR>
c0151597:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eb =
15&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; jmp&nbsp;&nbsp;&nbsp; c01515ae =
&lt;__rt_task_receive+0xad&gt;<BR>
c0151599:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b8 60 b9 3c =
c0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; =
mov&nbsp;&nbsp;&nbsp; $0xc03cb960,%eax<BR>
c015159e:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; be f4 ff ff =
ff&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; =
mov&nbsp;&nbsp;&nbsp; $0xfffffff4,%esi<BR>
c01515a3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e8 25 f2 fe =
ff&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; call&nbsp;&nbsp; =
c01407cd &lt;xnheap_alloc&gt;<BR>
c01515a8:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 85 =
c0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; test&nbsp;&nbsp; %eax,%eax<BR>
c01515aa:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 74 =
5e&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; je&nbsp;&nbsp;&nbsp;&nbsp; c015160a =
&lt;__rt_task_receive+0x109&gt;<BR>
c01515ac:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 =
c3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; %eax,%ebx<BR>
c01515ae:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 5d =
e4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; %ebx,0xffffffe4(%ebp)<BR>
c01515b1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 55 =
ec&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0xffffffec(%ebp),%edx<BR>
c01515b4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8d 45 =
dc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; lea&nbsp;&nbsp;&nbsp; 0xffffffdc(%ebp),%eax<BR>
c01515b7:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 4d =
f0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0xfffffff0(%ebp),%ecx<BR>
c01515ba:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e8 42 d9 ff =
ff&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; call&nbsp;&nbsp; =
c014ef01 &lt;rt_task_receive&gt;<BR>
c01515bf:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 85 =
c0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; test&nbsp;&nbsp; %eax,%eax<BR>
c01515c1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 =
c6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; %eax,%esi<BR>
c01515c3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7e =
12&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; jle&nbsp;&nbsp;&nbsp; c01515d7 =
&lt;__rt_task_receive+0xd6&gt;<BR>
c01515c5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 4d =
e8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0xffffffe8(%ebp),%ecx<BR>
c01515c8:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 85 =
c9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; test&nbsp;&nbsp; %ecx,%ecx<BR>
c01515ca:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 74 =
0b&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; je&nbsp;&nbsp;&nbsp;&nbsp; c01515d7 =
&lt;__rt_task_receive+0xd6&gt;<BR>
c01515cc:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 55 =
e4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0xffffffe4(%ebp),%edx<BR>
c01515cf:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 45 =
98&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0xffffff98(%ebp),%eax<BR>
c01515d2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e8 e9 9f 08 =
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; call&nbsp;&nbsp; =
c01db5c0 &lt;__copy_to_user_ll&gt;<BR>
c01515d7:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b 45 =
98&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0xffffff98(%ebp),%eax<BR>
c01515da:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8d 55 =
dc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; lea&nbsp;&nbsp;&nbsp; 0xffffffdc(%ebp),%edx<BR>
c01515dd:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b9 10 00 00 =
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; =
mov&nbsp;&nbsp;&nbsp; $0x10,%ecx<BR>
c01515e2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 45 =
e4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; %eax,0xffffffe4(%ebp)<BR>
c01515e5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8b =
07&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; (%edi),%eax<BR>
c01515e7:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e8 d4 9f 08 =
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; call&nbsp;&nbsp; =
c01db5c0 &lt;__copy_to_user_ll&gt;<BR>
c01515ec:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 85 =
db&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; test&nbsp;&nbsp; %ebx,%ebx<BR>
c01515ee:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 74 =
1a&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; je&nbsp;&nbsp;&nbsp;&nbsp; c015160a =
&lt;__rt_task_receive+0x109&gt;<BR>
c01515f0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8d 45 =
9c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; lea&nbsp;&nbsp;&nbsp; 0xffffff9c(%ebp),%eax<BR>
c01515f3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 39 =
c3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; cmp&nbsp;&nbsp;&nbsp; %eax,%ebx<BR>
c01515f5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 74 =
13&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; je&nbsp;&nbsp;&nbsp;&nbsp; c015160a =
&lt;__rt_task_receive+0x109&gt;<BR>
c01515f7:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 =
da&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; %ebx,%edx<BR>
c01515f9:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b8 60 b9 3c =
c0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; =
mov&nbsp;&nbsp;&nbsp; $0xc03cb960,%eax<BR>
c01515fe:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e8 a4 f0 fe =
ff&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; call&nbsp;&nbsp; =
c01406a7 &lt;xnheap_free&gt;<BR>
c0151603:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eb =
05&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; jmp&nbsp;&nbsp;&nbsp; c015160a =
&lt;__rt_task_receive+0x109&gt;<BR>
c0151605:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; be f2 ff ff =
ff&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; =
mov&nbsp;&nbsp;&nbsp; $0xfffffff2,%esi<BR>
c015160a:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 83 c4 =
5c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp; add&nbsp;&nbsp;&nbsp; $0x5c,%esp<BR>
c015160d:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 89 =
f0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; %esi,%eax<BR>
c015160f:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
5b&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; pop&nbsp;&nbsp;&nbsp; =
%ebx<BR>
c0151610:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
5e&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; pop&nbsp;&nbsp;&nbsp; =
%esi<BR>
c0151611:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
5f&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; pop&nbsp;&nbsp;&nbsp; =
%edi<BR>
c0151612:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
5d&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; pop&nbsp;&nbsp;&nbsp; =
%ebp<BR>
c0151613:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
c3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; =
ret&nbsp;&nbsp;&nbsp;<BR>
<BR>
<BR>
<BR>
<BR>
Associated source code:<BR>
<BR>
<BR>
//main.cpp<BR>
#include &quot;talker.h&quot;<BR>
#include &quot;listener.h&quot;<BR>
#include &lt;sys/mman.h&gt;<BR>
#include &lt;native/task.h&gt;<BR>
#include &lt;signal.h&gt;<BR>
<BR>
volatile int exitprogram;<BR>
RT_TASK talk_task, listen_task;<BR>
<BR>
<BR>
void catch_signal(int sig)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exitprogram=3D1;<BR>
}<BR>
<BR>
int main(int argc, char *argv[])<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exitprogram=3D0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mlockall(MCL_CURRENT | =
MCL_FUTURE);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //wait for ctrl-c<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signal(SIGTERM, =
catch_signal);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signal(SIGINT, =
catch_signal);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; talker *talk =3D new =
talker();<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; listener *listen =3D new =
listener();<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
talk-&gt;startup(&amp;talk_task, &amp;listen_task);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sleep(1);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
listen-&gt;startup(&amp;talk_task, &amp;listen_task);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pause();<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sleep(2);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_task_join(&amp;talk_task);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_task_join(&amp;listen_task);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_task_delete(&amp;talk_task);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_task_delete(&amp;listen_task);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>
}<BR>
<BR>
//talker.h<BR>
#ifndef TALKER_H_<BR>
#define TALKER_H_<BR>
#include &lt;stdio.h&gt;<BR>
#include &lt;stdlib.h&gt;<BR>
#include &lt;sys/time.h&gt;<BR>
#include &lt;unistd.h&gt;<BR>
#include &lt;sys/mman.h&gt;<BR>
#include &lt;native/task.h&gt;<BR>
#include &lt;native/timer.h&gt;<BR>
#define TIMEOUT (100000000)<BR>
#define MAIN_RATE_NS 20000000<BR>
<BR>
<BR>
extern volatile int exitprogram;<BR>
<BR>
class talker {<BR>
public:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; talker();<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; virtual ~talker();<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void mainloop();<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int startup(RT_TASK =
*talktask, RT_TASK *listentask);<BR>
<BR>
private:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RT_TASK *talk_task, =
*listen_task;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void shutdown();<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int iret;<BR>
<BR>
protected:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static void thunk(void * =
param);<BR>
};<BR>
<BR>
<BR>
<BR>
#endif /*TALKER_H_*/<BR>
<BR>
<BR>
<BR>
//talker.cpp<BR>
#include &quot;talker.h&quot;<BR>
<BR>
talker::talker()<BR>
{<BR>
}<BR>
talker::~talker()<BR>
{<BR>
}<BR>
<BR>
int talker::startup(RT_TASK *talktask, RT_TASK *listentask)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; talk_task=3Dtalktask;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; listen_task=3Dlistentask;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_create(talk_task, =
&quot;talk_task&quot;, 0, 51, 0);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iret=3D =
rt_task_start(talk_task,thunk,(void*)(this));<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return(0);<BR>
<BR>
<BR>
}<BR>
void talker::thunk(void * param)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; talker *instance =3D (talker =
*) param;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instance-&gt;mainloop();<BR>
}<BR>
void talker::mainloop()<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;talker task =
started\n&quot;);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int len;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RT_TASK_MCB talk_send, =
talk_reply;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_task_set_periodic(NULL,TM_NOW,MAIN_RATE_NS);<BR>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; while (1)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(exitprogram)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_task_wait_period(NULL);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; talk_send.opcode =3D =
0x01;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; talk_send.data =3D NULL;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; talk_send.size =3D 0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; talk_reply.size =3D 0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; talk_reply.data =3D NULL;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; len =3D =
rt_task_send(listen_task,&amp;talk_send,&amp;talk_reply,TM_NONBLOCK);<BR>=

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (len &lt; 0) =
printf(&quot;rt_task_send error\n&quot;);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (talk_reply.opcode !=3D =
4)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;len=3D%d, =
opcode=3D%d\n&quot;, len, talk_reply.opcode);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; shutdown();<BR>
}<BR>
<BR>
void talker::shutdown()<BR>
{<BR>
&nbsp;&nbsp;&nbsp; printf(&quot;Talker exits with return =
%d\n&quot;,iret);<BR>
}<BR>
<BR>
<BR>
//listener.h<BR>
#ifndef LISTENER_H_<BR>
#define LISTENER_H_<BR>
#include &lt;stdio.h&gt;<BR>
#include &lt;stdlib.h&gt;<BR>
#include &lt;sys/time.h&gt;<BR>
#include &lt;unistd.h&gt;<BR>
#include &lt;sys/mman.h&gt;<BR>
#include &lt;native/task.h&gt;<BR>
#include &lt;native/timer.h&gt;<BR>
<BR>
<BR>
<BR>
extern volatile int exitprogram;<BR>
<BR>
class listener {<BR>
public:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; listener();<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; virtual ~listener();<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void mainloop();<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int startup(RT_TASK =
*talktask, RT_TASK *listentask);<BR>
<BR>
private:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RT_TASK *talk_task, =
*listen_task;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void shutdown();<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int iret;<BR>
<BR>
protected:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static void thunk(void * =
param);<BR>
};<BR>
<BR>
<BR>
<BR>
#endif /*LISTENER_H_*/<BR>
<BR>
<BR>
//listener.cpp<BR>
<BR>
#include &quot;listener.h&quot;<BR>
<BR>
listener::listener()<BR>
{<BR>
}<BR>
<BR>
listener::~listener()<BR>
{<BR>
}<BR>
<BR>
int listener::startup(RT_TASK *talktask, RT_TASK *listentask)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; talk_task=3Dtalktask;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; listen_task=3Dlistentask;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_create(listen_task, =
&quot;listen_task&quot;, 0, 50, 0);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iret=3D =
rt_task_start(listen_task,thunk,(void*)(this));<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return(0);<BR>
<BR>
<BR>
}<BR>
<BR>
void listener::thunk(void * param)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; listener *instance =3D =
(listener *) param;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instance-&gt;mainloop();<BR>
}<BR>
<BR>
void listener::mainloop()<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;listener task =
started\n&quot;);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned char buf[10];<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RT_TASK_MCB listen_rcv, =
listen_reply;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (1)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int taskid;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(exitprogram)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; listen_rcv.data =3D =
(caddr_t)buf;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; listen_rcv.size =3D =
sizeof(buf);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; taskid =3D =
rt_task_receive(&amp;listen_rcv,TM_INFINITE);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;received data =
with opcode %d\n&quot;,listen_rcv.opcode);&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; listen_reply.opcode =3D =
4;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; listen_reply.size =3D 0;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; listen_reply.data =3D =
NULL;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_reply(taskid, =
&amp;listen_reply);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; shutdown();<BR>
}<BR>
<BR>
void listener::shutdown()<BR>
{<BR>
&nbsp;&nbsp;&nbsp; printf(&quot;listener exits with return =
%d\n&quot;,iret);<BR>
}<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Philippe Gerum on behalf of Philippe Gerum<BR>
Sent: Wed 5/7/2008 1:24 PM<BR>
To: Karch, Joshua<BR>
Cc: xenomai@xenomai.org<BR>
Subject: Re: [Xenomai-help] rt_task_send / receive problems various =
issues and&nbsp; bug trace<BR>
<BR>
Karch, Joshua wrote:<BR>
&gt;<BR>
&gt; Hello,<BR>
&gt;<BR>
&gt; I'm using rt_task_send from a talker task and rt_task_receive/reply =
from<BR>
&gt; a listener task.&nbsp; When I launch the two tasks in the following =
order:<BR>
&gt; listener task,&nbsp; talker task,&nbsp; everything runs =
normally.<BR>
&gt;<BR>
&gt; However, when I launch the talker task first, and then the listener =
task<BR>
&gt; second, I receive rt_task_send error -22 and after a bit of time =
the<BR>
&gt; listener task starts up.<BR>
<BR>
-EINVAL is not on the error list for rt_task_send(). Could you confirm =
this result?<BR>
<BR>
&nbsp;I know this is logical and to be expected,<BR>
<BR>
No, it's not. rt_task_send() does wait for the receiver to listen to, =
unless you<BR>
&nbsp;asked for a non blocking call using TM_NONBLOCK as a timeout.<BR>
<BR>
&gt; however, it appears that issuing the rt_task_send command to a task =
that<BR>
&gt; hasn't been started occasionally locks up sufficient resources =
to<BR>
&gt; prevent the listener task from starting.<BR>
<BR>
Any chance your code enters a tight loop due to rt_task_send() failing =
repeatedly?<BR>
<BR>
&nbsp;By controlling task startup<BR>
&gt; order, I was able to circumvent this issue.&nbsp; Both tasks have =
similar<BR>
&gt; priorities (50, 51).<BR>
&gt;<BR>
&gt; Additionally, I am unable to use rt_task_send with TM_NONBLOCK<BR>
&gt; len =3D =
rt_task_send(listen_task,&amp;talk_send,&amp;talk_reply,TM_NONBLOCK);<BR>=

&gt;<BR>
&gt; I get a bug failure and have to reset the machine-- see below:<BR>
&gt;<BR>
<BR>
Please disassemble your &quot;vmlinux&quot; kernel image, the exact one =
that causes a bug:<BR>
$ objdump -d vmlinux &gt; foo.txt.<BR>
In that large file, search for the &quot;__rt_task_receive&quot; symbol =
(notice the double<BR>
underscore prefix, we also have the &quot;rt_task_receive&quot; symbol, =
but we don't need<BR>
this code at the moment), then paste&amp;copy the disassembly code for =
that<BR>
function. I'll have a look.<BR>
<BR>
Step #2 is to send a simple piece of code that exhibits the problem. =
This will<BR>
speed up the debugging and fixing process.<BR>
<BR>
&gt; The reason I want to use TM_NONBLOCK is so that I can send a =
trigger<BR>
&gt; message from the producer task to the consumer task without =
requiring a<BR>
&gt; reply to trigger the consumer task to act on the data received. I =
am<BR>
&gt; using the rt_task_send trigger message to gate and synchronize =
the<BR>
&gt; consumer task. Is a reply required for all rt_task_send?<BR>
&gt;<BR>
&gt; It seems if I don't send a reply when rt_task_send has a =
timeout<BR>
&gt; specified the sending task locks up and the listening task runs =
rampant,<BR>
&gt; i.e. rt_task_receive no longer blocks and the loop runs with no =
delay<BR>
&gt; and essentially locks up the machine, since I don't use<BR>
&gt; rt_set_task_periodic on the listening task.<BR>
&gt;<BR>
&gt; Here is the trace, and it requires a reboot.&nbsp; I also can =
attach the<BR>
&gt; code- it is written in c++ with two separate classes as a model of =
the<BR>
&gt; application I am building.<BR>
&gt;<BR>
&gt; Thank you,<BR>
&gt;<BR>
&gt; Joshua Karch<BR>
&gt;<BR>
&gt; talker task started<BR>
&gt; rt_task_send error<BR>
&gt; len=3D-22, opcode=3D0<BR>
&gt; listener task stBUG: unable to handle kernel NULL pointer =
dereferencearted<BR>
&gt; rt_task_s at virtual address 0000020c<BR>
&gt; end error<BR>
&gt; len=3D-printing eip: c014f014 110, opcode=3D0<BR>
&gt; *pde =3D 00000000<BR>
&gt; Oops: 0000 [#1] PREEMPT<BR>
&gt; Modules linked in: xeno_timerbench nfs ipv6 nfsd lockd nfs_acl =
sunrpc<BR>
&gt; exportfs dm_snapshot dm_mirror dm_mod loop pcmcia =
firmware_class<BR>
&gt; serio_raw psmouse yenta_socket rsrc_nonstatic pcmcia_core =
cs5535_gpio<BR>
&gt; joydev evdev ext3 jbd mbcache usbhid ide_disk generic ohci_hcd =
ehci_hcd<BR>
&gt; amd74xx usbcore ide_core e100 mii<BR>
&gt;<BR>
&gt; Pid: 1973, comm: listen_task Not tainted (2.6.24.4 #12)<BR>
&gt; EIP: 0060:[&lt;c014f014&gt;] EFLAGS: 00010093 CPU: 0<BR>
&gt; EIP is at rt_task_receive+0x113/0x18b<BR>
&gt; EAX: cdc71f28 EBX: fffffd98 ECX: c03c5500 EDX: cd820acc<BR>
&gt; ESI: ffffff97 EDI: cd820610 EBP: cdc71edc ESP: cdc71ec4<BR>
&gt;&nbsp; DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068<BR>
&gt; Process listen_task (pid: 1973, ti=3Dcdc70000 task=3Dcdc6d320<BR>
&gt; task.ti=3Dcdc70000)&lt;0&gt;<BR>
&gt; I-pipe domain Linux<BR>
&gt; Stack: 00000000 cdc71f28 00000000 cdc71ee8 cdc6d320 cdc71fb8 =
cdc71f4c<BR>
&gt; c01515bf<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b7d083ea cdc71f00 =
c0102cb1 ce46bc70 c03c7e90 cd820620 cdc6d620<BR>
&gt; cd80ff44<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c029f55b cdc71f34 =
00000082 b91264ee 0000002e cdc6d320 b9127ee2<BR>
&gt; 0000002e<BR>
&gt; Call Trace:<BR>
&gt;&nbsp; [&lt;c01045f1&gt;] show_trace_log_lvl+0x1a/0x2f<BR>
&gt;&nbsp; [&lt;c01046a3&gt;] show_stack_log_lvl+0x9d/0xa5<BR>
&gt;&nbsp; [&lt;c0104769&gt;] show_registers+0xbe/0x1fd<BR>
&gt;&nbsp; [&lt;c01049c1&gt;] die+0x119/0x20a<BR>
&gt;&nbsp; [&lt;c010ef52&gt;] do_page_fault+0x480/0x57e<BR>
&gt;&nbsp; [&lt;c010ca34&gt;] __ipipe_handle_exception+0x11e/0x166<BR>
&gt;&nbsp; [&lt;c02a0e7f&gt;] error_code+0x6f/0x80<BR>
&gt;&nbsp; [&lt;c01515bf&gt;] __rt_task_receive+0xbe/0x113<BR>
&gt;&nbsp; [&lt;c0149b0d&gt;] losyscall_event+0x99/0x13d<BR>
&gt;&nbsp; [&lt;c013f05b&gt;] __ipipe_dispatch_event+0xac/0x16c<BR>
&gt;&nbsp; [&lt;c010c8b1&gt;] __ipipe_syscall_root+0x6a/0xcf<BR>
&gt;&nbsp; [&lt;c0103e89&gt;] system_call+0x29/0x4a<BR>
&gt;&nbsp; =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<BR>=

&gt; Code: 00 00 8d 87 bc 04 00 00 39 c2 0f 95 c0 0f b6 c0 f7 d8 21 d0 =
31 db<BR>
&gt; 3d 58 02 00 00 74 06 8d 98 98 fd ff ff 8b 45 ec be 97 ff ff ff =
&lt;8b&gt; 93<BR>
&gt; 74 04 00 00 3b 50 0c 77 23 85 d2 74 19 89 d1 8b b3 70 04<BR>
&gt; EIP: [&lt;c014f014&gt;] rt_task_receive+0x113/0x18b SS:ESP =
0068:cdc71ec4<BR>
&gt; ---[ end trace 523bcd2b73b75979 ]---<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt; =
------------------------------------------------------------------------<=
BR>
&gt;<BR>
&gt; _______________________________________________<BR>
&gt; Xenomai-help mailing list<BR>
&gt; Xenomai-help@domain.hid<BR>
&gt; <A =
HREF=3D"https://mail.gna.org/listinfo/xenomai-help">https://mail.gna.org/=
listinfo/xenomai-help</A><BR>
<BR>
<BR>
--<BR>
Philippe.<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8B07A.0F1F51B9--

