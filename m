Message-ID: <fd6a47a90601170611g7834733eq@domain.hid>
Date: Tue, 17 Jan 2006 15:11:12 +0100
From: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Subject: [Xenomai-help] Scheduling while atomic
In-Reply-To: <fd6a47a90601170609u594d4fd4k@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_13160_918347.1137507072744"
References: <fd6a47a90601160809l6aa38508o@domain.hid>
	<17355.55389.544946.912659@domain.hid>
	<fd6a47a90601170609u594d4fd4k@domain.hid>
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

------=_Part_13160_918347.1137507072744
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Gilles, Jan,


The offending program is quite complex (several .c files and
a considerable .h file tree) and involves 2 computers. However, I think I
can narrow down the problem to concurrent access (from 2 Xenomai threads in
2nd domain) to the same Linux file descriptor for a TCP/IP connection.

In order to rule this out, I have put RT_MUTEXes around the send() and
recv() calls.However, I still received 'scheduling while atomic'. Further
investigation, however, has shown that the mutexes seem to fail:
rt_mutex_enquire() returns 0 or even -1 after acquisition of the lock. With
this program, I didn't (yet) receive the 'scheduling...' error, but by
increasing the task repetition rate, it should be a matter of (a long) time
(both tasks arriving at a blocking write).

I have compiled a program that represents the structure of the original
program. Could you have a look and see if I'm not making a mistake here ?

For proper following up, I've also attached the dmesg log asked for earlier
by Jan.


/* TEST_MUTEX.C */

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <signal.h>
#include <math.h>

#include <native/task.h>
#include <native/mutex.h>
#include <native/sem.h>

int fd, err;
RT_MUTEX m;
RT_SEM s;

#define CHECK(arg) check(arg, __LINE__)

int check(int r, int n)
{
    if (r !=3D 0)
        fprintf(stderr, "L%d: %s.\n", n, strerror(-r));
    return(r);
}

void output(char c) {
    static int cnt =3D 0;
    int n;
    char buf[2];
    RT_MUTEX_INFO mutexinfo;

    buf[0] =3D c;

    if (cnt =3D=3D 80) {
        buf[1] =3D '\n';
        n =3D 2;
        cnt =3D 0;
    }
    else {
        n =3D 1;
        cnt++;
    }

    CHECK(rt_mutex_inquire(&m, &mutexinfo));
    if (mutexinfo.lockcnt <=3D 0) {
        RT_TASK_INFO taskinfo;
        CHECK(rt_task_inquire(NULL, &taskinfo));
        fprintf(stderr, "ALERT: No lock! (lockcnt=3D%d) Offending task: %s\=
n",
                mutexinfo.lockcnt, taskinfo.name );
    }

    if (write(fd, buf, n) !=3D n) {
        fprintf(stderr, "File write error.\n");
        CHECK(rt_sem_v(&s));
    }
}

void task0(void *arg)
{
    while (1) {
        CHECK(rt_task_sleep((float)rand()*1.0e7/(float)RAND_MAX));
        CHECK(rt_mutex_lock(&m, TM_INFINITE));
        output('0');
        CHECK(rt_mutex_unlock(&m));
    }
}

void task1(void *arg)
{
    while (1) {
        CHECK(rt_task_sleep((float)rand()*1.0e7/(float)RAND_MAX));
        CHECK(rt_mutex_lock(&m, TM_INFINITE));
        output('1');
        CHECK(rt_mutex_unlock(&m));
    }
}

void sighandler(int arg)
{
    CHECK(rt_sem_v(&s));
}

int main(int argc, char *argv[])
{
    RT_TASK t, t0, t1;

    if ((fd =3D open("dump.txt", O_CREAT | O_RDWR)) < 0)
        fprintf(stderr, "File open error.\n");
    else {
        CHECK(rt_timer_start(TM_ONESHOT));

        CHECK(rt_mutex_create(&m, "mutex"));
        CHECK(rt_sem_create(&s, "sem", 0, S_PRIO));

        signal(SIGINT, sighandler);

        CHECK(rt_task_create(&t0, "task0", 0, 30, T_FPU));
        CHECK(rt_task_start(&t0, task0, NULL));
        CHECK(rt_task_create(&t1, "task1", 0, 29, T_FPU));
        CHECK(rt_task_start(&t1, task1, NULL));
        CHECK(rt_task_shadow(&t, "main", 1, T_FPU));

        CHECK(rt_sem_p(&s, TM_INFINITE));
        signal(SIGINT, SIG_IGN);

        CHECK(rt_task_delete(&t1));
        CHECK(rt_task_delete(&t0));

        CHECK(rt_sem_delete(&s));
        CHECK(rt_mutex_delete(&m));

        rt_timer_stop();

        close(fd);
    }
    return 0;
}

Compiled with GCC 4.0.2:

gcc mtest.c -o mtest $(xeno-config --xeno-cflags) $(xeno-config
---xeno-ldflags)



Run on kernel 2.6.15, Adeos 1.1-03, Xenomai SVN rev. 462



dmesg output (usually not that long - the truncated first line is actually
there - it is not the top of the dmesg log):

pe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
scheduling while atomic: ext_upload/0x00000002/12490
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0148ade>] ipipe_trace_end+0x35/0x37
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
note: ext_upload[12490] exited with preempt_count 2
scheduling while atomic: ext_upload/0x00000002/12661
 [<c03b4c64>] schedule+0x4b4/0x790
 [<c011a0ca>] __wake_up_sync+0x67/0xb8
 [<c0155455>] xnshadow_harden+0xc6/0xdd
 [<c0156c5b>] losyscall_event+0x8c/0x1c0
 [<c0147473>] __ipipe_dispatch_event+0x90/0x173
 [<c011697a>] __ipipe_syscall_root+0x36/0x110
 [<c0103434>] system_call+0x20/0x41
note: ext_upload[12661] exited with preempt_count 2

