Subject: Re: Memory allocation issue
References: <af17cab0-8dce-e33c-b166-a3c5204a799f@akamina.com>
From: Peter Laurich <Peter.Laurich@akamina.com>
Message-ID: <aa0602f5-a927-f568-d07d-7df0667c717b@akamina.com>
Date: Mon, 1 Mar 2021 10:51:00 -0500
MIME-Version: 1.0
In-Reply-To: <af17cab0-8dce-e33c-b166-a3c5204a799f@akamina.com>
Content-Language: en-CA
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
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

I eventually sorted this one out on my own. In case anyone else is 
puzzled by the problem, here is my solution:

  * there is a default heap size that looks to be somewhere around 1 M.
    If you want more than that, you need to pass --mem-pool-size=<your
    size> as a command line argument when the program is started.
  * if you want multiple programs to share Xenomai objects, you need to
    have the same session. This is also a command line argument
    (--session=<your session>)
  * ALL programs that are to share the heap as well as the same Xenomai
    objects need to include both command line arguments --session= as
    well as --mem-pool-size=
  * I have not sorted out if / how kernel config values such as
    OPT_SHARED_HEAPSZ fit into the puzzle

Sadly, there is no --stop-page-faulting command line argument.

Good luck

Peter

On 2/25/2021 9:30 AM, Peter Laurich via Xenomai wrote:
> Hi,
>
> I am having problems allocating a larger heap using Xenomai 
> rt_heap_create(). The attempt to allocate a heap of size 1.3M fails 
> after having allocated less than 8K from the heap. I have the Xenomai 
> memory configuration limits all set high enough (I think) and even 
> pass the xenomai.sysheap_size=8192 on the kernel command line. My 
> kernel config values for Xenomai are:
>
> #
> # Sizes and static limits
> #
> CONFIG_XENO_OPT_PIPE_NRDEV=64
> CONFIG_XENO_OPT_REGISTRY_NRSLOTS=8196
> CONFIG_XENO_OPT_SYS_HEAPSZ=8192
> CONFIG_XENO_OPT_PRIVATE_HEAPSZ=512
> CONFIG_XENO_OPT_SHARED_HEAPSZ=512
> CONFIG_XENO_OPT_NRTIMERS=1024
>
> Executing the free command reports:
>
>         total  used    free      shared buff/cache   available
> Mem:  1026864 33720  974316        1208       18828 978560
> Swap:       0     0       0
>
> and the output from /proc/xenomai cat heap is:
>
> /proc/xenomai$ cat heap
>   TOTAL      FREE  NAME
> 8388608   8386304  system heap
>  524288    524160  shared heap
>
> I am using Xenomai 3.1 with kernel 4.19.144 on a Cortex A9 Freescale 
> i.MX6DL processor with 1 GB RAM.
>
> I am also having a problem with page faults that may be related so I 
> will include a description of this problem as well. If I reduce my 
> heap requirements so that the rt_heap_create() no longer fails, I can 
> attempt to run another task that uses Analogy to initialize my data 
> acquisition hardware. When I run this task, Xenomai reports multiple 
> switching to secondary mode exceptions that result in 
> SIGDEBUG_MIGRATE_FAULT exceptions. I do have mlockall specified.
>
> Thanks in advance for any suggestions as to what may be causing my 
> heap allocation to fail. If the page fault issue is not related, I can 
> post that problem separately later.
>
> Thanks.
>
> Peter
>
>
