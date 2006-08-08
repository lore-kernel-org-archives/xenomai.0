Message-ID: <44D7EDCF.9010409@domain.hid>
Date: Mon, 07 Aug 2006 21:50:07 -0400
From: Vincent Levesque <vleves@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] -110 error on rt_task_send... bug?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org
Cc: andrewg@domain.hid

Hello,

I'm having some problems with rt_task_send/receive/reply in the native 
skin. The code attached at the end of this email works fine on Xenomai 
2.1 but rt_task_send() fails with error message -110 on Xenomai 2.2.0 
and today's subversion trunk. I checked the error values of all other 
calls (removed for clarity) and everything seems to be ok. The -110 
error code is returned either when rt_task_send() times out or when 
rt_task_reply() is called, whichever comes first. If I set it to 
TM_INFINITE, rt_task_send() never returns and the system hangs when I 
press control-c. I've reproduced this behavior on two computers.

Am I doing something wrong that was tolerated by 2.1? Is this a bug in 
Xenomai 2.2?

Thank you,

Vincent Levesque
vleves@domain.hid



gcc -o test test.c `/usr/xenomai/bin/xeno-config --xeno-cflags` -O2 
`/usr/xenomai/bin/xeno-config --xeno-ldflags` -lnative

--------------------------------------------------------
test.c
--------------------------------------------------------

#include <stdio.h>
#include <sys/mman.h>
#include <native/task.h>

void recv_task(void *arg)
{
    RT_TASK_MCB mcb_receive;
    int flowid;
    int data;

    mcb_receive.data = (caddr_t)&data;
    mcb_receive.size = sizeof(int);
    flowid = rt_task_receive(&mcb_receive,TM_INFINITE);
    if (mcb_receive.opcode == 1)
    {
        printf("receiving %d\n", data);
        rt_task_reply(flowid, NULL);
    }
}

int main (int argc, char *argv[])
{
    int data, rv;
    RT_TASK_MCB mcb_send;
    RT_TASK peer;
    RT_TASK task;

    mlockall(MCL_CURRENT | MCL_FUTURE);

    rt_task_spawn(&peer, "recv_task", 0, 99, T_FPU, &recv_task, NULL);
    rt_task_shadow(&task, "send_task", 50, 0);

    data = 13;
    mcb_send.opcode = 1;
    mcb_send.data = (caddr_t)&data;
    mcb_send.size = sizeof(int);

    printf("sending %d\n", data);
    rv = rt_task_send(&peer,&mcb_send,NULL,1E9);
    if (rv < 0)
    {
        switch(rv)
        {
            case -ENOBUFS:        printf("ENOBUFS\n");
            case -EWOULDBLOCK:    printf("EWOULDBLOCK\n");
            case -EIDRM:        printf("EIDRM\n");
            case -EINTR:        printf("EINTR\n");
            case -EPERM:        printf("EPERM\n");
            default:            printf("unknown error: %d\n", rv);
        }
    }

    rt_task_delete(&peer);
    return 0;
}


