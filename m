Date: Mon, 31 Oct 2016 18:12:58 +0000 (UTC)
From: Giulio Moro <giuliomoro@yahoo.it>
Message-ID: <676757176.2746476.1477937578868@mail.yahoo.com>
In-Reply-To: <4004d7e1-d78f-0f97-ee12-d3a33f16400d@xenomai.org>
References: <308568998.3587071.1477532601674.ref@mail.yahoo.com>
 <308568998.3587071.1477532601674@mail.yahoo.com>
 <4004d7e1-d78f-0f97-ee12-d3a33f16400d@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] accessing mmap'ed memory causes mode switches
Reply-To: Giulio Moro <giuliomoro@yahoo.it>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks Philippe,

>> //causes mode switches:
>> rt_printf("%f\n", arr[n]);
>> 
>
>This is due to minor faults, when the memory is there but not referenced
>to by a valid PTE in the page table for the current process yet.
>
>Before the 3.10 series, the pipeline used to switch to secondary mode
>eagerly upon any kind of page fault including minor ones (see
>do_translation_fault() in arm/mm/fault.c), this is what your code is
>experiencing with 3.8.
>
>Starting from 3.10 and on, those faults should be transparently handled
>by the pipeline, and should not require any transition to secondary mode
>for armv6+ CPUs.
>
>In short, you need to upgrade the pipeline code.


I noticed that the mode switch happens over and over again even when accessing the same memory location multiple times.
e.g., this code will cause 10 mode switches:

for(j = 0; j < 10; ++j){
  arr[0] = 1.f; // switches to secondary mode
  rt_task_sleep(200000000);  // sleep, switches to primary mode
}

Is this phenomenon still explained by the issue in pre-3.10 you outlined ?

Thanks,
Giulio

