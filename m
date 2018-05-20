From: Philippe Gerum <rpm@xenomai.org>
References: <bd6a8257-9986-df8b-182d-b1b5d41e3a2a@xenomai.org>
Message-ID: <41222b4c-b99c-2745-f1df-f00785c52104@xenomai.org>
Date: Sun, 20 May 2018 20:15:34 +0200
MIME-Version: 1.0
In-Reply-To: <bd6a8257-9986-df8b-182d-b1b5d41e3a2a@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Performance issue with memory allocators
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 04/27/2018 08:23 PM, Philippe Gerum wrote:
> 
> After a comprehensive series of tests, it is now obvious that
> heapobj-pshared has gruesome performances when releasing bursts of
> small-sized objects. Allocation of large objects is not particularly
> efficient either, although not as bad. The Cobalt core allocator is
> affected by the same bug too.
> 
> Those new tests are available from the wip/heapmem branch, they are
> based on the smokey framework (e.g. smokey --run=memory_* --verbose=2).
> 
> Work is ongoing into the wip/heapmem branch to fix the mess, first
> addressing the issue with the core (in-kernel) allocator,
> heapobj-pshared next. Please note that wip/heapmem is a development
> branch I'm working on for testing improvements - hopefully - to the
> memory allocators, which should not be used in production.
> 
> I would strongly recommend that users running single-process
> applications - i.e. not needing the shared heap feature - make sure to
> turn off heapobj-pshared when configuring, by passing --disable-pshared
> to the configuration script (or leave the feature to the default off state).
> 

The situation is now fixed in the -next branch for the core (in kernel)
heap manager. A set of smokey tests exercising and benchmarking all
memory allocators has been merged too. They may run from seconds to
several minutes depending on the processing horsepower available with
the platform [1]. Reducing the number of allocation rounds for running a
memory pattern check with random block sizes helps in limiting the test
duration. e.g.

~ # smokey --run=memory_coreheap --verbose=2 random_alloc_rounds=16
== memcheck started on coreheap at Thu Jan  1 01:21:50 1970

     seq_heap_size=2048k
     random_alloc_rounds=16
     pattern_heap_size=128k
     pattern_check_rounds=128

heapmem is a new user-space allocator which is currently used as a
drop-in replacement for TLSF in this branch. This is mainly a workhorse
code I used for refining the new allocation algorithm, which is now
implemented by the Cobalt core for managing its memory heaps. It may or
may not be kept, depending on a general consensus about the matter.
Passing --with-localmem=tlsf when configuring reverts this setting,
switching back to TLSF for managing process local memory.

coreheap is the nickname of the in-kernel allocator (aka xnheap).
CONFIG_XENO_DRIVERS_HEAPCHECK must be enabled in the Kconfig to run the
corresponding smokey test.

As the benchmark figures show when running 'memory_pshared', the shared
memory allocator still needs to be fixed. This is next on my list.

Whether those major fixes should be backported to the -stable branch at
some point is an open question. The results obtained from the test and
benchmarking suite mentioned earlier should help in deciding about this
issue.

[1] # smokey --list=memory*
#6   memory_coreheap
	Check for the Cobalt core allocator sanity.
	seq_heap_size=<size[K|M|G]>	max. heap size for sequential alloc tests
	pattern_heap_size=<size[K|M|G]>	max. heap size for pattern check test
	random_alloc_rounds=<N>		# of rounds of random-size allocations
	pattern_check_rounds=<N>	# of rounds of pattern check tests
	max_results=<N>	# of result lines (worst-case first, -1=all)
	Set --verbose=2 for detailed runtime statistics.

#7   memory_heapmem
	Check for the heapmem allocator sanity.
	seq_heap_size=<size[K|M|G]>	max. heap size for sequential alloc tests
	pattern_heap_size=<size[K|M|G]>	max. heap size for pattern check test
	random_alloc_rounds=<N>		# of rounds of random-size allocations
	pattern_check_rounds=<N>	# of rounds of pattern check tests
	max_results=<N>	# of result lines (worst-case first, -1=all)
	Set --verbose=2 for detailed runtime statistics.

#8   memory_tlsf
	Check for the TLSF allocator sanity.
	seq_heap_size=<size[K|M|G]>	max. heap size for sequential alloc tests
	pattern_heap_size=<size[K|M|G]>	max. heap size for pattern check test
	random_alloc_rounds=<N>		# of rounds of random-size allocations
	pattern_check_rounds=<N>	# of rounds of pattern check tests
	max_results=<N>	# of result lines (worst-case first, -1=all)
	Set --verbose=2 for detailed runtime statistics.

#26  memory_pshared
	Check for the pshared allocator sanity.
	seq_heap_size=<size[K|M|G]>	max. heap size for sequential alloc tests
	pattern_heap_size=<size[K|M|G]>	max. heap size for pattern check test
	random_alloc_rounds=<N>		# of rounds of random-size allocations
	pattern_check_rounds=<N>	# of rounds of pattern check tests
	max_results=<N>	# of result lines (worst-case first, -1=all)
	Set --verbose=2 for detailed runtime statistics.

-- 
Philippe.

