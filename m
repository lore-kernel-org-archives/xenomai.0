Date: Thu, 24 May 2018 10:50:20 +0200 (CEST)
From: Paal Tamas <paal_to@freemail.hu>
Message-ID: <freemail.20180524105020.92819.1@fmxmldata01.freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=UTF-8
Subject: [Xenomai] Posix named semaphore used by two separate applications
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I would like to use the same named semaphore in two separate Xenomai binaries. I am using the Posix skin. It does not work as I am expecting it. 
The first instance of my test application creates a named semaphore. It goes to sleep after that. The second instance of the same applications starts than. It realizes that the semaphore with the name already exists, so it opens it. The sem_open() returns a valid (like) pointer. After that all semaphore functions in this second application return EINVAL (22) (Invalid argument). Both the sem_wait() and the sem_close() function behave this way.

The same procedure worked fine in 2.6.2.1 (the previous version I used). I tried 3.0.5 and the latest git repository too. The same bad behavior there.


My testcode:

#include <stdio.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <semaphore.h>
#include <sys/time.h>
#include <errno.h>
#include <stdlib.h>
#include <fcntl.h>
#include <time.h>
#include <sys/types.h>

#define SEMA_NAME "/testsema18"

void Sleep(unsigned int time)
{
struct timespec delay;  // structure for providing timeout
   delay.tv_sec = time / (1000*1000); // sec
   delay.tv_nsec = (time % (1000*1000)) * 1000;
   nanosleep(&delay, NULL);
}

int main(int argc, char* argv[])
{
sem_t *sema1=0;   
   if(argc<=1)
   {
      printf("Please supply a name for your process as an argument...\n");
      exit(1);
   }
   sema1=sem_open(SEMA_NAME, O_CREAT | O_EXCL,0777, 0);        
   if(sema1==SEM_FAILED)
   {
      if(errno==EEXIST)
      {
         printf("%s:sem_open(): semaphore already exists\n",argv[1]);
//         sema1=sem_open(SEMA_NAME,O_CREAT);  
         sema1=sem_open(SEMA_NAME,0);  
         if(sema1==SEM_FAILED)
         {
            printf("%s:sem_open(): sem_open() error:%d,%s\n",argv[1],errno,strerror(errno));
            exit(2);
         }
// try to acquire the semaphore
         struct timespec localTimeOut;
         struct timeval now;
         gettimeofday(&now, 0);
         if(sem_wait(sema1)!=0)
         {
            printf("%s:sem_wait() error:%d,%s\n",argv[1],errno,strerror(errno));
            if(sem_close(sema1)!=0) 
            {
               printf("%s:sem_close() error:%d,%s: exit(3)\n",argv[1],errno,strerror(errno));
               exit(3);
            }            
         }
         else
         {// access granted
            printf("%s:semaphore acquired successfully\n",argv[1]);
            if(sem_post(sema1)!=0)
            {
               printf("%s:sem_post() error:%d,%s\n",argv[1],errno,strerror(errno));
               if(sem_close(sema1)!=0) 
               {
                  printf("%s:sem_close() error:%d,%s: exit(4)\n",argv[1],errno,strerror(errno));
                  exit(4);
               }            
            }
            else printf("%s:semapore released successfully\n",argv[1]);
         }     
      }
      else
      {
         printf("%s:sem_open(): sem_open() error:%d,%s\n",argv[1],errno,strerror(errno));      
      }
   }
   else   
   {
      printf("%s:semapore created successfully\n",argv[1]);
      if(sem_post(sema1)!=0)
      {
         printf("%s:sem_post() error:%d,%s\n",argv[1],errno,strerror(errno));
         if(sem_close(sema1)!=0) 
         {
            printf("%s:sem_close() error:%d,%s: exit(6)\n",argv[1],errno,strerror(errno));
            exit(4);
         }            
      }
      else printf("%s:semapore released successfully\n",argv[1]);
   } 
   printf("%s:application goes to sleep\n",argv[1]);
   Sleep(3000000);
   if(sem_close(sema1)!=0) 
   {
      printf("%s:sem_close() error:%d,%s:exit(5)\n",argv[1],errno,strerror(errno));
      exit(5);
   }     
   else printf("%s:semaphore closed succesfully.%d\n",argv[1],errno);  
   if(sem_unlink(SEMA_NAME)!=0)
   {
      printf("%s:sem_unlink() error:%d,%s\n",argv[1],errno,strerror(errno));
   }
   else printf("%s:semaphore unlinked succesfully.%d\n",argv[1],errno);  
   printf("%s:application end.\n",argv[1]);
   return 0;   
}   



The makefile I use to compile it:

XENO_CONFIG := /usr/xenomai/bin/xeno-config
CFLAGS := $(shell $(XENO_CONFIG) --posix --cflags)
LDFLAGS := $(shell $(XENO_CONFIG) --posix --ldflags)
CC := $(shell $(XENO_CONFIG) --cc)

EXECUTABLE := mutextest

all: $(EXECUTABLE)

%: %.c
	$(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)



The script file I use to start the applications:

#!/bin/bash
export LD_LIBRARY_PATH="/usr/xenomai/lib"
./mutextest testapp111 &
sleep 1
./mutextest testapp222 &
#end



The output of the applications:

clickandmove@clickandmove-NUC:~/candm/xeno$ sudo ./run.sh
testapp111:semapore created successfully
testapp111:semapore released successfully
testapp111:application goes to sleep
clickandmove@clickandmove-NUC:~/candm/xeno$ testapp222:sem_open(): semaphore already exists
testapp222:sem_wait() error:22,Invalid argument
testapp222:sem_close() error:22,Invalid argument: exit(3)
testapp111:semaphore closed succesfully.0
testapp111:semaphore unlinked succesfully.0
testapp111:application end.



My system info:

./xeno-config --info
Xenomai version: Xenomai/cobalt v3.0.6 -- #50ef005 (2018-05-13 16:21:13 +0200)
Linux clickandmove-NUC 4.9.51xeno #1 SMP Wed May 23 05:14:47 PDT 2018 x86_64 x86_64 x86_64 GNU/Linux
Kernel parameters: BOOT_IMAGE=/boot/vmlinuz-4.9.51xeno root=UUID=7e90a17b-1ea0-4b84-849f-7d621fe6d580 ro quiet splash vt.handoff=7
I-pipe release #5 detected
Cobalt core 3.0.6 detected
Compiler: gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.5) 
Build args: --with-core=cobalt --enable-smp --enable-pshared



Please help me. What am I doing wrong?

Thank you,
Tamas



