Message-ID: <5549CEFE.6070000@free.fr>
Date: Wed, 06 May 2015 10:21:18 +0200
From: =?UTF-8?B?U3TDqXBoYW5lIEFOQ0VMT1Q=?= <sancelot@free.fr>
MIME-Version: 1.0
References: <553FAC36.3050803@free.fr> <553FC281.70308@xenomai.org>
 <5541D505.2000109@free.fr> <5541E930.30000@xenomai.org>
 <5542205E.5080302@free.fr> <5548C7A4.5030309@free.fr>
 <20150505172113.GO1993@hermes.click-hack.org>
In-Reply-To: <20150505172113.GO1993@hermes.click-hack.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] xenomai 3.0rc4 rt_heap_alloc replies with timeout
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/05/2015 19:21, Gilles Chanteperdrix wrote:
> On Tue, May 05, 2015 at 03:37:40PM +0200, Stéphane ANCELOT wrote:
>> Hi,
>> unfortunately, There is something wrong for unknown reason using these
>> functions.
>>
>> I made a simple regression program that only create heaps and allocates
>> area.
>>
>> At line 190 of the file, depending on the size value of the heap, the
>> program works or not.
>> This looks like corrupted memory problem...
> I do not see anything in your reports would could make think of a
> corrupted memory problem. Are you sure this is not simply a problem
> in the overhead calculation? Have you tried to call rt_heap_inquire
> between rt_heap_create and rt_heap_alloc to see if the usablemem
> field shows a big enough value?
>
have a look at the program and the execution. I am a bit surprised that 
available usablemem is greater than heap size .

execution :
    0"002.800| BUG: [main] trace assertion failed:
../heap_test.cpp:251 => "ret == 0"
  heap size : 36800 heap usablemem: 37376
  heap size : 36800 heap usablemem: 37376
heap size : 36800 heap usablemem: 37376
heap size : 36800 heap usablemem: 37376
heap size : 36800 heap usablemem: 37376
heap size : 36800 heap usablemem: 37376
heap size : 36800 heap usablemem: 37376
heap size : 36800 heap usablemem: 37376
heap size : 36800 heap usablemem: 37376
heap size : 36800 heap usablemem: 37376
heap size : 36800 heap usablemem: 37376
heap size : 36800 heap usablemem: 37376
heap size : 36800 heap usablemem: 37376
  heap size : 36800 heap usablemem: 37376
heap size : 36800 heap usablemem: 37376
  heap size : 36800 heap usablemem: 37376
heap size : 36800 heap usablemem: 37376
heap size : 36800 heap usablemem: 37376
heap size : 36800 heap usablemem: 37376
heap size : 36800 heap usablemem: 37376


program:
#include <iostream>
#include <stdlib.h>
#include <copperplate/traceobj.h>
#include <alchemy/task.h>
#include <alchemy/heap.h>
#include <alchemy/queue.h>

#define HEAPSIZE  16384
#define MSGSIZE   16
#define NMESSAGES (HEAPSIZE / MSGSIZE)
#define POOLSIZE  (NMESSAGES * sizeof(void *))

static struct traceobj trobj;

using namespace std;

static RT_HEAP heap1, heap2;
RT_HEAP_INFO info;

