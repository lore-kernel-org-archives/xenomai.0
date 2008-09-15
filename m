From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Mon, 15 Sep 2008 20:42:54 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_vyqzIpEHIxeHf5s"
Message-Id: <200809152042.55704.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Xenomai-Solo: bug in vxWorks taskSpawn with twice
	the same name
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

--Boundary-00=_vyqzIpEHIxeHf5s
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

Thanks a lot to Philippe for fixing the previous bug so quickly! Never got
fixed a bug as fast by WindRIver despite having paid quite a lot of money
for it!

Now my testsuite passes almost all tests but crashes, when it spawns
twice a task with the same name. E.g. I get the following output:
> testTask done t1 0x901a0f4 t2 0x901a2b4
> Xenomai/SOLO: duplicate task name: Test
> assert passed at task1 line 24
> assert passed at task1 line 24
> assert passed at task1 line 26
> assert passed at task1 line 26
>
> Command terminated by signal 11

Attached my simple test case.

Best regards

-- 
NIklaus Giger


--Boundary-00=_vyqzIpEHIxeHf5s
Content-Type: text/x-c++src;
  charset="utf-8";
  name="tst_main.cpp"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="tst_main.cpp"

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>


#define assert(cond) \
  if (!cond) printf("assert failed at %s line %d\n", __FUNCTION__, __LINE__); \
  else  printf("assert passed at %s line %d\n", __FUNCTION__, __LINE__);


#if defined(__SOLO__) || defined(_WRS_VXWORKS_MAJOR)
// #include <vxWorks.h>
#include <semLib.h>
#include <taskLib.h>
#include <tickLib.h>
#include <kernelLib.h>

void testTask(long a1, long a2, long a3, long a4, long a5,
	long a6, long a7, long a8, long a9, long a10);
bool finished;

  extern "C" void task1(long int, long int, long int, long int, long int, long int, long int, long int, long int, long int)
  {
	assert(1);
	taskDelay(30);	
	assert(2);
	finished = true;
  }

#endif

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
   int t1 =taskSpawn("Test", // name of new task (stored at pStackBase)
                     90, // priority of new task
                     0, // task option word
                     20*1024, // size (bytes) of stack needed plus name
                     task1,  // entry point of new task
                     0, // first argument
                     0,0,0,0,0,0,0,0,0);   // unused parameters

   int t2 =taskSpawn("Test", // name of new task (stored at pStackBase)
                     90, // priority of new task
                     0, // task option word
                     20*1024, // size (bytes) of stack needed plus name
                     task1,  // entry point of new task
                     0, // first argument
                     0,0,0,0,0,0,0,0,0);   // unused parameters

  printf("%s done t1 0x%x t2 0x%x\n", __FUNCTION__, t1, t2);
  while (!finished) sleep(1);
#ifdef __SOLO__
  finished = true;
  return;
#else
  return 0;
#endif
}


//  ___________________________________________________________________________

--Boundary-00=_vyqzIpEHIxeHf5s--

