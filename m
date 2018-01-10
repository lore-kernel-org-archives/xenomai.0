MIME-Version: 1.0
In-Reply-To: <e21aeb44-3c45-2233-1da4-fac858e79736@tuebingen.mpg.de>
References: <e21aeb44-3c45-2233-1da4-fac858e79736@tuebingen.mpg.de>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 10 Jan 2018 17:38:35 -0500
Message-ID: <CALLqZ8SfJO1YQk5L2MKR=A2uWwFhqE-pnGGmUhfPtbASpbpYPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Vincent Berenz <vberenz@tuebingen.mpg.de>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

You may want to look at this test for help:

https://git.xenomai.org/xenomai-3.git/tree/lib/alchemy/testsuite/heap-1.c

I think you should have rt_heap_bind after your call to
rt_heap_create, if you switch the timeout flag in rt_heap_bind to
TM_INFINITE I think you should see your program hang.  From the docs
(https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alchemy__heap.html#gae17a8784a83d2eec94089a86a831a833)
 on rt_heap_bind it returns 0 on success, and your program treats 0 as
an error.   Print the value of rc after rt_heap_bind returns, it will
probable be -EWOULDBLOCK .

Thanks

Greg

On Wed, Jan 10, 2018 at 4:31 AM, Vincent Berenz
<vberenz@tuebingen.mpg.de> wrote:
> Hi,
>
> We are currently moving from xenomai 2 to xenomai 3. I installed xenomai
> 3.0.5, and all seems to be working, with low latency.
> I am now trying to get our legacy code to work on xenomai 3 using the
> transition kit.
>
> Our program crashes on heap allocation (rt_heap_alloc function) with error
> code -11 (resource temporarily unavailable).
>
> The rt_heap_alloc function was called successfully a few times before the
> crash, so I first assumed not enough heap was reserved, so I recompiled the
> kernel with more and more heap:
>
> CONFIG_XENO_OPT_SYS_HEAPSZ=524288
>
> This does not solve the issue. We also tried tooling with the
> '--mem-pool-size' argument, with no success.
>
> To check things I created a toy executable which just allocate memory:
>
> --
>
>     void alloc (char *name, int elemSize) {
>
>       rt_printf("allocating for %d | ",elemSize);
>
>       int      rc;
>       RT_HEAP  heap;
>       void    *ptr;
>
>       rc = rt_heap_bind(&heap,name,TM_NONBLOCK);
>       if(!rc) return;
>
>       rc = rt_heap_create(&heap,name,(size_t)(elemSize),H_SHARED);
>       if(rc) return;
>
>       rc = rt_heap_alloc(&heap,(size_t)(elemSize),TM_NONBLOCK,&ptr);
>       if (rc) {
>         printf("%d %s\n",rc,strerror(-rc));
>         return;
>       }
>
>       printf("OK\n");
>       return;
>     }
>
>     int main(int, char** argv){
>
>       int nb_ints = atoi(argv[1]);
>       char *name = "test";
>       alloc(name,nb_ints*sizeof(int));
>
>     }
>
> --
>
>
> The output surprised me: allocation works for some values but not for
> others.
>
>     for((nb_ints=2000;nb_ints<=132000;nb_ints+=2000)); do xenomai_heap_test
> $nb_ints; done
>
> results in:
>
>     allocating for 8000 | OK
>     allocating for 16000 | OK
>     [...]
>     allocating for 64000 | OK
>     allocating for 72000 | -11 Resource temporarily unavailable
>     allocating for 80000 | -11 Resource temporarily unavailable
>     allocating for 88000 | OK
>     allocating for 96000 | OK
>     [...]
>     allocating for 128000 | OK
>     allocating for 136000 | -11 Resource temporarily unavailable
>     allocating for 144000 | -11 Resource temporarily unavailable
>     [...]
>     allocating for 168000 | -11 Resource temporarily unavailable
>     allocating for 176000 | OK
>     allocating for 184000 | OK
>     allocating for 192000 | OK
>     allocating for 200000 | OK
>     allocating for 208000 | OK
>     allocating for 216000 | -11 Resource temporarily unavailable
>     allocating for 224000 | -11 Resource temporarily unavailable
>     [...]
>     allocating for 328000 | -11 Resource temporarily unavailable
>     allocating for 336000 | -11 Resource temporarily unavailable
>     allocating for 344000 | OK
>     allocating for 352000 | OK
>     [...]
>     allocating for 384000 | OK
>     allocating for 392000 | -11 Resource temporarily unavailable
>     [...]
>     allocating for 520000 | -11 Resource temporarily unavailable
>     allocating for 528000 | -11 Resource temporarily unavailable
>
> Anything we are doing very wrong ?
>
> Vincent
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

