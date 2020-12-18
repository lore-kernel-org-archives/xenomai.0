From: Philippe Gerum <rpm@xenomai.org>
Subject: [CXP] Discussing the RTDM specification
Date: Fri, 18 Dec 2020 15:19:44 +0100
Message-ID: <874kkjurgf.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


This wiki page [1] contains a draft proposal about specifying which
services from the current RTDM interface should be part of the Common
Xenomai Platform. Some proposals for deprecation stand out:

- I suspect that only very few RTDM drivers are actually handling
  requests from other kernel-based drivers in real world applications,
  at least not enough to justify RTDM codifying these rare cases into a
  common interface (rtdm_open, rtdm_read, rtdm_write etc).

  In other words, although I would agree that a few particular drivers
  might want to export a couple of services to kernel-based clients in
  order to provide them some sort of backchannel, it seems wrong to
  require RTDM drivers to provide a kernel interface which would match
  their user interface in the same terms. For these specific cases, ad
  hoc code in these few drivers should be enough.

  Besides, I believe that most kernel->kernel request paths implemented
  by in-tree RTDM drivers have never been tested for years, if ever.
  Meanwhile, this kernel->kernel API introduces a basic exception case
  into many RTDM and driver code paths, e.g. for differentiating kernel
  vs user buffers, for only very few use cases.

  For these reasons, I would suggest to deprecate the kernel->kernel API
  from RTDM starting from 3.3, excluding it from the CXP in the same
  move.

- RTDM_EXECUTE_ATOMICALLY() and related calls relying on the Cobalt big
  lock must go. For SMP scalability reasons, this big lock was
  eliminated from the EVL core, which means that all the attached
  semantics will not hold there. Serializing access to shared resources
  should be guaranteed by resource-specific locking, not by a giant
  traffic light like the big lock implements.

- rtdm_mutex_timedlock() has dubious semantics. Hitting a timeout
  condition on grabbing a mutex either means that:

  * the mutex was already locked on entry to the call if timeout ==
    RTDM_TIMEOUT_NONE,

  * the mutex was not released within the allotted time, which had to be
    long enough to prevent early shots. This means that something is
    most likely going really wrong in the software, since a mutex is
    supposed to cover fairly short, hopefully simple sections of code,
    exhibiting an obvious exit path.

  In the first case, we would be better off providing
  rtdm_trylock_mutex() which has clearer semantics, starting from 3.3,
  adding it to the CXP. The ship is most likely wrecked already in the
  second case, so using a timeout condition as a way towards recovery is
  unlikely to succeed at this point anyway.

[1] https://gitlab.denx.de/Xenomai/xenomai/-/wikis/CXP_RTDM

-- 
Philippe.

