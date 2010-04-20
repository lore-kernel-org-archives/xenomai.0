Message-ID: <20100420172151.825755sbp92ssdc0@domain.hid>
Date: Tue, 20 Apr 2010 17:21:51 +0200
From: Michel He <michel.he@domain.hid>
References: <20100419190151.56913gdansdxkhvk@domain.hid>
	<4BCC8D2C.3070905@domain.hid>
In-Reply-To: <4BCC8D2C.3070905@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] RT_QUEUE problem in Sender/Receiver order
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Re,

    In order to describe it (by thousand words as the proverbe said), =20
I attach the following example.
You notice that in the line 85 :
rv =3D rt_task_send(&test_task3_ptr,&mcb_send,&mcb_reply,task_period_ns);

whenever you change &test_task3_ptr to &test_task2_ptr, the message is =20
NOT delivered at all. Only task3 can receive good msg. (not task2)

thank you


/*
  * tasksend.c
  *
  *  Created on: 7 avr. 2010
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


#define MAXRECVTASK 0
#define ANYSRC 0
#define MAX_MESSAGE_LENGTH 4
#define QUEUE_LIM 512
#define PROBECODE 0xa

RT_TASK test_task_ptr,test_task2_ptr,test_task3_ptr;

//tache maintenant la liste recvhostlist
RT_TASK *recvTask[MAXRECVTASK];
unsigned int nrecvhost=3D0;

int int_count =3D 0;
int end =3D 0;

//delay reception 0.1 s
#define PEER_RATE_NS 100000000

//cycle de la tache d'emission
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
=09=09rt_printf("error while set periodic, code %d\n",ret);
=09=09return;
=09}

=09mcb_send.opcode =3D 0x03;
=09datasend[0]=3D'a';
=09mcb_send.data =3D datasend;
=09mcb_send.size =3D sizeof(datasend);

=09mcb_reply.size =3D sizeof(datareply);
=09mcb_reply.data =3D datareply;

=09while(!end){

=09=09if (ret) {
=09=09=09rt_printf("error while rt_task_set_mode, code %d\n",ret);
=09=09=09return;
=09=09}
=09=09ret =3D rt_task_wait_period(&overrun);
=09=09if (ret) {
=09=09=09rt_printf("error while rt_task_wait_period, code %d\n",ret);
=09=09=09return;
=09=09}
=09=09count++;
=09=09rt_printf("message from testtask: count=3D%d\n", count);

=09=09rv =3D rt_task_send(&test_task3_ptr,&mcb_send,&mcb_reply,task_period_n=
s);
=09=09if (rv < 0) rt_printf("rt_task_send error\n");
=09=09else rt_printf("get mcb_reply=3D%d\n",mcb_reply.data[0]);
=09=09fflush(NULL);
=09}
}


void testtask2(void *cookie) {
=09RT_TASK_MCB mcb_rcv, mcb_reply;
=09int flowid, i, rv;
=09unsigned char datareply[16];
=09unsigned int taskmsg;
=09int count =3D 0;
=09int ret;
=09unsigned long overrun;
=09ret =3D rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(task_period_=
ns));
=09if (ret) {
=09=09rt_printf("error while set periodic, code %d\n",ret);
=09=09return;
=09}

=09while(!end){

=09=09ret =3D rt_task_wait_period(&overrun);
=09=09if (ret) {
=09=09=09rt_printf("error while rt_task_wait_period, code %d\n",ret);
=09=09=09return;
=09=09}

=09=09mcb_rcv.data =3D (caddr_t)&datareply;
=09=09mcb_rcv.size =3D sizeof(datareply);

=09=09flowid =3D rt_task_receive(&mcb_rcv,PEER_RATE_NS);
=09=09rt_printf("%s flowid=3D%d opcode=3D%d\n",\
=09=09=09=09__FUNCTION__, flowid, mcb_rcv.opcode);
=09=09if(flowid >=3D 0)
=09=09{
=09=09=09=09//this is my answer
=09=09=09=09mcb_reply.opcode =3D 1;
=09=09=09=09mcb_reply.size =3D 1;
=09=09=09=09mcb_reply.data =3D datareply;
=09=09=09=09datareply[0]=3D100;
=09=09=09=09rt_task_reply(flowid, &mcb_reply);
=09=09=09=09rt_printf("task2 replied to Sender\n");
=09=09}
=09=09else
=09=09{
=09=09=09rt_printf("err task2 : flowid neg\n");
=09=09}

=09=09fflush(NULL);
=09}
}


void testtask3(void *cookie) {
=09RT_TASK_MCB mcb_rcv, mcb_reply;
=09int flowid, i, rv;
=09unsigned char datareply[16];
=09unsigned int taskmsg;

=09int count =3D 0;
=09int ret;
=09unsigned long overrun;
=09ret =3D rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(task_period_=
ns));
=09if (ret) {
=09=09rt_printf("error while set periodic, code %d\n",ret);
=09=09return;
=09}

=09while(!end){

=09=09ret =3D rt_task_wait_period(&overrun);
=09=09if (ret) {
=09=09=09rt_printf("error while rt_task_wait_period, code %d\n",ret);
=09=09=09return;
=09=09}

=09=09mcb_rcv.data =3D (caddr_t)&datareply;
=09=09mcb_rcv.size =3D sizeof(datareply);

=09=09flowid =3D rt_task_receive(&mcb_rcv,PEER_RATE_NS);
=09=09rt_printf("%s flowid=3D%d opcode=3D%d\n",\
=09=09=09=09__FUNCTION__, flowid, mcb_rcv.opcode);
=09=09if(flowid >=3D 0)
=09=09{
=09=09=09=09//this is my answer
=09=09=09=09mcb_reply.opcode =3D 1;
=09=09=09=09mcb_reply.size =3D 1;
=09=09=09=09mcb_reply.data =3D datareply;
=09=09=09=09datareply[0]=3D100;
=09=09=09=09rt_task_reply(flowid, &mcb_reply);
=09=09=09=09rt_printf("task3 replied to Sender\n");
=09=09}
=09=09else
=09=09{
=09=09=09rt_printf("err task3 : flowid neg\n");
=09=09}

=09=09fflush(NULL);
=09}
}


// signal-handler, to ensure clean exit on Ctrl-C
void clean_exit(int dummy) {
=09rt_printf("cleanup\n");
=09end =3D 1;
=09rt_task_delete(&test_task_ptr);
=09rt_printf("end\n");
}

int main(int argc, char *argv[]) {
=09int err, ret;
=09int itask;


=09// install signal handler
=09signal(SIGTERM, clean_exit);
=09signal(SIGINT, clean_exit);

=09mlockall(MCL_CURRENT | MCL_FUTURE);

=09/* Perform auto-init of rt_print buffers if the task doesn't do so */
=09rt_print_auto_init(1);

