MIME-Version: 1.0
In-Reply-To: <526B99CD.3080303@xenomai.org>
References: <526B99CD.3080303@xenomai.org>,
 <OF415A91C1.3CB4977D-ON85257C0F.0078CAEF-85257C0F.0078CB7B@moog.com>
From: George Broz <GBroz@moog.com>
Message-ID: <OF4C4FACAC.0349F48E-ON85257C11.005CE00C-85257C11.005CE031@moog.com>
Date: Sun, 27 Oct 2013 12:54:28 -0400
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
Subject: Re: [Xenomai] rt_heap_alloc priority inversion
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: rpm@xenomai.org
Cc: Xenomai@xenomai.org

-----Philippe Gerum <rpm@xenomai.org> wrote: -----
>
>On 10/25/2013 11:59 PM, George Broz wrote:
>> Hello All,
>>
>> I'm running Linux 2.6.37.6 w/Xenomai 2.6.1, native API
>> on x86 (Atom, SMP, 32-bit).
>>
>> I have two tasks, both running in Xenomai user-space.
>> One is priority=3D99 and blocks on rt=5Fintr=5Fwait(),
>> running every 250 us with 125us margin. This task does
>> not make direct calls to rt=5Fheap=5Falloc/free().
>>
>> The other task is priority=3D50, wakes 1msec, sleeps 1msec.
>> This task routinely makes rt=5Fheap=5Falloc/free calls.
>>
>> When the priority=3D50 task makes rt=5Fheap=5Falloc() calls
>> for "size" greater than 5 MB, the priority=3D99 task
>> appears to be held off from executing for several ms.
>>
>> Plenty of memory is available (vmalloc=3D320M as linux
>> boot arg).
>
>The size that matters in how much memory you assigned to the heap in
>
>rt=5Fheap=5Fcreate().

Yes, sorry. Passing 256 MB (as 268,435,456) to rt=5Fheap=5Fcreate().

>
>  TM=5FNONBLOCK is used when calling
>> rt=5Fheap=5Falloc(). Both "0" and H=5FPRIO have been tried
>> for "mode" when creating the area with rt=5Fheap=5Fcreate().
>>
>> Is this expected behavior?
>>
>> How can large memory allocations be built without a
>> "realloc" equivalent offered in the memory heap
>> services?
>>
>>
>
>There is no reallocation in the rt heap services, ever. If H=5FSINGLE
>was=20
>passed to rt=5Fheap=5Fcreate(), there is not even any "allocation", the=20
>address of the heap memory is returned in that case, as it is viewed
>as=20
>a single buffer.
>
>Assuming you don't pass H=5FSINGLE when creating the heap,=20


We're not passing H=5FSINGLE when creating the heap. The only mode flag=20
passed to =5Fcreate() is H=5FPRIO or H=5FFIFO ("0") - have tried both,=20
and resulting behavior is the same.


>the only reason=20
>to get delays in non-blocking allocation mode would be that a minor
>VM=20
>fault unexpectedly happens when the 5MB block is being pulled from
>the=20
>heap, when writing our meta-data to that memory area. That would mean
>
>that your calling thread switches to secondary mode for handling the
>
>fault, and gets delayed for this reason.
>
>You should first try checking this assumption, by enabling T=5FWARNSW
>for=20
>your thread. If this is confirmed, then there could be something
>wrong=20
>in the i-pipe layer for your kernel release.

We always run with T=5FWARNSW turned on for the Xenomai tasks that
should never switch to secondary. A backtrace is generated if=20
a secondary transition occurs. We have used this mechanism=20
extensively in our development. When we attempt to allocate=20
5 MB, neither the calling task (prio=3D50), nor the high priority
task (prio=3D99) that gets held off logs a secondary mode=20
transition.


Going a step further, we can run in "simulation" mode where the
hardware interrupt source (on which rt=5Fintr=5Fwait() is waiting)=20
is replaced with rt=5Ftask=5Fset=5Fperiodic()/rt=5Ftask=5Fwait=5Fperiod()
and the same behavior results.

Any ideas?

>
>--=20
>Philippe.


Thanks for your help! Much appreciated!
--George=