int main(int argc, char *const argv[])
{
     int ret;
     void *p;
     int size;

     traceobj_init(&trobj, argv[0], 0);
     int flags;
     flags = H_FIFO ;
     size = 36800;
     ret = rt_heap_create(&heap2, "progauto1", size, flags);
     traceobj_assert(&trobj, ret == 0);

     ret = rt_heap_inquire(&heap2,&info);
     traceobj_assert(&trobj, ret == 0);

     cout << " heap size : " << info.heapsize << " heap usablemem: " << 
info.usablemem;

     ret = rt_heap_alloc(&heap2, size, TM_INFINITE, &p);
     traceobj_assert(&trobj, ret == 0);

     // --------------------------------------------------------------
     ret = rt_heap_create(&heap2, "progauto_simulation1", size, flags);
     traceobj_assert(&trobj, ret == 0);

     ret = rt_heap_inquire(&heap2,&info);
     traceobj_assert(&trobj, ret == 0);
     cout << " heap size : " << info.heapsize << " heap usablemem: " << 
info.usablemem;

     ret = rt_heap_alloc(&heap2, size, TM_INFINITE, &p);
     traceobj_assert(&trobj, ret == 0);

     // --------------------------------------------------------------
     ret = rt_heap_create(&heap2, "progauto2", size, flags);
     traceobj_assert(&trobj, ret == 0);

     ret = rt_heap_inquire(&heap2,&info);
     traceobj_assert(&trobj, ret == 0);
     cout << " heap size : " << info.heapsize << " heap usablemem: " << 
info.usablemem;

     ret = rt_heap_alloc(&heap2, size, TM_INFINITE, &p);
     traceobj_assert(&trobj, ret == 0);

     // --------------------------------------------------------------
     ret = rt_heap_create(&heap2, "progauto_simulation2", size, flags);
     traceobj_assert(&trobj, ret == 0);

     ret = rt_heap_inquire(&heap2,&info);
     traceobj_assert(&trobj, ret == 0);
     cout << " heap size : " << info.heapsize << " heap usablemem: " << 
info.usablemem;

     ret = rt_heap_alloc(&heap2, size, TM_INFINITE, &p);
     traceobj_assert(&trobj, ret == 0);

     // --------------------------------------------------------------
     ret = rt_heap_create(&heap2, "progauto3", size, flags);
     traceobj_assert(&trobj, ret == 0);

     ret = rt_heap_inquire(&heap2,&info);
     traceobj_assert(&trobj, ret == 0);
     cout << " heap size : " << info.heapsize << " heap usablemem: " << 
info.usablemem;

     ret = rt_heap_alloc(&heap2, size, TM_INFINITE, &p);
     traceobj_assert(&trobj, ret == 0);

     // --------------------------------------------------------------
     ret = rt_heap_create(&heap2, "progauto_simulation3", size, flags);
     traceobj_assert(&trobj, ret == 0);

     ret = rt_heap_inquire(&heap2,&info);
     traceobj_assert(&trobj, ret == 0);
     cout << " heap size : " << info.heapsize << " heap usablemem: " << 
info.usablemem;

     ret = rt_heap_alloc(&heap2, size, TM_INFINITE, &p);
     traceobj_assert(&trobj, ret == 0);


     // --------------------------------------------------------------
     ret = rt_heap_create(&heap2, "progauto4", size, flags);
     traceobj_assert(&trobj, ret == 0);

     ret = rt_heap_inquire(&heap2,&info);
     traceobj_assert(&trobj, ret == 0);
     cout << " heap size : " << info.heapsize << " heap usablemem: " << 
info.usablemem;

     ret = rt_heap_alloc(&heap2, size, TM_INFINITE, &p);
     traceobj_assert(&trobj, ret == 0);

     // --------------------------------------------------------------
     ret = rt_heap_create(&heap2, "progauto_simulation4", size, flags);
     traceobj_assert(&trobj, ret == 0);

     ret = rt_heap_inquire(&heap2,&info);
     traceobj_assert(&trobj, ret == 0);
     cout << " heap size : " << info.heapsize << " heap usablemem: " << 
info.usablemem;

     ret = rt_heap_alloc(&heap2, size, TM_INFINITE, &p);
     traceobj_assert(&trobj, ret == 0);


     // --------------------------------------------------------------
     ret = rt_heap_create(&heap2, "progauto5", size, flags);
     traceobj_assert(&trobj, ret == 0);

     ret = rt_heap_inquire(&heap2,&info);
     traceobj_assert(&trobj, ret == 0);
     cout << " heap size : " << info.heapsize << " heap usablemem: " << 
info.usablemem;

     ret = rt_heap_alloc(&heap2, size, TM_INFINITE, &p);
     traceobj_assert(&trobj, ret == 0);

     // --------------------------------------------------------------
     ret = rt_heap_create(&heap2, "progauto_simulation5", size, flags);
     traceobj_assert(&trobj, ret == 0);

     ret = rt_heap_inquire(&heap2,&info);
     traceobj_assert(&trobj, ret == 0);
     cout << " heap size : " << info.heapsize << " heap usablemem: " << 
info.usablemem;

     ret = rt_heap_alloc(&heap2, size, TM_INFINITE, &p);
     traceobj_assert(&trobj, ret == 0);


     // --------------------------------------------------------------
     ret = rt_heap_create(&heap2, "progauto6", size, flags);
     traceobj_assert(&trobj, ret == 0);

     ret = rt_heap_inquire(&heap2,&info);
     traceobj_assert(&trobj, ret == 0);
     cout << " heap size : " << info.heapsize << " heap usablemem: " << 
info.usablemem;

     ret = rt_heap_alloc(&heap2, size, TM_INFINITE, &p);
     traceobj_assert(&trobj, ret == 0);

     // --------------------------------------------------------------
     ret = rt_heap_create(&heap2, "progauto_simulation6", size, flags);
     traceobj_assert(&trobj, ret == 0);

     ret = rt_heap_inquire(&heap2,&info);
     traceobj_assert(&trobj, ret == 0);
     cout << " heap size : " << info.heapsize << " heap usablemem: " << 
info.usablemem;


     ret = rt_heap_alloc(&heap2, size, TM_INFINITE, &p);
     traceobj_assert(&trobj, ret == 0);


     // --------------------------------------------------------------
     ret = rt_heap_create(&heap2, "progauto7", size, flags);
     traceobj_assert(&trobj, ret == 0);

     ret = rt_heap_alloc(&heap2, size, TM_INFINITE, &p);
     traceobj_assert(&trobj, ret == 0);
     cout << " heap size : " << info.heapsize << " heap usablemem: " << 
info.usablemem;

     // --------------------------------------------------------------
     ret = rt_heap_create(&heap2, "progauto_simulation7", size, flags);
     traceobj_assert(&trobj, ret == 0);

     ret = rt_heap_alloc(&heap2, size, TM_INFINITE, &p);
     traceobj_assert(&trobj, ret == 0);
     cout << " heap size : " << info.heapsize << " heap usablemem: " << 
info.usablemem;


     // --------------------------------------------------------------
     ret = rt_heap_create(&heap2, "progauto8", size, flags);
     traceobj_assert(&trobj, ret == 0);

     ret = rt_heap_alloc(&heap2, size, TM_INFINITE, &p);
     traceobj_assert(&trobj, ret == 0);

     // --------------------------------------------------------------
     ret = rt_heap_create(&heap2, "progauto_simulation8", size, flags);
     traceobj_assert(&trobj, ret == 0);

     ret = rt_heap_alloc(&heap2, size, TM_INFINITE, &p);
     traceobj_assert(&trobj, ret == 0);
     cout << " heap size : " << info.heapsize << " heap usablemem: " << 
info.usablemem;

     // --------------------------------------------------------------
     ret = rt_heap_create(&heap2, "progauto9", size, flags);
     traceobj_assert(&trobj, ret == 0);

     ret = rt_heap_alloc(&heap2, size, TM_INFINITE, &p);
     traceobj_assert(&trobj, ret == 0);

     // --------------------------------------------------------------
     ret = rt_heap_create(&heap2, "progauto_simulation9", size, flags);
     traceobj_assert(&trobj, ret == 0);

     ret = rt_heap_alloc(&heap2, size, TM_INFINITE, &p);
     traceobj_assert(&trobj, ret == 0);
     cout << " heap size : " << info.heapsize << " heap usablemem: " << 
info.usablemem;

     // --------------------------------------------------------------
     ret = rt_heap_create(&heap2, "progauto10", size, flags);
     traceobj_assert(&trobj, ret == 0);
     cout << " heap size : " << info.heapsize << " heap usablemem: " << 
info.usablemem;

     ret = rt_heap_alloc(&heap2, size, TM_INFINITE, &p);
     traceobj_assert(&trobj, ret == 0);

     // --------------------------------------------------------------
     ret = rt_heap_create(&heap2, "progauto_simulation10", size, flags);
     traceobj_assert(&trobj, ret == 0);

     ret = rt_heap_alloc(&heap2, size, TM_INFINITE, &p);
     traceobj_assert(&trobj, ret == 0);
     cout << " heap size : " << info.heapsize << " heap usablemem: " << 
info.usablemem;

     size = 110400;
     // --------------------------------------------------------------
     ret = rt_heap_create(&heap2, "defprog", size, flags);
     traceobj_assert(&trobj, ret == 0);

     ret = rt_heap_alloc(&heap2, size, TM_INFINITE, &p);
     traceobj_assert(&trobj, ret == 0);
     cout << " heap size : " << info.heapsize << " heap usablemem: " << 
info.usablemem;

     size = 3200;
     // --------------------------------------------------------------
     ret = rt_heap_create(&heap2, "tempo", size, flags);
     traceobj_assert(&trobj, ret == 0);

     ret = rt_heap_alloc(&heap2, size, TM_INFINITE, &p);
     traceobj_assert(&trobj, ret == 0);
     cout << " heap size : " << info.heapsize << " heap usablemem: " << 
info.usablemem;

     size = 824; // size = 824 is failing but changing size to 3200 
rocks ...
     // --------------------------------------------------------------
     ret = rt_heap_create(&heap2, "config", size, flags);
     traceobj_assert(&trobj, ret == 0);
     cout << " heap size : " << info.heapsize << " heap usablemem: " << 
info.usablemem;

     ret = rt_heap_alloc(&heap2, size, TM_INFINITE, &p);
     traceobj_assert(&trobj, ret == 0);

     exit(0);
}



