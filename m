References: <e21aeb44-3c45-2233-1da4-fac858e79736@tuebingen.mpg.de>
 <CALLqZ8SfJO1YQk5L2MKR=A2uWwFhqE-pnGGmUhfPtbASpbpYPA@mail.gmail.com>
 <48bf5946-4617-aca5-bb4f-a12ce622f098@tuebingen.mpg.de>
 <CALLqZ8RXP5x_6yyhcGZxXD1g0hNRpEu6v1k4U2pJk0zRevXFBA@mail.gmail.com>
From: Vincent Berenz <vberenz@tuebingen.mpg.de>
Message-ID: <5c370309-bd7c-c789-49e1-8f296697cd0c@tuebingen.mpg.de>
Date: Fri, 12 Jan 2018 18:21:07 +0100
MIME-Version: 1.0
In-Reply-To: <CALLqZ8RXP5x_6yyhcGZxXD1g0hNRpEu6v1k4U2pJk0zRevXFBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Xenomai] heap allocation working for some memory sizes but not
 others
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

You are right, I did put too much trust on our legacy code.
After increasing the heap once more in the kernel configuration and 
creating heap of size higher than the allocated heap, the problem seems 
to be solved.
How much more memory should be created compared to the allocated size 
remains very unclear (at least to me). Adding a few bytes of memory did 
not do the trick. I ended up adding double, which is likely overkill.

Thanks again for your help

Vincent