------=_Part_13160_918347.1137507072744
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Gilles, Jan,</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>The offending program is quite complex (several .c files and a&nbsp;co=
nsiderable&nbsp;.h file tree) and involves 2 computers. However, I think I =
can narrow down the problem to concurrent access (from 2 Xenomai threads in=
 2nd domain) to the same Linux file descriptor for a TCP/IP connection.=20
</div>
<div>&nbsp;</div>
<div>In order to rule this out, I have put&nbsp;RT_MUTEXes around the send(=
) and recv() calls.However, I still received 'scheduling while atomic'. Fur=
ther investigation, however, has shown that the mutexes seem to fail: rt_mu=
tex_enquire() returns 0 or even -1 after acquisition of the lock. With this=
 program, I didn't (yet) receive the 'scheduling...' error, but by increasi=
ng the task repetition rate, it should be a matter of (a long) time (both t=
asks arriving at a blocking write).=20
</div>
<div>&nbsp;</div>
<div>I have compiled a program that represents the structure of the origina=
l program. Could you have a look and see if I'm not making a mistake here ?=
</div>
<div>&nbsp;</div>
<div>For proper following up, I've also attached the dmesg log asked for ea=
rlier by Jan.</div>
<div>&nbsp;</div>
<div><font face=3D"Courier New" color=3D"#228b22" size=3D"2"></font><font f=
ace=3D"Courier New" size=3D"2">
<p>/* TEST_MUTEX.C */</p>
<p>#include &lt;stdlib.h&gt;<br>#include &lt;stdio.h&gt;<br>#include &lt;un=
istd.h&gt;<br>#include &lt;fcntl.h&gt;<br>#include &lt;signal.h&gt;<br>#inc=
lude &lt;math.h&gt;</p>
<p>#include &lt;native/task.h&gt;<br>#include &lt;native/mutex.h&gt;<br>#in=
clude &lt;native/sem.h&gt;</p>
<p>int fd, err;<br>RT_MUTEX m;<br>RT_SEM s;</p>
<p>#define CHECK(arg) check(arg, __LINE__)</p>
<p>int check(int r, int n)<br>{<br>&nbsp;&nbsp;&nbsp; if (r !=3D 0)<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;L%d: %s.\n&quo=
t;, n, strerror(-r));<br>&nbsp;&nbsp;&nbsp; return(r);<br>}</p>
<p>void output(char c) {<br>&nbsp;&nbsp;&nbsp; static int cnt =3D 0;<br>&nb=
sp;&nbsp;&nbsp; int n;<br>&nbsp;&nbsp;&nbsp; char buf[2];<br>&nbsp;&nbsp;&n=
bsp; RT_MUTEX_INFO mutexinfo;<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; =
buf[0] =3D c;<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; if (cnt =3D=3D 8=
0) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf[1] =3D '\n';<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n =3D 2;=20
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cnt =3D 0;<br>&nbsp;&nbsp;&n=
bsp; }<br>&nbsp;&nbsp;&nbsp; else {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; n =3D 1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cnt++;<br>&nb=
sp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; CHECK(rt_mut=
ex_inquire(&amp;m, &amp;mutexinfo));<br>&nbsp;&nbsp;&nbsp; if (mutexinfo.lo=
ckcnt &lt;=3D 0) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RT_TASK_IN=
FO taskinfo;=20
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_task_inquire(NULL, =
&amp;taskinfo));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stde=
rr, &quot;ALERT: No lock! (lockcnt=3D%d) Offending task: %s\n&quot;,<br>&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; mutexinfo.lockcnt, <a onclick=3D"return top.js.OpenExtLink(win=
dow,event,this)" href=3D"http://taskinfo.name/" target=3D"_blank">
taskinfo.name </a>);<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; <br>&nbs=
p;&nbsp;&nbsp; if (write(fd, buf, n) !=3D n) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;File write error.\n&quot;);<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_sem_v(&amp;s));<br>&nbsp;&n=
bsp;&nbsp; }<br>}</p>
<p>void task0(void *arg)<br>{<br>&nbsp;&nbsp;&nbsp; while (1) {<br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_task_sleep((float)rand()*1.0e7/=
(float)RAND_MAX));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_m=
utex_lock(&amp;m, TM_INFINITE));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; output('0');<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_mut=
ex_unlock(&amp;m));=20
<br>&nbsp;&nbsp;&nbsp; }<br>}</p>
<p>void task1(void *arg)<br>{<br>&nbsp;&nbsp;&nbsp; while (1) {<br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_task_sleep((float)rand()*1.0e7/=
(float)RAND_MAX));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_m=
utex_lock(&amp;m, TM_INFINITE));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; output('1');<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_mut=
ex_unlock(&amp;m));=20
<br>&nbsp;&nbsp;&nbsp; }<br>}</p>
<p>void sighandler(int arg)<br>{<br>&nbsp;&nbsp;&nbsp; CHECK(rt_sem_v(&amp;=
s));<br>}</p>
<p>int main(int argc, char *argv[])<br>{<br>&nbsp;&nbsp;&nbsp; RT_TASK t, t=
0, t1;<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; if ((fd =3D open(&quot;=
dump.txt&quot;, O_CREAT | O_RDWR)) &lt; 0)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; fprintf(stderr, &quot;File open error.\n&quot;);<br>&nbsp;&nb=
sp;&nbsp; else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_timer_start(TM_ONESHOT)=
);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; CHECK(rt_mutex_create(&amp;m, &quot;mutex&quot;));<br>=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_sem_create(&amp;s, &quo=
t;sem&quot;, 0, S_PRIO));</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signal(SIGINT, sighandler);<b=
r>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; CHECK(rt_task_create(&amp;t0, &quot;task0&quot;, 0, 30, T_=
FPU));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_task_start(&a=
mp;t0, task0, NULL));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(r=
t_task_create(&amp;t1, &quot;task1&quot;, 0, 29, T_FPU));=20
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_task_start(&amp;t1,=
 task1, NULL));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_task=
