Message-ID: <20100415164539.471058da98lp4sjk@domain.hid>
Date: Thu, 15 Apr 2010 16:45:39 +0200
From: Michel He <michel.he@domain.hid>
References: <20100331143432.44386sa8ez2p2q2o@domain.hid>
	<4BB34F3A.3060105@domain.hid>
In-Reply-To: <4BB34F3A.3060105@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

For message passing from task to task, I use the 3 available =20
procedures rt_task_send(), rt_task_reply(), rt_task_receive().

The job is when one message emitted from the source to one =20
destination, however the message can be catched by an other task (not =20
the good correspondant). In Xenomai, when the message is NOT for a =20
task, it couldn't be passed to a next task. Tasks can receive any =20
message but not being able to relay it to the destination. (there's no =20
such function mentionned inside the API doc).

I build an example. (cf code sample)

any help is welcome

code sample :

/*
  *
  *  Created on: 15 avr. 2010
  *      Author: hemichel
  */

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <sys/time.h>
#include <sys/io.h>
#include <sys/mman.h>
#include <native/task.h>
#include <native/queue.h>
#include <native/intr.h>

#define STACK_SIZE 8192
#define STD_PRIO 1

RT_TASK test_task_ptr,test_task2_ptr,test_task3_ptr;
int int_count =3D 0;
int end =3D 0;

#define PEER_RATE_NS 10000000
//                     --s-ms-us-ns
RTIME task_period_ns =3D   1000000000llu;

void testtask(void *cookie) {
=09RT_TASK_MCB mcb_send, mcb_reply;
=09int flowid, i, rv;
=09unsigned char datasend[16];
=09unsigned char datareply[16];

=09int count =3D 0;
=09int ret;
=09unsigned long overrun;
=09ret =3D rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(task_period_=
ns));
=09if (ret) {
=09=09printf("error while set periodic, code %d\n",ret);
=09=09return;
=09}

=09mcb_send.opcode =3D 0x03;
=09datasend[0]=3D'a';
=09mcb_send.data =3D datasend;
=09mcb_send.size =3D sizeof(datasend);

=09mcb_reply.size =3D sizeof(datareply);
=09mcb_reply.data =3D datareply;

=09while(!end){
=09=09ret =3D rt_task_set_mode(0, T_PRIMARY, NULL);
=09=09if (ret) {
=09=09=09printf("error while rt_task_set_mode, code %d\n",ret);
=09=09=09return;
=09=09}
=09=09ret =3D rt_task_wait_period(&overrun);
=09=09if (ret) {
=09=09=09printf("error while rt_task_wait_period, code %d\n",ret);
=09=09=09return;
=09=09}
=09=09count++;
=09=09printf("message from testtask: count=3D%d\n", count);

=09=09rv =3D rt_task_send(&test_task2_ptr,&mcb_send,&mcb_reply,PEER_RATE_NS)=
;
=09=09if (rv < 0) printf("rt_task_send error\n");
=09=09else rt_printf("response mcb_reply=3D%d\n",mcb_reply.data[0]);
=09=09fflush(NULL);
=09}
}


void testtask2(void *cookie) {
=09RT_TASK_MCB mcb_rcv, mcb_reply;
=09int flowid, i, rv;
=09unsigned char datareply[16];

=09int count =3D 12;
=09int ret;
=09unsigned long overrun;
=09ret =3D rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(task_period_=
ns));
=09if (ret) {
=09=09printf("error while set periodic, code %d\n",ret);
=09=09return;
=09}

=09while(!end){
=09=09ret =3D rt_task_set_mode(0, T_PRIMARY, NULL);
=09=09if (ret) {
=09=09=09printf("error while rt_task_set_mode, code %d\n",ret);
=09=09=09return;
=09=09}
=09=09ret =3D rt_task_wait_period(&overrun);
=09=09if (ret) {
=09=09=09printf("error while rt_task_wait_period, code %d\n",ret);
=09=09=09return;
=09=09}

=09=09mcb_rcv.data =3D (caddr_t)datareply;
=09=09mcb_rcv.size =3D sizeof(datareply);

=09=09flowid =3D rt_task_receive(&mcb_rcv,PEER_RATE_NS);
=09=09rt_printf("task 2: flowid=3D%d rcv.size=3D%d bytes to receive buf, =20
opcode=3D%d\n",\
=09=09=09=09flowid,mcb_rcv.size,mcb_rcv.opcode);
=09=09if(flowid >=3D 0)
=09=09{
=09=09=09if (mcb_rcv.opcode =3D=3D 2) {
=09=09=09=09//this is mine
=09=09=09=09mcb_reply.opcode =3D 0x2;
=09=09=09=09mcb_reply.size =3D 1;
=09=09=09=09datareply[0]=3Dcount;
=09=09=09=09mcb_reply.data =3D datareply;
=09=09=09=09rt_task_reply(flowid, &mcb_reply);
=09=09=09=09rt_printf("replied from task2 to flowid=3D%d\n",flowid);
=09=09=09}
=09=09=09else {
=09=09=09=09rt_printf("task2 : not mined\n");
                                 //how to relay the catched msg to next ?
=09=09=09}
=09=09}

=09=09fflush(NULL);
=09}
}


void testtask3(void *cookie) {
=09RT_TASK_MCB mcb_rcv, mcb_reply;
=09int flowid, i, rv;
=09unsigned char datareply[16];

=09int count =3D 13;
=09int ret;
=09unsigned long overrun;
=09ret =3D rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(task_period_=
ns));
=09if (ret) {
=09=09printf("error while set periodic, code %d\n",ret);
=09=09return;
=09}

=09while(!end){
=09=09ret =3D rt_task_set_mode(0, T_PRIMARY, NULL);
=09=09if (ret) {
=09=09=09printf("error while rt_task_set_mode, code %d\n",ret);
=09=09=09return;
=09=09}
=09=09ret =3D rt_task_wait_period(&overrun);
=09=09if (ret) {
=09=09=09printf("error while rt_task_wait_period, code %d\n",ret);
=09=09=09return;
=09=09}

=09=09mcb_rcv.data =3D (caddr_t)datareply;
=09=09mcb_rcv.size =3D sizeof(datareply);

=09=09flowid =3D rt_task_receive(&mcb_rcv,PEER_RATE_NS);
=09=09rt_printf("task 3 : flowid=3D%d rcv.size=3D%d bytes to receive buf, =
=20
opcode=3D%d\n",\
=09=09=09=09flowid,mcb_rcv.size,mcb_rcv.opcode);
=09=09if(flowid >=3D 0)
=09=09{
=09=09=09if (mcb_rcv.opcode =3D=3D 3) {
=09=09=09=09//this is mine
=09=09=09=09mcb_reply.opcode =3D 0x3;
=09=09=09=09mcb_reply.size =3D 1;
=09=09=09=09datareply[0]=3Dcount;
=09=09=09=09mcb_reply.data =3D datareply;
=09=09=09=09rt_task_reply(flowid, &mcb_reply);
=09=09=09=09rt_printf("replied from task3 to flowid=3D%d\n",flowid);
=09=09=09}
=09=09=09else {
=09=09=09=09rt_printf("task3 : not mined\n");
                                 //how to relay the catched msg to next ?
=09=09=09}

=09=09}

=09=09fflush(NULL);
=09}
}



Jan Kiszka <jan.kiszka@domain.hid> a =E9crit=A0:

> Well, you could start with mapping the existing RTAI API calls in
> xrtai-lab on local Native calls. That will already give you a
> non-distributed port.


