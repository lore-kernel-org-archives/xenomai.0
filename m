References: <bd6a8257-9986-df8b-182d-b1b5d41e3a2a@xenomai.org>
 <41222b4c-b99c-2745-f1df-f00785c52104@xenomai.org>
 <d8f7d33e-a6fc-2911-56d8-f985981b1698@xenomai.org>
From: Steve Freyder <steve@freyder.net>
Message-ID: <5B1EDD8E.2010707@freyder.net>
Date: Mon, 11 Jun 2018 15:37:34 -0500
In-Reply-To: <d8f7d33e-a6fc-2911-56d8-f985981b1698@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Subject: Re: [Xenomai] Performance issue with memory allocators
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

   On 6/8/2018 7:48 AM, Philippe Gerum wrote:

On 05/20/2018 08:15 PM, Philippe Gerum wrote:

On 04/27/2018 08:23 PM, Philippe Gerum wrote:

After a comprehensive series of tests, it is now obvious that
heapobj-pshared has gruesome performances when releasing bursts of
small-sized objects. Allocation of large objects is not particularly
efficient either, although not as bad. The Cobalt core allocator is
affected by the same bug too.

Those new tests are available from the wip/heapmem branch, they are
based on the smokey framework (e.g. smokey --run=memory_* --verbose=2).

Work is ongoing into the wip/heapmem branch to fix the mess, first
addressing the issue with the core (in-kernel) allocator,
heapobj-pshared next. Please note that wip/heapmem is a development
branch I'm working on for testing improvements - hopefully - to the
memory allocators, which should not be used in production.

I would strongly recommend that users running single-process
applications - i.e. not needing the shared heap feature - make sure to
turn off heapobj-pshared when configuring, by passing --disable-pshared
to the configuration script (or leave the feature to the default off state).

As the benchmark figures show when running 'memory_pshared', the shared

memory allocator still needs to be fixed. This is next on my list.

The pshared allocator is now fixed in the next branch.


   I tried to build with the -next branch, I'm not sure if I'm doing
   something wrong, but I'm getting the errors below.  I thought perhaps
   the "struct shared_heap" should have been "struct shared_heap_memory",
   so I made that change, and that resulted in the second set of errors
   shown below that, then I decided time to post to the group:
   Thanks,
   Steve
   _______________________________________________________________________

   make[3]: Entering directory
   '/home/sdf/xenobuild/imx-xenomai/build/xenomai-3/lib/copperplate/regd'
     CC       regd.o
     CC       fs-common.o
   In file included from
   ../../../../../xenomai-3/include/cobalt/wrappers.h:21:0,
                    from
   /home/sdf/xenobuild/imx-xenomai/xenomai-3/include/cobalt/time.h:26,
                    from
   /opt/emac/5.1/sysroots/armv7a-neon-emac-linux-gnueabi/usr/include/sys/t
   ypes.h:132,
                    from
   ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:19:
   ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c: In function
   a?~open_heapsa?T:
   ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:247:10:
   error: dereferencing pointer to incomplete type a?~struct
   shared_heapa?T
      heap = container_of(obj, struct shared_heap, memspec);
             ^
   ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:247:10:
   error: initialization from incompatible pointer type
   [-Werror=incompatible-pointer-types]
      heap = container_of(obj, struct shared_heap, memspec);
             ^
   In file included from
   /opt/emac/5.1/sysroots/armv7a-neon-emac-linux-gnueabi/usr/include/strin
   g.h:32:0,
                    from
   ../../../../../xenomai-3/include/copperplate/heapobj.h:24,
                    from
   ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:27:
   ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:247:35:
   error: invalid use of undefined type a?~struct shared_heapa?T
      heap = container_of(obj, struct shared_heap, memspec);
                                      ^
   _______________________________________________________________________

   This is with "struct shared_heap" changed to "struct
   shared_heap_memory":
   make[3]: Entering directory
   '/home/sdf/xenobuild/imx-xenomai/build/xenomai-3/lib/copperplate/regd'
     CC       regd.o
     CC       fs-common.o
   ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c: In function
   aopen_heapsa:
   ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:249:17:
   error: astruct shared_heap_memorya has no member named aubytesa
      p->used = heap->ubytes;
                    ^
   ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:250:18:
   error: astruct shared_heap_memorya has no member named atotala
      p->total = heap->total;
                     ^
   Makefile:472: recipe for target 'fs-common.o' failed
   make[3]: *** [fs-common.o] Error 1
