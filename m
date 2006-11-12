Subject: Re: [Xenomai-help] Xenomai Kernel limits
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB0154E621@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB0154E621@domain.hid>
Content-Type: text/plain
Date: Mon, 13 Nov 2006 00:09:11 +0100
Message-Id: <1163372951.12206.77.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2006-11-10 at 12:18 +0000, Daniel Schnell wrote:
> Hi,
>  
> I am still struggling with problems under Xenomai and POSIX skin. You
> remember maybe I was posting a Kernel Oops some days ago.
> I realized that a basic test (not with our large app. but with a
> little test program) of clock_nanosleep() shows, that this function -
> if tested alone - works as expected. Strangely in our application the
> behaviour of clock_nanosleep() changes and then suddenly (before
> crashing) it returns only after 1/4 of the supposed time. Bear in
> mind: if I compile the app. against POSIX NPTL glibc, everything works
> as expected.
>  
> The Kernel oops went away if I replace clock_nanosleep() with the
> Linux select() facility (!). This is only a short term workaround as
> then we do not have realtime capabiliy. But at least I can continue
> with porting our application. 
> Meanwhile we got MSCAN running and I could run the application with
> Xenomai and select() instead of clock_nanosleep() over night. When
> checking the /proc/xenomai entries this morning, however we got the
> impression that we might overuse kernel resources:

This bug is caused by an issue with Xenomai's context switch code for
ppc which conflicts with vanilla Linux's tail scheduling code. The patch
below fixes it - (already committed to both v2.2.x and trunk/) :

--- ksrc/arch/powerpc/switch.S	(revision 1810)
+++ ksrc/arch/powerpc/switch.S	(working copy)
@@ -76,6 +76,7 @@
 
 	lwz	r1,KSP(r4)	/* Load new stack pointer */
 
+	mr	r3,r2
 	lwz	r0,PGDIR(r4)
         cmpwi   r0, 0
         beq-	same_current
@@ -155,6 +156,7 @@
 
 	lwz	r1,KSP(r4)	/* Load new stack pointer */
 		
+	mr	r3,r2
 	lwz	r0,PGDIR(r4)
         cmpwi   r0, 0
         beq-	same_current


>  
>  
> +++
> bash-2.05b# cat /proc/heap
> size=131072:used=134400:pagesz=512
> +++
>  
> This looks odd.

