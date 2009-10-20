From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4ADDA299.1020505@domain.hid>
References: <20091019171611.3332.24615.stgit@domain.hid>
	<20091019171612.3332.48569.stgit@domain.hid>
	<4ADCAD4C.2000504@domain.hid>  <4ADCB96B.2040703@domain.hid>
	<1256034733.2862.118.camel@domain.hid>  <4ADDA299.1020505@domain.hid>
Content-Type: text/plain
Date: Tue, 20 Oct 2009 14:48:23 +0200
Message-Id: <1256042903.2862.122.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH v2 2/3] nucleus: Include all heaps in
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
Cc: xenomai@xenomai.org

On Tue, 2009-10-20 at 13:44 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Mon, 2009-10-19 at 21:09 +0200, Jan Kiszka wrote:
> >> Gilles Chanteperdrix wrote:
> >>> Jan Kiszka wrote:
> >>>> @@ -234,12 +239,65 @@ int xnheap_init(xnheap_t *heap,
> >>>>  
> >>>>  	appendq(&heap->extents, &extent->link);
> >>>>  
> >>>> +	vsnprintf(heap->name, sizeof(heap->name), name, args);
> >>>> +
> >>>> +	spin_lock(&heapq_lock);
> >>>> +	appendq(&heapq, &heap->stat_link);
> >>>> +	spin_unlock(&heapq_lock);
> >>> You can not use a Linux spinlock in xnheap_init and xnheap_destroy:
> >>> - this breaks the build for the simulator;
> >>> - callers of xnheap_init and xnheap_destroy are not guaranteed to run on
> >>> the root domain.
> >> Oh, yes, unfortunately. That callers appear to be fixable, but that's
> >> probably not worth it at this point.
> > 
> > There is nothing to fix here. It's part of the service definition to be
> > able to call it from primary mode.
> 
> Strictly spoken not. But given that xnheap_init_mapped does not fulfill
> this promise and that quite a few users have an either-or use of this
> tuple, it doesn't buy us much to allow primary mode.

xnheap_init_mapped is derived from xnheap_init for obvious code reuse
issues, but this does not mean at all that xnheap_init should inherit
the prerequisites of xnheap_init_mapped when it comes to calling
context. Therefore, xnheap_init shall remain callable from primary
context; this is a published API out of tree code may rely on, and there
is absolutely no point in changing its requirements so far.

> 
> Jan
> 
-- 
Philippe.



