From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4ADCB96B.2040703@domain.hid>
References: <20091019171611.3332.24615.stgit@domain.hid>
	<20091019171612.3332.48569.stgit@domain.hid>
	<4ADCAD4C.2000504@domain.hid>  <4ADCB96B.2040703@domain.hid>
Content-Type: text/plain
Date: Tue, 20 Oct 2009 12:32:13 +0200
Message-Id: <1256034733.2862.118.camel@domain.hid>
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

On Mon, 2009-10-19 at 21:09 +0200, Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
> > Jan Kiszka wrote:
> >> @@ -234,12 +239,65 @@ int xnheap_init(xnheap_t *heap,
> >>  
> >>  	appendq(&heap->extents, &extent->link);
> >>  
> >> +	vsnprintf(heap->name, sizeof(heap->name), name, args);
> >> +
> >> +	spin_lock(&heapq_lock);
> >> +	appendq(&heapq, &heap->stat_link);
> >> +	spin_unlock(&heapq_lock);
> > 
> > You can not use a Linux spinlock in xnheap_init and xnheap_destroy:
> > - this breaks the build for the simulator;
> > - callers of xnheap_init and xnheap_destroy are not guaranteed to run on
> > the root domain.
> 
> Oh, yes, unfortunately. That callers appear to be fixable, but that's
> probably not worth it at this point.

There is nothing to fix here. It's part of the service definition to be
able to call it from primary mode.

>  I will have to rewrite
> heap_read_proc to break out of nklock frequently. Also not nice, but
> less invasive.
> 
> Jan
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



