Message-ID: <5549D15A.6060601@free.fr>
Date: Wed, 06 May 2015 10:31:22 +0200
From: =?UTF-8?B?U3TDqXBoYW5lIEFOQ0VMT1Q=?= <sancelot@free.fr>
MIME-Version: 1.0
References: <553FAC36.3050803@free.fr> <553FC281.70308@xenomai.org>
 <5541D505.2000109@free.fr> <5541E930.30000@xenomai.org>
 <5542205E.5080302@free.fr> <5548C7A4.5030309@free.fr>
 <20150505172113.GO1993@hermes.click-hack.org> <5549CEFE.6070000@free.fr>
 <20150506082624.GU1993@hermes.click-hack.org>
In-Reply-To: <20150506082624.GU1993@hermes.click-hack.org>
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

On 06/05/2015 10:26, Gilles Chanteperdrix wrote:
> On Wed, May 06, 2015 at 10:21:18AM +0200, Stéphane ANCELOT wrote:
>>      size = 824; // size = 824 is failing but changing size to 3200 rocks ...
>>      // --------------------------------------------------------------
>>      ret = rt_heap_create(&heap2, "config", size, flags);
>>      traceobj_assert(&trobj, ret == 0);
> The interesting call to rt_heap_inquire would go here.
>
> All the other ones are irrelevant.
>
> Also, have you tried directly creating the heap with the failing
> size instead of doing it after creating many useless heaps? Just to
> reduce the test case.
>
>
>>      cout << " heap size : " << info.heapsize << " heap usablemem: " <<
>> info.usablemem;
> The value you print here do not correspond to the heap you just
> created. What is the point of this ?
>
>>      ret = rt_heap_alloc(&heap2, size, TM_INFINITE, &p);
>>      traceobj_assert(&trobj, ret == 0);
>>
>>      exit(0);
>> }
>>
>>
You are right, reducing the test case, and using this size reports the 
problem :




output:
root@debian:/home/macsoft# ./heap_regression
    0"002.074| BUG: [main] trace assertion failed:
../heap_test.cpp:34 => "ret == 0"


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

static RT_HEAP  heap2;
RT_HEAP_INFO info;

int main(int argc, char *const argv[])
{
     int ret;
     void *p;
     int size;

     traceobj_init(&trobj, argv[0], 0);
     int flags;
     flags = H_FIFO ;


     size = 824; // size = 824 is failing but changing size to 3200 
rocks ...
     // --------------------------------------------------------------
     ret = rt_heap_create(&heap2, "config", size, flags);
     traceobj_assert(&trobj, ret == 0);

     ret = rt_heap_inquire(&heap2,&info);
     traceobj_assert(&trobj, ret == 0);
     cout << " heap size : " << info.heapsize << " heap usablemem: " << 
info.usablemem;

     ret = rt_heap_alloc(&heap2, size, TM_INFINITE, &p);
     traceobj_assert(&trobj, ret == 0);


     exit(0);
}