Yeah, it is. But primarily because you asked for a 1280Kb system heap,
and only 128Kb are being reported. The heap manager does not take into
account additional memory extents which are added to the system heap in
scatter init mode (which only Xenomai's ppc port currently uses). IOW,
extents are 128kb each, you asked for ten of them, but only the first
one is reported in the overall heap size, which is wrong. The patch
below fixes this issue (committed to both branches, too) :

--- include/nucleus/heap.h	(revision 1829)
+++ include/nucleus/heap.h	(working copy)
@@ -57,53 +57,54 @@
 
 typedef struct xnextent {
 
-    xnholder_t link;
+	xnholder_t link;
 
 #define link2extent(laddr) \
 ((xnextent_t *)(((char *)laddr) - (int)(&((xnextent_t *)0)->link)))
 
-    caddr_t membase,	/* Base address of the page array */
-	    memlim,	/* Memory limit of page array */
-	    freelist;	/* Head of the free page list */
+	caddr_t membase,	/* Base address of the page array */
+		memlim,		/* Memory limit of page array */
+		freelist;	/* Head of the free page list */
 
-    u_char pagemap[1];	/* Beginning of page map */
+	u_char pagemap[1];	/* Beginning of page map */
 
 } xnextent_t;
 
 typedef struct xnheap {
 
-    xnholder_t link;
+	xnholder_t link;
 
 #define link2heap(laddr) \
 ((xnheap_t *)(((char *)laddr) - (int)(&((xnheap_t *)0)->link)))
 
-    u_long extentsize,
-           pagesize,
-           pageshift,
-	   hdrsize,
-	   npages,	/* Number of pages per extent */
-	   ubytes,
-           maxcont;
+	u_long extentsize,
+		totalsize,
+		pagesize,
+		pageshift,
+		hdrsize,
+		npages,		/* Number of pages per extent */
+		ubytes,
+		maxcont;
 
-    xnqueue_t extents;
+	xnqueue_t extents;
 
 #ifdef CONFIG_SMP
-    xnlock_t lock;
+	xnlock_t lock;
 #endif /* CONFIG_SMP */
 
-    caddr_t buckets[XNHEAP_NBUCKETS];
+	caddr_t buckets[XNHEAP_NBUCKETS];
 
-    xnholder_t *idleq;
+	xnholder_t *idleq;
 
-    xnarch_heapcb_t archdep;
+	xnarch_heapcb_t archdep;
 
-    XNARCH_DECL_DISPLAY_CONTEXT();
+	XNARCH_DECL_DISPLAY_CONTEXT();
 
 } xnheap_t;
 
 extern xnheap_t kheap;
 
-#define xnheap_size(heap)            ((heap)->extentsize)
+#define xnheap_size(heap)            ((heap)->totalsize)
 #define xnheap_page_size(heap)       ((heap)->pagesize)
 #define xnheap_page_count(heap)      ((heap)->npages)
 #define xnheap_used_mem(heap)        ((heap)->ubytes)
Index: ksrc/nucleus/heap.c
===================================================================
--- ksrc/nucleus/heap.c	(revision 1829)
+++ ksrc/nucleus/heap.c	(working copy)
@@ -200,6 +200,7 @@
 	heap->npages = (heapsize - hdrsize) >> pageshift;
 	heap->ubytes = 0;
 	heap->maxcont = heap->npages * pagesize;
+	heap->totalsize = heap->maxcont;
 	heap->idleq = NULL;
 	inith(&heap->link);
 	initq(&heap->extents);
@@ -700,6 +701,7 @@
 	xnlock_get_irqsave(&heap->lock, s);
 
 	appendq(&heap->extents, &extent->link);
+	heap->totalsize += extsize;
 
 	xnlock_put_irqrestore(&heap->lock, s);
 

>  Either the output is misleading or we have used more resources than
> possible. But then I would expect that the Xenomai initialization
> routines (e.g. pthread_create(), rt_dev_open(), etc.) should return
> with an error. Either should be fixed, I suppose.
>  
> I configured Xenomai in the Kernel with the following values, but
> please bear in mind that was after I thought about a resource
> shortage:
>  
> CONFIG_XENO_OPT_PIPE_NRDEV=320

This is likely overkill, especially since you don't seem to need the
message pipe feature for your app. Each device allows to open a
bi-directional data path between real-time tasks and non RT processes;
device entries are named /dev/rtp[0-9]*. In your case, you could even
switch out the message pipe feature in the native skin configuration.

> CONFIG_XENO_OPT_REGISTRY_NRSLOTS=2560

This value is a hint to size an internal hash table used by the Xenomai
registry to index real-time objects. You should set this parameter
according to the (roughly) estimated number of rt_<something>_create()
your application issues, and for which you pass a non-null name string
(I said "non-null", not "non empty" which still causes an internal
registration to happen). In any case, this value is a hint which helps
reducing hash collisions, not a hard limit.

> CONFIG_XENO_OPT_SYS_HEAPSZ=1280

This is the size of the internal Xenomai workspace. Now that your
application runs, you might want to decrease the value above to get
reasonably closer to the actual consumption reported
by /proc/xenomai/heap. There are several consumers for this heap, but
basically, the usual suspects are:
- creating kernel-based Xenomai threads, which grabs stack memory from
this workspace (you don't seem to have any in your app),
- each new object indexed by the registry requires 8-bytes, plus the
size of the registry hash table itself.

> CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=40960

This is related to message pipes, so this won't appear anymore if you
configure that option out. It's the size of the internal streaming
buffer specifically used by rt_pipe_stream(). See the API doc. for more.

> CONFIG_XENO_OPT_RTDM_FILDES=512

Seems a lot, unless you have an insane amount of active data paths
between RTDM drivers and your applications. The default value (128) is
usually more than enough.

> CONFIG_XENO_DRIVERS_RTCAN_RXBUF_SIZE=8192
> CONFIG_XENO_DRIVERS_RTCAN_MAX_DEVICES=2
> CONFIG_XENO_DRIVERS_RTCAN_MAX_RECEIVERS=16
> CONFIG_XENO_DRIVERS_RTCAN_MSCAN_CLOCK=33000000
> 
>  
> The complete .config file is attached. Also the most relevant outputs
> of /proc/xenomai you can find in NightRun20061109.txt.
>  
> Questions:
>  
> - What happens, if the Kernel limits are exceeded ? Do Xenomai init
> functions return with an error ?

Yes. Any other behaviour is considered as a bug. I know that true geeks
love to execute the output of /dev/random, but for my part, I'm a luser,
so I prefer sending back return codes...

> - Is the Xenomai Kernel and user space usage after initialization
> fixed over the resource lifetime ? I.e. no dynamic
> allocation/deallocation somehow afterwards ?

It depends on the resource considered. E.g. Some memory is obtained upon
object creation from the Linux kernel, other is obtained from the system
workspace, which is allocated at Xenomai init. There is no fixed
behaviour in this area.

> - What does the output of /proc/heap actually mean ? What does the
> above stated output then mean ?

It means that you hit a bug. Normally, "size" means "overall size (in
bytes) available to fulfill user allocation requests at init". "used" is
the amount of memory already consumed from the previous value, at the
time you ask for this report.

> - I realized that when setting CONFIG_XENO_DRIVERS_RTCAN_RXBUF_SIZE to
> 131072, my application does not run. Which are the upper limits I can
> set for all the configurable Xenomai parameters ?
> - We are using 40+ Tasks, 265+ Condition variables, 200+ Mutexes, and
> 2 MSCAN ports. Additionally we use Linux sockets, files, etc. What is
> your proposed setting to reasonable values inside the Xenomai Kernel
> config ?

No problem, there is only very few hard limit on the number of objects
that can be created, and those are configurable. Only the system
workspace needs to be properly sized to handle the memory pressure. See
above for some explanations about sound values.

> - How can I find out, which resources run low, which resources I have
> allocated ?
> - Is there an overview (like in the VxWorks showXXXX() routines) how
> many IPC objects are allocated, which tasks block on it, etc ?) These
> would be extremely helpful.
> - Moreover is the output of the /proc/xenomai/stat and sched file
> somehow documented ?

Not really yet, aside of the mailing list archive, that is. You can get
a detailed explanation of the thread status flags in
include/nucleus/thread.h.

>  
>  
> Thanks in advance for your support,
>  
> Regards,
>  
> Daniel Schnell.
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



