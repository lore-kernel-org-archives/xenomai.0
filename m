References: <308568998.3587071.1477532601674.ref@mail.yahoo.com>
 <308568998.3587071.1477532601674@mail.yahoo.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <4004d7e1-d78f-0f97-ee12-d3a33f16400d@xenomai.org>
Date: Mon, 31 Oct 2016 18:40:00 +0100
MIME-Version: 1.0
In-Reply-To: <308568998.3587071.1477532601674@mail.yahoo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] accessing mmap'ed memory causes mode switches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <giuliomoro@yahoo.it>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/27/2016 03:43 AM, Giulio Moro wrote:
> Hello there,
> 
> I am new to the list, I am working on this project
>  https://github.com/BelaPlatform/Bela/ for real-time audio 
> on the BeagleBone Black using Xenomai.
> 
> I am trying to use Xenomai's POSIX skin to create and access
>  shared memory objects, but I am getting mode switches to 
> secondary mode every time I try to access (read or write) the 
> mapped memory, using Xenomai 2.6.3 on Debian ARM Linux 3.8.13r81 
> (https://github.com/RobertCNelson/bb-kernel/tree/3.8.13-xenomai-r81 ).
> I would expect no mode switches to take place once the memory 
> is mapped and accessed at least once.
> Full listing below,
> Notes:
> 
> - I build with 
> gcc -I. shm.c `xeno-config --skin posix --cflags` `xeno-config --skin posix --ldflags`  `xeno-config --skin native --ldflags` -o shm
> which evaluates to 
> gcc -I. shm.c -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -I/usr/xenomai/include/posix -Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread -lrt -lnative -L/usr/xenomai/lib -lxenomai -lpthread -lrt -o shm
> 
> 
> - I tried to explicitly use __wrap_shm_open and __wrap_mmap , no change.
> - I tried with and without the CONFIG_XENO_OPT_POSIX_SHM config line in the kernel, no change.
> - the documentation does not state that O_DIRECT can only be used when CONFIG_XENO_OPT_POSIX_SHM is activated

Xenomai's legacy POSIX shm support available with 2.6 did not bring any
actual upside, and was more or less a wrapper around the regular shm
support. For this reason, it has been dropped in 3.x. You may want to
use the latter directly, even with 2.6.

> - the description of the return values for mmap is wrong in the docs http://www.xenomai.org/documentation/trunk/html/api/group__posix__shm.html : it says it returns 0 on success, while it returns the pointer to the memory.
> 

The documentation is inlined in the source code, issuing patches to
update it is the best way to get it fixed.

> 
> minimal example (does not compile, gives you an idea)
> 
> fd = shm_open(SHM_NAME, O_RDWR | O_CREAT | O_DIRECT, 0);
> size_t len = 40;
> ftruncate(fd, len);void* addr = mmap(ignored, len, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> float* arr = (float*)addr;

No memory reference up to this point anyway.

> //causes mode switches:
> printf("%f\n", arr[n]);
> 

This is due to minor faults, when the memory is there but not referenced
to by a valid PTE in the page table for the current process yet.

Before the 3.10 series, the pipeline used to switch to secondary mode
eagerly upon any kind of page fault including minor ones (see
do_translation_fault() in arm/mm/fault.c), this is what your code is
experiencing with 3.8.

Starting from 3.10 and on, those faults should be transparently handled
by the pipeline, and should not require any transition to secondary mode
for armv6+ CPUs.

In short, you need to upgrade the pipeline code.

-- 
Philippe.