_shadow(&amp;t, &quot;main&quot;, 1, T_FPU));</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_sem_p(&amp;s, TM_INF=
INITE));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signal(SIGINT, SIG_I=
GN);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; CHECK(rt_task_delete(&amp;t1));<br>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_task_delete(&amp;t0));<br>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 CHECK(rt_sem_delete(&amp;s));=20
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHECK(rt_mutex_delete(&amp;m=
));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; rt_timer_stop();<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close(fd);<br>&nbs=
p;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; return 0;<br>}<br></p>
<p>Compiled with GCC 4.0.2:</p>
<p>gcc mtest.c -o mtest $(xeno-config --xeno-cflags) $(xeno-config ---xeno-=
ldflags)</p>
<p>&nbsp;</p>
<p>Run on kernel 2.6.15, Adeos 1.1-03, Xenomai SVN rev. 462</p>
<p>&nbsp;</p>
<p>dmesg output (usually not that long - the truncated first line is actual=
ly there - it is not the top of the dmesg log): </p>
<div>&nbsp;</div>
<div>pe_dispatch_event+0x90/0x173<br>&nbsp;[&lt;c011697a&gt;] __ipipe_sysca=
ll_root+0x36/0x110<br>&nbsp;[&lt;c0103434&gt;] system_call+0x20/0x41<br>sch=
eduling while atomic: ext_upload/0x00000002/12490<br>&nbsp;[&lt;c03b4c64&gt=
;] schedule+0x4b4/0x790=20
<br>&nbsp;[&lt;c011a0ca&gt;] __wake_up_sync+0x67/0xb8<br>&nbsp;[&lt;c015545=
5&gt;] xnshadow_harden+0xc6/0xdd<br>&nbsp;[&lt;c0156c5b&gt;] losyscall_even=
t+0x8c/0x1c0<br>&nbsp;[&lt;c0148ade&gt;] ipipe_trace_end+0x35/0x37<br>&nbsp=
;[&lt;c0147473&gt;] __ipipe_dispatch_event+0x90/0x173=20
<br>&nbsp;[&lt;c011697a&gt;] __ipipe_syscall_root+0x36/0x110<br>&nbsp;[&lt;=
c0103434&gt;] system_call+0x20/0x41<br>scheduling while atomic: ext_upload/=
0x00000002/12490<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/0x790<br>&nbsp;=
[&lt;c011a0ca&gt;] __wake_up_sync+0x67/0xb8=20
<br>&nbsp;[&lt;c0155455&gt;] xnshadow_harden+0xc6/0xdd<br>&nbsp;[&lt;c0156c=
5b&gt;] losyscall_event+0x8c/0x1c0<br>&nbsp;[&lt;c0148ade&gt;] ipipe_trace_=
end+0x35/0x37<br>&nbsp;[&lt;c0147473&gt;] __ipipe_dispatch_event+0x90/0x173=
<br>&nbsp;[&lt;c011697a&gt;] __ipipe_syscall_root+0x36/0x110=20
<br>&nbsp;[&lt;c0103434&gt;] system_call+0x20/0x41<br>scheduling while atom=
ic: ext_upload/0x00000002/12490<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/=
0x790<br>&nbsp;[&lt;c011a0ca&gt;] __wake_up_sync+0x67/0xb8<br>&nbsp;[&lt;c0=
155455&gt;] xnshadow_harden+0xc6/0xdd=20
<br>&nbsp;[&lt;c0156c5b&gt;] losyscall_event+0x8c/0x1c0<br>&nbsp;[&lt;c0148=
ade&gt;] ipipe_trace_end+0x35/0x37<br>&nbsp;[&lt;c0147473&gt;] __ipipe_disp=
atch_event+0x90/0x173<br>&nbsp;[&lt;c011697a&gt;] __ipipe_syscall_root+0x36=
/0x110<br>&nbsp;[&lt;c0103434&gt;] system_call+0x20/0x41=20
<br>scheduling while atomic: ext_upload/0x00000002/12490<br>&nbsp;[&lt;c03b=
4c64&gt;] schedule+0x4b4/0x790<br>&nbsp;[&lt;c011a0ca&gt;] __wake_up_sync+0=
x67/0xb8<br>&nbsp;[&lt;c0155455&gt;] xnshadow_harden+0xc6/0xdd<br>&nbsp;[&l=
t;c0156c5b&gt;] losyscall_event+0x8c/0x1c0=20
<br>&nbsp;[&lt;c0148ade&gt;] ipipe_trace_end+0x35/0x37<br>&nbsp;[&lt;c01474=
73&gt;] __ipipe_dispatch_event+0x90/0x173<br>&nbsp;[&lt;c011697a&gt;] __ipi=
pe_syscall_root+0x36/0x110<br>&nbsp;[&lt;c0103434&gt;] system_call+0x20/0x4=
1<br>scheduling while atomic: ext_upload/0x00000002/12490=20
<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/0x790<br>&nbsp;[&lt;c011a0ca&gt=
;] __wake_up_sync+0x67/0xb8<br>&nbsp;[&lt;c0155455&gt;] xnshadow_harden+0xc=
6/0xdd<br>&nbsp;[&lt;c0156c5b&gt;] losyscall_event+0x8c/0x1c0<br>&nbsp;[&lt=
;c0148ade&gt;] ipipe_trace_end+0x35/0x37=20
<br>&nbsp;[&lt;c0147473&gt;] __ipipe_dispatch_event+0x90/0x173<br>&nbsp;[&l=
t;c011697a&gt;] __ipipe_syscall_root+0x36/0x110<br>&nbsp;[&lt;c0103434&gt;]=
 system_call+0x20/0x41<br>scheduling while atomic: ext_upload/0x00000002/12=
