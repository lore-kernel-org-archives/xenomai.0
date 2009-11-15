From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4AFAB527.5050503@domain.hid>
References: <20091020113724.9069.23594.stgit@domain.hid>
	<20091020113726.9069.95593.stgit@domain.hid>
	<1256082066.2862.178.camel@domain.hid> <4AE0395F.1010800@domain.hid>
	<4AFAB527.5050503@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 15 Nov 2009 18:38:50 +0100
Message-ID: <1258306730.2348.96.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH v3 9/9] nucleus: Include all heaps in
	statistics
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, 2009-11-11 at 13:59 +0100, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > Philippe Gerum wrote:
> >> On Tue, 2009-10-20 at 13:37 +0200, Jan Kiszka wrote:
> >>> This extends /proc/xenomai/heap with statistics about all currently used
> >>> heaps. It takes care to flush nklock while iterating of this potentially
> >>> long list.
> >>>
> >>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> >>> ---
> >>>
> >>>  include/nucleus/heap.h    |   12 +++-
> >>>  ksrc/drivers/ipc/iddp.c   |    3 +
> >>>  ksrc/drivers/ipc/xddp.c   |    6 ++
> >>>  ksrc/nucleus/heap.c       |  131 ++++++++++++++++++++++++++++++++++++++++-----
> >>>  ksrc/nucleus/module.c     |    2 -
> >>>  ksrc/nucleus/pod.c        |    5 +-
> >>>  ksrc/nucleus/shadow.c     |    5 +-
> >>>  ksrc/skins/native/heap.c  |    6 +-
> >>>  ksrc/skins/native/pipe.c  |    4 +
> >>>  ksrc/skins/native/queue.c |    6 +-
> >>>  ksrc/skins/posix/shm.c    |    4 +
> >>>  ksrc/skins/psos+/rn.c     |    6 +-
> >>>  ksrc/skins/rtai/shm.c     |    7 ++
> >>>  ksrc/skins/vrtx/heap.c    |    6 +-
> >>>  ksrc/skins/vrtx/syscall.c |    3 +
> >>>  15 files changed, 169 insertions(+), 37 deletions(-)
> >>>
> >>> diff --git a/include/nucleus/heap.h b/include/nucleus/heap.h
> >>> index 44db738..f653cd7 100644
> >>> --- a/include/nucleus/heap.h
> >>> +++ b/include/nucleus/heap.h
> >>> @@ -115,6 +115,10 @@ typedef struct xnheap {
> >>>
> >>>       XNARCH_DECL_DISPLAY_CONTEXT();
> >>>
> >>> +     xnholder_t stat_link;   /* Link in heapq */
> >>> +
> >>> +     char name[48];
> >> s,48,XNOBJECT_NAME_LEN
> > 
> > OK, but XNOBJECT_NAME_LEN+16 (due to class prefixes and additional
> > information like the minor ID).
> > 
> >>> +
> >>>  } xnheap_t;
> >>>
> >>>  extern xnheap_t kheap;
> >>> @@ -202,7 +206,8 @@ void xnheap_cleanup_proc(void);
> >>>
> >>>  int xnheap_init_mapped(xnheap_t *heap,
> >>>                      u_long heapsize,
> >>> -                    int memflags);
> >>> +                    int memflags,
> >>> +                    const char *name, ...);
> >>>
> >> The va_list is handy, but this breaks the common pattern used throughout
> >> the rest of the nucleus, based on passing pre-formatted labels. So
> >> either we make all creation calls use va_lists (but xnthread would need
> >> more work), or we make xnheap_init_mapped use the not-so-handy current
> >> form.
> >>
> >> Actually, providing xnheap_set_name() and a name parameter/va_list to
> >> xnheap_init* is one too many, this clutters an inner interface
> >> uselessly. The latter should go away, assuming that anon heaps may still
> >> exist.
> > 
> > If we want to print all heaps, we should at least set a name indicating
> > their class. And therefore we need to pass a descriptive name along with
> > /every/ heap initialization. Forcing the majority of xnheap_init users
> > to additionally issue xnheap_set_name is the cluttering a wanted to
> > avoid. Only a minority needs this split-up, and therefore you see both
> > interfaces in my patch.
> > 
> >>>  void xnheap_destroy_mapped(xnheap_t *heap,
> >>>                          void (*release)(struct xnheap *heap),
> >>> @@ -224,7 +229,10 @@ void xnheap_destroy_mapped(xnheap_t *heap,
> >>>  int xnheap_init(xnheap_t *heap,
> >>>               void *heapaddr,
> >>>               u_long heapsize,
> >>> -             u_long pagesize);
> >>> +             u_long pagesize,
> >>> +             const char *name, ...);
> >>> +
> >>> +void xnheap_set_name(xnheap_t *heap, const char *name, ...);
> >>>
> >>>  void xnheap_destroy(xnheap_t *heap,
> >>>                   void (*flushfn)(xnheap_t *heap,
> >>> diff --git a/ksrc/drivers/ipc/iddp.c b/ksrc/drivers/ipc/iddp.c
> >>> index a407946..b6382f1 100644
> >>> --- a/ksrc/drivers/ipc/iddp.c
> >>> +++ b/ksrc/drivers/ipc/iddp.c
> >>> @@ -559,7 +559,8 @@ static int __iddp_bind_socket(struct rtipc_private *priv,
> >>>               }
> >>>
> >>>               ret = xnheap_init(&sk->privpool,
> >>> -                               poolmem, poolsz, XNHEAP_PAGE_SIZE);
> >>> +                               poolmem, poolsz, XNHEAP_PAGE_SIZE,
> >>> +                               "ippd: %d", port);
> >>>               if (ret) {
> >>>                       xnarch_free_host_mem(poolmem, poolsz);
> >>>                       goto fail;
> >>> diff --git a/ksrc/drivers/ipc/xddp.c b/ksrc/drivers/ipc/xddp.c
> >>> index f62147a..a5dafef 100644
> >>> --- a/ksrc/drivers/ipc/xddp.c
> >>> +++ b/ksrc/drivers/ipc/xddp.c
> >>> @@ -703,7 +703,7 @@ static int __xddp_bind_socket(struct rtipc_private *priv,
> >>>               }
> >>>
> >>>               ret = xnheap_init(&sk->privpool,
> >>> -                               poolmem, poolsz, XNHEAP_PAGE_SIZE);
> >>> +                               poolmem, poolsz, XNHEAP_PAGE_SIZE, "");
> >>>               if (ret) {
> >>>                       xnarch_free_host_mem(poolmem, poolsz);
> >>>                       goto fail;
> >>> @@ -746,6 +746,10 @@ static int __xddp_bind_socket(struct rtipc_private *priv,
> >>>       sk->minor = ret;
> >>>       sa->sipc_port = ret;
> >>>       sk->name = *sa;
> >>> +
> >>> +     if (poolsz > 0)
> >>> +             xnheap_set_name(sk->bufpool, "xddp: %d", sa->sipc_port);
> >>> +
> >>>       /* Set default destination if unset at binding time. */
> >>>       if (sk->peer.sipc_port < 0)
> >>>               sk->peer = *sa;
> >>> diff --git a/ksrc/nucleus/heap.c b/ksrc/nucleus/heap.c
> >>> index 96c46f8..793d1c5 100644
> >>> --- a/ksrc/nucleus/heap.c
> >>> +++ b/ksrc/nucleus/heap.c
> >>> @@ -76,6 +76,9 @@ EXPORT_SYMBOL_GPL(kheap);
> >>>  xnheap_t kstacks;    /* Private stack pool */
> >>>  #endif
> >>>
> >>> +static DEFINE_XNQUEUE(heapq);        /* Heap list for /proc reporting */
> >>> +static unsigned long heapq_rev;
> >>> +
> >>>  static void init_extent(xnheap_t *heap, xnextent_t *extent)
> >>>  {
> >>>       caddr_t freepage;
> >>> @@ -108,7 +111,7 @@ static void init_extent(xnheap_t *heap, xnextent_t *extent)
> >>>   */
> >>>
> >>>  /*!
> >>> - * \fn xnheap_init(xnheap_t *heap,void *heapaddr,u_long heapsize,u_long pagesize)
> >>> + * \fn xnheap_init(xnheap_t *heap,void *heapaddr,u_long heapsize,u_long pagesize,const char *name,...)
> >>>   * \brief Initialize a memory heap.
> >>>   *
> >>>   * Initializes a memory heap suitable for time-bounded allocation
> >>> @@ -145,6 +148,10 @@ static void init_extent(xnheap_t *heap, xnextent_t *extent)
> >>>   * best one for your needs. In the current implementation, pagesize
> >>>   * must be a power of two in the range [ 8 .. 32768 ] inclusive.
> >>>   *
> >>> + * @param name Name displayed in statistic outputs. This parameter can
> >>> + * be a format string, in which case succeeding parameters will be used
> >>> + * to resolve the final name.
> >>> + *
> >>>   * @return 0 is returned upon success, or one of the following error
> >>>   * codes:
> >>>   *
> >>> @@ -161,12 +168,13 @@ static void init_extent(xnheap_t *heap, xnextent_t *extent)
> >>>   * Rescheduling: never.
> >>>   */
> >>>
> >>> -int xnheap_init(xnheap_t *heap,
> >>> -             void *heapaddr, u_long heapsize, u_long pagesize)
> >>> +static int xnheap_init_va(xnheap_t *heap, void *heapaddr, u_long heapsize,
> >>> +                       u_long pagesize, const char *name, va_list args)
> >>>  {
> >>>       unsigned cpu, nr_cpus = xnarch_num_online_cpus();
> >>>       u_long hdrsize, shiftsize, pageshift;
> >>>       xnextent_t *extent;
> >>> +     spl_t s;
> >>>
> >>>       /*
> >>>        * Perform some parametrical checks first.
> >>> @@ -232,12 +240,71 @@ int xnheap_init(xnheap_t *heap,
> >>>
> >>>       appendq(&heap->extents, &extent->link);
> >>>
> >>> +     vsnprintf(heap->name, sizeof(heap->name), name, args);
> >>> +
> >>> +     xnlock_get_irqsave(&nklock, s);
> >>> +     appendq(&heapq, &heap->stat_link);
> >>> +     heapq_rev++;
> >>> +     xnlock_put_irqrestore(&nklock, s);
> >>> +
> >>>       xnarch_init_display_context(heap);
> >>>
> >>>       return 0;
> >>>  }
> >>> +
> >>> +int xnheap_init(xnheap_t *heap, void *heapaddr, u_long heapsize,
> >>> +             u_long pagesize, const char *name, ...)
> >>> +{
> >>> +     va_list args;
> >>> +     int ret;
> >>> +
> >>> +     va_start(args, name);
> >>> +     ret = xnheap_init_va(heap, heapaddr, heapsize, pagesize, name, args);
> >>> +     va_end(args);
> >>> +
> >>> +     return ret;
> >>> +}
> >>>  EXPORT_SYMBOL_GPL(xnheap_init);
> >>>
> >>> +/*!
> >>> + * \fn xnheap_set_name(xnheap_t *heap,const char *name,...)
> >>> + * \brief Overwrite the heap's name.
> >> At some point, there should be a common base struct containing
> >> everything needed to manipulate named objects, we would include in
> >> higher level containers. It seems we are over-specializing quite generic
> >> work.
> > 
> > Probably right (though this case remains special to some degree because
> > names may consist of numeric IDs that are formatted on visualization). I
> > think I should rename 'name' to 'display_name' or so to clarify that we
> > are not dealing with a generic object name here.
> > 
> 
> There wasn't any further feedback regarding this. What shall be the
> direction now? I would really like to see this analysis feature in final
> 2.5 so that people can check which heap overflew on ENOMEM.
> 

Same answer as previously I'm afraid. Adding a string format arg list to
xnheap_init(), which already takes 4 args, would just clutter the
interface, way more than introducing a dedicated routine to attach a
label to a heap. E.g.

-		err = xnheap_init(&pipe->privpool, poolmem, poolsize, XNHEAP_PAGE_SIZE);
+		err = xnheap_init(&pipe->privpool, poolmem, poolsize,
+				  XNHEAP_PAGE_SIZE,
+				  "rt_pipe: %d / %s", minor, name);

introduces a 7-args call form, which is not that nice, especially since
I'm trying now to reduce those abuses throughout the code (see
xnpod_init_thread/start_thread). 

Additionally, we want any "name" property to be XNOBJECT_NAME_LEN long, 
and nothing less or more, because this is a common assumption everywhere
in the code, and I see no reason for xnheap to diverge from that. Not to
speak of the fact that such a name is a natural candidate for index key
for registration purpose, and the descriptive labels introduced would
not be valid keys.

I would rather pick your suggestion to introduce a display-oriented name
we could call a label instead, to make clear that we are only dealing
with pretty-printing in /proc.

I.e.

- xnheap_init() remains unchanged
- xnheap_set_label(fmt, args...) is introduced

> Jan
> 


-- 
Philippe.



