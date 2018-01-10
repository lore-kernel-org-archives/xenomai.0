From: Vincent Berenz <vberenz@tuebingen.mpg.de>
Message-ID: <e21aeb44-3c45-2233-1da4-fac858e79736@tuebingen.mpg.de>
Date: Wed, 10 Jan 2018 10:31:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [Xenomai] heap allocation working for some memory sizes but not
	others
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

We are currently moving from xenomai 2 to xenomai 3. I installed xenomai 
3.0.5, and all seems to be working, with low latency.
I am now trying to get our legacy code to work on xenomai 3 using the 
transition kit.

Our program crashes on heap allocation (rt_heap_alloc function) with 
error code -11 (resource temporarily unavailable).

The rt_heap_alloc function was called successfully a few times before 
the crash, so I first assumed not enough heap was reserved, so I 
recompiled the kernel with more and more heap:

CONFIG_XENO_OPT_SYS_HEAPSZ=524288

This does not solve the issue. We also tried tooling with the 
'--mem-pool-size' argument, with no success.

To check things I created a toy executable which just allocate memory:

--

     void alloc (char *name, int elemSize) {

       rt_printf("allocating for %d | ",elemSize);

       int      rc;
       RT_HEAP  heap;
       void    *ptr;

       rc = rt_heap_bind(&heap,name,TM_NONBLOCK);
       if(!rc) return;

       rc = rt_heap_create(&heap,name,(size_t)(elemSize),H_SHARED);
       if(rc) return;

       rc = rt_heap_alloc(&heap,(size_t)(elemSize),TM_NONBLOCK,&ptr);
       if (rc) {
         printf("%d %s\n",rc,strerror(-rc));
         return;
       }

       printf("OK\n");
       return;
     }

     int main(int, char** argv){

       int nb_ints = atoi(argv[1]);
       char *name = "test";
       alloc(name,nb_ints*sizeof(int));

     }

--


The output surprised me: allocation works for some values but not for 
others.

     for((nb_ints=2000;nb_ints<=132000;nb_ints+=2000)); do 
xenomai_heap_test $nb_ints; done

results in:

     allocating for 8000 | OK
     allocating for 16000 | OK
     [...]
     allocating for 64000 | OK
     allocating for 72000 | -11 Resource temporarily unavailable
     allocating for 80000 | -11 Resource temporarily unavailable
     allocating for 88000 | OK
     allocating for 96000 | OK
     [...]
     allocating for 128000 | OK
     allocating for 136000 | -11 Resource temporarily unavailable
     allocating for 144000 | -11 Resource temporarily unavailable
     [...]
     allocating for 168000 | -11 Resource temporarily unavailable
     allocating for 176000 | OK
     allocating for 184000 | OK
     allocating for 192000 | OK
     allocating for 200000 | OK
     allocating for 208000 | OK
     allocating for 216000 | -11 Resource temporarily unavailable
     allocating for 224000 | -11 Resource temporarily unavailable
     [...]
     allocating for 328000 | -11 Resource temporarily unavailable
     allocating for 336000 | -11 Resource temporarily unavailable
     allocating for 344000 | OK
     allocating for 352000 | OK
     [...]
     allocating for 384000 | OK
     allocating for 392000 | -11 Resource temporarily unavailable
     [...]
     allocating for 520000 | -11 Resource temporarily unavailable
     allocating for 528000 | -11 Resource temporarily unavailable

Anything we are doing very wrong ?

Vincent