490<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/0x790=20
<br>&nbsp;[&lt;c011a0ca&gt;] __wake_up_sync+0x67/0xb8<br>&nbsp;[&lt;c015545=
5&gt;] xnshadow_harden+0xc6/0xdd<br>&nbsp;[&lt;c0156c5b&gt;] losyscall_even=
t+0x8c/0x1c0<br>&nbsp;[&lt;c0148ade&gt;] ipipe_trace_end+0x35/0x37<br>&nbsp=
;[&lt;c0147473&gt;] __ipipe_dispatch_event+0x90/0x173=20
<br>&nbsp;[&lt;c011697a&gt;] __ipipe_syscall_root+0x36/0x110<br>&nbsp;[&lt;=
c0103434&gt;] system_call+0x20/0x41<br>scheduling while atomic: ext_upload/=
0x00000002/12490<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/0x790<br>&nbsp;=
[&lt;c011a0ca&gt;] __wake_up_sync+0x67/0xb8=20
<br>&nbsp;[&lt;c0155455&gt;] xnshadow_harden+0xc6/0xdd<br>&nbsp;[&lt;c0156c=
5b&gt;] losyscall_event+0x8c/0x1c0<br>&nbsp;[&lt;c0148ade&gt;] ipipe_trace_=
end+0x35/0x37<br>&nbsp;[&lt;c0147473&gt;] __ipipe_dispatch_event+0x90/0x173=
<br>&nbsp;[&lt;c011697a&gt;] __ipipe_syscall_root+0x36/0x110=20
<br>&nbsp;[&lt;c0103434&gt;] system_call+0x20/0x41<br>scheduling while atom=
ic: ext_upload/0x00000002/12490<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/=
0x790<br>&nbsp;[&lt;c011a0ca&gt;] __wake_up_sync+0x67/0xb8<br>&nbsp;[&lt;c0=
155455&gt;] xnshadow_harden+0xc6/0xdd=20
<br>&nbsp;[&lt;c0156c5b&gt;] losyscall_event+0x8c/0x1c0<br>&nbsp;[&lt;c0148=
ade&gt;] ipipe_trace_end+0x35/0x37<br>&nbsp;[&lt;c0147473&gt;] __ipipe_disp=
atch_event+0x90/0x173<br>&nbsp;[&lt;c011697a&gt;] __ipipe_syscall_root+0x36=
/0x110<br>&nbsp;[&lt;c0103434&gt;] system_call+0x20/0x41=20
<br>scheduling while atomic: ext_upload/0x00000002/12490<br>&nbsp;[&lt;c03b=
4c64&gt;] schedule+0x4b4/0x790<br>&nbsp;[&lt;c011a0ca&gt;] __wake_up_sync+0=
x67/0xb8<br>&nbsp;[&lt;c0155455&gt;] xnshadow_harden+0xc6/0xdd<br>&nbsp;[&l=
t;c0156c5b&gt;] losyscall_event+0x8c/0x1c0=20
<br>&nbsp;[&lt;c0148ade&gt;] ipipe_trace_end+0x35/0x37<br>&nbsp;[&lt;c01474=
73&gt;] __ipipe_dispatch_event+0x90/0x173<br>&nbsp;[&lt;c011697a&gt;] __ipi=
pe_syscall_root+0x36/0x110<br>&nbsp;[&lt;c0103434&gt;] system_call+0x20/0x4=
1<br>scheduling while atomic: ext_upload/0x00000002/12490=20
<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/0x790<br>&nbsp;[&lt;c011a0ca&gt=
;] __wake_up_sync+0x67/0xb8<br>&nbsp;[&lt;c0155455&gt;] xnshadow_harden+0xc=
6/0xdd<br>&nbsp;[&lt;c0156c5b&gt;] losyscall_event+0x8c/0x1c0<br>&nbsp;[&lt=
;c0148ade&gt;] ipipe_trace_end+0x35/0x37=20
<br>&nbsp;[&lt;c0147473&gt;] __ipipe_dispatch_event+0x90/0x173<br>&nbsp;[&l=
t;c011697a&gt;] __ipipe_syscall_root+0x36/0x110<br>&nbsp;[&lt;c0103434&gt;]=
 system_call+0x20/0x41<br>scheduling while atomic: ext_upload/0x00000002/12=
