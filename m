From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sun, 14 Sep 2008 15:18:59 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_F9QzIC5FsoKGup8"
Message-Id: <200809141519.01180.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Deviation in Xenomai-Solo from vxWorks behaviour
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

--Boundary-00=_F9QzIC5FsoKGup8
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

The attached program works fine under vxWorks 6.6 (powerpc).
Running it under the current xenomai-solo (trunk) on my GNU/Debian
x86 system it gets stuck at line 82:

Here is the output from vxWorks
> timex tSysMain
> assert passed at tSysMain line 66
> assert passed at tSysMain line 67
> assert passed at tSysMain line 70
> assert passed at tSysMain line 71
> assert passed at tSysMain line 74
> assert passed at tSysMain line 75
> assert passed at tSysMain line 77
> assert passed at tSysMain line 78
> assert passed at tSysMain line 79
> assert passed at tSysMain line 80
> assert passed at tSysMain line 82
> assert passed at tSysMain line 83
> tSysMain done
> timex: time of execution = 600 +/- 2 (0%) millisecs
whereas my gdb reports the following
> Starting program:
> /home/hcu/celsius/project/metaFrame/bin/BSys/mak/xeno_vx-solo/debug/tst
> [Thread debugging using libthread_db enabled]
> [New Thread 0xb7c056c0 (LWP 32206)]
> [New Thread 0xb7f02b90 (LWP 32210)]
> [New Thread 0xb7ef1b90 (LWP 32213)]
> assert passed at testTask line 66
> assert passed at testTask line 67
> assert passed at testTask line 70
> assert passed at testTask line 71
> assert passed at testTask line 74
> assert passed at testTask line 75
> assert passed at testTask line 77
> assert passed at testTask line 78
> assert passed at testTask line 79
> assert passed at testTask line 80
> ^C
> Program received signal SIGINT, Interrupt.
> [Switching to Thread 0xb7c056c0 (LWP 32206)]
> 0xb7f05424 in __kernel_vsyscall ()
> (gdb) t 3
> [Switching to thread 3 (Thread 0xb7ef1b90 (LWP 32213))]#0  0xb7f05424 in
> __kernel_vsyscall () (gdb) i s
> #0  0xb7f05424 in __kernel_vsyscall ()
> #1  0xb7e9b025 in pthread_cond_wait@domain.hid () from
> /lib/i686/cmov/libpthread.so.0 #2  0xb7eaff2f in syncobj_pend
> (sobj=0x83fd0d0, timeout=0x0, syns=0xb7ef12a4) at syncobj.c:152 #3 
> 0xb7ebff80 in xsem_take (sem=0x83fd0c8, timeout=-1) at semLib.c:83 #4 
> 0xb7ec0837 in semTake (sem_id=138399944, timeout=-1) at semLib.c:404 #5 
> 0x08048a8d in testTask (a1=0, a2=0, a3=0, a4=0, a5=0, a6=0, a7=0, a8=0,
> a9=0, a10=0) at ../../BSys/src/tst_main.cpp:82 #6  0xb7ec116b in
> task_trampoline (arg=0x83fcee8) at taskLib.c:255 #7  0xb7e974c0 in
> start_thread () from /lib/i686/cmov/libpthread.so.0 #8  0xb7ceb55e in clone
> () from /lib/i686/cmov/libc.so.6
It looks like under xenomai a failing semTake(aSemaphore, nWaitTime))
erroneously decrements the counter instead of leaving .

Best regards

-- 
NIklaus Giger


--Boundary-00=_F9QzIC5FsoKGup8
Content-Type: text/x-c++src;
  charset="us-ascii";
  name="tst_main.cpp"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="tst_main.cpp"

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#if defined(__SOLO__) || defined(_WRS_VXWORKS_MAJOR)
// #include <vxWorks.h>
#include <semLib.h>
#include <taskLib.h>
#include <tickLib.h>
#include <kernelLib.h>

void testTask(long a1, long a2, long a3, long a4, long a5,
	long a6, long a7, long a8, long a9, long a10);
bool finished;

#endif

#undef FOREVER
#define FOREVER -1

#define OK 0
#ifndef ERROR
#define ERROR -1
#endif

#define assert(cond) \
  if (!cond) printf("assert failed at %s line %d\n", __FUNCTION__, __LINE__); \
  else  printf("assert passed at %s line %d\n", __FUNCTION__, __LINE__);

/**
 *  Main functions
 */
#if defined(PLAT_VXWORKS) || defined(_WRS_VXWORKS_MAJOR)

  extern "C" int tSysMain(const char* arg)
  {
    const char* argv[2];
    argv[0]  = "undefined";
    argv[1]  = arg;
    int argc = sizeof(argv) / sizeof(char*);
#else

  int main(int argc, char *const argv[])
  {
#endif

#ifdef __SOLO__

    kernelInit(testTask, argc, argv);
    while(!finished) { sleep(1); }
    exit(0);
}

void testTask(long a1, long a2, long a3, long a4, long a5,
	long a6, long a7, long a8, long a9, long a10)
{
   int argc=0; char *const argv[]={0};
#endif
  const unsigned long nWaitTime          = 100;
  const unsigned long nToleranace        = 20;
  const unsigned long nToleranceWaitTime = nWaitTime-nToleranace;

  int res, start, now;
  SEM_ID aSemaphore = semCCreate(SEM_Q_PRIORITY, 0);
  // test 3 time with timeout which must fail
  start = tickGet();
  assert(ERROR ==semTake(aSemaphore, nWaitTime));
  assert((tickGet() - start) >= nToleranceWaitTime);

  start = tickGet();
  assert(ERROR ==semTake(aSemaphore, nWaitTime));
  assert((tickGet() - start) >= nToleranceWaitTime);

  start = tickGet();
  assert(ERROR ==semTake(aSemaphore, nWaitTime));
  assert((tickGet() - start) >= nToleranceWaitTime);

  assert(OK == semGive(aSemaphore));
  assert(OK == semTake(aSemaphore, nWaitTime));
  assert(OK == semGive(aSemaphore));
  assert(OK == semGive(aSemaphore));

  assert(OK == semTake(aSemaphore, FOREVER));
  assert(OK == semTake(aSemaphore, FOREVER));
  printf("%s done\n", __FUNCTION__);
#ifdef __SOLO__
  finished = true;
  return;
#else
  return 0;
#endif
}


//  ___________________________________________________________________________

--Boundary-00=_F9QzIC5FsoKGup8--

