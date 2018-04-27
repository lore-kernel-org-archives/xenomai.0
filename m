From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <bd6a8257-9986-df8b-182d-b1b5d41e3a2a@xenomai.org>
Date: Fri, 27 Apr 2018 20:23:49 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Performance issue with memory allocators
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>


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

-- 
Philippe.