490<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/0x790=20
<br>&nbsp;[&lt;c011a0ca&gt;] __wake_up_sync+0x67/0xb8<br>&nbsp;[&lt;c015545=
5&gt;] xnshadow_harden+0xc6/0xdd<br>&nbsp;[&lt;c0156c5b&gt;] losyscall_even=
t+0x8c/0x1c0<br>&nbsp;[&lt;c0148ade&gt;] ipipe_trace_end+0x35/0x37<br>&nbsp=
;[&lt;c0147473&gt;] __ipipe_dispatch_event+0x90/0x173=20
<br>&nbsp;[&lt;c011697a&gt;] __ipipe_syscall_root+0x36/0x110<br>&nbsp;[&lt;=
c0103434&gt;] system_call+0x20/0x41<br>scheduling while atomic: ext_upload/=
0x00000002/12490<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/0x790<br>&nbsp;=
[&lt;c011a0ca&gt;] __wake_up_sync+0x67/0xb8=20
<br>&nbsp;[&lt;c0155455&gt;] xnshadow_harden+0xc6/0xdd<br>&nbsp;[&lt;c0156c=
5b&gt;] losyscall_event+0x8c/0x1c0<br>&nbsp;[&lt;c0148ade&gt;] ipipe_trace_=
end+0x35/0x37<br>&nbsp;[&lt;c0147473&gt;] __ipipe_dispatch_event+0x90/0x173=
<br>&nbsp;[&lt;c011697a&gt;] __ipipe_syscall_root+0x36/0x110=20
<br>&nbsp;[&lt;c0103434&gt;] system_call+0x20/0x41<br>scheduling while atom=
ic: ext_upload/0x00000002/12490<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/=
0x790<br>&nbsp;[&lt;c011a0ca&gt;] __wake_up_sync+0x67/0xb8<br>&nbsp;[&lt;c0=
155455&gt;] xnshadow_harden+0xc6/0xdd=20
<br>&nbsp;[&lt;c0156c5b&gt;] losyscall_event+0x8c/0x1c0<br>&nbsp;[&lt;c0148=
ade&gt;] ipipe_trace_end+0x35/0x37<br>&nbsp;[&lt;c0147473&gt;] __ipipe_disp=
atch_event+0x90/0x173<br>&nbsp;[&lt;c011697a&gt;] __ipipe_syscall_root+0x36=
/0x110<br>&nbsp;[&lt;c0103434&gt;] system_call+0x20/0x41=20
<br>scheduling while atomic: ext_upload/0x00000002/12490<br>&nbsp;[&lt;c03b=
4c64&gt;] schedule+0x4b4/0x790<br>&nbsp;[&lt;c011a0ca&gt;] __wake_up_sync+0=
x67/0xb8<br>&nbsp;[&lt;c0155455&gt;] xnshadow_harden+0xc6/0xdd<br>&nbsp;[&l=
t;c0156c5b&gt;] losyscall_event+0x8c/0x1c0=20
<br>&nbsp;[&lt;c0148ade&gt;] ipipe_trace_end+0x35/0x37<br>&nbsp;[&lt;c01474=
73&gt;] __ipipe_dispatch_event+0x90/0x173<br>&nbsp;[&lt;c011697a&gt;] __ipi=
pe_syscall_root+0x36/0x110<br>&nbsp;[&lt;c0103434&gt;] system_call+0x20/0x4=
1<br>scheduling while atomic: ext_upload/0x00000002/12490=20
<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/0x790<br>&nbsp;[&lt;c011a0ca&gt=
;] __wake_up_sync+0x67/0xb8<br>&nbsp;[&lt;c0155455&gt;] xnshadow_harden+0xc=
6/0xdd<br>&nbsp;[&lt;c0156c5b&gt;] losyscall_event+0x8c/0x1c0<br>&nbsp;[&lt=
;c0148ade&gt;] ipipe_trace_end+0x35/0x37=20
<br>&nbsp;[&lt;c0147473&gt;] __ipipe_dispatch_event+0x90/0x173<br>&nbsp;[&l=
t;c011697a&gt;] __ipipe_syscall_root+0x36/0x110<br>&nbsp;[&lt;c0103434&gt;]=
 system_call+0x20/0x41<br>scheduling while atomic: ext_upload/0x00000002/12=
490<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/0x790=20
<br>&nbsp;[&lt;c011a0ca&gt;] __wake_up_sync+0x67/0xb8<br>&nbsp;[&lt;c015545=
5&gt;] xnshadow_harden+0xc6/0xdd<br>&nbsp;[&lt;c0156c5b&gt;] losyscall_even=
t+0x8c/0x1c0<br>&nbsp;[&lt;c0148ade&gt;] ipipe_trace_end+0x35/0x37<br>&nbsp=
;[&lt;c0147473&gt;] __ipipe_dispatch_event+0x90/0x173=20
<br>&nbsp;[&lt;c011697a&gt;] __ipipe_syscall_root+0x36/0x110<br>&nbsp;[&lt;=
c0103434&gt;] system_call+0x20/0x41<br>scheduling while atomic: ext_upload/=
0x00000002/12490<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/0x790<br>&nbsp;=
[&lt;c011a0ca&gt;] __wake_up_sync+0x67/0xb8=20
<br>&nbsp;[&lt;c0155455&gt;] xnshadow_harden+0xc6/0xdd<br>&nbsp;[&lt;c0156c=
5b&gt;] losyscall_event+0x8c/0x1c0<br>&nbsp;[&lt;c0148ade&gt;] ipipe_trace_=
end+0x35/0x37<br>&nbsp;[&lt;c0147473&gt;] __ipipe_dispatch_event+0x90/0x173=
<br>&nbsp;[&lt;c011697a&gt;] __ipipe_syscall_root+0x36/0x110=20
<br>&nbsp;[&lt;c0103434&gt;] system_call+0x20/0x41<br>scheduling while atom=
ic: ext_upload/0x00000002/12490<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/=
0x790<br>&nbsp;[&lt;c011a0ca&gt;] __wake_up_sync+0x67/0xb8<br>&nbsp;[&lt;c0=
155455&gt;] xnshadow_harden+0xc6/0xdd=20
<br>&nbsp;[&lt;c0156c5b&gt;] losyscall_event+0x8c/0x1c0<br>&nbsp;[&lt;c0148=
ade&gt;] ipipe_trace_end+0x35/0x37<br>&nbsp;[&lt;c0147473&gt;] __ipipe_disp=
atch_event+0x90/0x173<br>&nbsp;[&lt;c011697a&gt;] __ipipe_syscall_root+0x36=
/0x110<br>&nbsp;[&lt;c0103434&gt;] system_call+0x20/0x41=20
<br>scheduling while atomic: ext_upload/0x00000002/12490<br>&nbsp;[&lt;c03b=
4c64&gt;] schedule+0x4b4/0x790<br>&nbsp;[&lt;c011a0ca&gt;] __wake_up_sync+0=
x67/0xb8<br>&nbsp;[&lt;c0155455&gt;] xnshadow_harden+0xc6/0xdd<br>&nbsp;[&l=
t;c0156c5b&gt;] losyscall_event+0x8c/0x1c0=20
<br>&nbsp;[&lt;c0148ade&gt;] ipipe_trace_end+0x35/0x37<br>&nbsp;[&lt;c01474=
73&gt;] __ipipe_dispatch_event+0x90/0x173<br>&nbsp;[&lt;c011697a&gt;] __ipi=
pe_syscall_root+0x36/0x110<br>&nbsp;[&lt;c0103434&gt;] system_call+0x20/0x4=
1<br>scheduling while atomic: ext_upload/0x00000002/12490=20
<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/0x790<br>&nbsp;[&lt;c011a0ca&gt=
;] __wake_up_sync+0x67/0xb8<br>&nbsp;[&lt;c0155455&gt;] xnshadow_harden+0xc=
6/0xdd<br>&nbsp;[&lt;c0156c5b&gt;] losyscall_event+0x8c/0x1c0<br>&nbsp;[&lt=
;c0148ade&gt;] ipipe_trace_end+0x35/0x37=20
<br>&nbsp;[&lt;c0147473&gt;] __ipipe_dispatch_event+0x90/0x173<br>&nbsp;[&l=
t;c011697a&gt;] __ipipe_syscall_root+0x36/0x110<br>&nbsp;[&lt;c0103434&gt;]=
 system_call+0x20/0x41<br>scheduling while atomic: ext_upload/0x00000002/12=