On 11.01.2018 17:13, Greg Gallagher wrote:
> Hi,
>     So there could be a couple things going on.  First, I'm not sure
> why from 2.6.4 to 3.0.x you are seeing the behavior change, but
> Xenomai 3 is fairly different from 2.6.x.  It could be Xenomai 3 is
> more strict when it comes to heap allocation or the heap code is
> different in Xenomai 3. You are getting EWOULDBLOCK returned from the
> rt_heap_alloc which means that there isn't a block available of
> suitable size.  Instead of allocating the entire heap size try smaller
> sizes in the rt_heap_alloc function and see if you get the same
> result.  The test code uses a 16k heap with 8k allocations. I've only
> briefly looked at the heap code (digging in more now) so I'm not sure
> if it's valid to allocate the entire heap.  Try changing your test to
> allocate less the the actual heap size and see if there is a change.
>
> Thanks
>
> Greg
>
>
> On Thu, Jan 11, 2018 at 9:13 AM, Vincent Berenz
> <vberenz@tuebingen.mpg.de> wrote:
>> Hi Greg,
>>
>> Thanks a lot for your help.
>>
>> Indeed, reading the doc it makes sense to call rt_heap_bind after
>> rt_heap_create. I updated my test code, but our legacy code have been
>> working fine the other way around, though.
>> I also changed the error management to consider 0 as success.
>> But the problem remains, with the output remaining the same.
>>
>> Some more info:
>>
>> - I ran the same code on ubuntu 14.04  / xenomai 2.6.4 and all was fine
>> (prints "OK" for any memory size passed as argument)
>> - indeed when using TM_INFINITE the program hang
>> - code 11 indeed corresponds to EWOULDBLOCK / EAGAIN
>> - if I replace H_SHARE with H_FIFO and H_PRIO, output remains the same
>> - if I replace H_SHARE with H_SINGLE, error code becomes 12 (cannot allocate
>> memory) (but also program still produces "OK" for some memory size, same
>> values as when using H_SHARE)
>> - I compiled the tests, and heap-1 / heap-2 run ok
>>
>> Best
>>
>> Vincent
>>
>>
>>
>> On 10.01.2018 23:38, Greg Gallagher wrote:
>>> Hi,
>>>
>>> You may want to look at this test for help:
>>>
>>> https://git.xenomai.org/xenomai-3.git/tree/lib/alchemy/testsuite/heap-1.c
>>>
>>> I think you should have rt_heap_bind after your call to
>>> rt_heap_create, if you switch the timeout flag in rt_heap_bind to
>>> TM_INFINITE I think you should see your program hang.  From the docs
>>>
>>> (https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alchemy__heap.html#gae17a8784a83d2eec94089a86a831a833)
>>>    on rt_heap_bind it returns 0 on success, and your program treats 0 as
>>> an error.   Print the value of rc after rt_heap_bind returns, it will
>>> probable be -EWOULDBLOCK .
>>>
>>> Thanks
>>>
>>> Greg
>>>
>>> On Wed, Jan 10, 2018 at 4:31 AM, Vincent Berenz
>>> <vberenz@tuebingen.mpg.de> wrote:
>>>> Hi,
>>>>
>>>> We are currently moving from xenomai 2 to xenomai 3. I installed xenomai
>>>> 3.0.5, and all seems to be working, with low latency.
>>>> I am now trying to get our legacy code to work on xenomai 3 using the
>>>> transition kit.
>>>>
>>>> Our program crashes on heap allocation (rt_heap_alloc function) with
>>>> error
>>>> code -11 (resource temporarily unavailable).
>>>>
>>>> The rt_heap_alloc function was called successfully a few times before the
>>>> crash, so I first assumed not enough heap was reserved, so I recompiled
>>>> the
>>>> kernel with more and more heap:
>>>>
>>>> CONFIG_XENO_OPT_SYS_HEAPSZ=524288
>>>>
>>>> This does not solve the issue. We also tried tooling with the
>>>> '--mem-pool-size' argument, with no success.
>>>>
>>>> To check things I created a toy executable which just allocate memory:
>>>>
>>>> --
>>>>
>>>>       void alloc (char *name, int elemSize) {
>>>>
>>>>         rt_printf("allocating for %d | ",elemSize);
>>>>
>>>>         int      rc;
>>>>         RT_HEAP  heap;
>>>>         void    *ptr;
>>>>
>>>>         rc = rt_heap_bind(&heap,name,TM_NONBLOCK);
>>>>         if(!rc) return;
>>>>
>>>>         rc = rt_heap_create(&heap,name,(size_t)(elemSize),H_SHARED);
>>>>         if(rc) return;
>>>>
>>>>         rc = rt_heap_alloc(&heap,(size_t)(elemSize),TM_NONBLOCK,&ptr);
>>>>         if (rc) {
>>>>           printf("%d %s\n",rc,strerror(-rc));
>>>>           return;
>>>>         }
>>>>
>>>>         printf("OK\n");
>>>>         return;
>>>>       }
>>>>
>>>>       int main(int, char** argv){
>>>>
>>>>         int nb_ints = atoi(argv[1]);
>>>>         char *name = "test";
>>>>         alloc(name,nb_ints*sizeof(int));
>>>>
>>>>       }
>>>>
>>>> --
>>>>
>>>>
>>>> The output surprised me: allocation works for some values but not for
>>>> others.
>>>>
>>>>       for((nb_ints=2000;nb_ints<=132000;nb_ints+=2000)); do
>>>> xenomai_heap_test
>>>> $nb_ints; done
>>>>
>>>> results in:
>>>>
>>>>       allocating for 8000 | OK
>>>>       allocating for 16000 | OK
>>>>       [...]
>>>>       allocating for 64000 | OK
>>>>       allocating for 72000 | -11 Resource temporarily unavailable
>>>>       allocating for 80000 | -11 Resource temporarily unavailable
>>>>       allocating for 88000 | OK
>>>>       allocating for 96000 | OK
>>>>       [...]
>>>>       allocating for 128000 | OK
>>>>       allocating for 136000 | -11 Resource temporarily unavailable
>>>>       allocating for 144000 | -11 Resource temporarily unavailable
>>>>       [...]
>>>>       allocating for 168000 | -11 Resource temporarily unavailable
>>>>       allocating for 176000 | OK
>>>>       allocating for 184000 | OK
>>>>       allocating for 192000 | OK
>>>>       allocating for 200000 | OK
>>>>       allocating for 208000 | OK
>>>>       allocating for 216000 | -11 Resource temporarily unavailable
>>>>       allocating for 224000 | -11 Resource temporarily unavailable
>>>>       [...]
>>>>       allocating for 328000 | -11 Resource temporarily unavailable
>>>>       allocating for 336000 | -11 Resource temporarily unavailable
>>>>       allocating for 344000 | OK
>>>>       allocating for 352000 | OK
>>>>       [...]
>>>>       allocating for 384000 | OK
>>>>       allocating for 392000 | -11 Resource temporarily unavailable
>>>>       [...]
>>>>       allocating for 520000 | -11 Resource temporarily unavailable
>>>>       allocating for 528000 | -11 Resource temporarily unavailable
>>>>
>>>> Anything we are doing very wrong ?
>>>>
>>>> Vincent
>>>>
>>>> _______________________________________________
>>>> Xenomai mailing list
>>>> Xenomai@xenomai.org
>>>> https://xenomai.org/mailman/listinfo/xenomai
>>


