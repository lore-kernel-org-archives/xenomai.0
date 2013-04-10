From: Michael Haberler <mail17@mah.priv.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Apr 2013 23:24:56 +0200
Message-Id: <FD5EBA50-E222-4012-A755-A20FF5D5971D@mah.priv.at>
Mime-Version: 1.0 (Apple Message framework v1283)
Subject: [Xenomai] shared memory compatibility - advice sought
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I am building an RT application which is portable across RTAI, =
Xenomai/userland threads, Xenomai/kernel threads, RT-preempt and vanilla =
kernels (modulo timing restrictions). The xenomai kernel threads build =
is on a deprecation path but build for coverage reasons atm.

The application already does support several instances on one machine, =
for instance one instance could be Xenomai kernel threads, a second one =
Xenomai user threads, a third one Posix threads (thats an example and =
doesnt make sense, just pointing out whats possible)

The userland threads instances uses sysvipc shm; RTAI instance uses =
rtai_malloc/rtai_kmalloc; Xenomai kernel uses =
rt_heap_create/rt_heap_alloc.

--

A requirement has come up to enable access of shared memory between =
instances and that's where I dont know how to proceed - the issues I =
have are:

- incompatible shared memory models between RTAI, Xenomai and shmctl()
- sequencing imposed by kernel threads models - shared memory must be =
created in-kernel and can attached to in userland but not vice versa

I know it is a faint hope, let me try nevertheless:

- is there a way to make Xenomai kernel threads use shared memory =
created in userland by shmctl(2) or mmap for that matter
- if there is, are there any downsides to it
- any other creative solutions you could think of?


I am aware that atm this is really a RTAI question; nevertheless it =
(still) affects Xenomai a bit so I dare to ask here

thanks in advance

Michael