490<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/0x790=20
<br>&nbsp;[&lt;c011a0ca&gt;] __wake_up_sync+0x67/0xb8<br>&nbsp;[&lt;c015545=
5&gt;] xnshadow_harden+0xc6/0xdd<br>&nbsp;[&lt;c0156c5b&gt;] losyscall_even=
t+0x8c/0x1c0<br>&nbsp;[&lt;c0148ade&gt;] ipipe_trace_end+0x35/0x37<br>&nbsp=
;[&lt;c0147473&gt;] __ipipe_dispatch_event+0x90/0x173=20
<br>&nbsp;[&lt;c011697a&gt;] __ipipe_syscall_root+0x36/0x110<br>&nbsp;[&lt;=
c0103434&gt;] system_call+0x20/0x41<br>scheduling while atomic: ext_upload/=
0x00000002/12490<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/0x790<br>&nbsp;=
[&lt;c011a0ca&gt;] __wake_up_sync+0x67/0xb8=20
<br>&nbsp;[&lt;c0155455&gt;] xnshadow_harden+0xc6/0xdd<br>&nbsp;[&lt;c0156c=
5b&gt;] losyscall_event+0x8c/0x1c0<br>&nbsp;[&lt;c0148ade&gt;] ipipe_trace_=
end+0x35/0x37<br>&nbsp;[&lt;c0147473&gt;] __ipipe_dispatch_event+0x90/0x173=
<br>&nbsp;[&lt;c011697a&gt;] __ipipe_syscall_root+0x36/0x110=20
<br>&nbsp;[&lt;c0103434&gt;] system_call+0x20/0x41<br>scheduling while atom=
ic: ext_upload/0x00000002/12490<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/=
0x790<br>&nbsp;[&lt;c011a0ca&gt;] __wake_up_sync+0x67/0xb8<br>&nbsp;[&lt;c0=
155455&gt;] xnshadow_harden+0xc6/0xdd=20
<br>&nbsp;[&lt;c0156c5b&gt;] losyscall_event+0x8c/0x1c0<br>&nbsp;[&lt;c0148=
ade&gt;] ipipe_trace_end+0x35/0x37<br>&nbsp;[&lt;c0147473&gt;] __ipipe_disp=
atch_event+0x90/0x173<br>&nbsp;[&lt;c011697a&gt;] __ipipe_syscall_root+0x36=
/0x110<br>&nbsp;[&lt;c0103434&gt;] system_call+0x20/0x41=20
<br>scheduling while atomic: ext_upload/0x00000002/12490<br>&nbsp;[&lt;c03b=
4c64&gt;] schedule+0x4b4/0x790<br>&nbsp;[&lt;c011a0ca&gt;] __wake_up_sync+0=
x67/0xb8<br>&nbsp;[&lt;c0155455&gt;] xnshadow_harden+0xc6/0xdd<br>&nbsp;[&l=
t;c0156c5b&gt;] losyscall_event+0x8c/0x1c0=20
<br>&nbsp;[&lt;c0148ade&gt;] ipipe_trace_end+0x35/0x37<br>&nbsp;[&lt;c01474=
73&gt;] __ipipe_dispatch_event+0x90/0x173<br>&nbsp;[&lt;c011697a&gt;] __ipi=
pe_syscall_root+0x36/0x110<br>&nbsp;[&lt;c0103434&gt;] system_call+0x20/0x4=
1<br>scheduling while atomic: ext_upload/0x00000002/12490=20
<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/0x790<br>&nbsp;[&lt;c011a0ca&gt=
;] __wake_up_sync+0x67/0xb8<br>&nbsp;[&lt;c0155455&gt;] xnshadow_harden+0xc=
6/0xdd<br>&nbsp;[&lt;c0156c5b&gt;] losyscall_event+0x8c/0x1c0<br>&nbsp;[&lt=
;c0148ade&gt;] ipipe_trace_end+0x35/0x37=20
<br>&nbsp;[&lt;c0147473&gt;] __ipipe_dispatch_event+0x90/0x173<br>&nbsp;[&l=
t;c011697a&gt;] __ipipe_syscall_root+0x36/0x110<br>&nbsp;[&lt;c0103434&gt;]=
 system_call+0x20/0x41<br>scheduling while atomic: ext_upload/0x00000002/12=
