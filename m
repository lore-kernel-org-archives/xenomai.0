Message-ID: <5165E85B.2040609@xenomai.org>
Date: Thu, 11 Apr 2013 00:31:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <FD5EBA50-E222-4012-A755-A20FF5D5971D@mah.priv.at>
In-Reply-To: <FD5EBA50-E222-4012-A755-A20FF5D5971D@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] shared memory compatibility - advice sought
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org

On 04/10/2013 11:24 PM, Michael Haberler wrote:

> I am building an RT application which is portable across RTAI,
> Xenomai/userland threads, Xenomai/kernel threads, RT-preempt and
> vanilla kernels (modulo timing restrictions). The xenomai kernel
> threads build is on a deprecation path but build for coverage reasons
> atm.
> 
> The application already does support several instances on one
> machine, for instance one instance could be Xenomai kernel threads, a
> second one Xenomai user threads, a third one Posix threads (thats an
> example and doesnt make sense, just pointing out whats possible)
> 
> The userland threads instances uses sysvipc shm; RTAI instance uses
> rtai_malloc/rtai_kmalloc; Xenomai kernel uses
> rt_heap_create/rt_heap_alloc.
> 
> --
> 
> A requirement has come up to enable access of shared memory between
> instances and that's where I dont know how to proceed - the issues I
> have are:
> 
> - incompatible shared memory models between RTAI, Xenomai and
> shmctl() - sequencing imposed by kernel threads models - shared
> memory must be created in-kernel and can attached to in userland but
> not vice versa
> 
> I know it is a faint hope, let me try nevertheless:
> 
> - is there a way to make Xenomai kernel threads use shared memory
> created in userland by shmctl(2) or mmap for that matter


RTDM skin (the future-proof way):
rtdm_mmap_to_user will allow you to map a piece of memory (obtained for
instance with kmalloc or even vmalloc in kernel-space), in a process
user-space. You have to devise the interactions between user and
kernel-space through a driver if you want the user-space to seem to do
the allocation first.


Posix skin (probably the easiest but deprecated way):
The Xenomai posix skin shared memories are useful expressly for that
(corner) case, which is the reason you will find them usually disabled
in your kernel configuration. If you enable them, the API is the POSIX
shared memory API, that is shm_open/ftruncate/mmap. The first shm_open
with O_CREAT creates the shared memory, whether in kernel-space or
user-space.

Note that if you need to share mutexes or semaphores between kernel and
user-space, the anonymous sem_t and pthread_mutex_t you put on the
shared memory can be shared too. You can also use named semaphores
(sem_open).

At the time when you drop kernel-space applications (as opposed to
drivrs), you disable the posix skin shared memory option in kernel
configuration, and Xenomai posix skin user-space threads will use Linux
regular shared memory, without even needing a recompilation of the
application.


Native skin (another a bit less easy deprecated way):
In the same vein, rt_heap_create can be used both from kernel and
user-space, and will create a shared memory if you pass the H_SHARED
parameter. rt_heap_bind can only be called from user-space, so, if you
want to seem to create the heap in user-space, you have to devise
interactions between kernel and user most probably through an RTDM driver.


Note 1: the POSIX API is available in all the cases you want to cover,
maybe the shm_open/ftruncate/mmap API is missing in RTAI case, but you
would probably be better implementing this missing support by wrapping
existing RTAI shared memory services, rather than inventing an
abstraction layer above all the cases. But I may be biased because I
wrote part of the POSIX API in Xenomai.

Note 2: Xenomai takes care of the architecture dependent troubles you
get by sharing memory between kernel-space and user-space on an ARM
processor with VIVT cache.

-- 
                                                                Gilles.

