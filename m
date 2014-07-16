Date: Wed, 16 Jul 2014 14:30:18 +0200 (CEST)
From: Paal Tamas <paal_to@freemail.hu>
In-Reply-To: <freemail.20140716141642.14849.3@fmxmldata05.freemail.hu>
Message-ID: <freemail.20140716143018.75842.1@fmxmldata00.freemail.hu>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Subject: Re: [Xenomai] Memory paging trouble
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

One more try: Gilles, Hopefully this time it will be better.Besides, I atta=
ched the test app source too. I am using Xeno 2.6.3 together with a 3.0.15 =
Linux kernel on an i.MX6 ARM hardware. I am using the Posix skin.
I have a memory paging problem inmy user mode app. I don&#39;t get any erro=
r message, only the contents of my memory buffer gets messed up. I try to d=
escribe what I see and what I suspect in as less words as possible:I alloca=
te (using malloc) a buffer which is  more then 3 memory pages long (a page =
is 4096bytes in my case). I write a few bytes to the beginning, then a few =
bytes to the end, save the contents ina file. After that I fill the rest of=
 the buffer from the beginning till the end and save the contents again int=
o a file. I write unsigned int values into it starting with zero counting u=
p to 3999.
After this procedure the buffer should look like this (I indicate the memor=
y page boundaries according to my test app):Page1
.
0
.
833
Page2
834
.
1857
Page3
1858
.
2881
Page4
2882
.
3905
Page5
3906
.
3999But the content of the buffer looks like this:Page1
.
0
.
833
Page2
2882
.
3905
Page3
2882
.
3905
Page4
2882
.
3905
Page5
3906
.
3999 It seems that the second and third pages, which were not added to the =
virtual memory of the process in the first cycle (because I wrote data only=
 into the address ranges of the first and  fourth pages then) are &#39;miss=
ing", and the content of the fourth page show up on the address range of th=
e second and third page.I see this strange behaviour only if I allocate thi=
s buffer in a Xenomai thread. If I do the allocation in the main thread of =
the process (e.g. in the main() function) the memory will not be corrupt!
If I compile the same source code to native Linux and running on the same h=
ardware, on the same kernel, it works fine, no memory corruption can be see=
n this time either.  I found the following workarounds:
WA1.: Initialize the buffer from the beginning to the end in a linear fashi=
on after allocation (e.g. writing the bytes one after the other, ensure to =
add the memory pages one afte the other to the process).
WA2.: Use calloc() instead of malloc() which is the same workaround as WA1 =
was.I am struggling with this issue since a week. Please help me where to s=
earch for the problem. In Xenomai, in the Linux kernel or in the stdlib? On=
e more strange thing that I am not sure if it has anything to do with this =
issue. I do not get any runtime error if I DON&#39;T call mlockall()! Why i=
s that? I read somewhere that some libraries call mlockall() during initial=
ization. Is it true? Thank you,
Tamas  The code: #include <stdio.h>
#include <string.h>

#include <errno.h>
#include <stdlib.h>
#include <time.h>
#include <pthread.h>

#include <sys/mman.h>

#define ALLOC_IN_THREAD
//#define ALLOC_IN_MAIN

#define MEMTEST_IN_THREAD
//#define MEMTEST_IN_MAIN

typedef unsigned int UInt32;
typedef unsigned char Bool;
typedef unsigned char UInt8;
#define TRUE 1
#define FALSE 0

static UInt32 *src_Src1;
static UInt32 src_Src1_maxSize,src_Src1_actualSize;
static UInt8 *src_Src2;
static UInt32 src_Src2_maxSize,src_Src2_actualSize;
static Bool src_Src3;

void printErrno(char *str)
{
   printf("%s: %d:%s\n",str,errno,strerror(errno));
}

void usecdelay(UInt32 time)
{
struct timespec delay;  // structure for providing timeout
   delay.tv_sec =3D time / (1000*1000); // sec
   delay.tv_nsec =3D (time % (1000*1000)) * 1000;
   nanosleep(&delay, NULL);
}