490<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/0x790=20
<br>&nbsp;[&lt;c011a0ca&gt;] __wake_up_sync+0x67/0xb8<br>&nbsp;[&lt;c015545=
5&gt;] xnshadow_harden+0xc6/0xdd<br>&nbsp;[&lt;c0156c5b&gt;] losyscall_even=
t+0x8c/0x1c0<br>&nbsp;[&lt;c0148ade&gt;] ipipe_trace_end+0x35/0x37<br>&nbsp=
;[&lt;c0147473&gt;] __ipipe_dispatch_event+0x90/0x173=20
<br>&nbsp;[&lt;c011697a&gt;] __ipipe_syscall_root+0x36/0x110<br>&nbsp;[&lt;=
c0103434&gt;] system_call+0x20/0x41<br>scheduling while atomic: ext_upload/=
0x00000002/12490<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/0x790<br>&nbsp;=
[&lt;c011a0ca&gt;] __wake_up_sync+0x67/0xb8=20
<br>&nbsp;[&lt;c0155455&gt;] xnshadow_harden+0xc6/0xdd<br>&nbsp;[&lt;c0156c=
5b&gt;] losyscall_event+0x8c/0x1c0<br>&nbsp;[&lt;c0148ade&gt;] ipipe_trace_=
end+0x35/0x37<br>&nbsp;[&lt;c0147473&gt;] __ipipe_dispatch_event+0x90/0x173=
<br>&nbsp;[&lt;c011697a&gt;] __ipipe_syscall_root+0x36/0x110=20
<br>&nbsp;[&lt;c0103434&gt;] system_call+0x20/0x41<br>scheduling while atom=
ic: ext_upload/0x00000002/12490<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/=
0x790<br>&nbsp;[&lt;c011a0ca&gt;] __wake_up_sync+0x67/0xb8<br>&nbsp;[&lt;c0=
155455&gt;] xnshadow_harden+0xc6/0xdd=20
<br>&nbsp;[&lt;c0156c5b&gt;] losyscall_event+0x8c/0x1c0<br>&nbsp;[&lt;c0148=
ade&gt;] ipipe_trace_end+0x35/0x37<br>&nbsp;[&lt;c0147473&gt;] __ipipe_disp=
atch_event+0x90/0x173<br>&nbsp;[&lt;c011697a&gt;] __ipipe_syscall_root+0x36=
/0x110<br>&nbsp;[&lt;c0103434&gt;] system_call+0x20/0x41=20
<br>scheduling while atomic: ext_upload/0x00000002/12490<br>&nbsp;[&lt;c03b=
4c64&gt;] schedule+0x4b4/0x790<br>&nbsp;[&lt;c011a0ca&gt;] __wake_up_sync+0=
x67/0xb8<br>&nbsp;[&lt;c0155455&gt;] xnshadow_harden+0xc6/0xdd<br>&nbsp;[&l=
t;c0156c5b&gt;] losyscall_event+0x8c/0x1c0=20
<br>&nbsp;[&lt;c0148ade&gt;] ipipe_trace_end+0x35/0x37<br>&nbsp;[&lt;c01474=
73&gt;] __ipipe_dispatch_event+0x90/0x173<br>&nbsp;[&lt;c011697a&gt;] __ipi=
pe_syscall_root+0x36/0x110<br>&nbsp;[&lt;c0103434&gt;] system_call+0x20/0x4=
1<br>scheduling while atomic: ext_upload/0x00000002/12490=20
<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/0x790<br>&nbsp;[&lt;c011a0ca&gt=
;] __wake_up_sync+0x67/0xb8<br>&nbsp;[&lt;c0155455&gt;] xnshadow_harden+0xc=
6/0xdd<br>&nbsp;[&lt;c0156c5b&gt;] losyscall_event+0x8c/0x1c0<br>&nbsp;[&lt=
;c0148ade&gt;] ipipe_trace_end+0x35/0x37=20
<br>&nbsp;[&lt;c0147473&gt;] __ipipe_dispatch_event+0x90/0x173<br>&nbsp;[&l=
t;c011697a&gt;] __ipipe_syscall_root+0x36/0x110<br>&nbsp;[&lt;c0103434&gt;]=
 system_call+0x20/0x41<br>scheduling while atomic: ext_upload/0x00000002/12=
490<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/0x790=20
<br>&nbsp;[&lt;c011a0ca&gt;] __wake_up_sync+0x67/0xb8<br>&nbsp;[&lt;c015545=
5&gt;] xnshadow_harden+0xc6/0xdd<br>&nbsp;[&lt;c0156c5b&gt;] losyscall_even=
t+0x8c/0x1c0<br>&nbsp;[&lt;c0148ade&gt;] ipipe_trace_end+0x35/0x37<br>&nbsp=
;[&lt;c0147473&gt;] __ipipe_dispatch_event+0x90/0x173=20
<br>&nbsp;[&lt;c011697a&gt;] __ipipe_syscall_root+0x36/0x110<br>&nbsp;[&lt;=
c0103434&gt;] system_call+0x20/0x41<br>scheduling while atomic: ext_upload/=
0x00000002/12490<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/0x790<br>&nbsp;=
[&lt;c011a0ca&gt;] __wake_up_sync+0x67/0xb8=20
<br>&nbsp;[&lt;c0155455&gt;] xnshadow_harden+0xc6/0xdd<br>&nbsp;[&lt;c0156c=
5b&gt;] losyscall_event+0x8c/0x1c0<br>&nbsp;[&lt;c0148ade&gt;] ipipe_trace_=
end+0x35/0x37<br>&nbsp;[&lt;c0147473&gt;] __ipipe_dispatch_event+0x90/0x173=
<br>&nbsp;[&lt;c011697a&gt;] __ipipe_syscall_root+0x36/0x110=20
<br>&nbsp;[&lt;c0103434&gt;] system_call+0x20/0x41<br>scheduling while atom=
ic: ext_upload/0x00000002/12490<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/=
0x790<br>&nbsp;[&lt;c011a0ca&gt;] __wake_up_sync+0x67/0xb8<br>&nbsp;[&lt;c0=
155455&gt;] xnshadow_harden+0xc6/0xdd=20
<br>&nbsp;[&lt;c0156c5b&gt;] losyscall_event+0x8c/0x1c0<br>&nbsp;[&lt;c0148=
ade&gt;] ipipe_trace_end+0x35/0x37<br>&nbsp;[&lt;c0147473&gt;] __ipipe_disp=
atch_event+0x90/0x173<br>&nbsp;[&lt;c011697a&gt;] __ipipe_syscall_root+0x36=
/0x110<br>&nbsp;[&lt;c0103434&gt;] system_call+0x20/0x41=20
<br>scheduling while atomic: ext_upload/0x00000002/12490<br>&nbsp;[&lt;c03b=
4c64&gt;] schedule+0x4b4/0x790<br>&nbsp;[&lt;c011a0ca&gt;] __wake_up_sync+0=
x67/0xb8<br>&nbsp;[&lt;c0155455&gt;] xnshadow_harden+0xc6/0xdd<br>&nbsp;[&l=
t;c0156c5b&gt;] losyscall_event+0x8c/0x1c0=20
<br>&nbsp;[&lt;c0148ade&gt;] ipipe_trace_end+0x35/0x37<br>&nbsp;[&lt;c01474=
73&gt;] __ipipe_dispatch_event+0x90/0x173<br>&nbsp;[&lt;c011697a&gt;] __ipi=
pe_syscall_root+0x36/0x110<br>&nbsp;[&lt;c0103434&gt;] system_call+0x20/0x4=
1<br>scheduling while atomic: ext_upload/0x00000002/12490=20
<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/0x790<br>&nbsp;[&lt;c011a0ca&gt=
;] __wake_up_sync+0x67/0xb8<br>&nbsp;[&lt;c0155455&gt;] xnshadow_harden+0xc=
6/0xdd<br>&nbsp;[&lt;c0156c5b&gt;] losyscall_event+0x8c/0x1c0<br>&nbsp;[&lt=
;c0148ade&gt;] ipipe_trace_end+0x35/0x37=20
<br>&nbsp;[&lt;c0147473&gt;] __ipipe_dispatch_event+0x90/0x173<br>&nbsp;[&l=
t;c011697a&gt;] __ipipe_syscall_root+0x36/0x110<br>&nbsp;[&lt;c0103434&gt;]=
 system_call+0x20/0x41<br>scheduling while atomic: ext_upload/0x00000002/12=
