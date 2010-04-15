From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20100415164539.471058da98lp4sjk@domain.hid>
References: <20100331143432.44386sa8ez2p2q2o@domain.hid>
	<4BB34F3A.3060105@domain.hid>
	<20100415164539.471058da98lp4sjk@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 15 Apr 2010 17:03:21 +0200
Message-ID: <1271343801.2365.703.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] netrpc
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michel He <michel.he@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Thu, 2010-04-15 at 16:45 +0200, Michel He wrote:
> For message passing from task to task, I use the 3 available =20
> procedures rt_task_send(), rt_task_reply(), rt_task_receive().
>=20
> The job is when one message emitted from the source to one =20
> destination, however the message can be catched by an other task (not =20
> the good correspondant). In Xenomai, when the message is NOT for a =20
> task, it couldn't be passed to a next task. Tasks can receive any =20
> message but not being able to relay it to the destination. (there's no =20
> such function mentionned inside the API doc).

Well, actually, no, there is none. Those services are aimed at being
plain simple client/server primitives, which assume that you do know
which server wants to receive your traffic. Providing a service to
re-queue the request for others to pick it, does not seem the right
approach, since there is no way you can tell whether the-other-guy will
schedule in before the current server goes back to its receive point,
unless you synchronize both servers, which would end up being quite
silly. However, your application can emulate this behavior much more
sanely, you don't need kernel support for that.

Btw, you should really remove rt_task_set_mode(...T_PRIMARY...) from
your code, because this is unfortunately totally useless overhead. Not
really your fault, T_PRIMARY should not have been provided this way.