void FillArray(UInt32 pin_DestECount)
{
   UInt32 i;
   for(i=3D0; i<pin_DestECount;i++)
   {
     src_Src1[i] =3D i;     =20
   }
   src_Src1_actualSize=3Dpin_DestECount;
   return;
}

void CopyArrayUInt32ToU8aBody(Bool pin_Enable, UInt32 pin_Offset)
{
   if (pin_Enable) {

      if (pin_Offset >=3D src_Src2_maxSize) {
         printf("EID_ARM_OFFSET_IS_TOO_LARGE\n");
         return;
      }
      UInt32 writableSize=3Dsrc_Src2_maxSize-pin_Offset;
      UInt8* pNext =3D&(src_Src2[pin_Offset]);
/*      *pNext=3D(UInt8)(src_Src1_actualSize&0xFF); pNext++;
      *pNext=3D(UInt8)((src_Src1_actualSize>>8)&0xFF); pNext++;
      *pNext=3D(UInt8)((src_Src1_actualSize>>16)&0xFF); pNext++;
      *pNext=3D(UInt8)((src_Src1_actualSize>>24)&0xFF); pNext++;
      *pNext=3D(UInt8)(src_Src1_maxSize&0xFF); pNext++;
      *pNext=3D(UInt8)((src_Src1_maxSize>>8)&0xFF); pNext++;
      *pNext=3D(UInt8)((src_Src1_maxSize>>16)&0xFF); pNext++;
      *pNext=3D(UInt8)((src_Src1_maxSize>>24)&0xFF); pNext++;
      writableSize-=3D8;*/
      UInt32 i;
      for(i=3D0;i<src_Src1_actualSize;i++)
      {
         *pNext=3D(UInt8)(*((UInt32*)(&src_Src1[i]))&0xFF); pNext++;
         *pNext=3D(UInt8)(((*((UInt32*)(&src_Src1[i])))>>8)&0xFF); pNext++;
         *pNext=3D(UInt8)(((*((UInt32*)(&src_Src1[i])))>>16)&0xFF); pNext++=
;
         *pNext=3D(UInt8)(((*((UInt32*)(&src_Src1[i])))>>24)&0xFF); pNext++=
;
         writableSize-=3D4;
      }
      if (src_Src2_actualSize < src_Src2_maxSize-writableSize) {
          src_Src2_actualSize=3Dsrc_Src2_maxSize-writableSize;
      }
   }
   return;
}

void CopyBoolToU8aBody(Bool pin_Enable, UInt32 pin_Offset)
{
   if (pin_Enable) {

      if (pin_Offset >=3D src_Src2_maxSize) {
         printf("EID_ARM_OFFSET_IS_TOO_LARGE\n");
         return;
      }
      UInt32 writableSize=3Dsrc_Src2_maxSize-pin_Offset;
      UInt8* pNext =3D&(src_Src2[pin_Offset]);
      *pNext=3D(UInt8)src_Src3; pNext++;
      writableSize--;
      if (src_Src2_actualSize < src_Src2_maxSize-writableSize) {
          src_Src2_actualSize=3Dsrc_Src2_maxSize-writableSize;
      }
   }
   return;
}

