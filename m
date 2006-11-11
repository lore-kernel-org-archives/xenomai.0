Subject: Re: [Xenomai-help] Xenomai Kernel limits
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1163175259.5765.174.camel@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB0154E67A@is-hdq-exchange.marel.net>
	<45549050.4090005@domain.hid>  <1163175259.5765.174.camel@domain.hid>
Content-Type: text/plain
Date: Sat, 11 Nov 2006 17:28:33 +0100
Message-Id: <1163262513.5765.221.camel@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

On Fri, 2006-11-10 at 17:14 +0100, Philippe Gerum wrote:
> On Fri, 2006-11-10 at 15:44 +0100, Jan Kiszka wrote:
> > Daniel Schnell wrote:
> > > Hi Jan,
> > > 
> > > 
> > > jan.kiszka@domain.hid wrote:
> > >> Maybe that bug is a symptom of some other scalability issue.
> > > 
> > > I suppose so, too.
> > >  
> > >>> +++
> > >>> bash-2.05b# cat /proc/heap
> > >>> size=131072:used=134400:pagesz=512
> > >>> +++
> > >>>
> > >>> This looks odd. Either the output is misleading or we have used more
> > >>> resources than possible. But then I would expect that the Xenomai
> > >>> initialization routines (e.g. pthread_create(), rt_dev_open(), etc.)
> > >>> should return with an error. Either should be fixed, I suppose.
> > >> Every services that allocates memory from the real-time heap should
> > >> fail now. If it doesn't (pthread_create is a good test candidate
> > >> here), we "only" face a statistics bug. Can you confirm that starting
> > >> further applications only increases the used counter but otherwise
> > >> works?    
> > > 
> > > I was running the cyclictest and the switchbench without problems at the
> > > same time and the /proc/xenomai/heap showed even a usage of 135 kBytes.
> > > So I assume that is a statistics bug.
> > 
> > ...or some overwritten memory: The block size is encoded in each heap
> > chunk. Looks to me like we do not check for its sanity with a magic
> > number or so, do we? Would be a nice debug feature. Someone around who's
> > bored (rhetoric question)?
> > 
> 
> The block size is encoded in the pagemap area, idle blocks carry forward
> links into the free list for a given page. If we go down the way adding
> redzones to detect overwrites, I'm afraid that we would have to add them
> all over the place, since trashing the pagemap means that the entire
> heap is basically dead in the water.
> 
> Regarding the size/used inconsistency from /proc/xenomai/heap, I would
> also rather suspect that xnheap::ubytes is being miscomputed, rather
> than trashed. E.g. there could be some mismatch/misuse in
> xnheap_alloc/xnheap_free, between block sizes implicitely derived from
> the log2 value found in the pagemap entries, and the sizes computed for
> blocks larger than 2 * page_size. In any case, I already see a bug there
> for allocation requests greater than 2 * page_size, but that would have
> the opposite effect than the current issue (i.e. leakage in used bytes
> accounting):
> 
> --- ksrc/nucleus/heap.c	(revision 1809)
> +++ ksrc/nucleus/heap.c	(working copy)
> @@ -468,7 +468,7 @@
>  		block = get_free_range(heap, size, 0);
>  
>  		if (block)
> -			heap->ubytes += size;
> +			heap->ubytes += xnheap_align(size, heap->pagesize);
>  	}
>  
>        release_and_exit:
> 
> [...]
> 

False alarm. This patch is useless since the requested size is already
rounded to the page size.

-- 
Philippe.