=09//Initialisation de Dispatch Sender
=09for (itask=3D0; itask < nrecvhost; itask++)
=09{
=09=09recvTask[itask]=3DNULL;
=09}

=09err =3D rt_task_spawn(&test_task_ptr, "Timer", STACK_SIZE, STD_PRIO, 0, =
=20
&testtask, NULL);
=09recvTask[nrecvhost]=3D&test_task_ptr;
=09nrecvhost++;
=09if (err) {
=09=09rt_printf("error rt_task_spawn\n");
=09=09return 0;
=09}

=09nrecvhost=3D0;
=09rt_printf("Fin Initialisation de la tache Emetteur\n");

=09err =3D rt_task_spawn(&test_task2_ptr, "Timer2", STACK_SIZE, STD_PRIO, =
=20
0, &testtask2, NULL);
=09recvTask[nrecvhost]=3D&test_task2_ptr;
=09nrecvhost++;
=09if (err) {
=09=09rt_printf("error rt_task_spawn\n");
=09=09return 0;
=09}


=09err =3D rt_task_spawn(&test_task3_ptr, "Timer3", STACK_SIZE, STD_PRIO, =
=20
0, &testtask3, NULL);
=09recvTask[nrecvhost]=3D&test_task3_ptr;
=09nrecvhost++;
=09if (err) {
=09=09rt_printf("error rt_task_spawn\n");
=09=09return 0;
=09}



=09// wait for signal & return of signal handler
=09pause();
=09fflush(NULL);
=09return 0;
}


Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> a =E9crit=A0:

> Michel He wrote:
>> hello everyone,
>>
>>     I find out a problem (it seems already mentionned before but I
>> can't find the link to the forum and the post). It deals with the
>> message passing, eg. when we change the order of task execution,
>> something can get wrong. Notice that codes below, if we launch the
>> exection of Recep2,Recep3,Sender, Recep2 won't get the right message.
>> But if we change the order to : Sender,Recep2,Recep3, everything is
>> back to OK. So any explanation ?
>
> A piece of self-contained code, compiling and demonstrating a bug when
> running is worth a thousand words.
>
>
> --
> =09=09=09=09=09    Gilles.
>