static UInt32 cycle=3D0;
void body()
{
FILE *fp;
   src_Src2_actualSize=3D0;
   CopyArrayUInt32ToU8aBody(TRUE, 0);

   fp=3Dfopen("testdata.txt","at");
   fprintf(fp,"After write from the beginning of the buffer: len=3D%d, cycl=
e=3D%d\n",src_Src2_actualSize,cycle);
   UInt32 i;
   for(i=3D0; i<src_Src2_actualSize;i+=3Dsizeof(UInt32))fprintf(fp,"%d:%d\n=
",i,(UInt32)(*((UInt32*)&(src_Src2[i]))));
   fclose(fp);

   CopyBoolToU8aBody(TRUE, 16008);

   fp=3Dfopen("testdata.txt","at");
   fprintf(fp,"After write to the end of the buffer: len=3D%d, cycle=3D%d\n=
",src_Src2_actualSize,cycle);
   for(i=3D0; i<src_Src2_actualSize;i+=3Dsizeof(UInt32))fprintf(fp,"%d:%d\n=
",i,(UInt32)(*((UInt32*)&(src_Src2[i]))));
   fclose(fp);

   cycle++;

}

Bool terminateThread=3DFALSE;
Bool threadTerminated=3DFALSE;

static void *LinuxThreadFunc(void *ptr)
{
UInt32 cntr=3D0;
   printf("-- thread1: is running\n");
#ifdef ALLOC_IN_THREAD
   printf("Allocating the buffers in the thread.\n");
//      src_Src1=3D(UInt32*)new UInt32[2000];
printf("malloc1...\n");
usecdelay(10000);
      src_Src1=3D(UInt32*)malloc(4000*sizeof(UInt32));
usecdelay(10000);
printf("...ok\n");
usecdelay(10000);

//      src_Src1=3D(UInt32*)calloc(2000*8,1);
      src_Src1_maxSize=3D4000;src_Src1_actualSize=3D0;
//      src_Src2=3D(UInt8*) new UInt8[16013l];
printf("malloc2...\n");
usecdelay(10000);
      src_Src2=3D(UInt8*) malloc(16013l);
usecdelay(10000);
printf("...ok\n");
usecdelay(10000);
//      src_Src2=3D(UInt8*) calloc(16013l,1);
      src_Src2_maxSize=3D16013l;src_Src2_actualSize=3D0;
#endif
   while(!terminateThread)
   {
#ifdef MEMTEST_IN_THREAD    =20
      if(cntr=3D=3D1) FillArray(src_Src1_maxSize);
      printf("-- thread1: cycle:%d test\n",cntr);
      body();
#else
      printf("-- thread1: cycle:%d empty\n",cntr);
#endif
      usecdelay(500000);
      cntr++;
   }
   threadTerminated=3DTRUE;
}


//--------------------------------------------------------------
int main (int argc, char* argv[])
{
int ret;
pthread_attr_t threadAttr;
pthread_t thread=3D0;  // thread identifier
FILE *fp;
UInt32 cntr=3D0;
    ret=3Dmlockall(MCL_CURRENT | MCL_FUTURE);
   printf("mlockall returned %d\n",ret);

   fp=3Dfopen("testdata.txt","wt");
   fprintf(fp,"Xenomai memory allocation issue test.\n");
   fclose(fp);

#ifdef ALLOC_IN_MAIN
   printf("Allocating the buffers in main()\n");
//      src_Src1=3D(UInt32*)new UInt32[2000];
   src_Src1=3D(UInt32*)malloc(4000*4);
   src_Src1_maxSize=3D2000;src_Src1_actualSize=3D0;
//      src_Src2=3D(UInt8*) new UInt8[16013l];
   src_Src2=3D(UInt8*) malloc(16013l);
   src_Src2_maxSize=3D16013l;src_Src2_actualSize=3D0;
#endif

   printf("- Create a new thread (thread1)\n");
 // initialize the thread attribute
   if(pthread_attr_init(&threadAttr)!=3D0)
   {
      printErrno("Thread(): pthread_attr_init() error :");
      return -1;
   }
// Set thread to detached state. No need for pthread_join
   if(pthread_attr_setdetachstate(&threadAttr, PTHREAD_CREATE_DETACHED)!=3D=
0)
   {
      printErrno("Thread(): pthread_attr_setdetachstate() error :");
      pthread_attr_destroy(&threadAttr);
      return -2;
   }
// Create the thread
   if(pthread_create(&thread, &threadAttr, LinuxThreadFunc, 0)!=3D0)
   {
      printErrno("Thread(): pthread_create() error :");
      pthread_attr_destroy(&threadAttr);
      return -3;
   }
// Destroy the thread attributes
   if(pthread_attr_destroy(&threadAttr)!=3D0)
   {
      printErrno("Thread(): pthread_attr_destroy() error :");
      return -4;
   }
   printf("- Thread create OK (thread1)\n");
   UInt32 i;
   for(i=3D0;i<3;i++)
   {
#ifdef MEMTEST_IN_MAIN  =20
      if(cntr=3D=3D1) FillArray(src_Src1_maxSize);
      body();
      printf("main loop is testing.\n");
#else
      printf("main loop is empty.\n");
#endif
      usecdelay(500000);
      cntr++;
   }

   terminateThread=3DTRUE;
   printf("- Wait for the thread (thread1) to exit\n");
   do
   {
      usecdelay(10000);
   }while(!threadTerminated);
   printf("- Thread1 terminated\n");
   free(src_Src2);
   free(src_Src1);
//   delete[] src_Src2;
//   delete[] src_Src1;
end:
   return 0;
}
=20
Paal Tamas <paal_to@freemail.hu> =C3=ADrta:
>Gilles, Hopefully this time it will be better. You can find the test code =
at the end of the email.
> I am using Xeno 2.6.3 together with a 3.0.15 Linux kernel on an i.MX6 ARM=
 hardware. I am using the Posix skin.I have a memory paging problem inmy us=
er mode app. I don&#39;t get any error message, only the contents of my mem=
ory buffer gets messed up. I try to describe what I see and what I suspect =
in as less words as possible: I allocate (using malloc) a buffer which is  =
more then 3 memory pages long (a page is 4096bytes in my case). I write a f=
ew bytes to the beginning, then a few bytes to the end, save the contents i=
na file. After that I fill the rest of the buffer from the beginning till t=
he end and save the contents again into a file. I write unsigned int values=
 into it starting with zero counting up to 3999.After this procedure the bu=
ffer should look like this (I indicate the memory page boundaries according=
 to my test app): Page1.0.833Page2834.1857Page31858.2881Page42882.3905Page5=
3906.3999 But the content of the buffer looks like this: Page1.0.833Page228=
82.3905Page32882.3905Page42882.3905Page53906.3999 It seems that the second =
and third pages, which were not added to the virtual memory of the process =
in the first cycle (because I wrote data only into the address ranges of th=
e first and  fourth pages then) are &#39;missing", and the content of the f=
ourth page show up on the address range of the second and third page. I see=
 this strange behaviour only if I allocate this buffer in a Xenomai thread.=
 If I do the allocation in the main thread of the process (e.g. in the main=
() function) the memory will not be corrupt!If I compile the same source co=
de to native Linux and running on the same hardware, on the same kernel, it=
 works fine, no memory corruption can be seen this time either. I found the=
 following workarounds:WA1.: Initialize the buffer from the beginning to th=
e end in a linear fashion after allocation (e.g. writing the bytes one afte=
r the other, ensure to add the memory pages one afte the other to the proce=
ss).WA2.: Use calloc() instead of malloc() which is the same workaround as =
WA1 was. I am struggling with this issue since a week. Please help me where=
 to search for the problem. In Xenomai, in the Linux kernel or in the stdli=
b? One more strange thing that I am not sure if it has anything to do with =
this issue. I do not get any runtime error if I DON&#39;T call mlockall()! =
Why is that? I read somewhere that some libraries call mlockall() during in=
itialization. Is it true? Thank you,Tamas The code: #include <stdio.h>
>#include <string.h>
>
>#include <errno.h>
>#include <stdlib.h>
>#include <time.h>
>#include <pthread.h>
>
>#include <sys/mman.h>
>
>#define ALLOC_IN_THREAD
>//#define ALLOC_IN_MAIN
>
>#define MEMTEST_IN_THREAD
>//#define MEMTEST_IN_MAIN
>
>typedef unsigned int UInt32;
>typedef unsigned char Bool;
>typedef unsigned char UInt8;
>#define TRUE 1
>#define FALSE 0
>
>static UInt32 *src_Src1;
>static UInt32 src_Src1_maxSize,src_Src1_actualSize;
>static UInt8 *src_Src2;
>static UInt32 src_Src2_maxSize,src_Src2_actualSize;
>static Bool src_Src3;
>
>void printErrno(char *str)
>{
>   printf("%s: %d:%s\n",str,errno,strerror(errno));
>}
>
>void usecdelay(UInt32 time)
>{
>struct timespec delay;  // structure for providing timeout
>   delay.tv_sec =3D time / (1000*1000); // sec
>   delay.tv_nsec =3D (time % (1000*1000)) * 1000;
>   nanosleep(&delay, NULL);
>}
>
>void FillArray(UInt32 pin_DestECount)
>{
>   UInt32 i;
>   for(i=3D0; i<pin_DestECount;i++)
>   {
>     src_Src1[i] =3D i;     =20
>   }
>   src_Src1_actualSize=3Dpin_DestECount;
>   return;
>}
>
>void CopyArrayUInt32ToU8aBody(Bool pin_Enable, UInt32 pin_Offset)
>{
>   if (pin_Enable) {
>
>      if (pin_Offset >=3D src_Src2_maxSize) {
>         printf("EID_ARM_OFFSET_IS_TOO_LARGE\n");
>         return;
>      }
>      UInt32 writableSize=3Dsrc_Src2_maxSize-pin_Offset;
>      UInt8* pNext =3D&(src_Src2[pin_Offset]);
>/*      *pNext=3D(UInt8)(src_Src1_actualSize&0xFF); pNext++;
>      *pNext=3D(UInt8)((src_Src1_actualSize>>8)&0xFF); pNext++;
>      *pNext=3D(UInt8)((src_Src1_actualSize>>16)&0xFF); pNext++;
>      *pNext=3D(UInt8)((src_Src1_actualSize>>24)&0xFF); pNext++;
>      *pNext=3D(UInt8)(src_Src1_maxSize&0xFF); pNext++;
>      *pNext=3D(UInt8)((src_Src1_maxSize>>8)&0xFF); pNext++;
>      *pNext=3D(UInt8)((src_Src1_maxSize>>16)&0xFF); pNext++;
>      *pNext=3D(UInt8)((src_Src1_maxSize>>24)&0xFF); pNext++;
>      writableSize-=3D8;*/
>      UInt32 i;
>      for(i=3D0;i<src_Src1_actualSize;i++)
>      {
>         *pNext=3D(UInt8)(*((UInt32*)(&src_Src1[i]))&0xFF); pNext++;
>         *pNext=3D(UInt8)(((*((UInt32*)(&src_Src1[i])))>>8)&0xFF); pNext++=
;
>         *pNext=3D(UInt8)(((*((UInt32*)(&src_Src1[i])))>>16)&0xFF); pNext+=
+;
>         *pNext=3D(UInt8)(((*((UInt32*)(&src_Src1[i])))>>24)&0xFF); pNext+=
+;
>         writableSize-=3D4;
>      }
>      if (src_Src2_actualSize < src_Src2_maxSize-writableSize) {
>          src_Src2_actualSize=3Dsrc_Src2_maxSize-writableSize;
>      }
>   }
>   return;
>}
>
>void CopyBoolToU8aBody(Bool pin_Enable, UInt32 pin_Offset)
>{
>   if (pin_Enable) {
>
>      if (pin_Offset >=3D src_Src2_maxSize) {
>         printf("EID_ARM_OFFSET_IS_TOO_LARGE\n");
>         return;
>      }
>      UInt32 writableSize=3Dsrc_Src2_maxSize-pin_Offset;
>      UInt8* pNext =3D&(src_Src2[pin_Offset]);
>      *pNext=3D(UInt8)src_Src3; pNext++;
>      writableSize--;
>      if (src_Src2_actualSize < src_Src2_maxSize-writableSize) {
>          src_Src2_actualSize=3Dsrc_Src2_maxSize-writableSize;
>      }
>   }
>   return;
>}
>
>static UInt32 cycle=3D0;
>void body()
>{
>FILE *fp;
>   src_Src2_actualSize=3D0;
>   CopyArrayUInt32ToU8aBody(TRUE, 0);
>
>   fp=3Dfopen("testdata.txt","at");
>   fprintf(fp,"After write from the beginning of the buffer: len=3D%d, cyc=
le=3D%d\n",src_Src2_actualSize,cycle);
>   UInt32 i;
>   for(i=3D0; i<src_Src2_actualSize;i+=3Dsizeof(UInt32))fprintf(fp,"%d:%d\=
n",i,(UInt32)(*((UInt32*)&(src_Src2[i]))));
>   fclose(fp);
>
>   CopyBoolToU8aBody(TRUE, 16008);
>
>   fp=3Dfopen("testdata.txt","at");
>   fprintf(fp,"After write to the end of the buffer: len=3D%d, cycle=3D%d\=
n",src_Src2_actualSize,cycle);
>   for(i=3D0; i<src_Src2_actualSize;i+=3Dsizeof(UInt32))fprintf(fp,"%d:%d\=
n",i,(UInt32)(*((UInt32*)&(src_Src2[i]))));
>   fclose(fp);
>
>   cycle++;
>
>}
>
>Bool terminateThread=3DFALSE;
>Bool threadTerminated=3DFALSE;
>
>static void *LinuxThreadFunc(void *ptr)
>{
>UInt32 cntr=3D0;
>   printf("-- thread1: is running\n");
>#ifdef ALLOC_IN_THREAD
>   printf("Allocating the buffers in the thread.\n");
>//      src_Src1=3D(UInt32*)new UInt32[2000];
>printf("malloc1...\n");
>usecdelay(10000);
>      src_Src1=3D(UInt32*)malloc(4000*sizeof(UInt32));
>usecdelay(10000);
>printf("...ok\n");
>usecdelay(10000);
>
>//      src_Src1=3D(UInt32*)calloc(2000*8,1);
>      src_Src1_maxSize=3D4000;src_Src1_actualSize=3D0;
>//      src_Src2=3D(UInt8*) new UInt8[16013l];
>printf("malloc2...\n");
>usecdelay(10000);
>      src_Src2=3D(UInt8*) malloc(16013l);
>usecdelay(10000);
>printf("...ok\n");
>usecdelay(10000);
>//      src_Src2=3D(UInt8*) calloc(16013l,1);
>      src_Src2_maxSize=3D16013l;src_Src2_actualSize=3D0;
>#endif
>   while(!terminateThread)
>   {
>#ifdef MEMTEST_IN_THREAD    =20
>      if(cntr=3D=3D1) FillArray(src_Src1_maxSize);
>      printf("-- thread1: cycle:%d test\n",cntr);
>      body();
>#else
>      printf("-- thread1: cycle:%d empty\n",cntr);
>#endif
>      usecdelay(500000);
>      cntr++;
>   }
>   threadTerminated=3DTRUE;
>}
>
>
>//--------------------------------------------------------------
>int main (int argc, char* argv[])
>{
>int ret;
>pthread_attr_t threadAttr;
>pthread_t thread=3D0;  // thread identifier
>FILE *fp;
>UInt32 cntr=3D0;
>    ret=3Dmlockall(MCL_CURRENT | MCL_FUTURE);
>   printf("mlockall returned %d\n",ret);
>
>   fp=3Dfopen("testdata.txt","wt");
>   fprintf(fp,"Xenomai memory allocation issue test.\n");
>   fclose(fp);
>
>#ifdef ALLOC_IN_MAIN
>   printf("Allocating the buffers in main()\n");
>//      src_Src1=3D(UInt32*)new UInt32[2000];
>   src_Src1=3D(UInt32*)malloc(4000*4);
>   src_Src1_maxSize=3D2000;src_Src1_actualSize=3D0;
>//      src_Src2=3D(UInt8*) new UInt8[16013l];
>   src_Src2=3D(UInt8*) malloc(16013l);
>   src_Src2_maxSize=3D16013l;src_Src2_actualSize=3D0;
>#endif
>
>   printf("- Create a new thread (thread1)\n");
> // initialize the thread attribute
>   if(pthread_attr_init(&threadAttr)!=3D0)
>   {
>      printErrno("Thread(): pthread_attr_init() error :");
>      return -1;
>   }
>// Set thread to detached state. No need for pthread_join
>   if(pthread_attr_setdetachstate(&threadAttr, PTHREAD_CREATE_DETACHED)!=
=3D0)
>   {
>      printErrno("Thread(): pthread_attr_setdetachstate() error :");
>      pthread_attr_destroy(&threadAttr);
>      return -2;
>   }
>// Create the thread
>   if(pthread_create(&thread, &threadAttr, LinuxThreadFunc, 0)!=3D0)
>   {
>      printErrno("Thread(): pthread_create() error :");
>      pthread_attr_destroy(&threadAttr);
>      return -3;
>   }
>// Destroy the thread attributes
>   if(pthread_attr_destroy(&threadAttr)!=3D0)
>   {
>      printErrno("Thread(): pthread_attr_destroy() error :");
>      return -4;
>   }
>   printf("- Thread create OK (thread1)\n");
>   UInt32 i;
>   for(i=3D0;i<3;i++)
>   {
>#ifdef MEMTEST_IN_MAIN  =20
>      if(cntr=3D=3D1) FillArray(src_Src1_maxSize);
>      body();
>      printf("main loop is testing.\n");
>#else
>      printf("main loop is empty.\n");
>#endif
>      usecdelay(500000);
>      cntr++;
>   }
>
>   terminateThread=3DTRUE;
>   printf("- Wait for the thread (thread1) to exit\n");
>   do
>   {
>      usecdelay(10000);
>   }while(!threadTerminated);
>   printf("- Thread1 terminated\n");
>   free(src_Src2);
>   free(src_Src1);
>//   delete[] src_Src2;
>//   delete[] src_Src1;
>end:
>   return 0;
>}
>=20
>Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> =C3=ADrta:
>>On 07/16/2014 01:23 PM, Paal Tamas wrote:
>>> Dear All, I am using Xeno 2.6.3 together with a 3.0.15 Linux kernel
>>> on an i.MX6 ARM hardware. I am using the Posix skin.I have a memory
>>> paging problem inmy user mode app. I don&#39;t get any error message,
>>> only the contents of my memory buffer gets messed up. I try to
>>> describe what I see and what I suspect in as less words as possible:
>>> I allocate (using malloc) a buffer which is  more then 3 memory pages
>>> long (a page is 4096bytes in my case). I write a few bytes to the
>>> beginning, then a few bytes to the end, save the contents ina file.
>>> After that I fill the rest of the buffer from the beginning till the
>>> end and save the contents again into a file. I write unsigned int
>>> values into it starting with zero counting up to 3999.After this
>>> procedure the buffer should look like this (I indicate the memory
>>> page boundaries according to my test app):
>>> Page1.0.833Page2834.1857Page31858.2881Page42882.3905Page53906.3999
>>> But the content of the buffer looks like this:
>>> Page1.0.833Page22882.3905Page3288 2.3905Page42882.3905Page53906.3999
>>> It seems that the second and third pages, which were not added to the
>>> virtual memory of the process in the first cycle (because I wrote
>>> data only into the address ranges of the first and  fourth pages
>>> then) are &#39;missing", and the content of the fourth page show up
>>> on the address range of the second and third page. I see this strange
>>> behaviour only if I allocate this buffer in a Xenomai thread. If I do
>>> the allocation in the main thread of the process (e.g. in the main()
>>> function) the memory will not be corrupt!If I compile the same source
>>> code to native Linux and running on the same hardware, on the same
>>> kernel, it works fine, no memory corruption can be seen this time
>>> either. I found the following workarounds:WA1.: Initialize the buffer
>>> from the beginning to the end in a linear fashion after allocation
>>> (e.g. writing the bytes one after the other, ensure to add the memory
>>> pages one afte the other to the process).WA2.: Use calloc() instead
>>> of mal loc() which is the same workaround as WA1 wa! s. I am
>>> struggling with this issue since a week. Please help me where to
>>> search for the problem. In Xenomai, in the Linux kernel or in the
>>> stdlib? One more strange thing that I am not sure if it has anything
>>> to do with this issue. I do not get any runtime error if I DON&#39;T
>>> call mlockall()! Why is that? I read somewhere that some libraries
>>> call mlockall() during initialization. Is it true? Thank you,Tamas=20
>>
>>Quite frankly, your mail is unreadable. Could you try and post a clear
>>and readable mail, preferably with a piece of code allowing to
>>reproduce the issue you meet?
>>--=20
>>                                                                Gilles.
>_______________________________________________
>Xenomai mailing list
>Xenomai@xenomai.org
>http://www.xenomai.org/mailman/listinfo/xenomai
