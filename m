From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4AEF1E91.6030407@domain.hid>
References: <20091020113724.9069.23594.stgit@domain.hid>
	<20091020113725.9069.28060.stgit@domain.hid>
	<1256404942.2862.498.camel@domain.hid>
	<1257177854.2065.616.camel@domain.hid>
	<4AEF0BCC.2020208@domain.hid>
	<1257180716.2065.618.camel@domain.hid>
	<4AEF0F7F.2060603@domain.hid>  <4AEF1E91.6030407@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Nov 2009 19:26:49 +0100
Message-ID: <1257186409.2210.0.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH v3 5/9] nucleus: Avoid returning errors
 from xnheap_destroy_mapped
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

On Mon, 2009-11-02 at 19:01 +0100, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > Philippe Gerum wrote:
> >> On Mon, 2009-11-02 at 17:41 +0100, Jan Kiszka wrote:
> >>> Philippe Gerum wrote:
> >>>> On Sat, 2009-10-24 at 19:22 +0200, Philippe Gerum wrote:
> >>>>> On Tue, 2009-10-20 at 13:37 +0200, Jan Kiszka wrote:
> >>>>>> Allowing xnheap_delete_mapped to return an error and then attempting to
> >>>>>> recover from it does not work out very well: Corner cases are racy,
> >>>>>> intransparent to the user, and proper error handling imposes a lot of
> >>>>>> complexity on the caller - if it actually bothers to check the return
> >>>>>> value...
> >>>>>>
> >>>>>> Fortunately, there is no reason for this function to fail: If the heap
> >>>>>> is still mapped, just install the provide cleanup handler and switch to
> >>>>>> deferred removal. If the unmapping fails, we either raced with some
> >>>>>> other caller of unmap or user space provided a bogus address, or
> >>>>>> something else is wrong. In any case, leaving the cleanup callback
> >>>>>> behind is the best we can do anyway.
> >>>>>>
> >>>>>> Removing the return value immediately allows to simplify the callers,
> >>>>>> namemly rt_queue_delete and rt_heap_delete.
> >>>>>>
> >>>>>> Note: This is still not 100% waterproof. If we issue
> >>>>>> xnheap_destroy_mapped from module cleanup passing a release handler
> >>>>>> that belongs to the module text, deferred release will cause a crash.
> >>>>>> But this corner case is no new regression, so let's keep the head in the
> >>>>>> sand.
> >>>>> I agree with this one, eventually. This does make things clearer, and
> >>>>> removes some opportunities for the upper interfaces to shot themselves
> >>>>> in the foot. Merged, thanks.
> >>>> Well, actually, it does make things clearer, but it is broken. Enabling
> >>>> list debugging makes the nucleus pull the break after a double unlink in
> >>>> vmclose().
> >>>>
> >>>> Basically, the issue is that calling rt_queue/heap_delete() explicitly
> >>>> from userland will break, due to the vmclose() handler being indirectly
> >>>> called by do_munmap() for the last mapping. The nasty thing is that
> >>>> without debugs on, kheapq is just silently trashed.
> >>>>
> >>>> Fix is on its way, along with nommu support for shared heaps as well.
> >>> OK, I see. Just on minor add-on to your fix:
> >>>
> >>> diff --git a/ksrc/nucleus/heap.c b/ksrc/nucleus/heap.c
> >>> index ec14f73..1ae6af6 100644
> >>> --- a/ksrc/nucleus/heap.c
> >>> +++ b/ksrc/nucleus/heap.c
> >>> @@ -1241,6 +1241,7 @@ void xnheap_destroy_mapped(xnheap_t *heap,
> >>>  		down_write(&current->mm->mmap_sem);
> >>>  		heap->archdep.release = NULL;
> >>>  		do_munmap(current->mm, (unsigned long)mapaddr, len);
> >>> +		heap->archdep.release = release;
> >>>  		up_write(&current->mm->mmap_sem);
> >>>  	}
> >>>  
> >>> @@ -1252,7 +1253,6 @@ void xnheap_destroy_mapped(xnheap_t *heap,
> >>>  	if (heap->archdep.numaps > 0) {
> >>>  		/* The release handler is supposed to clean up the rest. */
> >>>  		XENO_ASSERT(NUCLEUS, release != NULL, /* nop */);
> >>> -		heap->archdep.release = release;
> >>>  		return;
> >>>  	}
> >>>  
> >>>
> >>> This is safer than leaving a potential race window open between dropping
> >>> mmap_sem and fixing up archdep.release again.
> >>>
> >> Actually, we have to hold the kheap lock, in case weird code starts
> >> mapping randomly from userland without getting a valid descriptor
> >> through a skin call.
> > 
> > Yep, that as well.
> > 
> 
> Note that 6b1a185b46 doesn't obsolete my patch (pull it from my tree if
> you like).

Are you still referring to a race with the vmclose() handler?

> 
> Jan
> 


-- 
Philippe.



