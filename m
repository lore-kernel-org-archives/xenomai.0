Message-ID: <45087D79.50506@domain.hid>
Date: Wed, 13 Sep 2006 17:51:53 -0400
From: Vincent Levesque <vleves@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] problem with rt_task_send() timeout and timer
	overruns
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

Hello all,

I ran into some problems after moving working code to a slower machine 
and traced the problem down to the example attached at the bottom of 
this email. I've been using rt_task_send() to implement the equivalent 
of a function call, with an error code returned in the reply MCB's 
opcode field. In the example below, I send a message and expect a "666" 
opcode to be returned but I receive garbage at least on a few calls. The 
problem seems to occur when 1) the update rate in the sender is too high 
and 2) rt_task_send() has a timeout value (1 sec in the example.)  If I 
increase MAIN_RATE_NS or set the TIMEOUT to TM_INFINITE everything seems 
to be ok. I've been able to reproduce this problem with xenomai 2.2.2 
(two PCs) and 2.1.3. In more complex versions of this code the reply 
data buffers also seemed to be invalid or corrupted.

Looking at the docs, I'm not sure what to expect when rt_task_send() 
times out. It is returning 0 here. If I understand correctly, there is 
also no way to distinguish between an empty reply (with an opcode but no 
data buffer) and a NULL reply (i.e. rt_task_reply(flowid, NULL)). Could 
I be missing a rt_task_send() failure? If so, why would it fail here?

Thanks,

Vincent Levesque
vleves@domain.hid

gcc -o test main.c `/usr/xenomai-2.2/bin/xeno-config --xeno-cflags` 
`/usr/xenomai-2.2/bin/xeno-config --xeno-ldflags` -lnative

#include <sys/mman.h>
#include <native/task.h>

#define TIMEOUT ((RTIME)1E9)
#define PEER_RATE_NS 100000
#define MAIN_RATE_NS 5000000
#define PEER_NB_ITER 50

void run_peer(void *arg)
{
    unsigned char buf[1024];
    RT_TASK_MCB mcb_rcv, mcb_reply;
    int flowid, i, rv;

    while (1)
    {
        mcb_rcv.data = (caddr_t)buf;
        mcb_rcv.size = sizeof(buf);
        flowid = rt_task_receive(&mcb_rcv,TM_INFINITE);
        if(flowid >= 0)
        {
            rt_task_set_periodic(NULL,TM_NOW,PEER_RATE_NS);
            for (i=0; i<PEER_NB_ITER; ++i)
                rt_task_wait_period(NULL);
            rt_task_set_periodic(NULL,TM_NOW,TM_INFINITE);

            mcb_reply.opcode = 666;
            mcb_reply.size = 0;
            mcb_reply.data = NULL;
            rt_task_reply(flowid, &mcb_reply);
        }
    }
}

int main(int argc, char *argv[])
{
    int i, rv;
    RT_TASK task, peer_task;
    RT_TASK_MCB mcb_send, mcb_reply;

    mlockall(MCL_CURRENT | MCL_FUTURE);

    rt_task_spawn(&peer_task, "peer", 4096, 99, T_FPU, &run_peer, NULL);
    rt_task_shadow(&task, "user", 50, 0);
    
    rt_task_set_periodic(NULL,TM_NOW,MAIN_RATE_NS);

    for (i=0; i<10; ++i)
    {
        rt_task_wait_period(NULL);
        mcb_send.opcode = 0x02;
        mcb_send.data = NULL;
        mcb_send.size = 0;
        mcb_reply.size = 0;
        mcb_reply.data = NULL;
        rv = rt_task_send(&peer_task,&mcb_send,&mcb_reply,TIMEOUT);
        if (rv < 0) printf("rt_task_send error\n");
        if (mcb_reply.opcode != 666)
            printf("rv=%d, opcode=%d\n", rv, mcb_reply.opcode);
    }

    rt_task_delete(&peer_task);
    rt_task_delete(NULL);

    return 0;
}