490<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/0x790=20
<br>&nbsp;[&lt;c011a0ca&gt;] __wake_up_sync+0x67/0xb8<br>&nbsp;[&lt;c015545=
5&gt;] xnshadow_harden+0xc6/0xdd<br>&nbsp;[&lt;c0156c5b&gt;] losyscall_even=
t+0x8c/0x1c0<br>&nbsp;[&lt;c0148ade&gt;] ipipe_trace_end+0x35/0x37<br>&nbsp=
;[&lt;c0147473&gt;] __ipipe_dispatch_event+0x90/0x173=20
<br>&nbsp;[&lt;c011697a&gt;] __ipipe_syscall_root+0x36/0x110<br>&nbsp;[&lt;=
c0103434&gt;] system_call+0x20/0x41<br>scheduling while atomic: ext_upload/=
0x00000002/12490<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/0x790<br>&nbsp;=
[&lt;c011a0ca&gt;] __wake_up_sync+0x67/0xb8=20
<br>&nbsp;[&lt;c0155455&gt;] xnshadow_harden+0xc6/0xdd<br>&nbsp;[&lt;c0156c=
5b&gt;] losyscall_event+0x8c/0x1c0<br>&nbsp;[&lt;c0148ade&gt;] ipipe_trace_=
end+0x35/0x37<br>&nbsp;[&lt;c0147473&gt;] __ipipe_dispatch_event+0x90/0x173=
<br>&nbsp;[&lt;c011697a&gt;] __ipipe_syscall_root+0x36/0x110=20
<br>&nbsp;[&lt;c0103434&gt;] system_call+0x20/0x41<br>scheduling while atom=
ic: ext_upload/0x00000002/12490<br>&nbsp;[&lt;c03b4c64&gt;] schedule+0x4b4/=
0x790<br>&nbsp;[&lt;c011a0ca&gt;] __wake_up_sync+0x67/0xb8<br>&nbsp;[&lt;c0=
155455&gt;] xnshadow_harden+0xc6/0xdd=20
<br>&nbsp;[&lt;c0156c5b&gt;] losyscall_event+0x8c/0x1c0<br>&nbsp;[&lt;c0148=
ade&gt;] ipipe_trace_end+0x35/0x37<br>&nbsp;[&lt;c0147473&gt;] __ipipe_disp=
atch_event+0x90/0x173<br>&nbsp;[&lt;c011697a&gt;] __ipipe_syscall_root+0x36=
/0x110<br>&nbsp;[&lt;c0103434&gt;] system_call+0x20/0x41=20
<br>scheduling while atomic: ext_upload/0x00000002/12490<br>&nbsp;[&lt;c03b=
4c64&gt;] schedule+0x4b4/0x790<br>&nbsp;[&lt;c011a0ca&gt;] __wake_up_sync+0=
x67/0xb8<br>&nbsp;[&lt;c0155455&gt;] xnshadow_harden+0xc6/0xdd<br>&nbsp;[&l=
t;c0156c5b&gt;] losyscall_event+0x8c/0x1c0=20
<br>&nbsp;[&lt;c0148ade&gt;] ipipe_trace_end+0x35/0x37<br>&nbsp;[&lt;c01474=
73&gt;] __ipipe_dispatch_event+0x90/0x173<br>&nbsp;[&lt;c011697a&gt;] __ipi=
pe_syscall_root+0x36/0x110<br>&nbsp;[&lt;c0103434&gt;] system_call+0x20/0x4=
1<br>note: ext_upload[12490] exited with preempt_count 2=20
<br>scheduling while atomic: ext_upload/0x00000002/12661<br>&nbsp;[&lt;c03b=
4c64&gt;] schedule+0x4b4/0x790<br>&nbsp;[&lt;c011a0ca&gt;] __wake_up_sync+0=
x67/0xb8<br>&nbsp;[&lt;c0155455&gt;] xnshadow_harden+0xc6/0xdd<br>&nbsp;[&l=
t;c0156c5b&gt;] losyscall_event+0x8c/0x1c0=20
<br>&nbsp;[&lt;c0147473&gt;] __ipipe_dispatch_event+0x90/0x173<br>&nbsp;[&l=
t;c011697a&gt;] __ipipe_syscall_root+0x36/0x110<br>&nbsp;[&lt;c0103434&gt;]=
 system_call+0x20/0x41<br>note: ext_upload[12661] exited with preempt_count=
 2<br>&nbsp;</div>

<p>&nbsp;</p></font></div>

------=_Part_13160_918347.1137507072744--

