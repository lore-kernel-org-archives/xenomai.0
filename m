Message-ID: <4642D901.9050304@domain.hid>
Date: Thu, 10 May 2007 10:34:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1072004B0EE21141A9DEBA9785A77F14658A70@domain.hid>	
	<4641CD8B.8050309@domain.hid>	
	<7289437c0705090643gc9f0ddax6fa6cff44895c9ed@domain.hid>	
	<7289437c0705090735n58b4a0fbm7e31c8571efb7514@domain.hid>	
	<17986.12574.488256.997900@domain.hid>	
	<17986.15326.243315.427529@domain.hid>	
	<1178748178.11688.45.camel@domain.hid>	
	<17986.20728.617772.991566@domain.hid>
	<1178784303.11688.108.camel@domain.hid>
In-Reply-To: <1178784303.11688.108.camel@domain.hid>
Content-Type: multipart/mixed; boundary="------------090509080404080905030902"
Subject: Re: [Xenomai-help] Problem with pthread_setschedparam
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------090509080404080905030902
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7Bit

Philippe Gerum wrote:
> On Wed, 2007-05-09 at 23:23 +0200, Gilles Chanteperdrix wrote:
> > Gilles Chanteperdrix wrote:
> >  > Perrine Martignoni wrote:
> >  >  > On 5/9/07, Perrine Martignoni <perrmart@domain.hid> wrote:
> >  >  > >  On 5/9/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> >  >  > > >
> >  >  > > > Noren, Andrew wrote:
> >  >  > > > > Hi Gilles,
> >  >  > > > >
> >  >  > > > > I too have encountered this issue with the POSIX skin.
> >  >  > > > > I think it may have to do with the order in which the posix skin hooks
> >  >  > > > > are run on thread deletion.
> >  >  > > > >
> >  >  > > > > In ksrc/skins/posix/syscall.c
> >  >  > > > > xnpod_remove_hook(XNHOOK_THREAD_DELETE, &__shadow_delete_hook);
> >  >  > > > >
> >  >  > > > > and ksrc/skins/posix/thread.c
> >  >  > > > > xnpod_add_hook(XNHOOK_THREAD_DELETE, thread_delete_hook);
> >  >  > > > >
> >  >  > > > > The thread_delete_hook seems to run first causing the thread data to
> >  >  > > > be
> >  >  > > > > destroyed before __shadow_delete_hook has a chance to run.
> >  >  > > > >
> >  >  > > > > This results in __shadow_delete_hook failing in various cases.
> >  >  > > > >
> >  >  > > > > An example of an error case linked with this would be the failure to
> >  >  > > > > remove the thread key from the hash bucket after application
> >  >  > > > exit.  The
> >  >  > > > > next run of an application can then result in pthread_setschedparam
> >  >  > > > > failing to create a shadow since it likely finds an id in the hash
> >  >  > > > > bucket already.
> >  >  > > >
> >  >  > > > Hi,
> >  >  > > >
> >  >  > > > thanks for pointing this out, I see other skins use xnfreesafe in their
> >  >  > > > thread deletion hook instead of xnfree. The attached patch fixes this.
> >  >  > > >
> >  >  > > > Perrine, could you apply this patch and check that it solves your issue
> >  >  > > > ?
> >  >  > >
> >  >  > > I'll do that as soon as I can.
> >  >  > > Thanks
> >  >  > >
> >  >  >
> >  >  > I have applied the patch.
> >  >  > It doesn't solve the problem but I have more information :
> >  >  > 
> >  >  > 
> >  >  > pthread_create returned 11
> >  >  > 
> >  >  > __pthread_shadow: -11
> >  >  > 
> >  >  > Xenomai Posix skin init: pthread_setschedparam: Resource temporarily
> >  >  > unavailable
> >  > 
> >  > Ok, I could reproduce the problem. The issue is most likely an access to
> >  > the thread memory after it has been freed which breaks the allocator
> >  > linked list of free pages by replacing a link to a next free page by a
> >  > NULL pointer. xnheap_alloc interprets this NULL pointer as the end of the
> >  > linked list and hence considers that it is out of memory.
> > 
> > And the winner is... RPI! The offset of the thread structure member that
> > is set to NULL is the one of the rpi pointer. Disabling RPI makes the
> > problem vanish.
> > 
> > Philippe, when is this pointer set to NULL ?
> > 
> 
> When the thread leaves secondary mode or exits, which in turn removes it
> from the queue the nucleus considers for priority boosting the root
> thread. Check rpi_none().

Conclusion: the problem is the one Andrew spotted, there are two
hooks and the shadow hook (which calls xnshadow_unmap, which in turn
calls rpi_pop, which sets the rpi pointer to null) gets called after the
other thread deletion hook which initially called xnfree, and now calls
xnfreesafe.

But it seems that even xnfreesafe is not safe enough, and it frees the
thread pointer immediately whereas we would like the operation to be
deferred.

This problem is a problem for all skins, the freed memory is accessed
after it has been freed, it is only visible with the posix
skin on ARM, because the offset of the rpi pointer is the same as the
place where the xnheap allocator stores the pointer to the next free
page.

So, I propose the following patch which makes xnfreesafe safer.

Other solutions are:
- call directly xnheap_schedule_free in thread deletion hooks
- change the execution order of the deletion hooks
- merge the two deletion hooks, enclosing the shadow deletion hook in an
 #ifdef CONFIG_XENO_OPT_PERVASIVE, to get sure of the execution order.

-- 
                                                 Gilles Chanteperdrix

--------------090509080404080905030902
Content-Type: text/x-patch;
 name="xeno-safer-xnfreesafe.diff"
Content-Disposition: inline;
 filename="xeno-safer-xnfreesafe.diff"
Content-Transfer-Encoding: Quoted-Printable

Index: include/nucleus/heap.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/heap.h	(r=C3=A9vision 3042)
+++ include/nucleus/heap.h	(copie de travail)
@@ -117,13 +117,7 @@
 #define xnmalloc(size)     xnheap_alloc(&kheap,size)
 #define xnfree(ptr)        xnheap_free(&kheap,ptr)
 #define xnfreesync()       xnheap_finalize_free(&kheap)
-#define xnfreesafe(thread,ptr,ln) \
-do { \
-    if (xnpod_current_thread() =3D=3D thread) \
-	xnheap_schedule_free(&kheap,ptr,ln); \
-    else \
-	xnheap_free(&kheap,ptr); \
-} while(0)
+#define xnfreesafe(thread,ptr,ln) xnheap_schedule_free(&kheap,ptr,ln);
=20
 static inline size_t xnheap_rounded_size (size_t hsize, size_t psize)
 {

--------------090509080404080905030902--

