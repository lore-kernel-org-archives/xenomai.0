From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sun, 21 Sep 2008 22:26:13 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_m3q1IvyCGJ0tDYw"
Message-Id: <200809212226.14177.niklaus.giger@domain.hid>
Subject: [Xenomai-core] xenomai-solo-vxWorks: Calling semGive twice on a
	binary semaphore should not return an error
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

--Boundary-00=_m3q1IvyCGJ0tDYw
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

Examining errors in my big testsuite I discovered that giving a second
time a binary semaphore xenomai returns an error where vxWorks reports OK.

See the attached test case.
> sudo  ../../bin/BSys/mak/xeno_vx-solo/debug/tst
> assert passed at testTask line 65
> assert passed at testTask line 66
> assert failed at testTask line 67
> testTask done
> Xenomai/SOLO: failed to remove registry mount point /mnt/xenomai/4569
> (errno=16)

Best regards

-- 
NIklaus Giger


--Boundary-00=_m3q1IvyCGJ0tDYw
Content-Type: text/x-c++src;
  charset="us-ascii";
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
#include <errnoLib.h>

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

   // Initialisierung
   SEM_ID testBSem1 = semBCreate (0, SEM_EMPTY);

   assert(semTake(testBSem1, 10) == ERROR);  // Empty
   assert(semGive(testBSem1) == OK);
   assert(semGive(testBSem1) == OK);    // wie VxWorks

  printf("%s done\n", __FUNCTION__);
#ifdef __SOLO__
  finished = true;
  return;
#else
  return 0;
#endif
}


//  ___________________________________________________________________________

--Boundary-00=_m3q1IvyCGJ0tDYw--