>=20
> I build an example. (cf code sample)
>=20
> any help is welcome
>=20
> code sample :
>=20
> /*
>   *
>   *  Created on: 15 avr. 2010
>   *      Author: hemichel
>   */
>=20
> #include <stdio.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <string.h>
> #include <signal.h>
> #include <sys/time.h>
> #include <sys/io.h>
> #include <sys/mman.h>
> #include <native/task.h>
> #include <native/queue.h>
> #include <native/intr.h>
>=20
> #define STACK_SIZE 8192
> #define STD_PRIO 1
>=20
> RT_TASK test_task_ptr,test_task2_ptr,test_task3_ptr;
> int int_count =3D 0;
> int end =3D 0;
>=20
> #define PEER_RATE_NS 10000000
> //                     --s-ms-us-ns
> RTIME task_period_ns =3D   1000000000llu;
>=20
> void testtask(void *cookie) {
> 	RT_TASK_MCB mcb_send, mcb_reply;
> 	int flowid, i, rv;
> 	unsigned char datasend[16];
> 	unsigned char datareply[16];
>=20
> 	int count =3D 0;
> 	int ret;
> 	unsigned long overrun;
> 	ret =3D rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(task_period=
_ns));
> 	if (ret) {
> 		printf("error while set periodic, code %d\n",ret);
> 		return;
> 	}
>=20
> 	mcb_send.opcode =3D 0x03;
> 	datasend[0]=3D'a';
> 	mcb_send.data =3D datasend;
> 	mcb_send.size =3D sizeof(datasend);
>=20
> 	mcb_reply.size =3D sizeof(datareply);
> 	mcb_reply.data =3D datareply;
>=20
> 	while(!end){
> 		ret =3D rt_task_set_mode(0, T_PRIMARY, NULL);
> 		if (ret) {
> 			printf("error while rt_task_set_mode, code %d\n",ret);
> 			return;
> 		}
> 		ret =3D rt_task_wait_period(&overrun);
> 		if (ret) {
> 			printf("error while rt_task_wait_period, code %d\n",ret);
> 			return;
> 		}
> 		count++;
> 		printf("message from testtask: count=3D%d\n", count);
>=20
> 		rv =3D rt_task_send(&test_task2_ptr,&mcb_send,&mcb_reply,PEER_RATE_NS);
> 		if (rv < 0) printf("rt_task_send error\n");
> 		else rt_printf("response mcb_reply=3D%d\n",mcb_reply.data[0]);
> 		fflush(NULL);
> 	}
> }
>=20
>=20
> void testtask2(void *cookie) {
> 	RT_TASK_MCB mcb_rcv, mcb_reply;
> 	int flowid, i, rv;
> 	unsigned char datareply[16];
>=20
> 	int count =3D 12;
> 	int ret;
> 	unsigned long overrun;
> 	ret =3D rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(task_period=
_ns));
> 	if (ret) {
> 		printf("error while set periodic, code %d\n",ret);
> 		return;
> 	}
>=20
> 	while(!end){
> 		ret =3D rt_task_set_mode(0, T_PRIMARY, NULL);
> 		if (ret) {
> 			printf("error while rt_task_set_mode, code %d\n",ret);
> 			return;
> 		}
> 		ret =3D rt_task_wait_period(&overrun);
> 		if (ret) {
> 			printf("error while rt_task_wait_period, code %d\n",ret);
> 			return;
> 		}
>=20
> 		mcb_rcv.data =3D (caddr_t)datareply;
> 		mcb_rcv.size =3D sizeof(datareply);
>=20
> 		flowid =3D rt_task_receive(&mcb_rcv,PEER_RATE_NS);
> 		rt_printf("task 2: flowid=3D%d rcv.size=3D%d bytes to receive buf, =20
> opcode=3D%d\n",\
> 				flowid,mcb_rcv.size,mcb_rcv.opcode);
> 		if(flowid >=3D 0)
> 		{
> 			if (mcb_rcv.opcode =3D=3D 2) {
> 				//this is mine
> 				mcb_reply.opcode =3D 0x2;
> 				mcb_reply.size =3D 1;
> 				datareply[0]=3Dcount;
> 				mcb_reply.data =3D datareply;
> 				rt_task_reply(flowid, &mcb_reply);
> 				rt_printf("replied from task2 to flowid=3D%d\n",flowid);
> 			}
> 			else {
> 				rt_printf("task2 : not mined\n");
>                                  //how to relay the catched msg to next ?
> 			}
> 		}
>=20
> 		fflush(NULL);
> 	}
> }
>=20
>=20
> void testtask3(void *cookie) {
> 	RT_TASK_MCB mcb_rcv, mcb_reply;
> 	int flowid, i, rv;
> 	unsigned char datareply[16];
>=20
> 	int count =3D 13;
> 	int ret;
> 	unsigned long overrun;
> 	ret =3D rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(task_period=
_ns));
> 	if (ret) {
> 		printf("error while set periodic, code %d\n",ret);
> 		return;
> 	}
>=20
> 	while(!end){
> 		ret =3D rt_task_set_mode(0, T_PRIMARY, NULL);
> 		if (ret) {
> 			printf("error while rt_task_set_mode, code %d\n",ret);
> 			return;
> 		}
> 		ret =3D rt_task_wait_period(&overrun);
> 		if (ret) {
> 			printf("error while rt_task_wait_period, code %d\n",ret);
> 			return;
> 		}
>=20
> 		mcb_rcv.data =3D (caddr_t)datareply;
> 		mcb_rcv.size =3D sizeof(datareply);
>=20
> 		flowid =3D rt_task_receive(&mcb_rcv,PEER_RATE_NS);
> 		rt_printf("task 3 : flowid=3D%d rcv.size=3D%d bytes to receive buf, =20
> opcode=3D%d\n",\
> 				flowid,mcb_rcv.size,mcb_rcv.opcode);
> 		if(flowid >=3D 0)
> 		{
> 			if (mcb_rcv.opcode =3D=3D 3) {
> 				//this is mine
> 				mcb_reply.opcode =3D 0x3;
> 				mcb_reply.size =3D 1;
> 				datareply[0]=3Dcount;
> 				mcb_reply.data =3D datareply;
> 				rt_task_reply(flowid, &mcb_reply);
> 				rt_printf("replied from task3 to flowid=3D%d\n",flowid);
> 			}
> 			else {
> 				rt_printf("task3 : not mined\n");
>                                  //how to relay the catched msg to next ?
> 			}
>=20
> 		}
>=20
> 		fflush(NULL);
> 	}
> }
>=20
>=20
>=20
> Jan Kiszka <jan.kiszka@domain.hid> a =C3=A9crit :
>=20
> > Well, you could start with mapping the existing RTAI API calls in
> > xrtai-lab on local Native calls. That will already give you a
> > non-distributed port.
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--=20
Philippe.



